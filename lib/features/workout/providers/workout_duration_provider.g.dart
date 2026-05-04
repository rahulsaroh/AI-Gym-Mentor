// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_duration_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkoutDuration)
final workoutDurationProvider = WorkoutDurationProvider._();

final class WorkoutDurationProvider
    extends $NotifierProvider<WorkoutDuration, int> {
  WorkoutDurationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutDurationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutDurationHash();

  @$internal
  @override
  WorkoutDuration create() => WorkoutDuration();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$workoutDurationHash() => r'c46296e2f435f793b93ea7902613ea13382a65e0';

abstract class _$WorkoutDuration extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
