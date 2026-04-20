import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_gym_mentor/core/services/watch_service.dart';
import 'package:ai_gym_mentor/features/workout/providers/timer_notifier.dart';
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';
import 'package:ai_gym_mentor/core/database/database.dart' as db;
import 'package:drift/drift.dart';

part 'watch_sync_service.g.dart';

@riverpod
void watchSyncService(Ref ref) {
  // 1. Listen to Rest Timer updates
  ref.listen(timerProvider, (previous, next) {
    _pushStatus(ref);
  });

  // 2. Listen to Active Workout changes
  final homeState = ref.watch(workoutHomeProvider);
  homeState.whenData((state) {
    if (state.activeDraft != null) {
      _pushStatus(ref);
    }
  });
}

Future<void> _pushStatus(Ref ref) async {
  final watch = ref.read(watchServiceProvider.notifier);
  final timer = ref.read(timerProvider);
  final homeState = await ref.read(workoutHomeProvider.future);
  final activeDraft = homeState.activeDraft;

  if (activeDraft == null && !timer.isRunning) return;

  String exerciseName = timer.exerciseName ?? activeDraft?.name ?? 'Workout';
  int currentSet = 0;
  int totalSets = 0;

  if (activeDraft != null) {
    final database = ref.read(db.appDatabaseProvider);
    final sets = await (database.select(database.workoutSets)
          ..where((t) => t.workoutId.equals(activeDraft.id))
          ..orderBy([(t) => OrderingTerm(expression: t.exerciseOrder), (t) => OrderingTerm(expression: t.setNumber)]))
        .get();

    if (sets.isNotEmpty) {
      final completed = sets.where((s) => s.completed).toList();
      totalSets = sets.length;
      currentSet = (completed.length + 1).clamp(1, totalSets);

      final currentSetRow = sets.firstWhere((s) => !s.completed, orElse: () => sets.last);
      final exercise = await (database.select(database.exercises)
            ..where((t) => t.id.equals(currentSetRow.exerciseId)))
          .getSingleOrNull();
      
      if (!timer.isRunning) {
        exerciseName = exercise?.name ?? activeDraft.name;
      }
    }
  }

  await watch.updateWorkoutState(
    exerciseName: exerciseName,
    currentSet: currentSet,
    totalSets: totalSets,
    timerRunning: timer.isRunning,
    remainingSeconds: timer.remainingSeconds,
  );
}
