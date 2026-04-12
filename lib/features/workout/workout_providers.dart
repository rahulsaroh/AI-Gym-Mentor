import 'package:ai_gym_mentor/core/domain/entities/workout_program.dart';
import 'package:ai_gym_mentor/core/domain/entities/workout_session.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_providers.g.dart';

@riverpod
Future<WorkoutSession?> activeWorkout(Ref ref) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return await repo.getActiveWorkoutDraft();
}

@riverpod
Future<List<WorkoutProgram>> workoutTemplates(Ref ref) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return await repo.getAllTemplates();
}

@riverpod
Future<List<ProgramDay>> templateDays(
    Ref ref, int templateId) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return await repo.getTemplateDays(templateId);
}
