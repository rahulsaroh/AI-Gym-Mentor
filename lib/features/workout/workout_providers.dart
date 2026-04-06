import 'package:drift/drift.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_providers.g.dart';

@riverpod
Future<Workout?> activeWorkout(ActiveWorkoutRef ref) async {
  final db = ref.watch(appDatabaseProvider);
  return await (db.select(db.workouts)
        ..where((t) => t.status.equals('draft'))
        ..limit(1))
      .getSingleOrNull();
}

@riverpod
Future<List<WorkoutTemplate>> workoutTemplates(WorkoutTemplatesRef ref) async {
  final db = ref.watch(appDatabaseProvider);
  return await db.select(db.workoutTemplates).get();
}

@riverpod
Future<List<TemplateDay>> templateDays(TemplateDaysRef ref, int templateId) async {
  final db = ref.watch(appDatabaseProvider);
  return await (db.select(db.templateDays)..where((t) => t.templateId.equals(templateId))).get();
}
