import 'package:ai_gym_mentor/features/analytics/stats_repository.dart';
import 'package:ai_gym_mentor/features/analytics/progress_photos_repository.dart';
import 'package:ai_gym_mentor/features/analytics/measurements_repository.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart'
    as ent;
import 'package:ai_gym_mentor/core/domain/entities/body_target.dart' as target;
import 'package:ai_gym_mentor/core/domain/entities/progress_photo.dart'
    as photo;
import 'package:ai_gym_mentor/core/domain/entities/body_achievement.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/core/services/golden_ratio_service.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'analytics_providers.g.dart';

/// Provides the golden-ratio ideal targets for the current user profile.
final goldenRatioTargetsProvider = Provider<Map<String, double>>((ref) {
  final settings = ref.watch(settingsProvider).asData?.value;
  if (settings == null) return {};
  return GoldenRatioService.calculateTargets(
    heightCm: settings.height,
    sex: settings.sex,
  );
});

/// Global date-range filter for the Measurements tab.
/// When null: each target uses its own createdAt/deadline.
/// When set: ALL cards compute progress within this window.
enum MeasurementInterval {
  d14('14d'),
  m1('1M'),
  m3('3M'),
  m6('6M'),
  m12('12M'),
  all('All');

  final String label;
  const MeasurementInterval(this.label);
}

@riverpod
class SelectedMeasurementInterval extends _$SelectedMeasurementInterval {
  @override
  MeasurementInterval build() => MeasurementInterval.m1;

  void set(MeasurementInterval interval) {
    state = interval;
    // Also update the date range
    final now = DateTime.now();
    DateTime? start;
    switch (interval) {
      case MeasurementInterval.d14:
        start = now.subtract(const Duration(days: 14));
        break;
      case MeasurementInterval.m1:
        start = DateTime(now.year, now.month - 1, now.day);
        break;
      case MeasurementInterval.m3:
        start = DateTime(now.year, now.month - 3, now.day);
        break;
      case MeasurementInterval.m6:
        start = DateTime(now.year, now.month - 6, now.day);
        break;
      case MeasurementInterval.m12:
        start = DateTime(now.year - 1, now.month, now.day);
        break;
      case MeasurementInterval.all:
        start = null;
        break;
    }
    
    if (start != null) {
      ref.read(measurementDateRangeProvider.notifier).set(
        DateTimeRange(start: start, end: now.add(const Duration(days: 1)))
      );
    } else {
      ref.read(measurementDateRangeProvider.notifier).clear();
    }
  }
}

/// Global date-range filter for the Measurements tab.
/// When null: each target uses its own createdAt/deadline.
/// When set: ALL cards compute progress within this window.
@riverpod
class MeasurementDateRange extends _$MeasurementDateRange {
  @override
  DateTimeRange? build() => DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now().add(const Duration(days: 1)),
  );

  void set(DateTimeRange? range) => state = range;
  void clear() => state = null;
}

class AnalyticsDashboardData {
  final Map<String, dynamic> overview;
  final List<Map<String, dynamic>> recentPRs;
  final List<Map<String, dynamic>> volumeTrend;
  final List<Map<String, dynamic>> durationTrend;
  final List<Map<String, dynamic>> weightTrend;
  final Map<String, dynamic> muscleBalance;
  final Map<DateTime, int> activity;

  AnalyticsDashboardData({
    required this.overview,
    required this.recentPRs,
    required this.volumeTrend,
    required this.durationTrend,
    required this.weightTrend,
    required this.muscleBalance,
    required this.activity,
  });
}

@riverpod
Future<Map<String, dynamic>> dashboardStats(Ref ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getOverviewStats();
}

@riverpod
Future<List<Map<String, dynamic>>> recentPRs(Ref ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getRecentPRs();
}

@riverpod
Future<List<Map<String, dynamic>>> volumeTrend(Ref ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getWeeklyVolumeTrend();
}

@riverpod
Future<List<Map<String, dynamic>>> durationTrend(Ref ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getDurationTrend();
}

@riverpod
Future<List<Map<String, dynamic>>> frequencyTrend(Ref ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getWorkoutFrequency();
}

@riverpod
Future<Map<DateTime, int>> dailyActivity(Ref ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getDailyWorkoutActivity();
}

@riverpod
Future<List<Map<String, dynamic>>> weightTrend(Ref ref) async {
  final measurements = await ref.watch(bodyMeasurementsListProvider.future);
  final weightData = measurements
      .where((m) => m.weight != null)
      .map((m) => {'date': m.date, 'weight': m.weight!})
      .toList();
  weightData.sort(
    (a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime),
  );
  return weightData;
}

