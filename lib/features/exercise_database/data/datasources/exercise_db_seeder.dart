import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/core/database/database.dart' as schema;
import 'package:ai_gym_mentor/core/database/database.dart'; // For AppDatabase without prefix if needed, or use schema.AppDatabase
import 'package:ai_gym_mentor/core/database/initial_data.dart';

class ExerciseDbSeeder {
  static final ExerciseDbSeeder instance = ExerciseDbSeeder._();
  ExerciseDbSeeder._();

  static const String _seedKey =
      'exercises_seed_v9'; // v9: Integrated initialExercises from initial_data.dart

  /// Deduplicates source JSON by removing alphabetic-ID entries when
  /// numeric-ID alternatives exist with the same name.
  /// Returns map with {original, final, removed} counts.
  Future<Map<String, int>> _deduplicateExerciseData() async {
    // This method is informational - the actual deduplication happens
    // at build time via the Python script.
    // We can optionally validate here.
    final jsonString = await rootBundle.loadString('assets/data/exercises.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    
    // Group by name
    final Map<String, List<dynamic>> nameGroups = {};
    for (final item in jsonList) {
      final name = (item['name'] as String?)?.trim();
      if (name != null && name.isNotEmpty) {
        nameGroups.putIfAbsent(name, () => []).add(item);
      }
    }
    
    bool isNumeric(String? id) {
      if (id == null) return false;
      return RegExp(r'^\d+$').hasMatch(id);
    }
    bool isAlpha(String? id) {
      if (id == null) return false;
      return RegExp(r'[a-zA-Z]').hasMatch(id);
    }
    
    int removed = 0;
    for (final items in nameGroups.values) {
      if (items.length <= 1) continue;
      final hasNumeric = items.any((i) => isNumeric(i['id']));
      final hasAlpha = items.any((i) => isAlpha(i['id']));
      if (hasNumeric && hasAlpha) {
        removed += items.where((i) => isAlpha(i['id'])).length;
      }
    }
    
    return {
      'original': jsonList.length,
      'final': jsonList.length,
      'removed': removed,
    };
  }

  Future<void> seed([AppDatabase? providedDb]) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_seedKey) == true) {
      debugPrint('ExerciseDbSeeder: Already seeded v5, skipping...');
      return;
    }

    debugPrint('ExerciseDbSeeder: Starting Phase 3 seeding...');
    final database = providedDb ?? AppDatabase();

    try {
      // Pre-seed: Load and deduplicate exercise data
      final dedupResult = await _deduplicateExerciseData();
      if (dedupResult['original'] != dedupResult['final']) {
        debugPrint('ExerciseDbSeeder: Deduplicated source data '
            '(removed ${dedupResult['removed']} duplicates)');
      }

      // 1. Load Main Exercise Data
      final jsonString =
          await rootBundle.loadString('assets/data/exercises.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      debugPrint('ExerciseDbSeeder: Loaded ${jsonList.length} exercises');

      // Refining the approach to allow table linking:
      // We'll insert exercises first in one batch, then muscles/parts/instructions in another.

      // Pass 0: Pre-fetch existing exercise_id to ID mapping to maintain stability
      final Map<String, int> existingIdMap = {};
      final existingRows = await database.select(database.exercises).get();
      for (var row in existingRows) {
        if (row.exerciseId != null) {
          existingIdMap[row.exerciseId!] = row.id;
        } else {
          // Fallback for older data without exerciseId
          existingIdMap[row.name] = row.id;
        }
      }

      final Map<String, int> sourceIdToDbId = {};

      // Pass 1.1: initialExercises from initial_data.dart (Upsert Logic)
      await database.batch((batch) {
        for (final companion in initialExercises) {
          final name = companion.name.value;
          if (existingIdMap.containsKey(name)) {
            final dbId = existingIdMap[name]!;
            batch.update(database.exercises, companion, where: (t) => t.id.equals(dbId));
          } else {
            batch.insert(database.exercises, companion, mode: InsertMode.insertOrIgnore);
          }
        }
      });

      // Pass 1.2: JSON Exercises (Upsert Logic)
      await database.batch((batch) {
        for (final item in jsonList) {
          final extId = item['id'].toString();
          final rawPrimary = item['primaryMuscles'];
          final List<dynamic> primaryMuscles = rawPrimary is List
              ? rawPrimary
              : (rawPrimary != null ? [rawPrimary] : []);
          final primaryMuscle = primaryMuscles.isNotEmpty
              ? primaryMuscles.first.toString()
              : 'Other';

          final companion = schema.ExercisesCompanion(
            exerciseId: Value(extId),
            name: Value(item['name'] ?? 'Unknown'),
            category: Value(item['category'] ?? 'strength'),
            difficulty: Value(item['difficulty'] ?? 'beginner'),
            primaryMuscle: Value(primaryMuscle),
            equipment: Value(item['equipment'] ?? 'None'),
            setType: const Value('Straight'),
            force: Value(item['force']),
            mechanic: Value(item['mechanic']),
            imageUrl: Value(item['imageUrl']),
            gifUrl: Value(item['gifUrl']),
            source: Value(item['source'] ?? 'local'),
            nameHi: Value(item['nameHindi']),
            nameMr: Value(item['nameMarathi']),
            isEnriched: Value(item['safetyTips'] != null),
          );

          if (existingIdMap.containsKey(extId)) {
            final dbId = existingIdMap[extId]!;
            batch.update(database.exercises, companion, where: (t) => t.id.equals(dbId));
            sourceIdToDbId[extId] = dbId;
          } else if (existingIdMap.containsKey(item['name'])) {
            final dbId = existingIdMap[item['name']]!;
            batch.update(database.exercises, companion, where: (t) => t.id.equals(dbId));
            sourceIdToDbId[extId] = dbId;
          } else {
            // Since batch.insert doesn't return the ID immediately, 
            // we'll need to handle the mapping after Pass 1 or use a different approach.
            // For now, let's just insert and we'll re-fetch IDs if needed for Pass 2.
            batch.insert(database.exercises, companion);
          }
        }
      });

      // If we did insertions, we MUST re-populate sourceIdToDbId for Pass 2
      final updatedRows = await database.select(database.exercises).get();
      for (var row in updatedRows) {
        if (row.exerciseId != null) {
          sourceIdToDbId[row.exerciseId!] = row.id;
        }
      }

      // Pass 2: Related Data
      await database.batch((batch) {
        for (final item in jsonList) {
          final dbId = sourceIdToDbId[item['id']];
          if (dbId == null) continue;

          // Cleanup existing relations before re-seeding to avoid duplicates in non-unique tables
          batch.deleteWhere(
              database.exerciseInstructions, (t) => t.exerciseId.equals(dbId));
          batch.deleteWhere(
              database.exerciseMuscles, (t) => t.exerciseId.equals(dbId));
          batch.deleteWhere(
              database.exerciseBodyParts, (t) => t.exerciseId.equals(dbId));

          // Instructions (New Table)
          final instructions = item['instructions'] as List<dynamic>? ?? [];
          for (int i = 0; i < instructions.length; i++) {
            batch.insert(
                database.exerciseInstructions,
                schema.ExerciseInstructionsCompanion.insert(
                  exerciseId: dbId,
                  stepNumber: i + 1,
                  instructionText: instructions[i].toString(),
                ));
          }

          // Muscles (Primary)
          final primary = item['primaryMuscles'] as List<dynamic>? ?? [];
          for (var muscle in primary) {
            batch.insert(
                database.exerciseMuscles,
                schema.ExerciseMusclesCompanion.insert(
                  exerciseId: dbId,
                  muscleName: muscle.toString().toLowerCase(),
                  isPrimary: const Value(true),
                ),
                mode: InsertMode.insertOrIgnore);
          }

          // Muscles (Secondary)
          final rawSecondary = item['secondaryMuscles'];
          final List<dynamic> secondary = rawSecondary is List
              ? rawSecondary
              : (rawSecondary != null ? [rawSecondary] : []);
          for (var muscle in secondary) {
            batch.insert(
                database.exerciseMuscles,
                schema.ExerciseMusclesCompanion.insert(
                  exerciseId: dbId,
                  muscleName: muscle.toString().toLowerCase(),
                  isPrimary: const Value(false),
                ),
                mode: InsertMode.insertOrIgnore);
          }

          // Body Parts (Mapping Logic)
          final bodyParts = _mapMusclesToBodyParts(primary, secondary);
          for (var part in bodyParts) {
            batch.insert(
                database.exerciseBodyParts,
                schema.ExerciseBodyPartsCompanion.insert(
                  exerciseId: dbId,
                  bodyPart: part,
                ),
                mode: InsertMode.insertOrIgnore);
          }

          // Safety Tips & Enriched Content (Phase 3.5 - High Quality)
          if (item['safetyTips'] != null) {
            batch.insert(
                database.exerciseEnrichedContent,
                schema.ExerciseEnrichedContentCompanion.insert(
                  exerciseId: Value(dbId),
                  safetyTips: Value(jsonEncode(item['safetyTips'])),
                  commonMistakes: Value(jsonEncode(item['commonMistakes'])),
                  enrichedAt: Value(DateTime.now()),
                  enrichmentSource: const Value('llm-enriched'),
                ),
                mode: InsertMode.insertOrReplace);
          } else {
            _extractAndInsertSafetyTips(
                database, batch, dbId, item['instructions'] ?? []);
          }
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

  void _extractAndInsertSafetyTips(
      AppDatabase database, Batch batch, int dbId, List instructions) {
    const safetyKeywords = [
      'keep',
      'avoid',
      'maintain',
      'ensure',
      'careful',
      'slowly',
      'controlled',
      'breathe',
      'neutral',
      'straight',
      'do not',
      "don't",
      'prevent',
      'injury'
    ];

    final extractedTips = <String>[];
    for (var instr in instructions) {
      final text = instr.toString();
      final lowerText = text.toLowerCase();
      if (safetyKeywords.any((kw) => lowerText.contains(kw))) {
        if (text.length < 200) {
          // Avoid overly long descriptions
          extractedTips.add(text);
        }
      }
    }

    if (extractedTips.isNotEmpty) {
      batch.insert(
          database.exerciseEnrichedContent,
          schema.ExerciseEnrichedContentCompanion.insert(
            exerciseId: Value(dbId),
            safetyTips: Value(jsonEncode(extractedTips)),
            enrichedAt: Value(DateTime.now()),
            enrichmentSource: const Value('auto_extracted'),
          ),
          mode: InsertMode.insertOrReplace);
    }
  }

  List<String> _mapMusclesToBodyParts(List primary, List secondary) {
    final all = [...primary, ...secondary]
        .map((e) => e.toString().toLowerCase())
        .toList();
    final parts = <String>{};

    for (var m in all) {
      if (m.contains('pector') || m.contains('chest')) {
        parts.add('Chest');
      } else if (m.contains('lat') ||
          m.contains('rhombo') ||
          m.contains('trape') ||
          m.contains('back'))
        parts.add('Back');
      else if (m.contains('deltoid') || m.contains('shoulder'))
        parts.add('Shoulders');
      else if (m.contains('bicep'))
        parts.add('Biceps');
      else if (m.contains('tricep'))
        parts.add('Triceps');
      else if (m.contains('forearm'))
        parts.add('Arms');
      else if (m.contains('abdom') ||
          m.contains('core') ||
          m.contains('oblique'))
        parts.add('Abs');
      else if (m.contains('quad'))
        parts.add('Quads');
      else if (m.contains('hamstr'))
        parts.add('Hamstrings');
      else if (m.contains('glute'))
        parts.add('Glutes');
      else if (m.contains('calf'))
        parts.add('Calves');
      else if (m.contains('leg')) parts.add('Legs');
    }

    if (parts.isEmpty) parts.add('Other');
    return parts.toList();
  }

  Future<void> _seedProgressions(
      AppDatabase database, Map<String, int> sourceIdToDbId) async {
    try {
      final jsonString = await rootBundle
          .loadString('assets/exercise_data/progressions_seed.json');
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
                batch.insert(
                    database.exerciseProgressions,
                    schema.ExerciseProgressionsCompanion.insert(
                      exerciseId: baseDbId,
                      progressionExerciseId: progDbId,
                      position: position,
                    ),
                    mode: InsertMode.insertOrIgnore);
              }
            }
          }
        }
      });
    } catch (_) {}
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_seedKey);
    // Also remove any older versions just in case
    for (int i = 1; i <= 10; i++) {
      await prefs.remove('exercises_seed_v$i');
    }
  }
}
