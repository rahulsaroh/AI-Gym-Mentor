import 'dart:math';
import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/services/progression_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'plateau_service.g.dart';

class PlateauResult {
  final int exerciseId;
  final String exerciseName;
  final int weeksStuck;
  final double deloadWeight;

  PlateauResult({
    required this.exerciseId,
    required this.exerciseName,
    required this.weeksStuck,
    required this.deloadWeight,
  });
}

@riverpod
class PlateauService extends _$PlateauService {
  @override
  void build() {}

  Future<PlateauResult?> checkExercise(int exerciseId) async {
    final db = ref.read(appDatabaseProvider);
    final progression = ref.read(progressionServiceProvider.notifier);

    // 1. Fetch last 5 completed sessions
    final sessions = await (db.select(db.workoutSets)
          ..where(
              (t) => t.exerciseId.equals(exerciseId) & t.completed.equals(true))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.completedAt, mode: OrderingMode.desc)
          ]))
        .get();

    if (sessions.length < 5) return null;

    // Group by workoutId for distinct sessions
    final workoutIds = sessions.map((s) => s.workoutId).toSet().toList();
    if (workoutIds.length < 5) return null;

    final exercise = await (db.select(db.exercises)
          ..where((t) => t.id.equals(exerciseId)))
        .getSingle();

    // 2. Compute 1RMs for each session
    final session1RMs = <double>[];
    for (var i = 0; i < 5; i++) {
      final id = workoutIds[i];
      final sets = sessions.where((s) => s.workoutId == id).toList();
      if (sets.isNotEmpty) {
        final max1RM = sets
            .map((s) => progression.calculateEpley(s.weight, s.reps))
            .reduce(max);
        session1RMs.add(max1RM);
      }
    }

    // 3. Peak 1RM (all time)
    final allSets = sessions;
    final allTimePeak = allSets
        .map((s) => progression.calculateEpley(s.weight, s.reps))
        .reduce(max);

    // 4. Algorithm check
    final max1RM = session1RMs.reduce(max);
    final min1RM = session1RMs.reduce(min);

    final isStagnant = (max1RM - min1RM) < 2.5;
    final isBelowPeak = session1RMs.every((rm) => rm < allTimePeak * 0.98);

    if (isStagnant && isBelowPeak) {
      final currentWeight = sessions.first.weight;
      return PlateauResult(
        exerciseId: exerciseId,
        exerciseName: exercise.name,
        weeksStuck: 3, // Approximation based on 5 sessions
        deloadWeight: (currentWeight * 0.7).roundToDouble(),
      );
    }

    return null;
  }
}
