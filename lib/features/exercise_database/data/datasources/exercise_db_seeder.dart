import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/core/database/database.dart' as schema;
import 'package:ai_gym_mentor/core/database/database.dart'; // For AppDatabase without prefix if needed, or use schema.AppDatabase

class ExerciseDbSeeder {
  static final ExerciseDbSeeder instance = ExerciseDbSeeder._();
  ExerciseDbSeeder._();

  static const String _seedKey = 'exercises_seed_v4'; // Forced re-seed for layout/granularity fixes

  Future<void> seed([AppDatabase? providedDb]) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_seedKey) == true) {
      debugPrint('ExerciseDbSeeder: Already seeded v2, skipping...');
      return;
    }

    debugPrint('ExerciseDbSeeder: Starting Phase 3 seeding...');
    final database = providedDb ?? AppDatabase();

    try {
      // 1. Load Main Exercise Data
      final jsonString = await rootBundle.loadString('assets/data/exercises.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      debugPrint('ExerciseDbSeeder: Loaded ${jsonList.length} exercises');

      // Refining the approach to allow table linking:
      // We'll insert exercises first in one batch, then muscles/parts/instructions in another.
      
      final Map<String, int> sourceIdToDbId = {};
      
      // Pass 1: Exercises
      await database.batch((batch) {
        for (final item in jsonList) {
          final primaryMuscles = item['primaryMuscles'] as List<dynamic>? ?? [];
          final primaryMuscle = primaryMuscles.isNotEmpty ? primaryMuscles.first.toString() : 'Other';

          batch.insert(database.exercises, schema.ExercisesCompanion.insert(
            exerciseId: Value(item['id']),
            name: item['name'] ?? 'Unknown',
            category: Value(item['category'] ?? 'strength'),
            difficulty: Value(item['difficulty'] ?? 'beginner'),
            primaryMuscle: primaryMuscle,
            equipment: item['equipment'] ?? 'None',
            setType: 'Straight',
            force: Value(item['force']),
            mechanic: Value(item['mechanic']),
            imageUrl: Value(item['imageUrl']),
            source: Value(item['source'] ?? 'local'),
          ), mode: InsertMode.insertOrIgnore);
        }
      });

      // Retrieve mapping
      final allRows = await database.select(database.exercises).get();
      for (var row in allRows) {
        if (row.exerciseId != null) {
          sourceIdToDbId[row.exerciseId!] = row.id;
        }
      }

      // Pass 2: Related Data
      await database.batch((batch) {
        for (final item in jsonList) {
          final dbId = sourceIdToDbId[item['id']];
          if (dbId == null) continue;

          // Instructions (New Table)
          final instructions = item['instructions'] as List<dynamic>? ?? [];
          for (int i = 0; i < instructions.length; i++) {
            batch.insert(database.exerciseInstructions, schema.ExerciseInstructionsCompanion.insert(
              exerciseId: dbId,
              stepNumber: i + 1,
              instructionText: instructions[i].toString(),
            ));
          }

          // Muscles (Primary)
          final primary = item['primaryMuscles'] as List<dynamic>? ?? [];
          for (var muscle in primary) {
            batch.insert(database.exerciseMuscles, schema.ExerciseMusclesCompanion.insert(
              exerciseId: dbId,
              muscleName: muscle.toString().toLowerCase(),
              isPrimary: const Value(true),
            ), mode: InsertMode.insertOrIgnore);
          }

          // Muscles (Secondary)
          final secondary = item['secondaryMuscles'] as List<dynamic>? ?? [];
          for (var muscle in secondary) {
            batch.insert(database.exerciseMuscles, schema.ExerciseMusclesCompanion.insert(
              exerciseId: dbId,
              muscleName: muscle.toString().toLowerCase(),
              isPrimary: const Value(false),
            ), mode: InsertMode.insertOrIgnore);
          }

          // Body Parts (Mapping Logic)
          final bodyParts = _mapMusclesToBodyParts(primary, secondary);
          for (var part in bodyParts) {
            batch.insert(database.exerciseBodyParts, schema.ExerciseBodyPartsCompanion.insert(
              exerciseId: dbId,
              bodyPart: part,
            ), mode: InsertMode.insertOrIgnore);
          }

          // Safety Tips Auto-Extraction (Phase 3.5)
          _extractAndInsertSafetyTips(database, batch, dbId, item['instructions'] ?? []);
        }
      });

      // 3. Load Progressions (Phase 3.6)
      await _seedProgressions(database, sourceIdToDbId);

      await prefs.setBool(_seedKey, true);
      debugPrint('ExerciseDbSeeder: Phase 3 Seed completed successfully!');
    } catch (e) {
      debugPrint('ExerciseDbSeeder: Error: $e');
    }
  }

  void _extractAndInsertSafetyTips(AppDatabase database, Batch batch, int dbId, List instructions) {
    const safetyKeywords = [
      'keep', 'avoid', 'maintain', 'ensure', 'careful', 
      'slowly', 'controlled', 'breathe', 'neutral', 'straight',
      'do not', "don't", 'prevent', 'injury'
    ];
    
    final extractedTips = <String>[];
    for (var instr in instructions) {
      final text = instr.toString();
      final lowerText = text.toLowerCase();
      if (safetyKeywords.any((kw) => lowerText.contains(kw))) {
        if (text.length < 200) { // Avoid overly long descriptions
          extractedTips.add(text);
        }
      }
    }

    if (extractedTips.isNotEmpty) {
      batch.insert(database.exerciseEnrichedContent, schema.ExerciseEnrichedContentCompanion.insert(
        exerciseId: dbId,
        safetyTips: Value(jsonEncode(extractedTips)),
        enrichedAt: Value(DateTime.now()),
        enrichmentSource: const Value('auto_extracted'),
      ), mode: InsertMode.insertOrReplace);
    }
  }

  List<String> _mapMusclesToBodyParts(List primary, List secondary) {
    final all = [...primary, ...secondary].map((e) => e.toString().toLowerCase()).toList();
    final parts = <String>{};

    for (var m in all) {
      if (m.contains('pector') || m.contains('chest')) parts.add('Chest');
      else if (m.contains('lat') || m.contains('rhombo') || m.contains('trape') || m.contains('back')) parts.add('Back');
      else if (m.contains('deltoid') || m.contains('shoulder')) parts.add('Shoulders');
      else if (m.contains('bicep')) parts.add('Biceps');
      else if (m.contains('tricep')) parts.add('Triceps');
      else if (m.contains('forearm')) parts.add('Arms');
      else if (m.contains('abdom') || m.contains('core') || m.contains('oblique')) parts.add('Abs');
      else if (m.contains('quad')) parts.add('Quads');
      else if (m.contains('hamstr')) parts.add('Hamstrings');
      else if (m.contains('glute')) parts.add('Glutes');
      else if (m.contains('calf')) parts.add('Calves');
      else if (m.contains('leg')) parts.add('Legs');
    }
    
    if (parts.isEmpty) parts.add('Other');
    return parts.toList();
  }

  Future<void> _seedProgressions(AppDatabase database, Map<String, int> sourceIdToDbId) async {
    try {
      final jsonString = await rootBundle.loadString('assets/exercise_data/progressions_seed.json');
      final List<dynamic> progressions = json.decode(jsonString);

      await database.batch((batch) {
        for (final prog in progressions) {
          final chain = prog['chain'] as List;
          final baseSourceId = prog['base_id'] as String;
          final baseDbId = sourceIdToDbId[baseSourceId];

          if (baseDbId != null) {
            for (final item in chain) {
              final progSourceId = item['id'] as String;
              final position = item['position'] as int;
              final progDbId = sourceIdToDbId[progSourceId];

              if (progDbId != null && position != 0) {
                batch.insert(database.exerciseProgressions, schema.ExerciseProgressionsCompanion.insert(
                  exerciseId: baseDbId,
                  progressionExerciseId: progDbId,
                  position: position,
                ), mode: InsertMode.insertOrIgnore);
              }
            }
          }
        }
      });
    } catch (_) {}
  }
}
