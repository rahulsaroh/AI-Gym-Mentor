import 'package:ai_gym_mentor/features/analytics/stats_repository.dart';
import 'package:ai_gym_mentor/features/analytics/progress_photos_repository.dart';
import 'package:ai_gym_mentor/features/analytics/measurements_repository.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart'
    as ent;
import 'package:ai_gym_mentor/core/domain/entities/body_target.dart' as target;
import 'package:ai_gym_mentor/core/domain/entities/progress_photo.dart'
    as photo;
import 'package:ai_gym_mentor/core/domain/entities/body_achievement.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_providers.g.dart';

/// Global date-range filter for the Measurements tab.
/// When null: each target uses its own createdAt/deadline.
/// When set: ALL cards compute progress within this window.
@riverpod
class MeasurementDateRange extends _$MeasurementDateRange {
  @override
  DateTimeRange? build() => null;

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
Future<List<Map<String, dynamic>>> recentPRs(Ref ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getRecentPRs();
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

  Future<void> seedSampleData() async {
    final repo = ref.read(measurementsRepositoryProvider);
    final now = DateTime.now();
    
    // Generate 12 weeks of data
    for (int i = 12; i >= 0; i--) {
      final date = now.subtract(Duration(days: i * 7));
      final weight = 85.0 - (10.0 * (12 - i) / 12); // Linear decrease from 85 to 75
      final bodyFat = 25.0 - (7.0 * (12 - i) / 12); // Linear decrease from 25 to 18
      
      await repo.addMeasurement(ent.BodyMeasurement(
        id: 0,
        date: date,
        weight: weight,
        bodyFat: bodyFat,
        waist: 95.0 - (5.0 * (12 - i) / 12),
      ));
    }
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

  Future<void> seedSampleTargets() async {
    final repo = ref.read(measurementsRepositoryProvider);
    
    await repo.addTarget(target.BodyTarget(
      id: 0,
      metric: 'weight',
      targetValue: 72.0,
      createdAt: DateTime.now().subtract(const Duration(days: 90)),
      deadline: DateTime.now().add(const Duration(days: 30)),
    ));
    
    await repo.addTarget(target.BodyTarget(
      id: 0,
      metric: 'bodyFat',
      targetValue: 15.0,
      createdAt: DateTime.now().subtract(const Duration(days: 90)),
      deadline: DateTime.now().add(const Duration(days: 30)),
    ));
    
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
    final repo = ref.read(progressPhotosRepositoryProvider);
    await repo.addPhoto(pp);
    ref.invalidateSelf();
  }

  Future<void> deletePhoto(int id) async {
    final repo = ref.read(progressPhotosRepositoryProvider);
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

  // Show empty state only when there is truly nothing at all
  if (measurements.isEmpty && targets.isEmpty) {
    return PhysiqueAchievement(overallScore: 0, achievements: []);
  }

  return calculatePhysiqueScore(
    measurements.isEmpty ? null : measurements.first,
    targets,
    measurements,
    dateRange: dateRange,
  );
}

PhysiqueAchievement calculatePhysiqueScore(
  ent.BodyMeasurement? current,
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
  double? findCurrent(String metric) {
    if (dateRange != null) {
      int minDiff = 999999999;
      double? found;
      for (var m in allMeasurements) {
        final v = extractMetricValue(m, metric);
        if (v == null) continue;
        final diff = m.date.difference(dateRange.end).inSeconds.abs();
        if (diff < minDiff) { minDiff = diff; found = v; }
      }
      return found;
    } else {
      for (var m in allMeasurements) {
        final v = extractMetricValue(m, metric);
        if (v != null) return v;
      }
      return null;
    }
  }

  (double?, DateTime?) findStart(String metric, DateTime lookup) {
    double? val; DateTime? date; int best = 999999999;
    for (var m in allMeasurements) {
      final v = extractMetricValue(m, metric);
      if (v == null) continue;
      final diff = m.date.difference(lookup).inSeconds.abs();
      if (diff < best) { best = diff; val = v; date = m.date; }
    }
    return (val, date);
  }

  // ── Emit a card for EVERY standard metric ────────────────────────────────
  for (final cfg in standardMetrics) {
    final t = latestTargetMap[cfg.id]; // may be null → no target set yet
    final currentVal = findCurrent(cfg.id); // may be null → no measurement yet

    // Skip only when there is absolutely nothing to show
    if (currentVal == null && t == null) continue;

    final startLookup = dateRange?.start ?? t?.createdAt ?? DateTime.now();
    final (startRaw, startDate) = findStart(cfg.id, startLookup);
    final startVal = startRaw ?? currentVal ?? 0.0;

    double percentage = 0;
    if (t != null && t.targetValue > 0 && currentVal != null) {
      // Universal formula: works for both gain (target > start) and
      // loss (target < start) goals — direction auto-detected from target vs start.
      // e.g. weight gain: start=74, target=77, current=76 → (76-74)/(77-74) = 67%
      // e.g. weight loss: start=85, target=75, current=78 → (78-85)/(75-85) = 70%
      // e.g. regression:  start=85, target=75, current=87 → (87-85)/(75-85) = -20%
      final journeyLen = t.targetValue - startVal; // signed: positive = gain goal, negative = loss goal
      if (journeyLen.abs() < 0.001) {
        percentage = 1.0; // start == target, already done
      } else {
        percentage = (currentVal - startVal) / journeyLen;
        percentage = percentage.clamp(-1.0, 1.5);
      }
    }

    // Achievement ratio: how close current is to target RIGHT NOW.
    // For gain goal (target > current): current/target
    // For loss goal (target < current): target/current
    // e.g. current=90, target=100 → 90/100 = 90% (already 90% there)
    // e.g. current=78, target=75  → 75/78 = 96% (close to loss target)
    double achievementRatio = 0;
    if (t != null && t.targetValue > 0) {
      final cv = currentVal ?? 0.0;
      if (cv == 0 || t.targetValue == 0) {
        achievementRatio = 0;
      } else {
        achievementRatio = (cv <= t.targetValue)
            ? cv / t.targetValue   // gain goal: approaching from below
            : t.targetValue / cv;  // loss goal: approaching from above
        achievementRatio = achievementRatio.clamp(0.0, 1.0);
      }
    }

    achievements.add(MetricAchievement(
      id: t?.id ?? 0,
      metric: cfg.id,
      label: cfg.label,
      targetValue: t?.targetValue ?? 0,
      startValue: startVal,
      currentValue: currentVal ?? 0,
      percentage: percentage,
      achievementRatio: achievementRatio,
      deadline: dateRange?.end ?? t?.deadline,
      startDate: startDate,
    ));
  }

  // ── Also emit cards for custom targets (not in standardMetrics) ───────────
  for (final t in latestTargetMap.values) {
    if (standardMetrics.any((m) => m.id == t.metric)) continue;
    if (t.targetValue <= 0) continue;
    final currentVal = findCurrent(t.metric);
    final startLookup = dateRange?.start ?? t.createdAt;
    final (startRaw, startDate) = findStart(t.metric, startLookup);
    final startVal = startRaw ?? currentVal ?? 0.0;
    double percentage = 0;
    if (currentVal != null) {
      final journeyLen = (t.targetValue - startVal).abs();
      if (journeyLen >= 0.001) {
        percentage = (currentVal - startVal) / (t.targetValue - startVal);
        percentage = percentage.clamp(-1.0, 1.5);
      } else {
        percentage = 1.0;
      }
    }
    double achievementRatio = 0;
    if (currentVal != null && t.targetValue > 0) {
      achievementRatio = (currentVal <= t.targetValue)
          ? currentVal / t.targetValue
          : t.targetValue / currentVal;
      achievementRatio = achievementRatio.clamp(0.0, 1.0);
    }
    achievements.add(MetricAchievement(
      id: t.id,
      metric: t.metric,
      label: getMetricLabel(t.metric),
      targetValue: t.targetValue,
      startValue: startVal,
      currentValue: currentVal ?? 0,
      percentage: percentage,
      achievementRatio: achievementRatio,
      deadline: dateRange?.end ?? t.deadline,
      startDate: startDate,
    ));
  }

  // ── Overall score: average achievementRatio of metrics with a target ──────────
  // achievementRatio = how close current is to target (not journey-based).
  // rawScore uses journey percentages to detect if overall improving or regressing.
  final withTarget = achievements.where((a) => a.targetValue > 0).toList();
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
      return m.armRight;
    case 'armLeft':
    case 'leftArm':
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
