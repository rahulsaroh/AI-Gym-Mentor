import 'package:gym_gemini_pro/core/domain/entities/workout_program.dart' as ent;
import 'package:gym_gemini_pro/core/domain/entities/workout_session.dart' as ent;
import 'package:gym_gemini_pro/features/workout/workout_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_providers.g.dart';

@riverpod
Future<ent.WorkoutSession?> activeWorkout(ActiveWorkoutRef ref) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return await repo.getActiveWorkoutDraft();
}

@riverpod
Future<List<ent.WorkoutProgram>> workoutTemplates(WorkoutTemplatesRef ref) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return await repo.getAllTemplates();
}

@riverpod
Future<List<ent.ProgramDay>> templateDays(
    TemplateDaysRef ref, int templateId) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return await repo.getTemplateDays(templateId);
}
