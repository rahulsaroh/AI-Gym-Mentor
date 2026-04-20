// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WatchService)
final watchServiceProvider = WatchServiceProvider._();

final class WatchServiceProvider extends $NotifierProvider<WatchService, void> {
  WatchServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchServiceHash();

  @$internal
  @override
  WatchService create() => WatchService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$watchServiceHash() => r'5d04cddd3f56d62ccb34feea11902cf3d54af17e';

abstract class _$WatchService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
