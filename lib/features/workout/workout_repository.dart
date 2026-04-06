import 'package:drift/drift.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_repository.g.dart';

class WorkoutRepository {
  final AppDatabase _db;

  WorkoutRepository(this._db);

  Future<List<Workout>> getHistory({int limit = 20, int offset = 0}) async {
    return await (_db.select(_db.workouts)
          ..where((t) => t.status.equals('completed'))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
          ..limit(limit, offset: offset))
        .get();
  }

  Future<Map<String, dynamic>> getStats() async {
    final completedWorkouts = await (_db.select(_db.workouts)
          ..where((t) => t.status.equals('completed'))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)]))
        .get();

    if (completedWorkouts.isEmpty) {
      return {
        'currentStreak': 0,
        'longestStreak': 0,
        'totalWorkouts': 0,
        'totalVolume': 0.0,
      };
    }

    // Streak calculation
    int currentStreak = 0;
    int longestStreak = 0;
    int tempStreak = 0;

    final workoutDates = completedWorkouts.map((w) => DateTime(w.date.year, w.date.month, w.date.day)).toSet().toList();
    workoutDates.sort();

    if (workoutDates.isNotEmpty) {
      tempStreak = 1;
      longestStreak = 1;
      for (int i = 1; i < workoutDates.length; i++) {
        if (workoutDates[i].difference(workoutDates[i - 1]).inDays == 1) {
          tempStreak++;
        } else {
          if (tempStreak > longestStreak) longestStreak = tempStreak;
          tempStreak = 1;
        }
      }
      if (tempStreak > longestStreak) longestStreak = tempStreak;

      // Current streak check
      final today = DateTime.now();
      final lastWorkoutDay = workoutDates.last;
      final diff = DateTime(today.year, today.month, today.day).difference(lastWorkoutDay).inDays;
      
      if (diff <= 1) {
        // Find how many consecutive days back from lastWorkoutDay
        currentStreak = 1;
        for (int i = workoutDates.length - 1; i > 0; i--) {
          if (workoutDates[i].difference(workoutDates[i-1]).inDays == 1) {
            currentStreak++;
          } else {
            break;
          }
        }
      } else {
        currentStreak = 0;
      }
    }

    // Total Volume
    final volumeQuery = _db.selectOnly(_db.workoutSets)
      ..addColumns([_db.workoutSets.weight, _db.workoutSets.reps])
      ..where(_db.workoutSets.completed.equals(true));
    
    final sets = await volumeQuery.get();
    double totalVolume = 0;
    for (final row in sets) {
      final w = row.read(_db.workoutSets.weight) ?? 0;
      final r = row.read(_db.workoutSets.reps) ?? 0;
      totalVolume += w * r;
    }

    return {
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'totalWorkouts': completedWorkouts.length,
      'totalVolume': totalVolume,
    };
  }

  Future<List<WorkoutSet>> getWorkoutSets(int workoutId) async {
    return await (_db.select(_db.workoutSets)..where((t) => t.workoutId.equals(workoutId))).get();
  }

  Future<void> updateWorkout(WorkoutsCompanion companion) async {
    await (_db.update(_db.workouts)..where((t) => t.id.equals(companion.id.value))).write(companion);
  }

  Future<void> deleteWorkout(int workoutId) async {
    await _db.transaction(() async {
      await (_db.delete(_db.workoutSets)..where((t) => t.workoutId.equals(workoutId))).go();
      await (_db.delete(_db.workouts)..where((t) => t.id.equals(workoutId))).go();
    });
  }

  Future<List<WorkoutSet>> getSetsForHeatmap() async {
    return await (_db.select(_db.workoutSets)..where((t) => t.completed.equals(true))).get();
  }

  Future<Workout?> getLastWorkout() async {
    return await (_db.select(_db.workouts)
          ..where((t) => t.status.equals('completed'))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<Workout?> getActiveWorkoutDraft() async {
    return await (_db.select(_db.workouts)
          ..where((t) => t.status.equals('draft'))
          ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<Map<int, double>> getDailyVolumeRange(DateTime start, DateTime end) async {
    final query = _db.select(_db.workoutSets).join([
      innerJoin(_db.workouts, _db.workouts.id.equalsExp(_db.workoutSets.workoutId)),
    ])
      ..where(_db.workouts.date.isBiggerOrEqualValue(start) & 
              _db.workouts.date.isSmallerOrEqualValue(end) & 
              _db.workouts.status.equals('completed'));

    final rows = await query.get();
    final Map<int, double> dailyVolume = {};

    for (final row in rows) {
      final date = row.readTable(_db.workouts).date;
      final weight = row.readTable(_db.workoutSets).weight;
      final reps = row.readTable(_db.workoutSets).reps;
      
      // key is day of year or just a formatted string
      final dayKey = DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
      dailyVolume[dayKey] = (dailyVolume[dayKey] ?? 0) + (weight * reps);
    }

    return dailyVolume;
  }
}

@riverpod
WorkoutRepository workoutRepository(WorkoutRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return WorkoutRepository(db);
}
