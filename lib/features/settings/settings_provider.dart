import 'package:flutter/material.dart';
import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';

import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:ai_gym_mentor/features/settings/settings_repository.dart';
import 'package:ai_gym_mentor/features/settings/services/data_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  late final SettingsRepository _repository;

  @override
  Future<SettingsState> build() async {
    _repository = SettingsRepository();
    final settings = await _repository.loadSettings();
    
    // Auto-fetch height if at default and we have database records
    if (settings.height == 170.0) {
      try {
        final database = ref.read(appDatabaseProvider);
        final latestWithHeight = await (database.select(database.bodyMeasurements)
              ..where((t) => t.height.isNotNull())
              ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
              ..limit(1))
            .getSingleOrNull();
        
        if (latestWithHeight != null && latestWithHeight.height != null) {
          final updated = settings.copyWith(height: latestWithHeight.height!);
          await _repository.saveSettings(updated);
          return updated;
        }
      } catch (e) {
        debugPrint('SettingsProvider: Auto-fetch height failed: $e');
      }
    }
    
    return settings;
  }


  Future<void> updateSettings(SettingsState newState) async {
    state = AsyncData(newState);
    await _repository.saveSettings(newState);
  }

  Future<void> updateName(String name) async {
    final current = await future;
    final updated = current.copyWith(userName: name);
    await updateSettings(updated);
  }

  Future<void> updateTheme(ThemeMode mode) async {
    final current = await future;
    final updated = current.copyWith(themeMode: mode);
    await updateSettings(updated);
  }

  Future<void> updateAccentColor(Color color) async {
    final current = await future;
    final updated = current.copyWith(accentColor: color);
    await updateSettings(updated);
  }

  Future<void> updateWeightUnit(WeightUnit unit) async {
    final current = await future;
    final updated = current.copyWith(weightUnit: unit);
    await updateSettings(updated);
  }

  Future<void> updateRestTime(String type, int seconds) async {
    final current = await future;
    SettingsState updated;
    switch (type) {
      case 'straight':
        updated = current.copyWith(restTimeStraight: seconds);
        break;
      case 'superset':
        updated = current.copyWith(restTimeSuperset: seconds);
        break;
      case 'dropset':
        updated = current.copyWith(restTimeDropset: seconds);
        break;
      default:
        return;
    }
    await updateSettings(updated);
  }

  Future<void> updateOneRmFormula(OneRmFormula formula) async {
    final current = await future;
    final updated = current.copyWith(oneRmFormula: formula);
    await updateSettings(updated);
  }

  Future<void> updateHeight(double height) async {
    final current = await future;
    final updated = current.copyWith(height: height);
    await updateSettings(updated);
  }

  Future<void> updateSex(BiologicalSex sex) async {
    final current = await future;
    final updated = current.copyWith(sex: sex);
    await updateSettings(updated);
  }


}

@riverpod
DataService dataService(Ref ref) {
  return DataService(ref.watch(appDatabaseProvider));
}
