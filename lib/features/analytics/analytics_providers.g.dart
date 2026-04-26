// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedMeasurementInterval)
final selectedMeasurementIntervalProvider =
    SelectedMeasurementIntervalProvider._();

final class SelectedMeasurementIntervalProvider
    extends
        $NotifierProvider<SelectedMeasurementInterval, MeasurementInterval> {
  SelectedMeasurementIntervalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedMeasurementIntervalProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedMeasurementIntervalHash();

  @$internal
  @override
  SelectedMeasurementInterval create() => SelectedMeasurementInterval();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MeasurementInterval value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MeasurementInterval>(value),
    );
  }
}

String _$selectedMeasurementIntervalHash() =>
    r'd9aee215b0e0e67ec2de59cf4d673dc398434ca8';

abstract class _$SelectedMeasurementInterval
    extends $Notifier<MeasurementInterval> {
  MeasurementInterval build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MeasurementInterval, MeasurementInterval>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MeasurementInterval, MeasurementInterval>,
              MeasurementInterval,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Global date-range filter for the Measurements tab.
/// When null: each target uses its own createdAt/deadline.
/// When set: ALL cards compute progress within this window.

@ProviderFor(MeasurementDateRange)
final measurementDateRangeProvider = MeasurementDateRangeProvider._();

/// Global date-range filter for the Measurements tab.
/// When null: each target uses its own createdAt/deadline.
/// When set: ALL cards compute progress within this window.
final class MeasurementDateRangeProvider
    extends $NotifierProvider<MeasurementDateRange, DateTimeRange<DateTime>?> {
  /// Global date-range filter for the Measurements tab.
  /// When null: each target uses its own createdAt/deadline.
  /// When set: ALL cards compute progress within this window.
  MeasurementDateRangeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'measurementDateRangeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$measurementDateRangeHash();

  @$internal
  @override
  MeasurementDateRange create() => MeasurementDateRange();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTimeRange<DateTime>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTimeRange<DateTime>?>(value),
    );
  }
}

String _$measurementDateRangeHash() =>
    r'bcf67781ae99f9e914b611fa49147864d29dbe45';

/// Global date-range filter for the Measurements tab.
/// When null: each target uses its own createdAt/deadline.
/// When set: ALL cards compute progress within this window.

abstract class _$MeasurementDateRange
    extends $Notifier<DateTimeRange<DateTime>?> {
  DateTimeRange<DateTime>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<DateTimeRange<DateTime>?, DateTimeRange<DateTime>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTimeRange<DateTime>?, DateTimeRange<DateTime>?>,
              DateTimeRange<DateTime>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(dashboardStats)
final dashboardStatsProvider = DashboardStatsProvider._();

final class DashboardStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  DashboardStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardStatsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return dashboardStats(ref);
  }
}

String _$dashboardStatsHash() => r'855c50e866eaaa1317733f2cbe30e16ea5a518a4';

@ProviderFor(volumeTrend)
final volumeTrendProvider = VolumeTrendProvider._();

final class VolumeTrendProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  VolumeTrendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'volumeTrendProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$volumeTrendHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return volumeTrend(ref);
  }
}

String _$volumeTrendHash() => r'a64c01d9c700354b43e62c6464ee636bc52c28b2';

@ProviderFor(durationTrend)
final durationTrendProvider = DurationTrendProvider._();

final class DurationTrendProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  DurationTrendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'durationTrendProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$durationTrendHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return durationTrend(ref);
  }
}

String _$durationTrendHash() => r'7a68f9e8f7c586305099cb022e292120333c4b49';

@ProviderFor(frequencyTrend)
final frequencyTrendProvider = FrequencyTrendProvider._();

final class FrequencyTrendProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  FrequencyTrendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'frequencyTrendProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$frequencyTrendHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return frequencyTrend(ref);
  }
}

String _$frequencyTrendHash() => r'5377d5c0eacc71e4b75e313016bc72f21fa933ed';

@ProviderFor(dailyActivity)
final dailyActivityProvider = DailyActivityProvider._();

final class DailyActivityProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<DateTime, int>>,
          Map<DateTime, int>,
          FutureOr<Map<DateTime, int>>
        >
    with
        $FutureModifier<Map<DateTime, int>>,
        $FutureProvider<Map<DateTime, int>> {
  DailyActivityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyActivityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyActivityHash();

  @$internal
  @override
  $FutureProviderElement<Map<DateTime, int>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<DateTime, int>> create(Ref ref) {
    return dailyActivity(ref);
  }
}

String _$dailyActivityHash() => r'19fde8f629f016c2e66f114bd10e0b2d2883cebd';

@ProviderFor(weightTrend)
final weightTrendProvider = WeightTrendProvider._();

final class WeightTrendProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  WeightTrendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weightTrendProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weightTrendHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return weightTrend(ref);
  }
}

