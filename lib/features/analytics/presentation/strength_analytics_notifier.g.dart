// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strength_analytics_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StrengthAnalyticsNotifier)
final strengthAnalyticsProvider = StrengthAnalyticsNotifierProvider._();

final class StrengthAnalyticsNotifierProvider
    extends
        $AsyncNotifierProvider<
          StrengthAnalyticsNotifier,
          StrengthOverviewState
        > {
  StrengthAnalyticsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'strengthAnalyticsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$strengthAnalyticsNotifierHash();

  @$internal
  @override
  StrengthAnalyticsNotifier create() => StrengthAnalyticsNotifier();
}

String _$strengthAnalyticsNotifierHash() =>
    r'80a26e6f27dae1a2edeecf3590898dac08f18268';

abstract class _$StrengthAnalyticsNotifier
    extends $AsyncNotifier<StrengthOverviewState> {
  FutureOr<StrengthOverviewState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<StrengthOverviewState>, StrengthOverviewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<StrengthOverviewState>,
                StrengthOverviewState
              >,
              AsyncValue<StrengthOverviewState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
