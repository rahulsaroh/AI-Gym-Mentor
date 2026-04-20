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

String _$csvImportServiceHash() => r'b9dc94c094f8da47ddbde6d2e1ea859d574ce154';

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
