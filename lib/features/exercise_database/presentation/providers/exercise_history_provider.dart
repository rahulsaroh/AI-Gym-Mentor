import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';

part 'exercise_history_provider.g.dart';

@riverpod
Future<Map<String, dynamic>> exerciseStats(
    Ref ref, int exerciseId) async {
  final repo = ref.watch(exerciseRepositoryProvider);
  return await repo.getExerciseStats(exerciseId);
}

@riverpod
Future<List<Map<String, dynamic>>> exerciseHistory(
    Ref ref, int exerciseId) async {
  final repo = ref.watch(exerciseRepositoryProvider);
  return await repo.getExerciseHistory(exerciseId);
}

@riverpod
Future<List<Map<String, dynamic>>> exerciseChartData(
    Ref ref, int exerciseId, Duration range) async {
  final repo = ref.watch(exerciseRepositoryProvider);
  return await repo.getChartData(exerciseId, range);
}