@riverpod
Future<Map<String, dynamic>> muscleBalance(Ref ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getMuscleBalance();
}

@riverpod
Future<List<Map<String, dynamic>>> volumeVsWeightTrend(Ref ref) async {
  final volume = await ref.watch(volumeTrendProvider.future);
  final weight = await ref.watch(weightTrendProvider.future);

  if (volume.isEmpty) return [];

  return volume.map((v) {
    final vDate = v['date'] as DateTime;

    // Find closest weight measurement to this week
    Map<String, dynamic>? closestWeight;
    int minDiff = 999999999;

    for (var w in weight) {
      final wDate = w['date'] as DateTime;
      final diff = (vDate.difference(wDate).inDays).abs();
      if (diff < minDiff) {
        minDiff = diff;
        closestWeight = w;
      }
    }

    return {
      'date': vDate,
      'volume': v['volume'],
      'weight': closestWeight?['weight'] ?? 0.0,
    };
  }).toList();
}

@riverpod
Future<List<Map<String, dynamic>>> plateauAlerts(Ref ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getPlateauAlerts();
}

@riverpod
Future<List<FlSpot>> overallAchievementTrend(Ref ref) async {
  final measurements = await ref.watch(bodyMeasurementsListProvider.future);
  final targets = await ref.watch(bodyTargetsListProvider.future);
  final dateRange = ref.watch(measurementDateRangeProvider);

  if (targets.isEmpty) return [];

  // 1. Filter and sort measurements
  final filtered = measurements.where((m) {
    if (dateRange == null) return true;
    return m.date.isAfter(dateRange.start) && m.date.isBefore(dateRange.end);
  }).toList();
  filtered.sort((a, b) => a.date.compareTo(b.date));

  // 2. For each measurement date, calculate average achievement
  final List<FlSpot> spots = [];
  for (final m in filtered) {
    double totalAchievement = 0;
    int count = 0;
    for (final t in targets) {
      final currentVal = extractMetricValue(m, t.metric);
      if (currentVal == null || currentVal == 0) continue;

      // Find first measurement ever for this metric to be the "start"
      final firstM = measurements
          .where((m2) => extractMetricValue(m2, t.metric) != null)
          .toList()
        ..sort((a, b) => a.date.compareTo(b.date));

      if (firstM.isEmpty) continue;
      final startVal = extractMetricValue(firstM.first, t.metric)!;
      final targetVal = t.targetValue;

      if ((targetVal - startVal).abs() > 0.001) {
        final ratio = (currentVal - startVal) / (targetVal - startVal);
        totalAchievement += ratio.clamp(-1.0, 2.0);
        count++;
      }
    }
    if (count > 0) {
      spots.add(FlSpot(
          m.date.millisecondsSinceEpoch.toDouble(), totalAchievement / count));
    }
  }
  return spots;
}

@riverpod
Future<List<FlSpot>> metricAchievementTrend(Ref ref,
    {required String metricId}) async {
  final measurements = await ref.watch(bodyMeasurementsListProvider.future);
  final targets = await ref.watch(bodyTargetsListProvider.future);
  final dateRange = ref.watch(measurementDateRangeProvider);

  final target = targets.where((t) => t.metric == metricId).firstOrNull;
  if (target == null) return [];

  final filtered = measurements.where((m) {
    if (dateRange == null) return true;
    return m.date.isAfter(dateRange.start) && m.date.isBefore(dateRange.end);
  }).toList();
  filtered.sort((a, b) => a.date.compareTo(b.date));

  final firstM = measurements
      .where((m2) => extractMetricValue(m2, metricId) != null)
      .toList()
    ..sort((a, b) => a.date.compareTo(b.date));

  if (firstM.isEmpty) return [];
  final startVal = extractMetricValue(firstM.first, metricId)!;
  final targetVal = target.targetValue;

  return filtered
      .map((m) {
        final currentVal = extractMetricValue(m, metricId);
        if (currentVal == null || currentVal == 0) return null;

        double ratio = 0;
        if ((targetVal - startVal).abs() > 0.001) {
          ratio = (currentVal - startVal) / (targetVal - startVal);
        }
        return FlSpot(
            m.date.millisecondsSinceEpoch.toDouble(), ratio.clamp(-1.0, 2.0));
      })
      .whereType<FlSpot>()
      .toList();
}



