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
    r'39713e63b9e27389a27daa60f4921487924bdaf9';

abstract class _$WorkoutHomeNotifier extends $AsyncNotifier<WorkoutHomeState> {
  FutureOr<WorkoutHomeState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<WorkoutHomeState>, WorkoutHomeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WorkoutHomeState>, WorkoutHomeState>,
              AsyncValue<WorkoutHomeState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
