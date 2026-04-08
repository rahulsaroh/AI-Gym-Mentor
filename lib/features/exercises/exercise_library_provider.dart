import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'repositories/exercise_library_repository.dart';
import 'models/exercise.dart';

part 'exercise_library_provider.g.dart';

@riverpod
class ExerciseLibrarySearch extends _$ExerciseLibrarySearch {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
}

@riverpod
class ExerciseLibraryFilters extends _$ExerciseLibraryFilters {
  @override
  Map<String, String?> build() => {
    'category': null,
    'equipment': null,
    'difficulty': null,
  };

  void setCategory(String? category) => state = {...state, 'category': category};
  void setEquipment(String? equipment) => state = {...state, 'equipment': equipment};
  void setDifficulty(String? difficulty) => state = {...state, 'difficulty': difficulty};
  void reset() => state = {'category': null, 'equipment': null, 'difficulty': null};
}

@riverpod
Future<List<Exercise>> filteredLibraryExercises(FilteredLibraryExercisesRef ref) async {
  final repository = ref.watch(exerciseLibraryRepositoryProvider);
  final query = ref.watch(exerciseLibrarySearchProvider);
  final filters = ref.watch(exerciseLibraryFiltersProvider);

  await repository.seedDatabase(); // Ensure seeded

  if (query.isNotEmpty) {
    return repository.searchExercises(query);
  } else if (filters.values.any((v) => v != null)) {
    return repository.filterExercises(
      category: filters['category'],
      equipment: filters['equipment'],
      difficulty: filters['difficulty'],
    );
  } else {
    return repository.getAllExercises(limit: 100);
  }
}
