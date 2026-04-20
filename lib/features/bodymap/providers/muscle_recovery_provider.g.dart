// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_recovery_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(muscleRecovery)
final muscleRecoveryProvider = MuscleRecoveryProvider._();

final class MuscleRecoveryProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, double>>,
          Map<String, double>,
          FutureOr<Map<String, double>>
        >
    with
        $FutureModifier<Map<String, double>>,
        $FutureProvider<Map<String, double>> {
  MuscleRecoveryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'muscleRecoveryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$muscleRecoveryHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, double>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, double>> create(Ref ref) {
    return muscleRecovery(ref);
  }
}

String _$muscleRecoveryHash() => r'b99fff22fb2e2e54ea745e5f4c9d6c3846e78999';
