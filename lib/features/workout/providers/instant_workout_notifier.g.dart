// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instant_workout_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InstantWorkoutNotifier)
final instantWorkoutProvider = InstantWorkoutNotifierProvider._();

final class InstantWorkoutNotifierProvider
    extends $AsyncNotifierProvider<InstantWorkoutNotifier, int?> {
  InstantWorkoutNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'instantWorkoutProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$instantWorkoutNotifierHash();

  @$internal
  @override
  InstantWorkoutNotifier create() => InstantWorkoutNotifier();
}

String _$instantWorkoutNotifierHash() =>
    r'cfaa80c6b75f6be3882657c786e6293052c9f9fa';

abstract class _$InstantWorkoutNotifier extends $AsyncNotifier<int?> {
  FutureOr<int?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<int?>, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int?>, int?>,
              AsyncValue<int?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
