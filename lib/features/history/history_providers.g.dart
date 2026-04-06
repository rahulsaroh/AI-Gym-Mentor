// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historyStatsHash() => r'4456fb11f906bdf13b165715f2483ee4a5b1dafc';

/// See also [historyStats].
@ProviderFor(historyStats)
final historyStatsProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
  historyStats,
  name: r'historyStatsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$historyStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HistoryStatsRef = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$heatmapSetsHash() => r'ef0bd3c30c5cf06663643107545e187d33378366';

/// See also [heatmapSets].
@ProviderFor(heatmapSets)
final heatmapSetsProvider =
    AutoDisposeFutureProvider<List<WorkoutSet>>.internal(
  heatmapSets,
  name: r'heatmapSetsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$heatmapSetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HeatmapSetsRef = AutoDisposeFutureProviderRef<List<WorkoutSet>>;
String _$historyListHash() => r'76b6d80f4570392b35f2da9d31111c37da9570e9';

/// See also [HistoryList].
@ProviderFor(HistoryList)
final historyListProvider =
    AutoDisposeAsyncNotifierProvider<HistoryList, List<Workout>>.internal(
  HistoryList.new,
  name: r'historyListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$historyListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HistoryList = AutoDisposeAsyncNotifier<List<Workout>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
