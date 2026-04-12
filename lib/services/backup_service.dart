import 'dart:convert';
import 'dart:io';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:ai_gym_mentor/features/settings/settings_repository.dart';
import 'package:share_plus/share_plus.dart';
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
    final progressionSettings =
        await db.select(db.exerciseProgressionSettings).get();

    return {
      'gymlog_version': '1.0',
      'backup_date': DateTime.now().toIso8601String(),
      'user_profile': {
        'name': settings.userName,
        'unit': settings.weightUnit.name,
        'experience_level': settings.experienceLevel.name,
        'created_at': DateTime.now().toIso8601String(),
      },
      'custom_exercises':
          exercises.where((e) => e.isCustom).map((e) => e.toJson()).toList(),
      'base_exercises':
          exercises.where((e) => !e.isCustom).map((e) => e.toJson()).toList(),
      'workout_templates': templates.map((t) => t.toJson()).toList(),
      'template_days': templateDays.map((d) => d.toJson()).toList(),
      'template_exercises': templateExercises.map((e) => e.toJson()).toList(),
      'workouts': workouts.map((w) => w.toJson()).toList(),
      'workout_sets': workoutSets.map((s) => s.toJson()).toList(),
      'body_measurements': bodyMeasurements.map((m) => m.toJson()).toList(),
      'exercise_progression_settings':
          progressionSettings.map((ps) => ps.toJson()).toList(),
      'settings': {
        'weight_unit': settings.weightUnit.name,
        'theme_mode': settings.themeMode.name,
        'rest_time': 90,
        'accent_color': settings.accentColor.value,
      }
    };
  }

  Future<void> exportToLocalFile() async {
    final backup = await createFullBackup();
    final jsonStr = jsonEncode(backup);

    final date = DateFormat('yyyy_MM_dd').format(DateTime.now());
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/gymlog_backup_$date.json');

    await file.writeAsString(jsonStr);

    await Share.shareXFiles(
      [XFile(file.path)],
      subject: 'Gym Mentor Backup - $date',
    );
  }

  // Data Management
  Future<void> clearWorkoutHistory() async {
    final db = ref.read(appDatabaseProvider);
    await db.transaction(() async {
      await db.delete(db.workoutSets).go();
      await db.delete(db.workouts).go();
      // syncQueue is kept in DB but we don't clear it here anymore as it's unused
    });
  }

  Future<void> factoryReset() async {
    await SettingsRepository().clearAll();

    final db = ref.read(appDatabaseProvider);
    await db.close();

    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(dbFolder.path, 'gym_log.sqlite'));
    if (await dbFile.exists()) {
      await dbFile.delete();
    }
  }
}

