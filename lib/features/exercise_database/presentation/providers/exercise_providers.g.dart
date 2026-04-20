// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExerciseFilterState)
final exerciseFilterStateProvider = ExerciseFilterStateProvider._();

final class ExerciseFilterStateProvider
    extends $NotifierProvider<ExerciseFilterState, ExerciseFilter> {
  ExerciseFilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseFilterStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseFilterStateHash();

  @$internal
  @override
  ExerciseFilterState create() => ExerciseFilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExerciseFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExerciseFilter>(value),
    );
  }
}

String _$exerciseFilterStateHash() =>
    r'f087e1434ad1581a94af49b3a71275976168a401';

abstract class _$ExerciseFilterState extends $Notifier<ExerciseFilter> {
  ExerciseFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ExerciseFilter, ExerciseFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExerciseFilter, ExerciseFilter>,
              ExerciseFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ExerciseList)
final exerciseListProvider = ExerciseListProvider._();

final class ExerciseListProvider
    extends $AsyncNotifierProvider<ExerciseList, List<ExerciseEntity>> {
  ExerciseListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseListHash();

  @$internal
  @override
  ExerciseList create() => ExerciseList();
}

String _$exerciseListHash() => r'cb0dfea486035165ec3b73d5ba4ad394d00420d3';

abstract class _$ExerciseList extends $AsyncNotifier<List<ExerciseEntity>> {
  FutureOr<List<ExerciseEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ExerciseEntity>>, List<ExerciseEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ExerciseEntity>>,
                List<ExerciseEntity>
              >,
              AsyncValue<List<ExerciseEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(relatedExercises)
final relatedExercisesProvider = RelatedExercisesFamily._();

final class RelatedExercisesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ExerciseEntity>>,
          List<ExerciseEntity>,
          FutureOr<List<ExerciseEntity>>
        >
    with
        $FutureModifier<List<ExerciseEntity>>,
        $FutureProvider<List<ExerciseEntity>> {
  RelatedExercisesProvider._({
    required RelatedExercisesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'relatedExercisesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$relatedExercisesHash();

  @override
  String toString() {
    return r'relatedExercisesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ExerciseEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ExerciseEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return relatedExercises(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RelatedExercisesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$relatedExercisesHash() => r'0b7f6ea7a699f5de1819ce3b574d15b0a2622e1c';

final class RelatedExercisesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ExerciseEntity>>, int> {
  RelatedExercisesFamily._()
    : super(
        retry: null,
        name: r'relatedExercisesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RelatedExercisesProvider call(int exerciseId) =>
      RelatedExercisesProvider._(argument: exerciseId, from: this);

  @override
  String toString() => r'relatedExercisesProvider';
}

@ProviderFor(progressionChain)
final progressionChainProvider = ProgressionChainFamily._();

final class ProgressionChainProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ExerciseEntity>>,
          List<ExerciseEntity>,
          FutureOr<List<ExerciseEntity>>
        >
    with
        $FutureModifier<List<ExerciseEntity>>,
        $FutureProvider<List<ExerciseEntity>> {
  ProgressionChainProvider._({
    required ProgressionChainFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'progressionChainProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$progressionChainHash();

  @override
  String toString() {
    return r'progressionChainProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ExerciseEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ExerciseEntity>> create(Ref ref) {
    final argument = this.argument as int;
    return progressionChain(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProgressionChainProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$progressionChainHash() => r'8c84e4dc1c7709371bc7cf9595bedd55619dbfa5';

final class ProgressionChainFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ExerciseEntity>>, int> {
  ProgressionChainFamily._()
    : super(
        retry: null,
        name: r'progressionChainProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProgressionChainProvider call(int exerciseId) =>
      ProgressionChainProvider._(argument: exerciseId, from: this);

  @override
  String toString() => r'progressionChainProvider';
}

@ProviderFor(FavoriteToggle)
final favoriteToggleProvider = FavoriteToggleFamily._();

final class FavoriteToggleProvider
    extends $AsyncNotifierProvider<FavoriteToggle, void> {
  FavoriteToggleProvider._({
    required FavoriteToggleFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'favoriteToggleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$favoriteToggleHash();

  @override
  String toString() {
    return r'favoriteToggleProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FavoriteToggle create() => FavoriteToggle();

  @override
  bool operator ==(Object other) {
    return other is FavoriteToggleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$favoriteToggleHash() => r'9231399d769e2508085c84429b772053e76b0b66';

final class FavoriteToggleFamily extends $Family
    with
        $ClassFamilyOverride<
          FavoriteToggle,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          int
        > {
  FavoriteToggleFamily._()
    : super(
        retry: null,
        name: r'favoriteToggleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FavoriteToggleProvider call(int exerciseId) =>
      FavoriteToggleProvider._(argument: exerciseId, from: this);

  @override
  String toString() => r'favoriteToggleProvider';
}

abstract class _$FavoriteToggle extends $AsyncNotifier<void> {
  late final _$args = ref.$arg as int;
  int get exerciseId => _$args;

  FutureOr<void> build(int exerciseId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(allExercises)
final allExercisesProvider = AllExercisesProvider._();

final class AllExercisesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ExerciseEntity>>,
          List<ExerciseEntity>,
          FutureOr<List<ExerciseEntity>>
        >
    with
        $FutureModifier<List<ExerciseEntity>>,
        $FutureProvider<List<ExerciseEntity>> {
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
  $FutureProviderElement<List<ExerciseEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ExerciseEntity>> create(Ref ref) {
    return allExercises(ref);
  }
}

String _$allExercisesHash() => r'8a0630411988eb9ada499861829028912caa9ca5';

@ProviderFor(searchSuggestions)
final searchSuggestionsProvider = SearchSuggestionsFamily._();

final class SearchSuggestionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ExerciseEntity>>,
          List<ExerciseEntity>,
          FutureOr<List<ExerciseEntity>>
        >
    with
        $FutureModifier<List<ExerciseEntity>>,
        $FutureProvider<List<ExerciseEntity>> {
  SearchSuggestionsProvider._({
    required SearchSuggestionsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchSuggestionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchSuggestionsHash();

  @override
  String toString() {
    return r'searchSuggestionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ExerciseEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ExerciseEntity>> create(Ref ref) {
    final argument = this.argument as String;
    return searchSuggestions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchSuggestionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchSuggestionsHash() => r'0172dc89113bb0d075511300572663a3e59350a8';

final class SearchSuggestionsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ExerciseEntity>>, String> {
  SearchSuggestionsFamily._()
    : super(
        retry: null,
        name: r'searchSuggestionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SearchSuggestionsProvider call(String query) =>
      SearchSuggestionsProvider._(argument: query, from: this);

  @override
  String toString() => r'searchSuggestionsProvider';
}
