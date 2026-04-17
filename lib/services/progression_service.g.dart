// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progression_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProgressionService)
final progressionServiceProvider = ProgressionServiceProvider._();

final class ProgressionServiceProvider
    extends $NotifierProvider<ProgressionService, void> {
  ProgressionServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'progressionServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$progressionServiceHash();

  @$internal
  @override
  ProgressionService create() => ProgressionService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$progressionServiceHash() =>
    r'26611ec3700d6d62ef5af24ff2bc9429db68e077';

abstract class _$ProgressionService extends $Notifier<void> {
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
