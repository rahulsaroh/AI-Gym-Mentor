import 'package:flutter/material.dart';

enum WeightUnit { kg, lbs }

enum ExperienceLevel { beginner, intermediate, advanced }

enum FontSize { normal, large }

class SettingsState {
  final String userName;
  final ExperienceLevel experienceLevel;
  final WeightUnit weightUnit;

  final ThemeMode themeMode;
  final Color accentColor;
  final FontSize fontSize;

  final int restTimeStraight;
  final int restTimeSuperset;
  final int restTimeDropset;
  final bool timerSound;
  final bool timerVibration;
  final bool backgroundNotification;
  final bool autoBackup;

  final double barbellWeight;
  final Map<String, int>
      availablePlates; // Key is string weight to allow const constructors

  final double autoIncrement;
  final bool showRpe;
  final bool showPreviousData;

  final String? googleDriveEmail;
  final DateTime? lastSynced;
  final DateTime? lastDriveBackup;

  const SettingsState({
    this.userName = 'Alex',
    this.experienceLevel = ExperienceLevel.beginner,
    this.weightUnit = WeightUnit.kg,
    this.themeMode = ThemeMode.system,
    this.accentColor = Colors.blue,
    this.fontSize = FontSize.normal,
    this.restTimeStraight = 90,
    this.restTimeSuperset = 120,
    this.restTimeDropset = 30,
    this.timerSound = true,
    this.timerVibration = true,
    this.backgroundNotification = true,
    this.autoBackup = false,
    this.barbellWeight = 20.0,
    this.availablePlates = const {
      '1.25': 4,
      '2.5': 4,
      '5.0': 4,
      '10.0': 2,
      '15.0': 2,
      '20.0': 2,
      '25.0': 2
    },
    this.autoIncrement = 0.0,
    this.showRpe = true,
    this.showPreviousData = true,
    this.googleDriveEmail,
    this.lastSynced,
    this.lastDriveBackup,
  });

  SettingsState copyWith({
    String? userName,
    ExperienceLevel? experienceLevel,
    WeightUnit? weightUnit,
    ThemeMode? themeMode,
    Color? accentColor,
    FontSize? fontSize,
    int? restTimeStraight,
    int? restTimeSuperset,
    int? restTimeDropset,
    bool? timerSound,
    bool? timerVibration,
    bool? backgroundNotification,
    bool? autoBackup,
    double? barbellWeight,
    Map<String, int>? availablePlates,
    double? autoIncrement,
    bool? showRpe,
    bool? showPreviousData,
    String? googleDriveEmail,
    DateTime? lastSynced,
    DateTime? lastDriveBackup,
  }) {
    return SettingsState(
      userName: userName ?? this.userName,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      weightUnit: weightUnit ?? this.weightUnit,
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      fontSize: fontSize ?? this.fontSize,
      restTimeStraight: restTimeStraight ?? this.restTimeStraight,
      restTimeSuperset: restTimeSuperset ?? this.restTimeSuperset,
      restTimeDropset: restTimeDropset ?? this.restTimeDropset,
      timerSound: timerSound ?? this.timerSound,
      timerVibration: timerVibration ?? this.timerVibration,
      backgroundNotification:
          backgroundNotification ?? this.backgroundNotification,
      autoBackup: autoBackup ?? this.autoBackup,
      barbellWeight: barbellWeight ?? this.barbellWeight,
      availablePlates: availablePlates ?? this.availablePlates,
      autoIncrement: autoIncrement ?? this.autoIncrement,
      showRpe: showRpe ?? this.showRpe,
      showPreviousData: showPreviousData ?? this.showPreviousData,
      googleDriveEmail: googleDriveEmail ?? this.googleDriveEmail,
      lastSynced: lastSynced ?? this.lastSynced,
      lastDriveBackup: lastDriveBackup ?? this.lastDriveBackup,
    );
  }
}
