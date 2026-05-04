// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_in_review_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(YearInReviewNotifier)
final yearInReviewProvider = YearInReviewNotifierFamily._();

final class YearInReviewNotifierProvider
    extends $AsyncNotifierProvider<YearInReviewNotifier, YearInReviewData?> {
  YearInReviewNotifierProvider._({
    required YearInReviewNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'yearInReviewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$yearInReviewNotifierHash();

  @override
  String toString() {
    return r'yearInReviewProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  YearInReviewNotifier create() => YearInReviewNotifier();

  @override
  bool operator ==(Object other) {
    return other is YearInReviewNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$yearInReviewNotifierHash() =>
    r'bd6eb92bdd84c4c5684825efb919f4283bd75b73';

final class YearInReviewNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          YearInReviewNotifier,
          AsyncValue<YearInReviewData?>,
          YearInReviewData?,
          FutureOr<YearInReviewData?>,
          int
        > {
  YearInReviewNotifierFamily._()
    : super(
        retry: null,
        name: r'yearInReviewProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  YearInReviewNotifierProvider call(int year) =>
      YearInReviewNotifierProvider._(argument: year, from: this);

  @override
  String toString() => r'yearInReviewProvider';
}

abstract class _$YearInReviewNotifier
    extends $AsyncNotifier<YearInReviewData?> {
  late final _$args = ref.$arg as int;
  int get year => _$args;

  FutureOr<YearInReviewData?> build(int year);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<YearInReviewData?>, YearInReviewData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<YearInReviewData?>, YearInReviewData?>,
              AsyncValue<YearInReviewData?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(availableReviewYears)
final availableReviewYearsProvider = AvailableReviewYearsProvider._();

final class AvailableReviewYearsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<int>>,
          List<int>,
          FutureOr<List<int>>
        >
    with $FutureModifier<List<int>>, $FutureProvider<List<int>> {
  AvailableReviewYearsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableReviewYearsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableReviewYearsHash();

  @$internal
  @override
  $FutureProviderElement<List<int>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<int>> create(Ref ref) {
    return availableReviewYears(ref);
  }
}

String _$availableReviewYearsHash() =>
    r'34f1f5efc1fee2fd7f0e7d7ec696be1a45b2b883';
