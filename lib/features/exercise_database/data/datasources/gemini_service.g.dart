// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GeminiService)
final geminiServiceProvider = GeminiServiceProvider._();

final class GeminiServiceProvider
    extends $NotifierProvider<GeminiService, void> {
  GeminiServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'geminiServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$geminiServiceHash();

  @$internal
  @override
  GeminiService create() => GeminiService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$geminiServiceHash() => r'c49de3ecf5b82ae30d5d41eb39c9f418d3b4e525';

abstract class _$GeminiService extends $Notifier<void> {
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
