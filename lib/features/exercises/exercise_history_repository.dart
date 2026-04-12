import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_history_repository.g.dart';

class ExerciseHistoryRepository {
  final AppDatabase _db;

  ExerciseHistoryRepository(this._db);

  Future<Map<String, dynamic>> getExerciseStats(int exerciseId) async {
    final sets = await (_db.select(_db.workoutSets)
          ..where((t) =>
              t.exerciseId.equals(exerciseId) & t.completed.equals(true)))
        .get();

    if (sets.isEmpty) return {};

    double maxWeight = 0;
    double maxReps = 0;
    double best1RM = 0;
    int totalSets = sets.length;

    for (var s in sets) {
      if (s.weight > maxWeight) maxWeight = s.weight;
      if (s.reps > maxReps) maxReps = s.reps;
      final rm = s.weight * (1 + s.reps / 30);
      if (rm > best1RM) best1RM = rm;
    }

    return {
      'maxWeight': maxWeight,
      'maxReps': maxReps,
      'best1RM': best1RM,
      'totalSets': totalSets,
    };
  }

  Future<List<Map<String, dynamic>>> getExerciseHistory(int exerciseId) async {
    final query = _db.select(_db.workoutSets).join([
      innerJoin(
          _db.workouts, _db.workouts.id.equalsExp(_db.workoutSets.workoutId)),
    ])
      ..where(_db.workoutSets.exerciseId.equals(exerciseId) &
          _db.workoutSets.completed.equals(true))
      ..orderBy([
        OrderingTerm(expression: _db.workouts.date, mode: OrderingMode.desc)
      ]);

    final rows = await query.get();

    // Group by workoutId/date
    final Map<int, Map<String, dynamic>> sessions = {};
    for (final row in rows) {
      final workout = row.readTable(_db.workouts);
      final set = row.readTable(_db.workoutSets);

      sessions.putIfAbsent(
          workout.id,
          () => {
                'date': workout.date,
                'workoutName': workout.name,
                'sets': <WorkoutSet>[],
              });
      (sessions[workout.id]!['sets'] as List<WorkoutSet>).add(set);
    }

    return sessions.values.toList();
  }

  Future<List<Map<String, dynamic>>> getChartData(
      int exerciseId, Duration range) async {
    final cutoffDate = DateTime.now().subtract(range);

    final query = _db.select(_db.workoutSets).join([
      innerJoin(
          _db.workouts, _db.workouts.id.equalsExp(_db.workoutSets.workoutId)),
    ])
      ..where(_db.workoutSets.exerciseId.equals(exerciseId) &
          _db.workoutSets.completed.equals(true) &
          _db.workouts.date.isBiggerThanValue(cutoffDate))
      ..orderBy([
        OrderingTerm(expression: _db.workouts.date, mode: OrderingMode.asc)
      ]);

    final rows = await query.get();

    final Map<DateTime, double> daily1RM = {};
    final Map<DateTime, double> dailyVolume = {};

    for (final row in rows) {
      final date = row.readTable(_db.workouts).date;
      final day = DateTime(date.year, date.month, date.day);
      final set = row.readTable(_db.workoutSets);

      final rm = set.weight * (1 + set.reps / 30);
      daily1RM[day] = (daily1RM[day] ?? 0) > rm ? daily1RM[day]! : rm;

      dailyVolume[day] = (dailyVolume[day] ?? 0) + (set.weight * set.reps);
    }

    final result = <Map<String, dynamic>>[];
    final sortedDates = daily1RM.keys.toList()..sort();
    for (var d in sortedDates) {
      result.add({
        'date': d,
        'rm': daily1RM[d],
        'volume': dailyVolume[d],
      });
    }

    return result;
  }
}

@riverpod
ExerciseHistoryRepository exerciseHistoryRepository(
    Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ExerciseHistoryRepository(db);
}
