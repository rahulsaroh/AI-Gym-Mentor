// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(watchSyncService)
final watchSyncServiceProvider = WatchSyncServiceProvider._();

final class WatchSyncServiceProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  WatchSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchSyncServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchSyncServiceHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return watchSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$watchSyncServiceHash() => r'528fe29fc39d325837264615aa81d4b426ba3c8f';
