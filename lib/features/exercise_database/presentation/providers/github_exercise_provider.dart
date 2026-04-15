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

// State for filters
class GithubFilterState {
  final String? bodyPart;
  final String? equipment;
  final String searchQuery;

  const GithubFilterState({
    this.bodyPart,
    this.equipment,
    this.searchQuery = '',
  });

  GithubFilterState copyWith({
    String? bodyPart,
    bool clearBodyPart = false,
    String? equipment,
    bool clearEquipment = false,
    String? searchQuery,
  }) {
    return GithubFilterState(
      bodyPart: clearBodyPart ? null : (bodyPart ?? this.bodyPart),
      equipment: clearEquipment ? null : (equipment ?? this.equipment),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

// StateProvider-like Notifier for the filter state
class GithubFilterNotifier extends Notifier<GithubFilterState> {
  @override
  GithubFilterState build() => const GithubFilterState();

  void updateBodyPart(String? bodyPart) {
    state = state.copyWith(bodyPart: bodyPart, clearBodyPart: bodyPart == null);
  }

  void updateEquipment(String? equipment) {
    state = state.copyWith(equipment: equipment, clearEquipment: equipment == null);
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void clearAll() {
    state = const GithubFilterState();
  }
}

final githubFilterProvider = NotifierProvider<GithubFilterNotifier, GithubFilterState>(GithubFilterNotifier.new);

// Providers that watch the filter state
final selectedBodyPartProvider = Provider<String?>((ref) {
  return ref.watch(githubFilterProvider).bodyPart;
});

final selectedEquipmentProvider = Provider<String?>((ref) {
  return ref.watch(githubFilterProvider).equipment;
});

final exerciseSearchQueryProvider = Provider<String>((ref) {
  return ref.watch(githubFilterProvider).searchQuery;
});

// Filtered exercises based on search and filters
final filteredGithubExercisesProvider =
    FutureProvider<List<GithubExercise>>((ref) async {
  final service = ref.watch(githubExerciseServiceProvider);
  final filterState = ref.watch(githubFilterProvider);
  final query = filterState.searchQuery;
  final bodyPart = filterState.bodyPart;
  final equipment = filterState.equipment;

  List<GithubExercise> exercises;

  // Search if query is not empty
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
  final filterState = ref.watch(githubFilterProvider);
  return filterState.bodyPart != null ||
      filterState.equipment != null ||
      filterState.searchQuery.isNotEmpty;
});


