// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoryFilterState)
final historyFilterStateProvider = HistoryFilterStateProvider._();

final class HistoryFilterStateProvider
    extends $NotifierProvider<HistoryFilterState, HistoryFilter> {
  HistoryFilterStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'historyFilterStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$historyFilterStateHash();

  @$internal
  @override
  HistoryFilterState create() => HistoryFilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HistoryFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HistoryFilter>(value),
    );
  }
}

String _$historyFilterStateHash() =>
    r'fce4a774d67c41917891051cf05fb98c3d4ff29d';

abstract class _$HistoryFilterState extends $Notifier<HistoryFilter> {
  HistoryFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<HistoryFilter, HistoryFilter>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<HistoryFilter, HistoryFilter>,
        HistoryFilter,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(historyStats)
final historyStatsProvider = HistoryStatsProvider._();

final class HistoryStatsProvider extends $FunctionalProvider<
        AsyncValue<Map<String, dynamic>>,
        Map<String, dynamic>,
        FutureOr<Map<String, dynamic>>>
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  HistoryStatsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'historyStatsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$historyStatsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return historyStats(ref);
  }
}

String _$historyStatsHash() => r'4860a477cbc069456b7902bcfcae25b44cedb8ec';

@ProviderFor(HistoryList)
final historyListProvider = HistoryListProvider._();

final class HistoryListProvider
    extends $AsyncNotifierProvider<HistoryList, List<HistoryItem>> {
  HistoryListProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'historyListProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$historyListHash();

  @$internal
  @override
  HistoryList create() => HistoryList();
}

String _$historyListHash() => r'7ebb6f44bb14eba3a0624b8bc88e7dfedeae67d8';

abstract class _$HistoryList extends $AsyncNotifier<List<HistoryItem>> {
  FutureOr<List<HistoryItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<HistoryItem>>, List<HistoryItem>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<HistoryItem>>, List<HistoryItem>>,
        AsyncValue<List<HistoryItem>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(heatmapSets)
final heatmapSetsProvider = HeatmapSetsProvider._();

final class HeatmapSetsProvider extends $FunctionalProvider<
        AsyncValue<List<ent.LoggedSet>>,
        List<ent.LoggedSet>,
        FutureOr<List<ent.LoggedSet>>>
    with
        $FutureModifier<List<ent.LoggedSet>>,
        $FutureProvider<List<ent.LoggedSet>> {
  HeatmapSetsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'heatmapSetsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$heatmapSetsHash();

  @$internal
  @override
  $FutureProviderElement<List<ent.LoggedSet>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<ent.LoggedSet>> create(Ref ref) {
    return heatmapSets(ref);
  }
}

String _$heatmapSetsHash() => r'50b237ca9c4bb4f8705aa77e93d01942a8e3ae17';
