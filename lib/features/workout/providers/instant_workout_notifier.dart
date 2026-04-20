import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_gym_mentor/features/exercise_database/data/datasources/gemini_service.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';

part 'instant_workout_notifier.g.dart';

@riverpod
class InstantWorkoutNotifier extends _$InstantWorkoutNotifier {
  @override
  Future<int?> build() async => null;

  Future<void> generateWorkout({
    required List<String> bodyParts,
    required String equipment,
    required int duration,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final gemini = ref.read(geminiServiceProvider.notifier);
      final repo = ref.read(workoutRepositoryProvider);

      final suggestions = await gemini.generateWorkoutPlan(
        bodyParts: bodyParts,
        equipmentPreference: equipment,
        durationMinutes: duration,
      );

      final workoutId = await repo.createWorkout(
        name: 'AI Generated: ${bodyParts.join(", ")}',
      );

      await repo.addExercisesWithSets(workoutId, suggestions);
      
      return workoutId;
    });
  }
  
  void reset() {
    state = const AsyncValue.data(null);
  }
}
