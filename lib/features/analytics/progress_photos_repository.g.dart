// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_photos_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(progressPhotosRepository)
final progressPhotosRepositoryProvider = ProgressPhotosRepositoryProvider._();

final class ProgressPhotosRepositoryProvider
    extends
        $FunctionalProvider<
          ProgressPhotosRepository,
          ProgressPhotosRepository,
          ProgressPhotosRepository
        >
    with $Provider<ProgressPhotosRepository> {
  ProgressPhotosRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'progressPhotosRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$progressPhotosRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProgressPhotosRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProgressPhotosRepository create(Ref ref) {
    return progressPhotosRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProgressPhotosRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProgressPhotosRepository>(value),
    );
  }
}

String _$progressPhotosRepositoryHash() =>
    r'7f6b211cc5677eb5393f9abcbdaa9c0f127e3d05';
