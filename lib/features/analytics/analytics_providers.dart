import 'package:ai_gym_mentor/features/analytics/stats_repository.dart';
import 'package:ai_gym_mentor/features/analytics/progress_photos_repository.dart';import 'package:ai_gym_mentor/features/analytics/measurements_repository.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart' as ent;
import 'package:ai_gym_mentor/core/domain/entities/body_target.dart' as target;
import 'package:ai_gym_mentor/core/domain/entities/progress_photo.dart' as photo;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_providers.g.dart';

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
Future<List<Map<String, dynamic>>> frequencyTrend(Ref ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getWorkoutFrequency();
}

@riverpod
Future<Map<String, dynamic>> muscleBalance(Ref ref) async {
  final repo = ref.watch(statsRepositoryProvider);
  return await repo.getMuscleBalance();
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
