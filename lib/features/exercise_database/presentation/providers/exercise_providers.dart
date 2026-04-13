import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:ai_gym_mentor/features/exercise_database/data/models/exercise_filter_model.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';

part 'exercise_providers.g.dart';

@riverpod
class ExerciseFilterState extends _$ExerciseFilterState {
  @override
  ExerciseFilter build() => const ExerciseFilter();

  void updateFilter(ExerciseFilter Function(ExerciseFilter) update) {
    state = update(state);
  }
}

@riverpod
class ExerciseList extends _$ExerciseList {
  int _page = 0;
  bool _hasMore = true;
  static const _pageSize = 20;

  @override
  Future<List<ExerciseEntity>> build() async {
    ref.listen(exerciseFilterStateProvider, (_, __) {
      _resetAndReload();
    });
    return _fetchPage();
  }

  Future<List<ExerciseEntity>> _fetchPage() async {
    final filter = ref.read(exerciseFilterStateProvider);
    return ref.read(exerciseRepositoryProvider).getExercises(
      page: _page,
      pageSize: _pageSize,
      bodyPart: filter.bodyPart,
      category: filter.category,
      equipment: filter.equipment,
      difficulty: filter.difficulty,
      favoritesOnly: filter.favoritesOnly,
    );
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;
    _page++;
    final more = await _fetchPage();
    if (more.isEmpty) {
      _hasMore = false;
      return;
    }
    state = AsyncData([...state.value ?? [], ...more]);
  }

  Future<void> _resetAndReload() async {
    _page = 0;
    _hasMore = true;
    state = const AsyncLoading();
    state = AsyncData(await _fetchPage());
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      await _resetAndReload();
      return;
    }
    state = const AsyncLoading();
    final results = await ref.read(exerciseRepositoryProvider).searchExercises(query);
    state = AsyncData(results);
  }
}

final exerciseDetailProvider = FutureProvider.family<ExerciseEntity?, int>((ref, id) async {
  final repo = ref.read(exerciseRepositoryProvider);
  await repo.markRecentlyViewed(id);
  return repo.getExerciseById(id);
});

final bodyPartsProvider = FutureProvider<List<String>>((ref) =>
  ref.read(exerciseRepositoryProvider).getAvailableBodyParts());

final equipmentProvider = FutureProvider<List<String>>((ref) =>
  ref.read(exerciseRepositoryProvider).getAvailableEquipment());

final bodyPartCountsProvider = FutureProvider<Map<String, int>>((ref) =>
  ref.read(exerciseRepositoryProvider).getExerciseCountByBodyPart());

final recentlyViewedProvider = FutureProvider<List<ExerciseEntity>>((ref) =>
  ref.read(exerciseRepositoryProvider).getRecentlyViewed());

final connectivityProvider = StreamProvider<bool>((ref) {
  return Connectivity().onConnectivityChanged
    .map((results) => results.any((result) => result != ConnectivityResult.none));
});

@riverpod
Future<List<ExerciseEntity>> relatedExercises(Ref ref, int exerciseId) async {
  return ref.read(exerciseRepositoryProvider).getRelatedExercises(exerciseId);
}

@riverpod
Future<List<ExerciseEntity>> progressionChain(Ref ref, int exerciseId) async {
  return ref.read(exerciseRepositoryProvider).getProgressionChain(exerciseId);
}

@riverpod
class FavoriteToggle extends _$FavoriteToggle {
  @override
  Future<void> build(int exerciseId) async {}

  Future<void> toggle(bool isFavorite) async {
    await ref.read(exerciseRepositoryProvider).toggleFavorite(exerciseId, isFavorite);
    ref.invalidate(exerciseDetailProvider(exerciseId));
  }
}

@riverpod
Future<List<ExerciseEntity>> allExercises(Ref ref) {
  return ref.read(exerciseRepositoryProvider).getAllExercises();
}
