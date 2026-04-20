import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/services/one_rm_service.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'strength_repository.g.dart';

class StrengthRepository {
  final AppDatabase db;
  StrengthRepository(this.db);

  /// Saves or updates a 1RM snapshot for a specific session/exercise.
  Future<void> saveSnapshot(Exercise1RmSnapshotsCompanion companion) async {
    await db.into(db.exercise1RmSnapshots).insertOnConflictUpdate(companion);
  }

  /// Calculates and stores 1RM snapshots for all completed sets in a workout.
  Future<void> processWorkout(int workoutId, OneRmFormula formula) async {
    final sets = await (db.select(db.workoutSets).join([
      innerJoin(db.exercises, db.exercises.id.equalsExp(db.workoutSets.exerciseId)),
      innerJoin(db.workouts, db.workouts.id.equalsExp(db.workoutSets.workoutId)),
    ])..where(db.workoutSets.workoutId.equals(workoutId) & 
              db.workoutSets.completed.equals(true))).get();

    if (sets.isEmpty) return;

    final workout = sets.first.readTable(db.workouts);
    
    // Group by exercise to find the best set for that exercise in this session
    final Map<int, List<TypedResult>> exerciseGroups = {};
    for (final row in sets) {
      final s = row.readTable(db.workoutSets);
      exerciseGroups.putIfAbsent(s.exerciseId, () => []).add(row);
    }

    for (final entry in exerciseGroups.entries) {
      final exerciseId = entry.key;
      final rows = entry.value;
      
      double best1RM = 0;
      TypedResult? bestRow;

      for (final row in rows) {
        final s = row.readTable(db.workoutSets);
        final ex = row.readTable(db.exercises);
        
        if (!OneRmService.isEligible(
          weight: s.weight, 
          reps: s.reps, 
          exerciseSetType: ex.setType, 
          exerciseCategory: ex.category
        )) continue;

        final rm = OneRmService.calculate(
          weight: s.weight, 
          reps: s.reps, 
          formula: formula
        );

        if (rm > best1RM) {
          best1RM = rm;
          bestRow = row;
        }
      }

      if (bestRow != null && best1RM > 0) {
        final s = bestRow.readTable(db.workoutSets);
        
        // Determine if it's a PR by comparing with past snapshots
        final pastBest = await (db.selectOnly(db.exercise1RmSnapshots)
          ..addColumns([db.exercise1RmSnapshots.estimated1Rm.max()])
          ..where(db.exercise1RmSnapshots.exerciseId.equals(exerciseId) & 
                  db.exercise1RmSnapshots.workoutId.equals(workoutId).not())).getSingle();
        
        final maxPast = pastBest.read(db.exercise1RmSnapshots.estimated1Rm.max()) ?? 0.0;
        final isPr = best1RM > maxPast;

        await saveSnapshot(Exercise1RmSnapshotsCompanion.insert(
          exerciseId: exerciseId,
          workoutId: Value(workoutId),
          date: workout.date,
          weight: s.weight,
          reps: s.reps,
          estimated1Rm: best1RM,
          formula: formula.name,
          isPr: Value(isPr),
        ));
      }
    }
  }

