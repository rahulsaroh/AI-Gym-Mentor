import 'package:gym_gemini_pro/core/auth/auth_provider.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/services/sheets_service.dart';
import 'package:gym_gemini_pro/features/settings/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

part 'sync_worker.g.dart';

enum SyncStatus { idle, syncing, success, failed, authenticationRequired }

@riverpod
class SyncWorker extends _$SyncWorker {
  @override
  SyncStatus build() {
    return SyncStatus.idle;
  }

  Future<void> processQueue() async {
    state = SyncStatus.syncing;
    debugPrint('SyncWorker: Starting processQueue...');
    final db = ref.read(appDatabaseProvider);
    final googleSignIn = ref.read(googleSignInProvider);
    
    if (!await googleSignIn.isSignedIn()) {
      debugPrint('SyncWorker: User NOT signed in to Google.');
      state = SyncStatus.authenticationRequired;
      return;
    }
    
    final client = await googleSignIn.getAuthenticatedClient();
    if (client == null) {
      debugPrint('SyncWorker: Failed to get authenticated client.');
      state = SyncStatus.failed;
      return;
    }

    final sheetsService = SheetsService(client);
    
    // Ensure spreadsheet exists before syncing
    String? spreadsheetId = await sheetsService.getSpreadsheetId();
    if (spreadsheetId == null) {
      debugPrint('SyncWorker: Spreadsheet ID not found. Creating new spreadsheet...');
      spreadsheetId = await sheetsService.createSpreadsheet();
      if (spreadsheetId == null) {
        debugPrint('SyncWorker: Failed to create/find spreadsheet. Aborting sync.');
        state = SyncStatus.failed;
        return;
      }
      debugPrint('SyncWorker: Spreadsheet ID created: $spreadsheetId');
    }
    
    debugPrint('SyncWorker: Checking for pending items...');
    final pendingItems = await (db.select(db.syncQueue)
          ..where((t) => t.status.equals('pending') | t.status.equals('failed'))
          ..where((t) => t.attempts.isSmallerThanValue(3))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();

    if (pendingItems.isEmpty) {
      debugPrint('SyncWorker: No pending items found.');
      state = SyncStatus.success;
      return;
    }

    debugPrint('SyncWorker: Found ${pendingItems.length} pending items.');

    // Pre-fetch exercises for mapping
    final exercises = await (db.select(db.exercises)).get();
    final exerciseMap = {for (var e in exercises) e.id: e.name};

    final workoutItems = pendingItems.where((i) => i.type == 'workout' && i.workoutId != null).toList();
    if (workoutItems.isNotEmpty) {
      final workoutDataList = <Map<String, dynamic>>[];
      final successIds = <int>[];
      
      for (final item in workoutItems) {
        final workout = await (db.select(db.workouts)..where((t) => t.id.equals(item.workoutId!))).getSingleOrNull();
        if (workout != null) {
          final sets = await (db.select(db.workoutSets)..where((t) => t.workoutId.equals(item.workoutId!))).get();
          workoutDataList.add({'workout': workout, 'sets': sets, 'exerciseNames': exerciseMap});
          successIds.add(item.id);
        } else {
          // Workout moved or deleted? Mark as done so we don't block
          await (db.update(db.syncQueue)..where((t) => t.id.equals(item.id))).write(const SyncQueueCompanion(status: Value('done')));
        }
      }

      if (workoutDataList.isNotEmpty) {
        try {
          debugPrint('SyncWorker: Appending ${workoutDataList.length} workouts...');
          await sheetsService.appendWorkoutsBatch(workoutDataList);
          await (db.update(db.syncQueue)..where((t) => t.id.isIn(successIds))).write(const SyncQueueCompanion(status: Value('done')));
          debugPrint('SyncWorker: Workouts synced successfully.');
        } catch (e) {
          debugPrint('SyncWorker: Workout sync failed: $e');
          for (var id in successIds) {
             final item = workoutItems.firstWhere((i) => i.id == id);
             await (db.update(db.syncQueue)..where((t) => t.id.equals(id))).write(
               SyncQueueCompanion(status: const Value('failed'), attempts: Value(item.attempts + 1), error: Value(e.toString())),
             );
          }
        }
      }
    }

    final measurementItems = pendingItems.where((i) => i.type == 'measurement' && i.measurementId != null).toList();
    if (measurementItems.isNotEmpty) {
      final measurements = <BodyMeasurement>[];
      final successIds = <int>[];

      for (final item in measurementItems) {
        final m = await (db.select(db.bodyMeasurements)..where((t) => t.id.equals(item.measurementId!))).getSingleOrNull();
        if (m != null) {
          measurements.add(m);
          successIds.add(item.id);
        } else {
          await (db.update(db.syncQueue)..where((t) => t.id.equals(item.id))).write(const SyncQueueCompanion(status: Value('done')));
        }
      }

      if (measurements.isNotEmpty) {
        try {
          debugPrint('SyncWorker: Appending ${measurements.length} measurements...');
          await sheetsService.appendMeasurementsBatch(measurements);
          await (db.update(db.syncQueue)..where((t) => t.id.isIn(successIds))).write(const SyncQueueCompanion(status: Value('done')));
          debugPrint('SyncWorker: Measurements synced successfully.');
        } catch (e) {
          debugPrint('SyncWorker: Measurement sync failed: $e');
          for (var id in successIds) {
             final item = measurementItems.firstWhere((i) => i.id == id);
             await (db.update(db.syncQueue)..where((t) => t.id.equals(id))).write(
               SyncQueueCompanion(status: const Value('failed'), attempts: Value(item.attempts + 1), error: Value(e.toString())),
             );
          }
        }
      }
    }

    // Update settings
    final currentSettings = await ref.read(settingsProvider.future);
    await ref.read(settingsProvider.notifier).updateSettings(
      currentSettings.copyWith(lastSynced: DateTime.now())
    );
    
    client.close();
    debugPrint('SyncWorker: Sync complete.');
    state = SyncStatus.success;
  }
}
