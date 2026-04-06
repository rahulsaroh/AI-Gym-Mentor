import 'package:drift/drift.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stats_repository.g.dart';

class StatsRepository {
  final AppDatabase db;
  StatsRepository(this.db);

  /// Overview Stats: Volume this month, Workouts this month, Avg Duration, Active Streak
  Future<Map<String, dynamic>> getOverviewStats() async {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    
    // Total Volume this month
    final volumeQuery = db.selectOnly(db.workoutSets)
      ..addColumns([db.workoutSets.weight, db.workoutSets.reps])
      ..join([
        innerJoin(db.workouts, db.workouts.id.equalsExp(db.workoutSets.workoutId)),
      ])
      ..where(db.workouts.date.isBiggerOrEqualValue(monthStart) & db.workouts.status.equals('completed'));
    
    final volumeData = await volumeQuery.get();
    double totalVolume = 0;
    for (final row in volumeData) {
      totalVolume += (row.read(db.workoutSets.weight) ?? 0) * (row.read(db.workoutSets.reps) ?? 0);
    }

    // Workout Count this month
    final countQuery = db.select(db.workouts)
      ..where((t) => t.date.isBiggerOrEqualValue(monthStart) & t.status.equals('completed'));
    final workouts = await countQuery.get();

    // Avg Duration
    double avgDuration = 0;
    if (workouts.isNotEmpty) {
      final totalSecs = workouts.fold(0, (a, b) => a + (b.duration ?? 0));
      avgDuration = totalSecs / workouts.length / 60; // in minutes
    }

    return {
      'monthlyVolume': totalVolume,
      'workoutCount': workouts.length,
      'avgDuration': avgDuration.round(),
    };
  }

  /// Weekly Volume Trend (Last 12 Weeks)
  Future<List<Map<String, dynamic>>> getWeeklyVolumeTrend() async {
    final now = DateTime.now();
    final twelveWeeksAgo = now.subtract(const Duration(days: 84));
    
    final query = db.select(db.workoutSets).join([
      innerJoin(db.workouts, db.workouts.id.equalsExp(db.workoutSets.workoutId)),
    ])
      ..where(db.workouts.date.isBiggerOrEqualValue(twelveWeeksAgo) & db.workouts.status.equals('completed'));

    final rows = await query.get();
    final Map<int, double> weeklyVolume = {}; // Week number -> volume

    for (final row in rows) {
      final date = row.readTable(db.workouts).date;
      final volume = row.readTable(db.workoutSets).weight * row.readTable(db.workoutSets).reps;
      
      // Calculate week start for the key
      final weekStart = date.subtract(Duration(days: date.weekday - 1));
      final key = DateTime(weekStart.year, weekStart.month, weekStart.day).millisecondsSinceEpoch;
      
      weeklyVolume[key] = (weeklyVolume[key] ?? 0) + volume;
    }

    final sortedKeys = weeklyVolume.keys.toList()..sort();
    return sortedKeys.map((k) => {
      'date': DateTime.fromMillisecondsSinceEpoch(k),
      'volume': weeklyVolume[k],
    }).toList();
  }

  /// Workout Frequency (Last 12 Weeks)
  Future<List<Map<String, dynamic>>> getWorkoutFrequency() async {
    final now = DateTime.now();
    final twelveWeeksAgo = now.subtract(const Duration(days: 84));

    final query = db.select(db.workouts)
      ..where((t) => t.date.isBiggerOrEqualValue(twelveWeeksAgo) & t.status.equals('completed'));
    
    final workouts = await query.get();
    final Map<int, int> frequency = {};

    for (final w in workouts) {
      final weekStart = w.date.subtract(Duration(days: w.date.weekday - 1));
      final key = DateTime(weekStart.year, weekStart.month, weekStart.day).millisecondsSinceEpoch;
      frequency[key] = (frequency[key] ?? 0) + 1;
    }

    // Ensure all 12 weeks are represented
    for (int i = 0; i < 12; i++) {
        final d = now.subtract(Duration(days: (now.weekday - 1) + (i * 7)));
        final key = DateTime(d.year, d.month, d.day).millisecondsSinceEpoch;
        if (!frequency.containsKey(key)) frequency[key] = 0;
    }

    final sortedKeys = frequency.keys.toList()..sort();
    return sortedKeys.map((k) => {
      'date': DateTime.fromMillisecondsSinceEpoch(k),
      'count': frequency[k],
    }).toList();
  }

