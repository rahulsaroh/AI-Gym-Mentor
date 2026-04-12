import 'dart:math';
import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'progression_service.g.dart';

class ProgressionSuggestion {
  final double suggestedWeight;
  final String reason;
  final double lastSessionWeight;
  final String trendArrow; // 'up', 'flat', 'down'

  ProgressionSuggestion({
    required this.suggestedWeight,
    required this.reason,
    required this.lastSessionWeight,
    required this.trendArrow,
  });
}

@riverpod
class ProgressionService extends _$ProgressionService {
  @override
  void build() {}

  Future<ProgressionSuggestion?> getSuggestion(int exerciseId,
      {double targetReps = 10, int targetSets = 3}) async {
    final db = ref.read(appDatabaseProvider);

    // 1. Fetch last 3 completed sessions for this exercise
    final sessions = await (db.select(db.workoutSets)
          ..where(
              (t) => t.exerciseId.equals(exerciseId) & t.completed.equals(true))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.completedAt, mode: OrderingMode.desc)
          ]))
        .get();

    if (sessions.isEmpty) return null;

    // Group by workoutId to get distinct sessions
    final workoutIds = sessions.map((s) => s.workoutId).toSet().toList();
    if (workoutIds.isEmpty) return null;

    final lastWorkoutId = workoutIds.first;
    final lastSessionSets =
        sessions.where((s) => s.workoutId == lastWorkoutId).toList();

    // Most recent working weight
    final lastWeight = lastSessionSets.first.weight;

    // 3. Get settings and overrides
    final settings = await (db.select(db.exerciseProgressionSettings)
          ..where((t) => t.exerciseId.equals(exerciseId)))
        .getSingleOrNull();

    final currentTargetReps = settings?.targetReps.toDouble() ?? targetReps;
    final increment = settings?.incrementOverride ?? 2.5;

    // 4. Check success against actual target
    final allHitTarget =
        lastSessionSets.every((s) => s.reps >= currentTargetReps);
    final failCount =
        lastSessionSets.where((s) => s.reps < currentTargetReps).length;
    final isFail = failCount > (lastSessionSets.length / 2);

    double suggestedWeight = lastWeight;
    String reason = 'Maintain weight to perfect form.';

    if (allHitTarget) {
      suggestedWeight = lastWeight + increment;
      reason =
          'Hit target of ${currentTargetReps.toInt()} reps! Increasing by ${increment}kg.';
    } else if (isFail) {
      suggestedWeight = max(0.0, lastWeight - increment);
      reason =
          'Missed target reps of ${currentTargetReps.toInt()} on most sets. Reducing by ${increment}kg.';
    } else {
      suggestedWeight = lastWeight;
      reason =
          'Maintain and focus on hitting your ${currentTargetReps.toInt()} rep target.';
    }

    // 4. Trend Arrow (last 5 sessions 1RM)
    String trendArrow = 'flat';
    if (workoutIds.length >= 2) {
      final last5Ids = workoutIds.take(5).toList();
      final session1RMs = <double>[];

      for (var id in last5Ids) {
        final sets = sessions.where((s) => s.workoutId == id).toList();
        if (sets.isNotEmpty) {
          final max1RM =
              sets.map((s) => calculateEpley(s.weight, s.reps)).reduce(max);
          session1RMs.add(max1RM);
        }
      }

      if (session1RMs.length >= 2) {
        if (session1RMs.first > session1RMs.last * 1.02) {
          trendArrow = 'up';
        } else if (session1RMs.first < session1RMs.last * 0.98) {
          trendArrow = 'down';
        }
      }
    }

    return ProgressionSuggestion(
      suggestedWeight: suggestedWeight,
      reason: reason,
      lastSessionWeight: lastWeight,
      trendArrow: trendArrow,
    );
  }

  // 1RM Formulas
  double calculateEpley(double weight, double reps) => weight * (1 + reps / 30);
  double calculateBrzycki(double weight, double reps) =>
      weight * (36 / (37 - reps));
  double calculateLombardi(double weight, double reps) =>
      weight * pow(reps, 0.1);
  double calculateOConner(double weight, double reps) =>
      weight * (1 + reps / 40);

  Map<String, double> getAll1RMs(double weight, double reps) {
    if (reps <= 0)
      return {'Epley': 0, 'Brzycki': 0, 'Lombardi': 0, 'OConner': 0};
    return {
      'Epley': calculateEpley(weight, reps),
      'Brzycki': calculateBrzycki(weight, reps),
      'Lombardi': calculateLombardi(weight, reps),
      'OConner': calculateOConner(weight, reps),
    };
  }
}

final exerciseSuggestionProvider = FutureProvider.autoDispose
    .family<ProgressionSuggestion?, int>((ref, exerciseId) {
  return ref
      .watch(progressionServiceProvider.notifier)
      .getSuggestion(exerciseId);
});
