// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csv_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CsvService)
final csvServiceProvider = CsvServiceProvider._();

final class CsvServiceProvider extends $NotifierProvider<CsvService, void> {
  CsvServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'csvServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$csvServiceHash();

  @$internal
  @override
  CsvService create() => CsvService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$csvServiceHash() => r'c519c4cde8b94ff4ca3a65163d2ec3ed650a161f';

abstract class _$CsvService extends $Notifier<void> {
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
