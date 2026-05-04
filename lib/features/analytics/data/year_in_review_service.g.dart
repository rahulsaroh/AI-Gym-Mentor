// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_in_review_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(yearInReviewService)
final yearInReviewServiceProvider = YearInReviewServiceProvider._();

final class YearInReviewServiceProvider
    extends
        $FunctionalProvider<
          YearInReviewService,
          YearInReviewService,
          YearInReviewService
        >
    with $Provider<YearInReviewService> {
  YearInReviewServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'yearInReviewServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$yearInReviewServiceHash();

  @$internal
  @override
  $ProviderElement<YearInReviewService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  YearInReviewService create(Ref ref) {
    return yearInReviewService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(YearInReviewService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<YearInReviewService>(value),
    );
  }
}

String _$yearInReviewServiceHash() =>
    r'1abb107a41b1df51685a1c98280bc5eb7b3d9cb0';
