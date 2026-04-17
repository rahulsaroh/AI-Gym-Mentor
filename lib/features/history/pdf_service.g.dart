// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PdfService)
final pdfServiceProvider = PdfServiceProvider._();

final class PdfServiceProvider extends $NotifierProvider<PdfService, void> {
  PdfServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pdfServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pdfServiceHash();

  @$internal
  @override
  PdfService create() => PdfService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$pdfServiceHash() => r'31884c4bec6e7b8aa6471ef8d4f88756b21d08ea';

abstract class _$PdfService extends $Notifier<void> {
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