@riverpod
Future<List<Map<String, dynamic>>> fullPRHistory(Ref ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getFullPRHistory();
}

@riverpod
Future<List<int>> workoutPRs(Ref ref, int workoutId) async {
  final repo = ref.watch(statsRepositoryProvider);
  final fullHistory = await ref.watch(fullPRHistoryProvider.future);

  // A PR was achieved in this workout if the date of its all-time best matches the workout date
  final workout = await (repo.db.select(
    repo.db.workouts,
  )..where((t) => t.id.equals(workoutId))).getSingle();

  return fullHistory
      .where(
        (pr) =>
            (pr['date'] as DateTime).day == workout.date.day &&
            (pr['date'] as DateTime).month == workout.date.month &&
            (pr['date'] as DateTime).year == workout.date.year,
      )
      .map((pr) => pr['exerciseId'] as int)
      .toList();
}

@riverpod
class BodyMeasurementsList extends _$BodyMeasurementsList {
  @override
  Future<List<ent.BodyMeasurement>> build() async {
    final repo = ref.watch(measurementsRepositoryProvider);
    return await repo.getAllMeasurements();
  }

  Future<void> addMeasurement(ent.BodyMeasurement measurement) async {
    final repo = ref.read(measurementsRepositoryProvider);
    await repo.addMeasurement(measurement);
    ref.invalidateSelf();
  }

  Future<void> deleteMeasurement(int id) async {
    final repo = ref.read(measurementsRepositoryProvider);
    await repo.deleteMeasurement(id);
    ref.invalidateSelf();
  }

  Future<void> deleteMeasurements(Iterable<int> ids) async {
    final repo = ref.read(measurementsRepositoryProvider);
    for (final id in ids) {
      await repo.deleteMeasurement(id);
    }
    ref.invalidateSelf();
  }

  Future<void> clearAllHistory() async {
    final repo = ref.read(measurementsRepositoryProvider);
    await repo.deleteAllMeasurements();
    ref.invalidateSelf();
  }

  Future<void> seedSampleData() async {
    // Hardcoded seeding disabled to ensure data integrity.
    // In the future, this could be replaced with a real demo-data generator if needed.
    ref.invalidateSelf();
  }
}

@riverpod
class BodyTargetsList extends _$BodyTargetsList {
  @override
  Future<List<target.BodyTarget>> build() async {
    final repo = ref.watch(measurementsRepositoryProvider);
    return await repo.getAllTargets();
  }

  Future<void> addTarget(target.BodyTarget tb) async {
    final repo = ref.read(measurementsRepositoryProvider);
    await repo.addTarget(tb);
    ref.invalidateSelf();
  }

  Future<void> deleteTarget(int id) async {
    final repo = ref.read(measurementsRepositoryProvider);
    await repo.deleteTarget(id);
    ref.invalidateSelf();
  }

  Future<void> clearAllTargets() async {
    final repo = ref.read(measurementsRepositoryProvider);
    await repo.deleteAllTargets();
    ref.invalidateSelf();
  }

  Future<void> seedSampleTargets() async {
    // Hardcoded seeding disabled.
    ref.invalidateSelf();
  }
}

@riverpod
class ProgressPhotosList extends _$ProgressPhotosList {
  @override
  Future<List<photo.ProgressPhoto>> build() async {
    final repo = ref.watch(progressPhotosRepositoryProvider);
    return await repo.getAllPhotos();
  }

  Future<void> addPhoto(photo.ProgressPhoto pp) async {
    final repo = ref.watch(progressPhotosRepositoryProvider);
    await repo.addPhoto(pp);
    ref.invalidateSelf();
  }

  Future<void> deletePhoto(int id) async {
    final repo = ref.watch(progressPhotosRepositoryProvider);
    await repo.deletePhoto(id);
    ref.invalidateSelf();
  }
}

@riverpod
Future<AnalyticsDashboardData> unifiedDashboardData(Ref ref) async {
  // Use .future to wait for all the individual providers to resolve
  final results = await Future.wait([
    ref.watch(dashboardStatsProvider.future),
    ref.watch(recentPRsProvider.future),
    ref.watch(volumeTrendProvider.future),
    ref.watch(durationTrendProvider.future),
    ref.watch(weightTrendProvider.future),
    ref.watch(muscleBalanceProvider.future),
    ref.watch(dailyActivityProvider.future),
  ]);

  return AnalyticsDashboardData(
    overview: results[0] as Map<String, dynamic>,
    recentPRs: results[1] as List<Map<String, dynamic>>,
    volumeTrend: results[2] as List<Map<String, dynamic>>,
    durationTrend: results[3] as List<Map<String, dynamic>>,
    weightTrend: results[4] as List<Map<String, dynamic>>,
    muscleBalance: results[5] as Map<String, dynamic>,
    activity: results[6] as Map<DateTime, int>,
  );
}

