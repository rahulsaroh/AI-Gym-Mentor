import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/services/doms_service.dart';
import 'package:drift/drift.dart';

part 'muscle_recovery_provider.g.dart';

@riverpod
Future<Map<String, double>> muscleRecovery(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);
  final doms = DomsService();
  
  // Fetch all completed workout sets with exercise details to get muscle groups
  final sets = await (db.select(db.workoutSets).join([
    innerJoin(db.exercises, db.exercises.id.equalsExp(db.workoutSets.exerciseId)),
    innerJoin(db.workouts, db.workouts.id.equalsExp(db.workoutSets.workoutId)),
  ])
  ..where(db.workoutSets.completed.equals(true))
  ..orderBy([OrderingTerm.desc(db.workouts.date)]))
  .get();

  final Map<String, DateTime> lastTrainedMap = {};

  for (var row in sets) {
    final workout = row.readTable(db.workouts);
    final exercise = row.readTable(db.exercises);
    final muscles = exercise.primaryMuscle.split(',');

    for (var muscle in muscles) {
      final name = muscle.trim();
      if (!lastTrainedMap.containsKey(name)) {
        lastTrainedMap[name] = workout.date;
      }
    }
  }

  final Map<String, double> recoveryScores = {};
  for (var entry in lastTrainedMap.entries) {
    recoveryScores[entry.key] = doms.calculateDomsScore(entry.value);
  }

  return recoveryScores;
}
