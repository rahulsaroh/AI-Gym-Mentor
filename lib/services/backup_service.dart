import 'dart:convert';
import 'dart:io';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/features/settings/settings_provider.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:gym_gemini_pro/features/settings/settings_repository.dart';
import 'package:share_plus/share_plus.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_service.g.dart';

@riverpod
class BackupService extends _$BackupService {
  @override
  void build() {}

  Future<Map<String, dynamic>> createFullBackup() async {
    final db = ref.read(appDatabaseProvider);
    final settings = await ref.read(settingsProvider.future);

    final exercises = await db.select(db.exercises).get();
    final templates = await db.select(db.workoutTemplates).get();
    final templateDays = await db.select(db.templateDays).get();
    final templateExercises = await db.select(db.templateExercises).get();
    final workouts = await db.select(db.workouts).get();
    final workoutSets = await db.select(db.workoutSets).get();
    final bodyMeasurements = await db.select(db.bodyMeasurements).get();
    final progressionSettings = await db.select(db.exerciseProgressionSettings).get();

    return {
      'gymlog_version': '1.0',
      'backup_date': DateTime.now().toIso8601String(),
      'user_profile': {
        'name': settings.userName,
        'unit': settings.weightUnit.name,
        'experience_level': settings.experienceLevel.name,
        // Using a placeholder for created_at if not in settings yet
        'created_at': DateTime.now().toIso8601String(), 
      },
      'custom_exercises': exercises.where((e) => e.isCustom).map((e) => e.toJson()).toList(),
      'base_exercises': exercises.where((e) => !e.isCustom).map((e) => e.toJson()).toList(),
      'workout_templates': templates.map((t) => t.toJson()).toList(),
      'template_days': templateDays.map((d) => d.toJson()).toList(),
      'template_exercises': templateExercises.map((e) => e.toJson()).toList(),
      'workouts': workouts.map((w) => w.toJson()).toList(),
      'workout_sets': workoutSets.map((s) => s.toJson()).toList(),
      'body_measurements': bodyMeasurements.map((m) => m.toJson()).toList(),
      'exercise_progression_settings': progressionSettings.map((p) => p.toJson()).toList(),
      'settings': {
        'weight_unit': settings.weightUnit.name,
        'theme_mode': settings.themeMode.name,
        'rest_time': 90, // Default or from global settings
        'accent_color': settings.accentColor.value,
      }
    };
  }

  Future<void> exportToLocalFile() async {
    final backup = await createFullBackup();
    final jsonStr = jsonEncode(backup);
    
    final date = DateFormat('yyyy_MM_DD').format(DateTime.now());
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/gymlog_backup_$date.json');
    
    await file.writeAsString(jsonStr);
    
    await Share.shareXFiles(
      [XFile(file.path)],
      subject: 'GYM Kilo Backup - $date',
    );
  }

  // Google Drive Integration
  Future<void> uploadToDrive(http.Client client) async {
    final driveApi = drive.DriveApi(client);
    final backup = await createFullBackup();
    final jsonStr = jsonEncode(backup);
    
    final fileMetadata = drive.File()
      ..name = 'GYM Kilo Backup'
      ..mimeType = 'application/json';

    // Check if file already exists
    final list = await driveApi.files.list(
      q: "name = 'GYM Kilo Backup' and trashed = false",
      spaces: 'drive',
    );

    final media = drive.Media(
      Stream.value(utf8.encode(jsonStr)),
      jsonStr.length,
    );

    if (list.files != null && list.files!.isNotEmpty) {
      // Update existing
      final fileId = list.files!.first.id!;
      await driveApi.files.update(fileMetadata, fileId, uploadMedia: media);
    } else {
      // Create new
      await driveApi.files.create(fileMetadata, uploadMedia: media);
    }
  }

  Future<List<drive.File>> listDriveBackups(http.Client client) async {
    final driveApi = drive.DriveApi(client);
    final list = await driveApi.files.list(
      q: "name contains 'Backup' and trashed = false",
      orderBy: 'modifiedTime desc',
    );
    return list.files ?? [];
  }

  Future<Map<String, dynamic>> downloadFromDrive(http.Client client, String fileId) async {
    final driveApi = drive.DriveApi(client);
    final response = await driveApi.files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.metadata,
    ) as drive.File;
    
    final media = await driveApi.files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    final bytes = await media.stream.fold<List<int>>([], (p, e) => p..addAll(e));
    final jsonStr = utf8.decode(bytes);
    return jsonDecode(jsonStr);
  }

  // Data Management
  Future<void> clearWorkoutHistory() async {
    final db = ref.read(appDatabaseProvider);
    await db.transaction(() async {
      await db.delete(db.workoutSets).go();
      await db.delete(db.workouts).go();
      await db.delete(db.syncQueue).go();
    });
  }

  Future<void> factoryReset() async {
    // 1. Clear SharedPreferences
    await SettingsRepository().clearAll();
    
    // 2. Clear Database (Delete file for re-seed)
    final db = ref.read(appDatabaseProvider);
    await db.close();
    
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(dbFolder.path, 'gym_log.sqlite'));
    if (await dbFile.exists()) {
      await dbFile.delete();
    }
  }
}