  /// Fetches 1RM history for a specific exercise over a given range.
  Future<List<Exercise1RmSnapshot>> getExerciseHistory(int exerciseId) async {
    return await (db.select(db.exercise1RmSnapshots)
          ..where((t) => t.exerciseId.equals(exerciseId))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)]))
        .get();
  }

  /// Gets the latest snapshot for every exercise that has one.
  Future<List<Exercise1RmSnapshot>> getLatestSnapshots() async {
    // This is equivalent to finding the snapshot with the max date for each exerciseId.
    final query = db.select(db.exercise1RmSnapshots);
    // Drift doesn't support easy 'group by' for full rows, so we use a custom query or a simpler approach.
    // For local data, fetching all and taking latest is often fine, but we'll try to be efficient.
    final all = await query.get();
    final Map<int, Exercise1RmSnapshot> latest = {};
    for (final s in all) {
      if (!latest.containsKey(s.exerciseId) || s.date.isAfter(latest[s.exerciseId]!.date)) {
        latest[s.exerciseId] = s;
      }
    }
    return latest.values.toList()..sort((a,b) => b.date.compareTo(a.date));
  }

  /// Gets the name of an exercise.
  Future<String> getExerciseName(int id) async {
    final ex = await (db.select(db.exercises)..where((t) => t.id.equals(id))).getSingleOrNull();
    return ex?.name ?? 'Unknown Exercise';
  }

  /// Gets snapshots joined with exercise names within a specific date range.
  Future<List<Map<String, dynamic>>> getEnrichedSnapshots({DateTime? start, DateTime? end}) async {
    final query = db.select(db.exercise1RmSnapshots).join([
      innerJoin(db.exercises, db.exercises.id.equalsExp(db.exercise1RmSnapshots.exerciseId)),
    ]);

    if (start != null) {
      query.where(db.exercise1RmSnapshots.date.isBiggerOrEqualValue(start));
    }
    if (end != null) {
      query.where(db.exercise1RmSnapshots.date.isSmallerOrEqualValue(end));
    }

    query.orderBy([OrderingTerm(expression: db.exercise1RmSnapshots.date, mode: OrderingMode.desc)]);

    final results = await query.get();
    return results.map((r) => {
      'snapshot': r.readTable(db.exercise1RmSnapshots),
      'exerciseName': r.readTable(db.exercises).name,
    }).toList();
  }

  /// PRs broken in a specific date range.
  Future<List<Exercise1RmSnapshot>> getRecentPRs({DateTime? since}) async {
    final threshold = since ?? DateTime.now().subtract(const Duration(days: 30));
    return await (db.select(db.exercise1RmSnapshots)
          ..where((t) => t.isPr.equals(true) & t.date.isBiggerOrEqualValue(threshold))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)]))
        .get();
  }

  /// Comprehensive strength metrics for a specific exercise.
  Future<Map<String, dynamic>> getExerciseStrengthMetrics(int exerciseId, {DateTime? rangeStart}) async {
    final history = await getExerciseHistory(exerciseId);
    if (history.isEmpty) return {};

    final latest = history.last;
    final allTimeBest = history.reduce((a, b) => a.estimated1Rm > b.estimated1Rm ? a : b);
    
    // Calculate changes based on range
    final start = rangeStart ?? DateTime.now().subtract(const Duration(days: 30));
    final baseline = history.where((s) => s.date.isBefore(start)).lastOrNull;
    
    double changePercent = 0;
    if (baseline != null) {
      changePercent = ((latest.estimated1Rm - baseline.estimated1Rm) / baseline.estimated1Rm) * 100;
    }

    return {
      'latest': latest,
      'allTimeBest': allTimeBest,
      'changePercent': changePercent,
      'historyCount': history.length,
      'trend': changePercent > 0.5 ? 'improving' : (changePercent < -0.5 ? 'declining' : 'stable'),
    };
  }

  /// Finds exercises with the highest percentage increase in e1RM over a period.
  Future<List<Map<String, dynamic>>> getTopMovers(DateTime start, DateTime end) async {
    final snapshots = await getEnrichedSnapshots(start: start, end: end);
    if (snapshots.isEmpty) return [];

    final Map<int, List<Exercise1RmSnapshot>> grouped = {};
    final Map<int, String> names = {};

    for (final e in snapshots) {
      final s = e['snapshot'] as Exercise1RmSnapshot;
      names[s.exerciseId] = e['exerciseName'] as String;
      grouped.putIfAbsent(s.exerciseId, () => []).add(s);
    }

    final List<Map<String, dynamic>> movers = [];

    for (final entry in grouped.entries) {
      final id = entry.key;
      final history = entry.value..sort((a, b) => a.date.compareTo(b.date));
      if (history.length < 2) continue;

      final first = history.first;
      final last = history.last;
      
      final change = ((last.estimated1Rm - first.estimated1Rm) / first.estimated1Rm) * 100;
      
      if (change > 0) {
        movers.add({
          'exerciseId': id,
          'name': names[id],
          'changePercent': change,
          'startRm': first.estimated1Rm,
          'endRm': last.estimated1Rm,
        });
      }
    }

    movers.sort((a, b) => (b['changePercent'] as double).compareTo(a['changePercent'] as double));
    return movers.take(5).toList();
  }

  /// Identifies exercises that haven't seen an improvement in e1RM in the last X days.
  Future<List<Map<String, dynamic>>> getStagnatingExercises(int daysThreshold) async {
    final threshold = DateTime.now().subtract(Duration(days: daysThreshold));
    final latestSnapshots = await getLatestSnapshots();
    
    final List<Map<String, dynamic>> stagnating = [];

    for (final latest in latestSnapshots) {
      // Get history to see if there was any improvement since threshold
      final history = await getExerciseHistory(latest.exerciseId);
      final recentHistory = history.where((s) => s.date.isAfter(threshold)).toList();
      
      if (recentHistory.isEmpty) continue; // Not trained recently

      final bestOverall = history.reduce((a, b) => a.estimated1Rm > b.estimated1Rm ? a : b);
      final bestRecent = recentHistory.reduce((a, b) => a.estimated1Rm > b.estimated1Rm ? a : b);

      // If best recent is same or worse than best before threshold, and it's been several sessions
      if (bestRecent.estimated1Rm <= bestOverall.estimated1Rm + 0.1 && recentHistory.length >= 3) {
        stagnating.add({
          'exerciseId': latest.exerciseId,
          'name': await getExerciseName(latest.exerciseId),
          'daysSinceImprovement': DateTime.now().difference(bestOverall.date).inDays,
          'lastBestDate': bestOverall.date,
          'currentBest': bestOverall.estimated1Rm,
        });
      }
    }

    return stagnating..sort((a, b) => (b['daysSinceImprovement'] as int).compareTo(a['daysSinceImprovement'] as int));
  }

  /// Calculates the average strength change across all tracked exercises.
  Future<double> getGlobalStrengthTrend(DateTime start, DateTime end) async {
    final movers = await getTopMovers(start, end);
    if (movers.isEmpty) return 0;

    final totalChange = movers.fold(0.0, (sum, m) => sum + (m['changePercent'] as double));
    return totalChange / movers.length;
  }

  /// Gets the total number of sessions logged for an exercise that resulted in a 1RM snapshot.
  Future<int> getStrengthSessionsCount(int exerciseId) async {
    final countExp = db.exercise1RmSnapshots.id.count();
    final query = db.selectOnly(db.exercise1RmSnapshots)
      ..addColumns([countExp])
      ..where(db.exercise1RmSnapshots.exerciseId.equals(exerciseId));
    
    final result = await query.map((r) => r.read<int>(countExp)).getSingle();
    return result ?? 0;
  }

  /// Background backfill for existing workout history.
  Future<void> performBackfill(OneRmFormula formula) async {
    // Find all completed workouts that don't have snapshots yet
    final query = db.select(db.workouts).join([
      leftOuterJoin(db.exercise1RmSnapshots, db.exercise1RmSnapshots.workoutId.equalsExp(db.workouts.id))
    ])..where(db.workouts.status.equals('completed') & db.exercise1RmSnapshots.id.isNull());

    final results = await query.get();
    final workoutIds = results.map((r) => r.readTable(db.workouts).id).toSet().toList();

    for (final id in workoutIds) {
      await processWorkout(id, formula);
    }
  }
}

@riverpod
StrengthRepository strengthRepository(Ref ref) {
  return StrengthRepository(ref.watch(appDatabaseProvider));
}
