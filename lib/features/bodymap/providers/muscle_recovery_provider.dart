import 'package:drift/drift.dart' show OrderingTerm;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/services/doms_service.dart';

part 'muscle_recovery_provider.g.dart';

@riverpod
Future<Map<String, double>> muscleRecovery(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);
  final doms = DomsService();

  final query = db.select(db.workoutSets).join([
    innerJoin(db.exercises,
        db.exercises.id.equalsExp(db.workoutSets.exerciseId)),
    innerJoin(
        db.workouts, db.workouts.id.equalsExp(db.workoutSets.workoutId)),
  ])
    ..where(db.workoutSets.completed.equals(true))
    ..orderBy([OrderingTerm.desc(db.workouts.date)]);

  final sets = await query.get();

  final Map<String, DateTime> lastTrainedMap = {};

  for (final row in sets) {
    final workout = row.readTable(db.workouts);
    final exercise = row.readTable(db.exercises);
    final muscles = <String>[
      exercise.primaryMuscle,
      if (exercise.secondaryMuscle != null) exercise.secondaryMuscle!,
    ].expand((m) => m.split(',')).map((m) => m.trim()).where((m) => m.isNotEmpty);

    for (final name in muscles) {
      lastTrainedMap.putIfAbsent(name, () => workout.date);
    }
  }

  final Map<String, double> recoveryScores = {};
  for (final entry in lastTrainedMap.entries) {
    // Recovery = 1.0 - DOMS score (so 1.0 = fully recovered, 0.0 = very sore)
    recoveryScores[entry.key] =
        (1.0 - doms.calculateDomsScore(entry.value)).clamp(0.0, 1.0);
  }

  return recoveryScores;
}
