// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_qa_checker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExerciseQaChecker)
final exerciseQaCheckerProvider = ExerciseQaCheckerProvider._();

final class ExerciseQaCheckerProvider
    extends $NotifierProvider<ExerciseQaChecker, void> {
  ExerciseQaCheckerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'exerciseQaCheckerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$exerciseQaCheckerHash();

  @$internal
  @override
  ExerciseQaChecker create() => ExerciseQaChecker();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$exerciseQaCheckerHash() => r'0e7824227bbd3d8f40c447dc3d08d3473ec37b8e';

abstract class _$ExerciseQaChecker extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
