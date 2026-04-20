import 'package:flutter/material.dart';
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
    return await _repository.loadSettings();
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

  Future<void> updateGeminiApiKey(String? key) async {
    final current = await future;
    final updated = current.copyWith(geminiApiKey: key);
    await updateSettings(updated);
  }
}

@riverpod
DataService dataService(Ref ref) {
  return DataService(ref.watch(appDatabaseProvider));
}
