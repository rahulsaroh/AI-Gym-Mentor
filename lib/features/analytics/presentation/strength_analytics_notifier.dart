import 'package:ai_gym_mentor/features/analytics/data/strength_repository.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_gym_mentor/core/database/database.dart';

part 'strength_analytics_notifier.g.dart';

enum StrengthTimeRange { last30Days, last90Days, lastYear, allTime }

class StrengthOverviewState {
  final List<Map<String, dynamic>> enrichedSnapshots;
  final List<Exercise1RmSnapshot> recentPRs;
  final Map<int, Map<String, dynamic>> exerciseMetrics;
  final List<Map<String, dynamic>> topMovers;
  final List<Map<String, dynamic>> stagnatingExercises;
  final double globalTrend;
  final StrengthTimeRange timeRange;
  final bool isBackfilling;

  StrengthOverviewState({
    this.enrichedSnapshots = const [],
    this.recentPRs = const [],
    this.exerciseMetrics = const {},
    this.topMovers = const [],
    this.stagnatingExercises = const [],
    this.globalTrend = 0,
    this.timeRange = StrengthTimeRange.last30Days,
    this.isBackfilling = false,
  });

  StrengthOverviewState copyWith({
    List<Map<String, dynamic>>? enrichedSnapshots,
    List<Exercise1RmSnapshot>? recentPRs,
    Map<int, Map<String, dynamic>>? exerciseMetrics,
    List<Map<String, dynamic>>? topMovers,
    List<Map<String, dynamic>>? stagnatingExercises,
    double? globalTrend,
    StrengthTimeRange? timeRange,
    bool? isBackfilling,
  }) {
    return StrengthOverviewState(
      enrichedSnapshots: enrichedSnapshots ?? this.enrichedSnapshots,
      recentPRs: recentPRs ?? this.recentPRs,
      exerciseMetrics: exerciseMetrics ?? this.exerciseMetrics,
      topMovers: topMovers ?? this.topMovers,
      stagnatingExercises: stagnatingExercises ?? this.stagnatingExercises,
      globalTrend: globalTrend ?? this.globalTrend,
      timeRange: timeRange ?? this.timeRange,
      isBackfilling: isBackfilling ?? this.isBackfilling,
    );
  }
}

@riverpod
class StrengthAnalyticsNotifier extends _$StrengthAnalyticsNotifier {
  @override
  Future<StrengthOverviewState> build() async {
    final repo = ref.watch(strengthRepositoryProvider);
    final previousState = state.asData?.value;
    final timeRange = previousState?.timeRange ?? StrengthTimeRange.last30Days;
    final now = DateTime.now();
    
    DateTime rangeStart = now.subtract(const Duration(days: 30));
    switch (timeRange) {
      case StrengthTimeRange.last30Days:
        rangeStart = now.subtract(const Duration(days: 30));
        break;
      case StrengthTimeRange.last90Days:
        rangeStart = now.subtract(const Duration(days: 90));
        break;
      case StrengthTimeRange.lastYear:
        rangeStart = now.subtract(const Duration(days: 365));
        break;
      case StrengthTimeRange.allTime:
        rangeStart = DateTime(2000);
        break;
    }

    // Check if backfill is needed (no snapshots existing)
    final allEnriched = await repo.getEnrichedSnapshots();
    if (allEnriched.isEmpty) {
      _triggerBackfill();
    }

    final enrichedInRange = await repo.getEnrichedSnapshots(start: rangeStart);
    final recentPRs = await repo.getRecentPRs(since: rangeStart);
    final topMovers = await repo.getTopMovers(rangeStart, now);
    final stagnating = await repo.getStagnatingExercises(30); // 30 days stagnation threshold
    final globalTrend = await repo.getGlobalStrengthTrend(rangeStart, now);

    final Map<int, Map<String, dynamic>> metrics = {};
    
    // Get unique latest snapshots for the exercise list
    final latestEnriched = <int, Map<String, dynamic>>{};
    for (var e in allEnriched) {
      final id = (e['snapshot'] as Exercise1RmSnapshot).exerciseId;
      if (!latestEnriched.containsKey(id)) {
        latestEnriched[id] = e;
      }
    }

    final latestList = latestEnriched.values.toList();
    for (final e in latestList.take(10)) {
      final s = e['snapshot'] as Exercise1RmSnapshot;
      metrics[s.exerciseId] = await repo.getExerciseStrengthMetrics(s.exerciseId, rangeStart: rangeStart);
    }

    return StrengthOverviewState(
      enrichedSnapshots: latestList,
      recentPRs: recentPRs,
      exerciseMetrics: metrics,
      topMovers: topMovers,
      stagnatingExercises: stagnating,
      globalTrend: globalTrend,
      timeRange: timeRange,
      isBackfilling: previousState?.isBackfilling ?? false,
    );
  }

  void setTimeRange(StrengthTimeRange range) {
    state = AsyncValue.data(state.value!.copyWith(timeRange: range));
    ref.invalidateSelf();
  }

  Future<void> _triggerBackfill() async {
    final repo = ref.read(strengthRepositoryProvider);
    final settings = await ref.read(settingsProvider.future);
    
    state = AsyncValue.data(state.value?.copyWith(isBackfilling: true) ?? StrengthOverviewState(isBackfilling: true));
    
    try {
      await repo.performBackfill(settings.oneRmFormula);
      ref.invalidateSelf();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