String _$weightTrendHash() => r'0460708393741bba4d707f4fe15a67cb07bacb0f';

@ProviderFor(muscleBalance)
final muscleBalanceProvider = MuscleBalanceProvider._();

final class MuscleBalanceProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  MuscleBalanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'muscleBalanceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$muscleBalanceHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return muscleBalance(ref);
  }
}

String _$muscleBalanceHash() => r'f209ac7ec9c7a0054a7752d3a1a8a827d5dfcbf5';

@ProviderFor(volumeVsWeightTrend)
final volumeVsWeightTrendProvider = VolumeVsWeightTrendProvider._();

final class VolumeVsWeightTrendProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  VolumeVsWeightTrendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'volumeVsWeightTrendProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$volumeVsWeightTrendHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return volumeVsWeightTrend(ref);
  }
}

String _$volumeVsWeightTrendHash() =>
    r'6672c186655f7eb5cf16330793a4d1765a37a4bb';

@ProviderFor(plateauAlerts)
final plateauAlertsProvider = PlateauAlertsProvider._();

final class PlateauAlertsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  PlateauAlertsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plateauAlertsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plateauAlertsHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return plateauAlerts(ref);
  }
}

String _$plateauAlertsHash() => r'd73aa8790884bff04ee1f39639dd3c3f331bac6f';

@ProviderFor(overallAchievementTrend)
final overallAchievementTrendProvider = OverallAchievementTrendProvider._();

final class OverallAchievementTrendProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FlSpot>>,
          List<FlSpot>,
          FutureOr<List<FlSpot>>
        >
    with $FutureModifier<List<FlSpot>>, $FutureProvider<List<FlSpot>> {
  OverallAchievementTrendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'overallAchievementTrendProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$overallAchievementTrendHash();

  @$internal
  @override
  $FutureProviderElement<List<FlSpot>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FlSpot>> create(Ref ref) {
    return overallAchievementTrend(ref);
  }
}

String _$overallAchievementTrendHash() =>
    r'52da5c267f8af25142f6ed99835878a80e87fb61';

@ProviderFor(metricAchievementTrend)
final metricAchievementTrendProvider = MetricAchievementTrendFamily._();

