import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/features/workout/workout_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_providers.g.dart';

@riverpod
Future<Map<String, dynamic>> historyStats(HistoryStatsRef ref) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return await repo.getStats();
}

@riverpod
class HistoryList extends _$HistoryList {
  static const int _pageSize = 20;

  @override
  Future<List<Workout>> build() async {
    final repo = ref.watch(workoutRepositoryProvider);
    return await repo.getHistory(limit: _pageSize, offset: 0);
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasValue) return;

    final currentList = state.value!;
    final repo = ref.read(workoutRepositoryProvider);
    final more = await repo.getHistory(limit: _pageSize, offset: currentList.length);
    
    if (more.isNotEmpty) {
      state = AsyncValue.data([...currentList, ...more]);
    }
  }

  Future<void> deleteWorkout(int id) async {
    final repo = ref.read(workoutRepositoryProvider);
    final currentList = state.value ?? [];
    
    // Optimistic UI update
    state = AsyncValue.data(currentList.where((w) => w.id != id).toList());

    try {
      await repo.deleteWorkout(id);
      ref.invalidate(historyStatsProvider);
    } catch (e) {
      // Rollback on error
      state = AsyncValue.data(currentList);
      rethrow;
    }
  }
}

@riverpod
Future<List<WorkoutSet>> heatmapSets(HeatmapSetsRef ref) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return await repo.getSetsForHeatmap();
}