@riverpod
Future<PhysiqueAchievement> physiqueAchievement(Ref ref) async {
  final targets = await ref.watch(bodyTargetsListProvider.future);
  final measurements = await ref.watch(bodyMeasurementsListProvider.future);
  final dateRange = ref.watch(measurementDateRangeProvider);

  return calculatePhysiqueScore(
    targets,
    measurements,
    dateRange: dateRange,
  );
}

PhysiqueAchievement calculatePhysiqueScore(
  List<target.BodyTarget> targets,
  List<ent.BodyMeasurement> allMeasurements, {
  DateTimeRange? dateRange,
}) {
  final achievements = <MetricAchievement>[];

  // ── Deduplicate targets: keep only the LATEST per metric ─────────────────
  final latestTargetMap = <String, target.BodyTarget>{};
  for (final t in targets) {
    final existing = latestTargetMap[t.metric];
    if (existing == null || t.createdAt.isAfter(existing.createdAt)) {
      latestTargetMap[t.metric] = t;
    }
  }

  // ── Local helpers ─────────────────────────────────────────────────────────
  (double? current, double? start, DateTime? startDate) getMetricRangeValues(String metric) {
    final filtered = allMeasurements
        .where((m) {
          final v = extractMetricValue(m, metric);
          if (v == null || v == 0) return false;
          if (dateRange == null) return true;
          return m.date.isAfter(dateRange.start.subtract(const Duration(seconds: 1))) && 
                 m.date.isBefore(dateRange.end.add(const Duration(seconds: 1)));
        })
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    if (filtered.isEmpty) return (null, null, null);

    final startVal = extractMetricValue(filtered.first, metric);
    final currentVal = extractMetricValue(filtered.last, metric);
    final startDate = filtered.first.date;

    return (currentVal, startVal, startDate);
  }

  // 1. Process Standard Metrics (Always show these)
  for (final cfg in standardMetrics) {
    final t = latestTargetMap[cfg.id];
    final (currentVal, startVal, startDate) = getMetricRangeValues(cfg.id);

    double percentage = 0;
    if (t != null && t.targetValue > 0 && currentVal != null && startVal != null) {
      final journeyLen = t.targetValue - startVal;
      if (journeyLen.abs() < 0.001) {
        percentage = 1.0;
      } else {
        percentage = (currentVal - startVal) / journeyLen;
        percentage = percentage.clamp(-1.0, 1.5);
      }
    }

    double achievementRatio = 0;
    if (t != null && t.targetValue > 0) {
      final cv = currentVal ?? 0.0;
      if (cv != 0) {
        achievementRatio = (cv <= t.targetValue)
            ? cv / t.targetValue
            : t.targetValue / cv;
        achievementRatio = achievementRatio.clamp(0.0, 1.0);
      }
    }

    achievements.add(MetricAchievement(
      id: t?.id ?? 0,
      metric: cfg.id,
      label: cfg.label,
      targetValue: t?.targetValue ?? 0,
      startValue: startVal ?? 0.0,
      currentValue: currentVal ?? 0,
      percentage: percentage,
      achievementRatio: achievementRatio,
      deadline: dateRange?.end ?? t?.deadline,
      startDate: startDate,
    ));
  }

  // 2. Process Custom Metrics (Those in history OR those with targets)
  final allHistoryCustomKeys = allMeasurements
      .expand((m) => m.customValues?.keys ?? <String>[])
      .toSet();
  
  // Also include targets that aren't standard
  final customTargetKeys = latestTargetMap.keys.where((k) => !standardMetrics.any((m) => m.id == k));
  
  final allCustomKeys = {...allHistoryCustomKeys, ...customTargetKeys};

  for (final metricId in allCustomKeys) {
    final t = latestTargetMap[metricId];
    final (currentVal, startVal, startDate) = getMetricRangeValues(metricId);
    
    // If it's a custom metric and we have NO data and NO target, we skip it
    if (currentVal == null && (t == null || t.targetValue <= 0)) continue;

    double percentage = 0;
    if (t != null && t.targetValue > 0 && currentVal != null && startVal != null) {
      final journeyLen = t.targetValue - startVal;
      if (journeyLen.abs() < 0.001) {
        percentage = 1.0;
      } else {
        percentage = (currentVal - startVal) / journeyLen;
        percentage = percentage.clamp(-1.0, 1.5);
      }
    }

    double achievementRatio = 0;
    if (t != null && t.targetValue > 0) {
      final cv = currentVal ?? 0.0;
      if (cv != 0) {
        achievementRatio = (cv <= t.targetValue)
            ? cv / t.targetValue
            : t.targetValue / cv;
        achievementRatio = achievementRatio.clamp(0.0, 1.0);
      }
    }

    achievements.add(MetricAchievement(
      id: t?.id ?? 0,
      metric: metricId,
      label: getMetricLabel(metricId),
      targetValue: t?.targetValue ?? 0,
      startValue: startVal ?? 0.0,
      currentValue: currentVal ?? 0,
      percentage: percentage,
      achievementRatio: achievementRatio,
      deadline: dateRange?.end ?? t?.deadline,
      startDate: startDate,
    ));
  }

  // ── Overall score calculation ──────────────────────────────────────────────
  final withTarget = achievements.where((a) => a.targetValue > 0 && a.startDate != null).toList();
  double rawScore = 0, overallScore = 0;
  if (withTarget.isNotEmpty) {
    rawScore = withTarget.fold(0.0, (s, a) => s + a.percentage) / withTarget.length;
    overallScore = withTarget.fold(0.0, (s, a) => s + a.achievementRatio) / withTarget.length;
  }

  return PhysiqueAchievement(
    overallScore: overallScore,
    rawOverallScore: rawScore,
    achievements: achievements,
  );
}

