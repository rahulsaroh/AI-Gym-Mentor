// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_library_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exerciseLibraryRepository)
final exerciseLibraryRepositoryProvider = ExerciseLibraryRepositoryProvider._();

final class ExerciseLibraryRepositoryProvider extends $FunctionalProvider<
    ExerciseLibraryRepository,
    ExerciseLibraryRepository,
    ExerciseLibraryRepository> with $Provider<ExerciseLibraryRepository> {
  ExerciseLibraryRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'exerciseLibraryRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$exerciseLibraryRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExerciseLibraryRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExerciseLibraryRepository create(Ref ref) {
    return exerciseLibraryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExerciseLibraryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExerciseLibraryRepository>(value),
    );
  }
}

String _$exerciseLibraryRepositoryHash() =>
    r'9f0dd0c8831414e8f814bf33291eeab8a0e85591';
