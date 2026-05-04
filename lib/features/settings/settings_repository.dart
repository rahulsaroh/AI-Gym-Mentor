import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';

class SettingsRepository {
  static const _key = 'user_settings';

  Future<SettingsState> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) {
      // Migrate individual legacy keys if they exist
      return _migrateLegacy(prefs);
    }

    try {
      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      return _fromMap(map);
    } catch (_) {
      return const SettingsState();
    }
  }

  Future<void> saveSettings(SettingsState settings) async {
    final prefs = await SharedPreferences.getInstance();
    final map = _toMap(settings);
    await prefs.setString(_key, jsonEncode(map));
  }

  SettingsState _migrateLegacy(SharedPreferences prefs) {
    final name = prefs.getString('userName') ?? 'Alex';
    final unit =
        prefs.getString('weightUnit') == 'lbs' ? WeightUnit.lbs : WeightUnit.kg;
    final exp = ExperienceLevel.values.firstWhere(
      (e) => e.name == (prefs.getString('experienceLevel') ?? 'beginner'),
      orElse: () => ExperienceLevel.beginner,
    );

    return SettingsState(
      userName: name,
      weightUnit: unit,
      experienceLevel: exp,
      age: prefs.getInt('age') ?? 25,
      goals: prefs.getString('goals') ?? 'Build muscle and gain strength',
    );
  }

  Map<String, dynamic> _toMap(SettingsState s) {
    return {
      'userName': s.userName,
      'experienceLevel': s.experienceLevel.name,
      'weightUnit': s.weightUnit.name,
      'age': s.age,
      'goals': s.goals,
      'themeMode': s.themeMode.name,
      'accentColor': s.accentColor.value,
      'fontSize': s.fontSize.name,
      'restTimeStraight': s.restTimeStraight,
      'restTimeSuperset': s.restTimeSuperset,
      'restTimeDropset': s.restTimeDropset,
      'timerSound': s.timerSound,
      'timerVibration': s.timerVibration,
      'backgroundNotification': s.backgroundNotification,
      'barbellWeight': s.barbellWeight,
      'availablePlates': s.availablePlates,
      'autoIncrement': s.autoIncrement,
      'showRpe': s.showRpe,
      'showPreviousData': s.showPreviousData,
      'autoBackup': s.autoBackup,
      'autoSaveToDownloads': s.autoSaveToDownloads,
      'autoSyncGoogleDrive': s.autoSyncGoogleDrive,
      'autoSyncICloud': s.autoSyncICloud,
      'googleDriveEmail': s.googleDriveEmail,
      'lastSynced': s.lastSynced?.toIso8601String(),
      'height': s.height,
      'weight': s.weight,
      'sex': s.sex.name,
    };
  }

  SettingsState _fromMap(Map<String, dynamic> map) {
    return SettingsState(
      userName: map['userName'] ?? 'Alex',
      experienceLevel: ExperienceLevel.values.firstWhere(
          (e) => e.name == map['experienceLevel'],
          orElse: () => ExperienceLevel.beginner),
      weightUnit: map['weightUnit'] == 'lbs' ? WeightUnit.lbs : WeightUnit.kg,
      age: map['age'] ?? 25,
      goals: map['goals'] ?? 'Build muscle and gain strength',
      themeMode: ThemeMode.values.firstWhere((e) => e.name == map['themeMode'],
          orElse: () => ThemeMode.system),
      accentColor: Color(map['accentColor'] ?? Colors.blue.value),
      fontSize: FontSize.values.firstWhere((e) => e.name == map['fontSize'],
          orElse: () => FontSize.normal),
      restTimeStraight: map['restTimeStraight'] ?? 90,
      restTimeSuperset: map['restTimeSuperset'] ?? 120,
      restTimeDropset: map['restTimeDropset'] ?? 30,
      timerSound: map['timerSound'] ?? true,
      timerVibration: map['timerVibration'] ?? true,
      backgroundNotification: map['backgroundNotification'] ?? true,
      barbellWeight: (map['barbellWeight'] ?? 20.0).toDouble(),
      availablePlates: (map['availablePlates'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(k, v as int)) ??
          const {},
      autoIncrement: (map['autoIncrement'] ?? 0.0).toDouble(),
      showRpe: map['showRpe'] ?? true,
      showPreviousData: map['showPreviousData'] ?? true,
      autoBackup: map['autoBackup'] ?? false,
      autoSaveToDownloads: map['autoSaveToDownloads'] ?? true,
      autoSyncGoogleDrive: map['autoSyncGoogleDrive'] ?? false,
      autoSyncICloud: map['autoSyncICloud'] ?? false,
      googleDriveEmail: map['googleDriveEmail'],
      lastSynced:
          map['lastSynced'] != null ? DateTime.parse(map['lastSynced']) : null,
      height: (map['height'] ?? 170.0).toDouble(),
      weight: (map['weight'] ?? 75.0).toDouble(),
      sex: BiologicalSex.values.firstWhere(
        (e) => e.name == (map['sex'] ?? 'male'),
        orElse: () => BiologicalSex.male,
      ),
    );
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
