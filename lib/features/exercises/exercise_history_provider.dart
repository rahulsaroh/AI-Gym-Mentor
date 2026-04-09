import 'package:gym_gemini_pro/features/exercises/exercise_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_history_provider.g.dart';

@riverpod
Future<Map<String, dynamic>> exerciseStats(
    ExerciseStatsRef ref, int exerciseId) async {
  final repo = ref.watch(exerciseHistoryRepositoryProvider);
  return await repo.getExerciseStats(exerciseId);
}

@riverpod
Future<List<Map<String, dynamic>>> exerciseHistory(
    ExerciseHistoryRef ref, int exerciseId) async {
  final repo = ref.watch(exerciseHistoryRepositoryProvider);
  return await repo.getExerciseHistory(exerciseId);
}

@riverpod
Future<List<Map<String, dynamic>>> exerciseChartData(
    ExerciseChartDataRef ref, int exerciseId, Duration range) async {
  final repo = ref.watch(exerciseHistoryRepositoryProvider);
  return await repo.getChartData(exerciseId, range);
}
