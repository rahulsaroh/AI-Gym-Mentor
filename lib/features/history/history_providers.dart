import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/domain/entities/logged_set.dart' as ent;
import 'package:ai_gym_mentor/core/domain/entities/workout_session.dart' as ent;
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_providers.g.dart';

class HistoryItem {
  final ent.WorkoutSession workout;
  final double volume;
  final int setCount;
  HistoryItem(
      {required this.workout, required this.volume, required this.setCount});
}

@riverpod
Future<Map<String, dynamic>> historyStats(Ref ref) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return await repo.getStats();
}

@riverpod
class HistoryList extends _$HistoryList {
  static const int _pageSize = 20;

  @override
  Future<List<HistoryItem>> build() async {
    final repo = ref.watch(workoutRepositoryProvider);
    final data = await repo.getHistoryWithVolume(limit: _pageSize, offset: 0);
    return data
        .map((d) => HistoryItem(
              workout: d['workout'],
              volume: d['volume'],
              setCount: d['setCount'],
            ))
        .toList();
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasValue) return;

    final currentList = state.value!;
    final repo = ref.read(workoutRepositoryProvider);
    final moreData = await repo.getHistoryWithVolume(
        limit: _pageSize, offset: currentList.length);
    final more = moreData
        .map((d) => HistoryItem(
              workout: d['workout'],
              volume: d['volume'],
              setCount: d['setCount'],
            ))
        .toList();

    if (more.isNotEmpty) {
      state = AsyncValue.data([...currentList, ...more]);
    }
  }

  Future<void> deleteWorkout(int id) async {
    final repo = ref.read(workoutRepositoryProvider);
    final currentList = state.value ?? [];

    // Optimistic UI update
    state = AsyncValue.data(
        currentList.where((item) => item.workout.id != id).toList());

    try {
      await repo.deleteWorkout(id);
      ref.invalidate(historyStatsProvider);
      // Also invalidate home provider to refresh streaks and volume
      ref.invalidate(workoutHomeProvider);
    } catch (e) {
      // Rollback on error
      state = AsyncValue.data(currentList);
      rethrow;
    }
  }
}

@riverpod
Future<List<ent.LoggedSet>> heatmapSets(Ref ref) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return await repo.getSetsForHeatmap();
}
