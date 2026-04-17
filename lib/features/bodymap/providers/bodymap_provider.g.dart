// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bodymap_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BodymapMode)
final bodymapModeProvider = BodymapModeProvider._();

final class BodymapModeProvider
    extends $NotifierProvider<BodymapMode, BodyMapMode> {
  BodymapModeProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'bodymapModeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$bodymapModeHash();

  @$internal
  @override
  BodymapMode create() => BodymapMode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BodyMapMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BodyMapMode>(value),
    );
  }
}

String _$bodymapModeHash() => r'153ff137dd432e23e585420f334f096f92f9180f';

abstract class _$BodymapMode extends $Notifier<BodyMapMode> {
  BodyMapMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BodyMapMode, BodyMapMode>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<BodyMapMode, BodyMapMode>, BodyMapMode, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
