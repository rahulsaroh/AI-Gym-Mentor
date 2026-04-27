// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Settings)
final settingsProvider = SettingsProvider._();

final class SettingsProvider
    extends $AsyncNotifierProvider<Settings, SettingsState> {
  SettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsHash();

  @$internal
  @override
  Settings create() => Settings();
}

String _$settingsHash() => r'05c7f59fad7a097e8c7090ee715acfa7f75df345';

abstract class _$Settings extends $AsyncNotifier<SettingsState> {
  FutureOr<SettingsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SettingsState>, SettingsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SettingsState>, SettingsState>,
              AsyncValue<SettingsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(dataService)
final dataServiceProvider = DataServiceProvider._();

final class DataServiceProvider
    extends $FunctionalProvider<DataService, DataService, DataService>
    with $Provider<DataService> {
  DataServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dataServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dataServiceHash();

  @$internal
  @override
  $ProviderElement<DataService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DataService create(Ref ref) {
    return dataService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DataService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DataService>(value),
    );
  }
}

String _$dataServiceHash() => r'b708822fcf0e79883558f3d33a8e9ae6c77a1c1e';
