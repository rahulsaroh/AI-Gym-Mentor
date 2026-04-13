// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exerciseRepository)
final exerciseRepositoryProvider = ExerciseRepositoryProvider._();

final class ExerciseRepositoryProvider extends $FunctionalProvider<
    ExerciseRepository,
    ExerciseRepository,
    ExerciseRepository> with $Provider<ExerciseRepository> {
  ExerciseRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'exerciseRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$exerciseRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExerciseRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExerciseRepository create(Ref ref) {
    return exerciseRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExerciseRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExerciseRepository>(value),
    );
  }
}

String _$exerciseRepositoryHash() =>
    r'3889a983676e1613e2fa84795d15f761611f96d0';
