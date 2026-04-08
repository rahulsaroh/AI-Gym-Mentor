// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_library_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredLibraryExercisesHash() =>
    r'ff240b60f86634c8ae8b09e5cd51da539b28aebd';

/// See also [filteredLibraryExercises].
@ProviderFor(filteredLibraryExercises)
final filteredLibraryExercisesProvider =
    AutoDisposeFutureProvider<List<Exercise>>.internal(
  filteredLibraryExercises,
  name: r'filteredLibraryExercisesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredLibraryExercisesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredLibraryExercisesRef
    = AutoDisposeFutureProviderRef<List<Exercise>>;
String _$exerciseLibrarySearchHash() =>
    r'9ec41f8ee81bb2f312ec28427d161de3b5bba9bb';

/// See also [ExerciseLibrarySearch].
@ProviderFor(ExerciseLibrarySearch)
final exerciseLibrarySearchProvider =
    AutoDisposeNotifierProvider<ExerciseLibrarySearch, String>.internal(
  ExerciseLibrarySearch.new,
  name: r'exerciseLibrarySearchProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exerciseLibrarySearchHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExerciseLibrarySearch = AutoDisposeNotifier<String>;
String _$exerciseLibraryFiltersHash() =>
    r'0e138f908f92d1db0b5a5045d9d02c8a4a21721e';

/// See also [ExerciseLibraryFilters].
@ProviderFor(ExerciseLibraryFilters)
final exerciseLibraryFiltersProvider = AutoDisposeNotifierProvider<
    ExerciseLibraryFilters, Map<String, String?>>.internal(
  ExerciseLibraryFilters.new,
  name: r'exerciseLibraryFiltersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exerciseLibraryFiltersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExerciseLibraryFilters = AutoDisposeNotifier<Map<String, String?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
