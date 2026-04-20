import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';

part 'bodymap_dao.g.dart';

@DriftAccessor(tables: [WorkoutSets, Workouts, Exercises, ExerciseMuscleMap])
class BodyMapDao extends DatabaseAccessor<AppDatabase> with _$BodyMapDaoMixin {
  BodyMapDao(super.db);

  Future<Map<String, double>> getMuscleVolumeLastSevenDays() async {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

    final query = select(workoutSets).join([
      innerJoin(
        workouts,
        workouts.id.equalsExp(workoutSets.workoutId),
      ),
      innerJoin(
        exerciseMuscleMap,
        exerciseMuscleMap.exerciseId.equalsExp(workoutSets.exerciseId),
      ),
    ])
      ..where(workouts.date.isBiggerOrEqualValue(sevenDaysAgo))
      ..where(workoutSets.completed.equals(true));

    final rows = await query.get();
    final volumeMap = <String, double>{};

    for (final row in rows) {
      final log = row.readTable(workoutSets);
      final muscle = row.readTable(exerciseMuscleMap).primaryMuscle.toLowerCase();
      final volume = (repsToDouble(log.reps) * log.weight).toDouble();
      volumeMap[muscle] = (volumeMap[muscle] ?? 0) + volume;
    }
    return volumeMap;
  }

  double repsToDouble(double reps) => reps;

  Future<Map<String, DateTime>> getLastWorkoutTimePerMuscle() async {
    final query = select(workoutSets).join([
      innerJoin(
        workouts,
        workouts.id.equalsExp(workoutSets.workoutId),
      ),
      innerJoin(
        exerciseMuscleMap,
        exerciseMuscleMap.exerciseId.equalsExp(workoutSets.exerciseId),
      ),
    ])
      ..where(workoutSets.completed.equals(true))
      ..orderBy([OrderingTerm.desc(workouts.date)]);

    final rows = await query.get();
    final lastTimeMap = <String, DateTime>{};

    for (final row in rows) {
      final date = row.readTable(workouts).date;
      final muscle = row.readTable(exerciseMuscleMap).primaryMuscle.toLowerCase();
      if (!lastTimeMap.containsKey(muscle)) {
        lastTimeMap[muscle] = date;
      }
    }
    return lastTimeMap;
  }
}