double? extractMetricValue(ent.BodyMeasurement m, String metric) {
  switch (metric) {
    case 'weight':
      return m.weight;
    case 'bodyFat':
      return m.bodyFat;
    case 'neck':
      return m.neck;
    case 'chest':
      return m.chest;
    case 'shoulders':
      return m.shoulders;
    case 'armRight':
    case 'rightArm':
    case 'right bicep':
      return m.armRight;
    case 'armLeft':
    case 'leftArm':
    case 'left bicep':
      return m.armLeft;
    case 'forearmLeft':
      return m.forearmLeft;
    case 'forearmRight':
      return m.forearmRight;
    case 'waist':
      return m.waist;
    case 'waistNaval':
      return m.waistNaval;
    case 'hips':
      return m.hips;
    case 'thighLeft':
    case 'leftThigh':
      return m.thighLeft;
    case 'thighRight':
    case 'rightThigh':
      return m.thighRight;
    case 'calfLeft':
    case 'calves':
      return m.calfLeft;
    case 'calfRight':
      return m.calfRight;
    case 'height':
      return m.height;
    case 'subcutaneousFat':
      return m.subcutaneousFat;
    case 'visceralFat':
      return m.visceralFat;
  }

  // Custom values
  if (m.customValues != null && m.customValues!.containsKey(metric)) {
    return m.customValues![metric];
  }

  return null;
}

String getMetricLabel(String metric) {
  switch (metric) {
    case 'weight':
      return 'Weight';
    case 'bodyFat':
      return 'Body Fat';
    case 'neck':
      return 'Neck';
    case 'chest':
      return 'Chest';
    case 'shoulders':
      return 'Shoulders';
    case 'armLeft':
    case 'leftArm':
      return 'Left Bicep';
    case 'armRight':
    case 'rightArm':
      return 'Right Bicep';
    case 'forearmLeft':
      return 'L-Forearm';
    case 'forearmRight':
      return 'R-Forearm';
    case 'waist':
      return 'Waist';
    case 'waistNaval':
      return 'Naval Waist';
    case 'hips':
      return 'Hips';
    case 'thighLeft':
    case 'leftThigh':
      return 'L-Thigh';
    case 'thighRight':
    case 'rightThigh':
      return 'R-Thigh';
    case 'calfLeft':
    case 'calves':
      return 'L-Calf';
    case 'calfRight':
      return 'R-Calf';
    case 'height':
      return 'Height';
    case 'subcutaneousFat':
      return 'Subcutaneous Fat';
    case 'visceralFat':
      return 'Visceral Fat';
    default:
      return metric;
  }
}

class MetricConfig {
  final String id;
  final String label;
  final IconData icon;
  final String unit;
  final String? assetPath;
  final bool lowerIsBetter;