  /// Muscle Group Balance (This month vs Last month)
  Future<Map<String, dynamic>> getMuscleBalance() async {
    final now = DateTime.now();
    final thisMonthStart = DateTime(now.year, now.month, 1);
    final lastMonthStart = DateTime(now.year, now.month - 1, 1);
    
    final muscles = ['Chest', 'Back', 'Shoulders', 'Biceps', 'Triceps', 'Quads', 'Hamstrings', 'Core'];
    
    Future<Map<String, double>> fetchVolume(DateTime start, DateTime end) async {
      final query = db.select(db.workoutSets).join([
        innerJoin(db.workouts, db.workouts.id.equalsExp(db.workoutSets.workoutId)),
        innerJoin(db.exercises, db.exercises.id.equalsExp(db.workoutSets.exerciseId)),
      ])
        ..where(db.workouts.date.isBiggerOrEqualValue(start) & 
                db.workouts.date.isSmallerThanValue(end) & 
                db.workouts.status.equals('completed'));
      
      final results = await query.get();
      Map<String, double> volumes = { for (var m in muscles) m : 0.0 };
      
      for (final row in results) {
        final muscle = row.readTable(db.exercises).primaryMuscle;
        final volume = row.readTable(db.workoutSets).weight * row.readTable(db.workoutSets).reps;
        if (volumes.containsKey(muscle)) {
          volumes[muscle] = (volumes[muscle] ?? 0) + volume;
        }
      }
      return volumes;
    }

    final thisMonth = await fetchVolume(thisMonthStart, now.add(const Duration(days: 1)));
    final lastMonth = await fetchVolume(lastMonthStart, thisMonthStart);

    return {
      'labels': muscles,
      'thisMonth': muscles.map((m) => thisMonth[m] ?? 0.0).toList(),
      'lastMonth': muscles.map((m) => lastMonth[m] ?? 0.0).toList(),
    };
  }

  /// Plateau Alerts: 1RM stagnation in last 5 sessions
  Future<List<Map<String, dynamic>>> getPlateauAlerts() async {
    final exerciseSelect = db.selectOnly(db.workoutSets)
      ..addColumns([db.workoutSets.exerciseId])
      ..groupBy([db.workoutSets.exerciseId]);
    
    // Filter by count in Dart to avoid complex 'having' syntax issues in this Drift version
    final allExerciseCounts = await exerciseSelect.get();
    final exerciseIds = allExerciseCounts
        .map((r) => r.read(db.workoutSets.exerciseId))
        .where((id) => id != null)
        .toList();
    List<Map<String, dynamic>> alerts = [];

    for (final id in exerciseIds) {
      if (id == null) continue;
      
      // Get last 5 session dates for this exercise
      final sessionDatesQuery = db.selectOnly(db.workoutSets)
        ..addColumns([db.workouts.date])
        ..join([innerJoin(db.workouts, db.workouts.id.equalsExp(db.workoutSets.workoutId))])
        ..where(db.workoutSets.exerciseId.equals(id) & db.workouts.status.equals('completed'))
        ..groupBy([db.workouts.date])
        ..orderBy([OrderingTerm.desc(db.workouts.date)])
        ..limit(5);
      
      final dates = (await sessionDatesQuery.get()).map((r) => r.read(db.workouts.date)).toList();
      if (dates.length < 5) continue;

      List<double> oneRMs = [];
      for (final date in dates) {
        if (date == null) continue;
        // Best 1RM for this session
        final sessionSetsQuery = db.select(db.workoutSets).join([
          innerJoin(db.workouts, db.workouts.id.equalsExp(db.workoutSets.workoutId)),
        ])
          ..where(db.workoutSets.exerciseId.equals(id) & db.workouts.date.equals(date));
        
        final sessionSets = await sessionSetsQuery.get();
        double best1RM = 0;
        for (final row in sessionSets) {
          final s = row.readTable(db.workoutSets);
          final rm = s.weight * (1 + s.reps / 30);
          if (rm > best1RM) best1RM = rm;
        }
        oneRMs.add(best1RM);
      }

      // Check for plateau: difference between max and min 1RM < 2.5kg
      final maxRM = oneRMs.reduce((a, b) => a > b ? a : b);
      final minRM = oneRMs.reduce((a, b) => a < b ? a : b);
      
      if (maxRM - minRM < 2.5) {
        final exercise = await (db.select(db.exercises)..where((t) => t.id.equals(id))).getSingle();
        alerts.add({
          'exerciseId': id,
          'name': exercise.name,
          'last5RMs': oneRMs.reversed.toList(),
          'suggestion': _getSuggestion(exercise.primaryMuscle),
        });
      }
    }
    return alerts;
  }

