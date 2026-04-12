import 'package:ai_gym_mentor/core/domain/entities/exercise.dart';
import 'package:ai_gym_mentor/features/exercises/exercise_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_provider.g.dart';

@riverpod
Stream<List<Exercise>> allExercises(Ref ref) {
  final repository = ref.watch(exerciseRepositoryProvider);
  return repository.watchAllExercises();
}

@riverpod
class ExerciseFilters extends _$ExerciseFilters {
  @override
  Map<String, String> build() {
    return {
      'search': '',
      'muscle': 'All Muscles',
      'equipment': 'All Equipment',
    };
  }

  void setSearch(String query) {
    state = {...state, 'search': query};
  }

  void setMuscle(String muscle) {
    state = {...state, 'muscle': muscle};
  }

  void setEquipment(String equipment) {
    state = {...state, 'equipment': equipment};
  }

  void reset() {
    state = {
      'search': '',
      'muscle': 'All Muscles',
      'equipment': 'All Equipment',
    };
  }
}

@riverpod
Stream<List<Exercise>> filteredExercises(Ref ref) {
  final allExercisesAsync = ref.watch(allExercisesProvider);
  final filters = ref.watch(exerciseFiltersProvider);

  return allExercisesAsync.when(
    data: (exercises) {
      final filtered = exercises.where((ex) {
        final matchesSearch =
            ex.name.toLowerCase().contains(filters['search']!.toLowerCase());
        final matchesMuscle = filters['muscle'] == 'All Muscles' ||
            ex.primaryMuscle == filters['muscle'];
        final matchesEquipment = filters['equipment'] == 'All Equipment' ||
            ex.equipment == filters['equipment'];
        return matchesSearch && matchesMuscle && matchesEquipment;
      }).toList();
      return Stream.value(filtered);
    },
    loading: () => const Stream.empty(),
    error: (_, __) => const Stream.empty(),
  );
}