  const MetricConfig({
    required this.id,
    required this.label,
    required this.icon,
    required this.unit,
    this.assetPath,
    this.lowerIsBetter = false,
  });
}

final List<MetricConfig> standardMetrics = [
  const MetricConfig(
    id: 'weight',
    label: 'Weight',
    icon: LucideIcons.scale,
    unit: 'kg',
    assetPath: 'assets/images/measurements/weight.png',
    lowerIsBetter: true,
  ),
  const MetricConfig(
    id: 'bodyFat',
    label: 'Body Fat',
    icon: LucideIcons.percent,
    unit: '%',
    assetPath: 'assets/images/measurements/body_fat.png',
    lowerIsBetter: true,
  ),
  const MetricConfig(
    id: 'waist',
    label: 'Waist',
    icon: LucideIcons.ruler,
    unit: 'cm',
    assetPath: 'assets/images/measurements/waist.png',
    lowerIsBetter: true,
  ),
  const MetricConfig(
    id: 'waistNaval',
    label: 'Naval Waist',
    icon: LucideIcons.ruler,
    unit: 'cm',
    assetPath: 'assets/images/measurements/waist.png',
    lowerIsBetter: true,
  ),
  const MetricConfig(
    id: 'chest',
    label: 'Chest',
    icon: LucideIcons.ruler,
    unit: 'cm',
    assetPath: 'assets/images/measurements/chest.png',
  ),
  const MetricConfig(
    id: 'shoulders',
    label: 'Shoulders',
    icon: LucideIcons.ruler,
    unit: 'cm',
    assetPath: 'assets/images/measurements/shoulders.png',
  ),
  const MetricConfig(
    id: 'hips',
    label: 'Hips',
    icon: LucideIcons.ruler,
    unit: 'cm',
    assetPath: 'assets/images/measurements/hips.png',
    lowerIsBetter: true,
  ),
  const MetricConfig(
    id: 'neck',
    label: 'Neck',
    icon: LucideIcons.ruler,
    unit: 'cm',
    assetPath: 'assets/images/measurements/neck.png',
  ),
  const MetricConfig(
    id: 'armLeft',
    label: 'Left Bicep',
    icon: LucideIcons.armchair,
    unit: 'cm',
    assetPath: 'assets/images/measurements/arms.png',
  ),
  const MetricConfig(
    id: 'armRight',
    label: 'Right Bicep',
    icon: LucideIcons.armchair,
    unit: 'cm',
    assetPath: 'assets/images/measurements/arms.png',
  ),
  const MetricConfig(
    id: 'forearmLeft',
    label: 'L-Forearm',
    icon: LucideIcons.armchair,
    unit: 'cm',
    assetPath: 'assets/images/measurements/forearms.png',
  ),
  const MetricConfig(
    id: 'forearmRight',
    label: 'R-Forearm',
    icon: LucideIcons.armchair,
    unit: 'cm',
    assetPath: 'assets/images/measurements/forearms.png',
  ),
  const MetricConfig(
    id: 'thighLeft',
    label: 'L-Thigh',
    icon: LucideIcons.ruler,
    unit: 'cm',
    assetPath: 'assets/images/measurements/thighs.png',
  ),
  const MetricConfig(
    id: 'thighRight',
    label: 'R-Thigh',
    icon: LucideIcons.ruler,
    unit: 'cm',
    assetPath: 'assets/images/measurements/thighs.png',
  ),
  const MetricConfig(
    id: 'calfLeft',
    label: 'L-Calf',
    icon: LucideIcons.ruler,
    unit: 'cm',
    assetPath: 'assets/images/measurements/calves.png',
  ),
  const MetricConfig(
    id: 'calfRight',
    label: 'R-Calf',
    icon: LucideIcons.ruler,
    unit: 'cm',
    assetPath: 'assets/images/measurements/calves.png',
  ),
  const MetricConfig(
    id: 'height',
    label: 'Height',
    icon: LucideIcons.ruler,
    unit: 'cm',
    assetPath: 'assets/images/measurements/height.png',
  ),
  const MetricConfig(
    id: 'subcutaneousFat',
    label: 'Subcutaneous Fat',
    icon: LucideIcons.percent,
    unit: '%',
    lowerIsBetter: true,
  ),
  const MetricConfig(
    id: 'visceralFat',
    label: 'Visceral Fat',
    icon: LucideIcons.percent,
    unit: '',
    lowerIsBetter: true,
  ),
];
