// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_home_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkoutHomeNotifier)
final workoutHomeProvider = WorkoutHomeNotifierProvider._();

final class WorkoutHomeNotifierProvider
    extends $AsyncNotifierProvider<WorkoutHomeNotifier, WorkoutHomeState> {
  WorkoutHomeNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'workoutHomeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$workoutHomeNotifierHash();

  @$internal
  @override
  WorkoutHomeNotifier create() => WorkoutHomeNotifier();
}

String _$workoutHomeNotifierHash() =>
    r'5d038d5dc40e2b2b8eeb7c8dd0a342eb7486cf89';

abstract class _$WorkoutHomeNotifier extends $AsyncNotifier<WorkoutHomeState> {
  FutureOr<WorkoutHomeState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<WorkoutHomeState>, WorkoutHomeState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<WorkoutHomeState>, WorkoutHomeState>,
        AsyncValue<WorkoutHomeState>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