final class MetricAchievementTrendProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FlSpot>>,
          List<FlSpot>,
          FutureOr<List<FlSpot>>
        >
    with $FutureModifier<List<FlSpot>>, $FutureProvider<List<FlSpot>> {
  MetricAchievementTrendProvider._({
    required MetricAchievementTrendFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'metricAchievementTrendProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$metricAchievementTrendHash();

  @override
  String toString() {
    return r'metricAchievementTrendProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<FlSpot>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FlSpot>> create(Ref ref) {
    final argument = this.argument as String;
    return metricAchievementTrend(ref, metricId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MetricAchievementTrendProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$metricAchievementTrendHash() =>
    r'84dd7a377b1055f6899ce558f25c325e4abd73de';

final class MetricAchievementTrendFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<FlSpot>>, String> {
  MetricAchievementTrendFamily._()
    : super(
        retry: null,
        name: r'metricAchievementTrendProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MetricAchievementTrendProvider call({required String metricId}) =>
      MetricAchievementTrendProvider._(argument: metricId, from: this);

  @override
  String toString() => r'metricAchievementTrendProvider';
}

@ProviderFor(recentPRs)
final recentPRsProvider = RecentPRsProvider._();

final class RecentPRsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  RecentPRsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentPRsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentPRsHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return recentPRs(ref);
  }
}

String _$recentPRsHash() => r'd130b371b2a845a632292098586dd4184211b1c5';

@ProviderFor(fullPRHistory)
final fullPRHistoryProvider = FullPRHistoryProvider._();

final class FullPRHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          FutureOr<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $FutureProvider<List<Map<String, dynamic>>> {
  FullPRHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fullPRHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fullPRHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Map<String, dynamic>>> create(Ref ref) {
    return fullPRHistory(ref);
  }
}

String _$fullPRHistoryHash() => r'dc8e2c6288fd7d2669d56dcbfe14fbc8470430f7';

@ProviderFor(workoutPRs)
final workoutPRsProvider = WorkoutPRsFamily._();

final class WorkoutPRsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<int>>,
          List<int>,
          FutureOr<List<int>>
        >
    with $FutureModifier<List<int>>, $FutureProvider<List<int>> {
  WorkoutPRsProvider._({
    required WorkoutPRsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'workoutPRsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$workoutPRsHash();

  @override
  String toString() {
    return r'workoutPRsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<int>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<int>> create(Ref ref) {
    final argument = this.argument as int;
    return workoutPRs(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutPRsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$workoutPRsHash() => r'9e3de2bff240a1f01e9999f99113ee69c33feaf1';

final class WorkoutPRsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<int>>, int> {
  WorkoutPRsFamily._()
    : super(
        retry: null,
        name: r'workoutPRsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WorkoutPRsProvider call(int workoutId) =>
      WorkoutPRsProvider._(argument: workoutId, from: this);

  @override
  String toString() => r'workoutPRsProvider';
}

@ProviderFor(BodyMeasurementsList)
final bodyMeasurementsListProvider = BodyMeasurementsListProvider._();

final class BodyMeasurementsListProvider
    extends
        $AsyncNotifierProvider<
          BodyMeasurementsList,
          List<ent.BodyMeasurement>
        > {
  BodyMeasurementsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bodyMeasurementsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bodyMeasurementsListHash();

  @$internal
  @override
  BodyMeasurementsList create() => BodyMeasurementsList();
}

String _$bodyMeasurementsListHash() =>
    r'670ee9d91203ba4747ac9e39be2fee1174de27f5';

abstract class _$BodyMeasurementsList
    extends $AsyncNotifier<List<ent.BodyMeasurement>> {
  FutureOr<List<ent.BodyMeasurement>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ent.BodyMeasurement>>,
              List<ent.BodyMeasurement>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ent.BodyMeasurement>>,
                List<ent.BodyMeasurement>
              >,
              AsyncValue<List<ent.BodyMeasurement>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(BodyTargetsList)
final bodyTargetsListProvider = BodyTargetsListProvider._();

final class BodyTargetsListProvider
    extends $AsyncNotifierProvider<BodyTargetsList, List<target.BodyTarget>> {
  BodyTargetsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bodyTargetsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bodyTargetsListHash();

  @$internal
  @override
  BodyTargetsList create() => BodyTargetsList();
}

String _$bodyTargetsListHash() => r'c9f46fb94fa6d217796e47846c83a639dbf4d62c';

abstract class _$BodyTargetsList
    extends $AsyncNotifier<List<target.BodyTarget>> {
  FutureOr<List<target.BodyTarget>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<target.BodyTarget>>,
              List<target.BodyTarget>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<target.BodyTarget>>,
                List<target.BodyTarget>
              >,
              AsyncValue<List<target.BodyTarget>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ProgressPhotosList)
final progressPhotosListProvider = ProgressPhotosListProvider._();

final class ProgressPhotosListProvider
    extends
        $AsyncNotifierProvider<ProgressPhotosList, List<photo.ProgressPhoto>> {
  ProgressPhotosListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'progressPhotosListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$progressPhotosListHash();

  @$internal
  @override
  ProgressPhotosList create() => ProgressPhotosList();
}

String _$progressPhotosListHash() =>
    r'0e2fc2385b0d68681a896ec78a55549be71f4c8b';

abstract class _$ProgressPhotosList
    extends $AsyncNotifier<List<photo.ProgressPhoto>> {
  FutureOr<List<photo.ProgressPhoto>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<photo.ProgressPhoto>>,
              List<photo.ProgressPhoto>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<photo.ProgressPhoto>>,
                List<photo.ProgressPhoto>
              >,
              AsyncValue<List<photo.ProgressPhoto>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(unifiedDashboardData)
final unifiedDashboardDataProvider = UnifiedDashboardDataProvider._();

final class UnifiedDashboardDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<AnalyticsDashboardData>,
          AnalyticsDashboardData,
          FutureOr<AnalyticsDashboardData>
        >
    with
        $FutureModifier<AnalyticsDashboardData>,
        $FutureProvider<AnalyticsDashboardData> {
  UnifiedDashboardDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unifiedDashboardDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unifiedDashboardDataHash();

  @$internal
  @override
  $FutureProviderElement<AnalyticsDashboardData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AnalyticsDashboardData> create(Ref ref) {
    return unifiedDashboardData(ref);
  }
}

String _$unifiedDashboardDataHash() =>
    r'552cc5fb23e00cffc0c293a96a3e72536ce8b490';

@ProviderFor(physiqueAchievement)
final physiqueAchievementProvider = PhysiqueAchievementProvider._();

final class PhysiqueAchievementProvider
    extends
        $FunctionalProvider<
          AsyncValue<PhysiqueAchievement>,
          PhysiqueAchievement,
          FutureOr<PhysiqueAchievement>
        >
    with
        $FutureModifier<PhysiqueAchievement>,
        $FutureProvider<PhysiqueAchievement> {
  PhysiqueAchievementProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'physiqueAchievementProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$physiqueAchievementHash();

  @$internal
  @override
  $FutureProviderElement<PhysiqueAchievement> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PhysiqueAchievement> create(Ref ref) {
    return physiqueAchievement(ref);
  }
}

String _$physiqueAchievementHash() =>
    r'c20a983984a211c21728978c7a821b0cc02d841c';