  String _getSuggestion(String muscle) {
    final list = [
      'Try adding 1 rep per set next time.',
      'Reduce weight by 10% and focus on perfect form for one session.',
      'Try a variation: maybe a pause at the bottom.',
      'Add an extra set to increase total volume.',
    ];
    return (list..shuffle()).first;
  }

  Future<List<Map<String, dynamic>>> getRecentPRs() async {
    final monthAgo = DateTime.now().subtract(const Duration(days: 30));
    
    // PR = a set that has the highest 1RM for that exercise across all time, and occurred in last 30 days
    final query = db.select(db.workoutSets).join([
      innerJoin(db.workouts, db.workouts.id.equalsExp(db.workoutSets.workoutId)),
      innerJoin(db.exercises, db.exercises.id.equalsExp(db.workoutSets.exerciseId)),
    ])
      ..where(db.workouts.date.isBiggerOrEqualValue(monthAgo) & db.workouts.status.equals('completed'))
      ..orderBy([OrderingTerm.desc(db.workouts.date)]);
    
    final rows = await query.get();
    List<Map<String, dynamic>> prs = [];
    Set<int> processedExerciseIds = {};

    for (final row in rows) {
      final s = row.readTable(db.workoutSets);
      final date = row.readTable(db.workouts).date;
      final exercise = row.readTable(db.exercises);
      
      if (processedExerciseIds.contains(exercise.id)) continue;

      final currentRM = s.weight * (1 + s.reps / 30);
      
      // Check if this is truly the personal best
      final allTimeQuery = db.selectOnly(db.workoutSets)
        ..addColumns([db.workoutSets.weight, db.workoutSets.reps])
        ..where(db.workoutSets.exerciseId.equals(exercise.id));
      
      final allHistory = await allTimeQuery.get();
      double maxAllTime = 0;
      for (final h in allHistory) {
        final w = h.read(db.workoutSets.weight) ?? 0;
        final r = h.read(db.workoutSets.reps) ?? 0;
        final rm = w * (1 + r / 30);
        if (rm > maxAllTime) maxAllTime = rm;
      }

      if (currentRM >= maxAllTime - 0.1) { // Floating point safety
        prs.add({
          'exerciseId': exercise.id,
          'name': exercise.name,
          'value': '${s.weight}kg x ${s.reps.toInt()}',
          'rm': currentRM,
          'date': date,
        });
        processedExerciseIds.add(exercise.id);
      }
      if (prs.length >= 10) break;
    }
    return prs;
  }
}

@riverpod
StatsRepository statsRepository(StatsRepositoryRef ref) {
  return StatsRepository(ref.watch(appDatabaseProvider));
}
