// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allExercisesHash() => r'6d4e4af96a1a109974c9a316e7c38a42c5c9ed96';

/// See also [allExercises].
@ProviderFor(allExercises)
final allExercisesProvider = AutoDisposeStreamProvider<List<Exercise>>.internal(
  allExercises,
  name: r'allExercisesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allExercisesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllExercisesRef = AutoDisposeStreamProviderRef<List<Exercise>>;
String _$filteredExercisesHash() => r'fad828c9cc7a996d85b8c8bcd38b2d0124c34814';

/// See also [filteredExercises].
@ProviderFor(filteredExercises)
final filteredExercisesProvider =
    AutoDisposeStreamProvider<List<Exercise>>.internal(
  filteredExercises,
  name: r'filteredExercisesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredExercisesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredExercisesRef = AutoDisposeStreamProviderRef<List<Exercise>>;
String _$exerciseFiltersHash() => r'2e0386f9581f23adb9de9ab1356b5551b88187a2';

/// See also [ExerciseFilters].
@ProviderFor(ExerciseFilters)
final exerciseFiltersProvider =
    AutoDisposeNotifierProvider<ExerciseFilters, Map<String, String>>.internal(
  ExerciseFilters.new,
  name: r'exerciseFiltersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exerciseFiltersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExerciseFilters = AutoDisposeNotifier<Map<String, String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
