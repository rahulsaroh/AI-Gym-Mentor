import 'package:ai_gym_mentor/features/analytics/stats_repository.dart';
import 'package:ai_gym_mentor/features/analytics/progress_photos_repository.dart';import 'package:ai_gym_mentor/features/analytics/measurements_repository.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart' as ent;
import 'package:ai_gym_mentor/core/domain/entities/body_target.dart' as target;
import 'package:ai_gym_mentor/core/domain/entities/progress_photo.dart' as photo;
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
      .map((m) => {
            'date': m.date,
            'weight': m.weight!,
          })
      .toList();
  weightData.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));
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
  final workout = await (repo.db.select(repo.db.workouts)..where((t) => t.id.equals(workoutId))).getSingle();
  
  return fullHistory
    .where((pr) => (pr['date'] as DateTime).day == workout.date.day && 
                  (pr['date'] as DateTime).month == workout.date.month &&
                  (pr['date'] as DateTime).year == workout.date.year)
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
