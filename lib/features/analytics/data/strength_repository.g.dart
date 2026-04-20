// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strength_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(strengthRepository)
final strengthRepositoryProvider = StrengthRepositoryProvider._();

final class StrengthRepositoryProvider
    extends
        $FunctionalProvider<
          StrengthRepository,
          StrengthRepository,
          StrengthRepository
        >
    with $Provider<StrengthRepository> {
  StrengthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'strengthRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$strengthRepositoryHash();

  @$internal
  @override
  $ProviderElement<StrengthRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StrengthRepository create(Ref ref) {
    return strengthRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StrengthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StrengthRepository>(value),
    );
  }
}

String _$strengthRepositoryHash() =>
    r'83a6639bcbdec1ccc7a4d6fb4926388242194bc4';
