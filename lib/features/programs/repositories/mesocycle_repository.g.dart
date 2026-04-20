// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mesocycle_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mesocycleRepository)
final mesocycleRepositoryProvider = MesocycleRepositoryProvider._();

final class MesocycleRepositoryProvider
    extends
        $FunctionalProvider<
          MesocycleRepository,
          MesocycleRepository,
          MesocycleRepository
        >
    with $Provider<MesocycleRepository> {
  MesocycleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesocycleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesocycleRepositoryHash();

  @$internal
  @override
  $ProviderElement<MesocycleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MesocycleRepository create(Ref ref) {
    return mesocycleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MesocycleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MesocycleRepository>(value),
    );
  }
}

String _$mesocycleRepositoryHash() =>
    r'85b1777e9129badd5a87144374f0ec6b914dea02';
