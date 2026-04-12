// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plateau_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlateauService)
final plateauServiceProvider = PlateauServiceProvider._();

final class PlateauServiceProvider
    extends $NotifierProvider<PlateauService, void> {
  PlateauServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'plateauServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$plateauServiceHash();

  @$internal
  @override
  PlateauService create() => PlateauService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$plateauServiceHash() => r'7ab0904866792ec1f250cc8437cb7215574034fb';

abstract class _$PlateauService extends $Notifier<void> {
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
