// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csv_import_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CsvImportService)
final csvImportServiceProvider = CsvImportServiceProvider._();

final class CsvImportServiceProvider
    extends $NotifierProvider<CsvImportService, void> {
  CsvImportServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'csvImportServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$csvImportServiceHash();

  @$internal
  @override
  CsvImportService create() => CsvImportService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$csvImportServiceHash() => r'cba1b31c18c7c9300b5949c945630c4c2dbe00b6';

abstract class _$CsvImportService extends $Notifier<void> {
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
