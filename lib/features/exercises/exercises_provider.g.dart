// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(allExercises)
final allExercisesProvider = AllExercisesProvider._();

final class AllExercisesProvider extends $FunctionalProvider<
        AsyncValue<List<Exercise>>, List<Exercise>, Stream<List<Exercise>>>
    with $FutureModifier<List<Exercise>>, $StreamProvider<List<Exercise>> {
  AllExercisesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'allExercisesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$allExercisesHash();

  @$internal
  @override
  $StreamProviderElement<List<Exercise>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Exercise>> create(Ref ref) {
    return allExercises(ref);
  }
}

String _$allExercisesHash() => r'811ff50e9332e9c058a0d7222e7ffaf374ca7287';

@ProviderFor(ExerciseFilters)
final exerciseFiltersProvider = ExerciseFiltersProvider._();

final class ExerciseFiltersProvider
    extends $NotifierProvider<ExerciseFilters, Map<String, String>> {
  ExerciseFiltersProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'exerciseFiltersProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$exerciseFiltersHash();

  @$internal
  @override
  ExerciseFilters create() => ExerciseFilters();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, String>>(value),
    );
  }
}

String _$exerciseFiltersHash() => r'2e0386f9581f23adb9de9ab1356b5551b88187a2';

abstract class _$ExerciseFilters extends $Notifier<Map<String, String>> {
  Map<String, String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<String, String>, Map<String, String>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, String>, Map<String, String>>,
        Map<String, String>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredExercises)
final filteredExercisesProvider = FilteredExercisesProvider._();

final class FilteredExercisesProvider extends $FunctionalProvider<
        AsyncValue<List<Exercise>>, List<Exercise>, Stream<List<Exercise>>>
    with $FutureModifier<List<Exercise>>, $StreamProvider<List<Exercise>> {
  FilteredExercisesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'filteredExercisesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$filteredExercisesHash();

  @$internal
  @override
  $StreamProviderElement<List<Exercise>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Exercise>> create(Ref ref) {
    return filteredExercises(ref);
  }
}

String _$filteredExercisesHash() => r'7df30f0f4669b4470e5e5154f2000551927e90bb';
