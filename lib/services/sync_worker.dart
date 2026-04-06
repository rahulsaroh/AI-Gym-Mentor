
import 'package:gym_gemini_pro/core/auth/auth_provider.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/services/sheets_service.dart';
import 'package:gym_gemini_pro/features/settings/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';

part 'sync_worker.g.dart';

@riverpod
class SyncWorker extends _$SyncWorker {
  @override
  void build() {}

  Future<void> processQueue() async {
    final db = ref.read(appDatabaseProvider);
    final googleSignIn = ref.read(googleSignInProvider);
    
    // Check if user is signed in
    if (!await googleSignIn.isSignedIn()) return;
    
    final client = await googleSignIn.getAuthenticatedClient();
    if (client == null) return;

    final sheetsService = SheetsService(client);
    
    final pendingItems = await (db.select(db.syncQueue)
          ..where((t) => t.status.equals('pending') | t.status.equals('failed'))
          ..where((t) => t.attempts.isSmallerThanValue(3))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();

    if (pendingItems.isEmpty) return;

    final workoutDataList = <Map<String, dynamic>>[];
    final measurements = <BodyMeasurement>[];
    final processedIds = <int>[];

    // Pre-fetch exercises for mapping
    final exercises = await (db.select(db.exercises)).get();
    final exerciseMap = {for (var e in exercises) e.id: e.name};

    for (final item in pendingItems) {
      try {
        if (item.type == 'workout' && item.workoutId != null) {
          final workout = await (db.select(db.workouts)..where((t) => t.id.equals(item.workoutId!))).getSingleOrNull();
          if (workout != null) {
            final sets = await (db.select(db.workoutSets)..where((t) => t.workoutId.equals(item.workoutId!))).get();
            workoutDataList.add({'workout': workout, 'sets': sets, 'exerciseNames': exerciseMap});
          }
          processedIds.add(item.id);
        } else if (item.type == 'measurement' && item.measurementId != null) {
          final measurement = await (db.select(db.bodyMeasurements)..where((t) => t.id.equals(item.measurementId!))).getSingleOrNull();
          if (measurement != null) measurements.add(measurement);
          processedIds.add(item.id);
        }
      } catch (e) {
        // Individual item fetch error - mark as failed
        await (db.update(db.syncQueue)..where((t) => t.id.equals(item.id))).write(
          SyncQueueCompanion(status: const Value('failed'), attempts: Value(item.attempts + 1), error: Value(e.toString())),
        );
      }
    }

    // Process Workouts Batch
    if (workoutDataList.isNotEmpty) {
      try {
        await sheetsService.appendWorkoutsBatch(workoutDataList);
      } catch (e) {
        // Batch failed - handle or rethrow
      }
    }

    // Process Measurements Batch
    if (measurements.isNotEmpty) {
      try {
        await sheetsService.appendMeasurementsBatch(measurements);
      } catch (e) {
        // Batch failed
      }
    }

    // Mark as done
    if (processedIds.isNotEmpty) {
      await (db.update(db.syncQueue)..where((t) => t.id.isIn(processedIds))).write(
        const SyncQueueCompanion(status: Value('done')),
      );

      final currentSettings = await ref.read(settingsProvider.future);
      await ref.read(settingsProvider.notifier).updateSettings(
        currentSettings.copyWith(lastSynced: DateTime.now())
      );
    }
  }
}
