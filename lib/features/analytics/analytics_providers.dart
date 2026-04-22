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

  return calculatePhysiqueScore(measurements.first, targets, measurements);
}

PhysiqueAchievement calculatePhysiqueScore(
  ent.BodyMeasurement current,
  List<target.BodyTarget> targets,
  List<ent.BodyMeasurement> allMeasurements,
) {
  final achievements = <MetricAchievement>[];

  for (final t in targets) {
    double? currentVal;
    for (var m in allMeasurements) {
      final val = extractMetricValue(m, t.metric);
      if (val != null) {
        currentVal = val;
        break;
      }
    }
    
    // If no measurement exists yet, default to 0.0 so the card still shows
    final actualCurrentVal = currentVal ?? 0.0;

    // Find start value: measurement closest to target.createdAt
    ent.BodyMeasurement? startMeasurement;
    double? startVal;
    for (var m in allMeasurements) {
      if (m.date.isAfter(t.createdAt) || m.date.isAtSameMomentAs(t.createdAt)) {
        startMeasurement = m;
        // Keep going backward in time to find the one closest to createdAt
      } else {
        break; // allMeasurements is sorted descending (newest first)
      }
    }
    
    // If we found a measurement around createdAt, extract its value
    if (startMeasurement != null) {
      startVal = extractMetricValue(startMeasurement, t.metric);
    }
    
    // If no start value was found at createdAt, try to find the earliest recorded value, 
    // or fallback to actualCurrentVal, or 0.0
    if (startVal == null) {
       for (var m in allMeasurements.reversed) {
          final val = extractMetricValue(m, t.metric);
          if (val != null) {
             startVal = val;
             break;
          }
       }
    }
    
    final actualStartVal = startVal ?? actualCurrentVal;

    double percentage = 0;
    if ((t.targetValue - actualStartVal).abs() > 0.001) {
      percentage = (actualCurrentVal - actualStartVal) / (t.targetValue - actualStartVal);
    } else if ((actualCurrentVal - t.targetValue).abs() < 0.001) {
      percentage = 1.0;
    }

    percentage = percentage.clamp(0.0, 1.25);

    achievements.add(
      MetricAchievement(
        id: t.id,
        metric: t.metric,
        label: getMetricLabel(t.metric),
        targetValue: t.targetValue,
        startValue: actualStartVal,
        currentValue: actualCurrentVal,
        percentage: percentage,
        deadline: t.deadline,
      ),
    );
  }

  double overallScore = 0;
  if (achievements.isNotEmpty) {
    overallScore =
        achievements.fold(0.0, (sum, a) => sum + a.percentage.clamp(0.0, 1.0)) /
        achievements.length;
  }

  return PhysiqueAchievement(
    overallScore: overallScore,
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
    case 'armLeft':
    case 'leftArm':
      return m.armLeft;
    case 'armRight':
    case 'rightArm':
      return m.armRight;
    case 'forearmLeft':
      return m.forearmLeft;
    case 'forearmRight':
      return m.forearmRight;
    case 'waist':
      return m.waist;
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
      return 'L-Arm';
    case 'armRight':
    case 'rightArm':
      return 'R-Arm';
    case 'forearmLeft':
      return 'L-Forearm';
    case 'forearmRight':
      return 'R-Forearm';
    case 'waist':
      return 'Waist';
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
    label: 'L-Arm',
    icon: LucideIcons.armchair,
    unit: 'cm',
    assetPath: 'assets/images/measurements/arms.png',
  ),
  const MetricConfig(
    id: 'armRight',
    label: 'R-Arm',
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
];
