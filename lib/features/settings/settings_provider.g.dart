// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dataServiceHash() => r'c23e54ac8c8f52748f72bc5159e183843a4e72b6';

/// See also [dataService].
@ProviderFor(dataService)
final dataServiceProvider = AutoDisposeProvider<DataService>.internal(
  dataService,
  name: r'dataServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dataServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DataServiceRef = AutoDisposeProviderRef<DataService>;
String _$settingsHash() => r'374df1393faa783907ebbf2e020b6afa5691a493';

/// See also [Settings].
@ProviderFor(Settings)
final settingsProvider =
    AsyncNotifierProvider<Settings, SettingsState>.internal(
  Settings.new,
  name: r'settingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$settingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Settings = AsyncNotifier<SettingsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
