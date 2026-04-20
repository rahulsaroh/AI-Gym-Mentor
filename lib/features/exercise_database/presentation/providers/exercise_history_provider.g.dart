// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exerciseStats)
final exerciseStatsProvider = ExerciseStatsFamily._();

final class ExerciseStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  ExerciseStatsProvider._({
    required ExerciseStatsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'exerciseStatsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$exerciseStatsHash();

  @override
  String toString() {
    return r'exerciseStatsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    final argument = this.argument as int;
    return exerciseStats(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ExerciseStatsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$exerciseStatsHash() => r'de79680556b6cd9a87dcd181a4ba126bfe0a0c77';

final class ExerciseStatsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, dynamic>>, int> {
  ExerciseStatsFamily._()
    : super(
        retry: null,
        name: r'exerciseStatsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExerciseStatsProvider call(int exerciseId) =>
      ExerciseStatsProvider._(argument: exerciseId, from: this);

  @override
  String toString() => r'exerciseStatsProvider';
}

@ProviderFor(exerciseHistory)
final exerciseHistoryProvider = ExerciseHistoryFamily._();

final class ExerciseHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  ExerciseHistoryProvider._({
    required ExerciseHistoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'exerciseHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$exerciseHistoryHash();

  @override
  String toString() {
    return r'exerciseHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as int;
    return exerciseHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ExerciseHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$exerciseHistoryHash() => r'2e0b5e349caf0b120ddbf50f4eaaee23ee4c61f4';

final class ExerciseHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Map<String, dynamic>>>, int> {
  ExerciseHistoryFamily._()
    : super(
        retry: null,
        name: r'exerciseHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExerciseHistoryProvider call(int exerciseId) =>
      ExerciseHistoryProvider._(argument: exerciseId, from: this);

  @override
  String toString() => r'exerciseHistoryProvider';
}

@ProviderFor(exerciseChartData)
final exerciseChartDataProvider = ExerciseChartDataFamily._();

final class ExerciseChartDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  ExerciseChartDataProvider._({
    required ExerciseChartDataFamily super.from,
    required (int, Duration) super.argument,
  }) : super(
         retry: null,
         name: r'exerciseChartDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$exerciseChartDataHash();

  @override
  String toString() {
    return r'exerciseChartDataProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as (int, Duration);
    return exerciseChartData(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is ExerciseChartDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$exerciseChartDataHash() => r'a7636ab3f7b523a0428738665e13317118130b49';

final class ExerciseChartDataFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Map<String, dynamic>>>,
          (int, Duration)
        > {
  ExerciseChartDataFamily._()
    : super(
        retry: null,
        name: r'exerciseChartDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ExerciseChartDataProvider call(int exerciseId, Duration range) =>
      ExerciseChartDataProvider._(argument: (exerciseId, range), from: this);

  @override
  String toString() => r'exerciseChartDataProvider';
}
