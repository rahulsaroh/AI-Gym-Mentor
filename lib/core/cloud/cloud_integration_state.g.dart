// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_integration_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CloudIntegration)
final cloudIntegrationProvider = CloudIntegrationProvider._();

final class CloudIntegrationProvider
    extends $NotifierProvider<CloudIntegration, CloudIntegrationState> {
  CloudIntegrationProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'cloudIntegrationProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$cloudIntegrationHash();

  @$internal
  @override
  CloudIntegration create() => CloudIntegration();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CloudIntegrationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CloudIntegrationState>(value),
    );
  }
}

String _$cloudIntegrationHash() => r'83000bd86767cf3390d84cc66b39b772cbd8b39a';

abstract class _$CloudIntegration extends $Notifier<CloudIntegrationState> {
  CloudIntegrationState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CloudIntegrationState, CloudIntegrationState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<CloudIntegrationState, CloudIntegrationState>,
        CloudIntegrationState,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
