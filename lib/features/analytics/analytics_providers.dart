import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/features/analytics/stats_repository.dart';
import 'package:gym_gemini_pro/features/analytics/measurements_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_providers.g.dart';

@riverpod
Future<Map<String, dynamic>> dashboardStats(DashboardStatsRef ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getOverviewStats();
}

@riverpod
Future<List<Map<String, dynamic>>> volumeTrend(VolumeTrendRef ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getWeeklyVolumeTrend();
}

@riverpod
Future<List<Map<String, dynamic>>> frequencyTrend(FrequencyTrendRef ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getWorkoutFrequency();
}

@riverpod
Future<Map<String, dynamic>> muscleBalance(MuscleBalanceRef ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getMuscleBalance();
}

@riverpod
Future<List<Map<String, dynamic>>> plateauAlerts(PlateauAlertsRef ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getPlateauAlerts();
}

@riverpod
Future<List<Map<String, dynamic>>> recentPRs(RecentPRsRef ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getRecentPRs();
}

@riverpod
class BodyMeasurementsList extends _$BodyMeasurementsList {
  @override
  Future<List<BodyMeasurement>> build() async {
    final repo = ref.watch(measurementsRepositoryProvider);
    return await repo.getAllMeasurements();
  }

  Future<void> addMeasurement(BodyMeasurementsCompanion companion) async {
    final repo = ref.read(measurementsRepositoryProvider);
    await repo.addMeasurement(companion);
    ref.invalidateSelf();
  }

  Future<void> deleteMeasurement(int id) async {
    final repo = ref.read(measurementsRepositoryProvider);
    await repo.deleteMeasurement(id);
    ref.invalidateSelf();
  }
}
