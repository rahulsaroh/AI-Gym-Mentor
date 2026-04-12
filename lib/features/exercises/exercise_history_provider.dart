import 'package:ai_gym_mentor/features/exercises/exercise_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_history_provider.g.dart';

@riverpod
Future<Map<String, dynamic>> exerciseStats(
    Ref ref, int exerciseId) async {
  final repo = ref.watch(exerciseHistoryRepositoryProvider);
  return await repo.getExerciseStats(exerciseId);
}

@riverpod
Future<List<Map<String, dynamic>>> exerciseHistory(
    Ref ref, int exerciseId) async {
  final repo = ref.watch(exerciseHistoryRepositoryProvider);
  return await repo.getExerciseHistory(exerciseId);
}

@riverpod
Future<List<Map<String, dynamic>>> exerciseChartData(
    Ref ref, int exerciseId, Duration range) async {
  final repo = ref.watch(exerciseHistoryRepositoryProvider);
  return await repo.getChartData(exerciseId, range);
}
