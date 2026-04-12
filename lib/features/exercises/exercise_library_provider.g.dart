// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_library_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExerciseLibrarySearch)
final exerciseLibrarySearchProvider = ExerciseLibrarySearchProvider._();

final class ExerciseLibrarySearchProvider
    extends $NotifierProvider<ExerciseLibrarySearch, String> {
  ExerciseLibrarySearchProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'exerciseLibrarySearchProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$exerciseLibrarySearchHash();

  @$internal
  @override
  ExerciseLibrarySearch create() => ExerciseLibrarySearch();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$exerciseLibrarySearchHash() =>
    r'9ec41f8ee81bb2f312ec28427d161de3b5bba9bb';

abstract class _$ExerciseLibrarySearch extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String, String>, String, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ExerciseLibraryFilters)
final exerciseLibraryFiltersProvider = ExerciseLibraryFiltersProvider._();

final class ExerciseLibraryFiltersProvider
    extends $NotifierProvider<ExerciseLibraryFilters, Map<String, String?>> {
  ExerciseLibraryFiltersProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'exerciseLibraryFiltersProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$exerciseLibraryFiltersHash();

  @$internal
  @override
  ExerciseLibraryFilters create() => ExerciseLibraryFilters();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, String?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, String?>>(value),
    );
  }
}

String _$exerciseLibraryFiltersHash() =>
    r'0e138f908f92d1db0b5a5045d9d02c8a4a21721e';

abstract class _$ExerciseLibraryFilters
    extends $Notifier<Map<String, String?>> {
  Map<String, String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<String, String?>, Map<String, String?>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, String?>, Map<String, String?>>,
        Map<String, String?>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredLibraryExercises)
final filteredLibraryExercisesProvider = FilteredLibraryExercisesProvider._();

final class FilteredLibraryExercisesProvider extends $FunctionalProvider<
        AsyncValue<List<Exercise>>, List<Exercise>, FutureOr<List<Exercise>>>
    with $FutureModifier<List<Exercise>>, $FutureProvider<List<Exercise>> {
  FilteredLibraryExercisesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'filteredLibraryExercisesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$filteredLibraryExercisesHash();

  @$internal
  @override
  $FutureProviderElement<List<Exercise>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Exercise>> create(Ref ref) {
    return filteredLibraryExercises(ref);
  }
}

String _$filteredLibraryExercisesHash() =>
    r'3beb9a319d7de4cd50e918f3ceccc8ef7aeaf6ad';
