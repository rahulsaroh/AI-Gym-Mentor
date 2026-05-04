import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:intl/intl.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/services/cloud_sync_service.dart';

class SaveResult {
  final bool success;
  final String? filePath;
  final String? error;

  SaveResult({required this.success, this.filePath, this.error});
}

class WorkoutAutoSaveService {
  final Ref ref;

  WorkoutAutoSaveService(this.ref);

  Future<String> getPersistentFilePath() async {
    if (Platform.isAndroid) {
      // Use standard public Downloads folder
      // On Android 11+ this works if targeting SAF or if using requestLegacyExternalStorage on some versions
      // But for a reliable public path:
      final directory = Directory('/storage/emulated/0/Download/GymLog');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      return '${directory.path}/gym_log.xlsx';
    }

    // iOS fallback: App Documents (syncs to iCloud if NSUbiquitousDocumentsDirectory is used later)
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/gym_log.xlsx';
  }

  Future<SaveResult> appendWorkout({
    required Workout workout,
    required List<WorkoutSet> sets,
    required Map<int, String> exerciseNames,
  }) async {
    try {
      final filePath = await getPersistentFilePath();
      final file = File(filePath);
      Excel excel;

      if (await file.exists()) {
        final bytes = await file.readAsBytes();
        excel = Excel.decodeBytes(bytes);
      } else {
        excel = Excel.createExcel();
        excel.delete('Sheet1'); // Remove default
        _createHeaders(excel);
      }

      final Sheet? sheet = excel['Raw Log'];
      if (sheet == null) return SaveResult(success: false, error: 'Sheet creation failed');

      final dateStr = DateFormat('yyyy-MM-dd').format(workout.date);
      final dayName = DateFormat('EEEE').format(workout.date);

      for (final set in sets) {
        final exerciseName = exerciseNames[set.exerciseId] ?? 'Unknown Exercise';
        final vol = (set.weight ?? 0.0) * (set.reps ?? 0.0);
        
        sheet.appendRow([
          TextCellValue(dateStr),
          TextCellValue(dayName),
          TextCellValue(workout.name),
          TextCellValue(exerciseName),
          IntCellValue(set.setNumber),
          TextCellValue(set.setType.name), 
          DoubleCellValue(set.weight ?? 0.0),
          DoubleCellValue(set.reps ?? 0.0),
          TextCellValue(set.rpe?.toString() ?? ''),
          DoubleCellValue(vol),
          TextCellValue(set.isPr ? 'YES' : ''),
          TextCellValue(set.notes ?? ''),
        ]);
      }

      final fileBytes = excel.save();
      if (fileBytes != null) {
        await file.writeAsBytes(fileBytes);
        
        // Trigger Cloud Sync if enabled
        final settings = ref.read(settingsProvider).value;
        if (settings != null) {
          final cloudService = ref.read(cloudSyncServiceProvider);
          if (settings.autoSyncGoogleDrive) {
            cloudService.syncToGoogleDrive(filePath);
          }
          if (settings.autoSyncICloud && Platform.isIOS) {
            cloudService.syncToICloud(filePath);
          }
        }

        return SaveResult(success: true, filePath: filePath);
      }
      return SaveResult(success: false, error: 'Failed to save bytes');
    } catch (e) {
      debugPrint('AutoSave Error: $e');
      return SaveResult(success: false, error: e.toString());
    }
  }

  void _createHeaders(Excel excel) {
    // Sheet 1: Raw Log
    final rawSheet = excel['Raw Log'];
    rawSheet.appendRow([
      'Date', 'Day', 'Workout Name', 'Exercise', 'Set#', 'Set Type',
      'Weight(kg)', 'Reps', 'RPE', 'Volume(kg)', 'Is PR', 'Notes'
    ].map((h) => TextCellValue(h)).toList());

    // Sheet 5: Body Measurements
    final measurementSheet = excel['Body Measurements'];
    measurementSheet.appendRow([
      'Date', 'Weight (kg)', 'Δ Weight', 'Body Fat (%)', 'Chest', 'Shoulders', 
      'Waist', 'Hips', 'Left Arm', 'Right Arm', 'Left Thigh', 'Right Thigh', 
      'Left Calf', 'Right Calf', 'Notes'
    ].map((h) => TextCellValue(h)).toList());
  }
}

final autoSaveServiceProvider = Provider((ref) => WorkoutAutoSaveService(ref));
