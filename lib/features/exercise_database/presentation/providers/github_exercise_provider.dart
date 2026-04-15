import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/services/github_exercise_service.dart';

final githubExerciseServiceProvider = Provider((ref) {
  return GithubExerciseService();
});

// All exercises from GitHub
final allGithubExercisesProvider =
    FutureProvider<List<GithubExercise>>((ref) async {
  final service = ref.watch(githubExerciseServiceProvider);
  return service.getAllExercises();
});

// Simple state for filters
class _FilterState {
  final String? bodyPart;
  final String? equipment;
  final String searchQuery;

  const _FilterState({
    this.bodyPart,
    this.equipment,
    this.searchQuery = '',
  });
}

// Mutable state for filters
final _currentFilterState = ValueNotifier<_FilterState>(const _FilterState());

// Providers that read from the current state
final selectedBodyPartProvider = Provider<String?>((ref) {
  // Trigger watchers through a simple hack - just read  the notifier constantly
  return _currentFilterState.value.bodyPart;
});

final selectedEquipmentProvider = Provider<String?>((ref) {
  return _currentFilterState.value.equipment;
});

final exerciseSearchQueryProvider = Provider<String>((ref) {
  return _currentFilterState.value.searchQuery;
});

// Filtered exercises based on search and filters
final filteredGithubExercisesProvider =
    FutureProvider<List<GithubExercise>>((ref) async {
  final service = ref.watch(githubExerciseServiceProvider);
  final query = ref.watch(exerciseSearchQueryProvider);
  final bodyPart = ref.watch(selectedBodyPartProvider);
  final equipment = ref.watch(selectedEquipmentProvider);

  List<GithubExercise> exercises;

  // Start with search results if query is not empty
  if (query.isNotEmpty) {
    exercises = await service.searchExercises(query);
  } else {
    exercises = await service.getAllExercises();
  }

  // Apply body part filter
  if (bodyPart != null && bodyPart.isNotEmpty) {
    exercises = exercises
        .where((e) => e.bodyPart.toLowerCase() == bodyPart.toLowerCase())
        .toList();
  }

  // Apply equipment filter
  if (equipment != null && equipment.isNotEmpty) {
    exercises = exercises
        .where((e) => e.equipment.toLowerCase() == equipment.toLowerCase())
        .toList();
  }

  return exercises;
});

// Get all unique body parts
final bodyPartsProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.watch(githubExerciseServiceProvider);
  return service.getBodyParts();
});

// Get all unique equipment types
final equipmentTypesProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.watch(githubExerciseServiceProvider);
  return service.getEquipmentTypes();
});

// Get all unique muscle targets
final muscleTargetsProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.watch(githubExerciseServiceProvider);
  return service.getMuscleTargets();
});

// Provider to check if any filters are active
final hasActiveFiltersProvider = Provider<bool>((ref) {
  final bodyPart = ref.watch(selectedBodyPartProvider);
  final equipment = ref.watch(selectedEquipmentProvider);
  final query = ref.watch(exerciseSearchQueryProvider);

  return bodyPart != null || equipment != null || query.isNotEmpty;
});

// Filter update functions
void updateBodyPartFilter(String? bodyPart) {
  final current = _currentFilterState.value;
  _currentFilterState.value = _FilterState(
    bodyPart: bodyPart,
    equipment: current.equipment,
    searchQuery: current.searchQuery,
  );
}

void updateEquipmentFilter(String? equipment) {
  final current = _currentFilterState.value;
  _currentFilterState.value = _FilterState(
    bodyPart: current.bodyPart,
    equipment: equipment,
    searchQuery: current.searchQuery,
  );
}

void updateSearchQuery(String query) {
  final current = _currentFilterState.value;
  _currentFilterState.value = _FilterState(
    bodyPart: current.bodyPart,
    equipment: current.equipment,
    searchQuery: query,
  );
}

void clearAllFilters() {
  _currentFilterState.value = const _FilterState();
}
