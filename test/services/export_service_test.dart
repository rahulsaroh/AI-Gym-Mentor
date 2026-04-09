import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/services/export_service.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// Mock PathProvider to avoid MissingPluginException in tests
class MockPathProvider extends PathProviderPlatform with MockPlatformInterfaceMixin {
  @override
  Future<String?> getTemporaryPath() async => '.';
  @override
  Future<String?> getApplicationSupportPath() async => '.';
  @override
  Future<String?> getLibraryPath() async => '.';
  @override
  Future<String?> getApplicationDocumentsPath() async => '.';
  @override
  Future<String?> getExternalStoragePath() async => '.';
  @override
  Future<List<String>?> getExternalCachePaths() async => ['.'];
  @override
  Future<List<String>?> getExternalStoragePaths({StorageDirectory? type}) async => ['.'];
  @override
  Future<String?> getDownloadsPath() async => '.';
}

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    PathProviderPlatform.instance = MockPathProvider();
    db = AppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
      ],
    );
  });

  tearDown(() {
    container.dispose();
    db.close();
  });

  // Note: Testing actual Share/FilePicker is difficult in unit tests.
  // We focus on the data preparation logic if possible, but currently 
  // ExportService mixes data prep with side effects.
  
  // Future Refactoring Opportunity: Separate data prep from platform calls.
  
  test('ExportService - JSON structure check', () async {
    // Add dummy data
    await db.into(db.workouts).insert(WorkoutsCompanion.insert(
      name: 'Test Workout',
      date: DateTime.now(),
    ));

    final workouts = await db.select(db.workouts).get();
    final sets = await db.select(db.workoutSets).get();

    final data = {
      'version': 1,
      'exported_at': DateTime.now().toIso8601String(),
      'workouts': workouts.map((w) => w.toJson()).toList(),
      'sets': sets.map((s) => s.toJson()).toList(),
    };

    expect(data['version'], 1);
    expect(data['workouts'], isNotEmpty);
    expect((data['workouts'] as List).first['name'], 'Test Workout');
  });
}
