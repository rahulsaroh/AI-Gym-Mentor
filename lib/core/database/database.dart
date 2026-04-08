import 'dart:io';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:gym_gemini_pro/core/database/initial_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

enum SetType { straight, warmup, superset, dropSet, amrap, timed, restPause, cluster }

class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get primaryMuscle => text()();
  TextColumn get secondaryMuscle => text().nullable()();
  TextColumn get equipment => text()();
  TextColumn get setType => text()();
  IntColumn get restTime => integer().withDefault(const Constant(90))();
  TextColumn get instructions => text().nullable()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUsed => dateTime().nullable()();
}

class WorkoutTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get lastUsed => dateTime().nullable()();
}

class TemplateDays extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get templateId => integer().references(WorkoutTemplates, #id)();
  TextColumn get name => text()();
  IntColumn get order => integer()();
}

class TemplateExercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get dayId => integer().references(TemplateDays, #id)();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  IntColumn get order => integer()();
  IntColumn get setType => intEnum<SetType>().withDefault(const Constant(0))();
  TextColumn get setsJson => text()(); // JSON representation of TemplateSet list
  IntColumn get restTime => integer().withDefault(const Constant(90))();
  TextColumn get notes => text().nullable()();
  TextColumn get supersetGroupId => text().nullable()();
}

class Workouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get endTime => dateTime().nullable()();
  IntColumn get duration => integer().nullable()(); // in minutes or seconds
  IntColumn get templateId => integer().nullable().references(WorkoutTemplates, #id)();
  IntColumn get dayId => integer().nullable().references(TemplateDays, #id)();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('draft'))(); // draft, completed
}

class WorkoutSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workoutId => integer().references(Workouts, #id)();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  IntColumn get exerciseOrder => integer()();
  IntColumn get setNumber => integer()();
  RealColumn get reps => real()();
  RealColumn get weight => real()();
  RealColumn get rpe => real().nullable()();
  IntColumn get rir => integer().nullable()();
  IntColumn get setType => intEnum<SetType>().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  BoolColumn get isPr => boolean().withDefault(const Constant(false))();
  TextColumn get supersetGroupId => text().nullable()();
  TextColumn get subSetsJson => text().nullable()(); // For DropSets/Rest-Pause
}

class BodyMeasurements extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  RealColumn get weight => real().nullable()();
  RealColumn get chest => real().nullable()();
  RealColumn get waist => real().nullable()();
  RealColumn get hips => real().nullable()();
  RealColumn get leftArm => real().nullable()();
  RealColumn get rightArm => real().nullable()();
  RealColumn get leftThigh => real().nullable()();
  RealColumn get rightThigh => real().nullable()();
  RealColumn get calves => real().nullable()();
  RealColumn get bodyFat => real().nullable()();
}

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workoutId => integer().nullable().references(Workouts, #id)();
  IntColumn get measurementId => integer().nullable().references(BodyMeasurements, #id)();
  TextColumn get type => text()(); // workout, measurement
  TextColumn get status => text().withDefault(const Constant('pending'))(); // pending, done, failed
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get error => text().nullable()();
}

class ExerciseProgressionSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  RealColumn get incrementOverride => real().nullable()(); // Exercise-specific increment
  IntColumn get targetReps => integer().withDefault(const Constant(10))();
  IntColumn get targetSets => integer().withDefault(const Constant(3))();
  BoolColumn get autoSuggest => boolean().withDefault(const Constant(true))();
}

@DriftDatabase(tables: [
  Exercises,
  WorkoutTemplates,
  TemplateDays,
  TemplateExercises,
  Workouts,
  WorkoutSets,
  BodyMeasurements,
  SyncQueue,
  ExerciseProgressionSettings,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          // Helper to check if a column exists to avoid duplicate column errors
          Future<bool> hasColumn(String table, String column) async {
            final result = await customSelect('PRAGMA table_info("$table")').get();
            return result.any((row) => row.data['name'] == column);
          }

          if (from < 2) {
            if (!await hasColumn('workout_sets', 'notes')) {
              await m.addColumn(workoutSets, workoutSets.notes);
            }
          }
          if (from < 3) {
            await m.createTable(bodyMeasurements);
            await m.createTable(syncQueue);
          }
          if (from < 4) {
            if (!await hasColumn('workout_sets', 'set_type')) {
              await m.addColumn(workoutSets, workoutSets.setType);
            }
            if (!await hasColumn('workout_sets', 'superset_group_id')) {
              await m.addColumn(workoutSets, workoutSets.supersetGroupId);
            }
            if (!await hasColumn('workout_sets', 'sub_sets_json')) {
              await m.addColumn(workoutSets, workoutSets.subSetsJson);
            }
            if (!await hasColumn('template_exercises', 'set_type')) {
              await m.addColumn(templateExercises, templateExercises.setType);
            }
            if (!await hasColumn('template_exercises', 'superset_group_id')) {
              await m.addColumn(templateExercises, templateExercises.supersetGroupId);
            }
          }
          if (from < 5) {
            await m.createTable(exerciseProgressionSettings);
          }
          if (from < 6) {
            try {
              await m.createIndex(Index('idx_sets_exercise_id', 'CREATE INDEX idx_sets_exercise_id ON workout_sets(exercise_id)'));
              await m.createIndex(Index('idx_workouts_date', 'CREATE INDEX idx_workouts_date ON workouts(date)'));
              await m.createIndex(Index('idx_exercises_muscle', 'CREATE INDEX idx_exercises_muscle ON exercises(primary_muscle)'));
            } catch (e) {
              debugPrint('Index creation skipped (likely exists): $e');
            }
          }
          if (from < 7) {
            if (!await hasColumn('workouts', 'day_id')) {
              await m.addColumn(workouts, workouts.dayId);
            }
          }
          if (from < 8) {
            if (!await hasColumn('workout_sets', 'is_pr')) {
              await m.addColumn(workoutSets, workoutSets.isPr);
            }
          }
          if (from < 9) {
            if (!await hasColumn('workout_sets', 'rir')) {
              await m.addColumn(workoutSets, workoutSets.rir);
            }
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');

          if (details.wasCreated) {
            await batch((b) async {
              await _seedInitialData(b);
            });
            await _seedSamplePrograms();
          } else {
            await seedExercisesIfEmpty();
            await _seedProgramsIfMissing();
          }
        },
      );

  Future<void> _seedInitialData(Batch batch) async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/exercises.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      final exercisesToInsert = jsonList.map((item) {
        return ExercisesCompanion.insert(
          name: item['name'] as String,
          primaryMuscle: item['primaryMuscle'] as String,
          secondaryMuscle: Value(item['secondaryMuscle'] as String?),
          equipment: item['equipment'] as String,
          setType: item['setType'] as String,
          restTime: Value(item['restTime'] as int? ?? 90),
          instructions: Value(item['instructions'] as String?),
          isCustom: const Value(false),
        );
      }).toList();

      batch.insertAll(exercises, exercisesToInsert);
    } catch (e) {
      debugPrint('Error seeding from JSON: $e');
      batch.insertAll(exercises, initialExercises);
    }
  }

  Future<void> _seedSamplePrograms() async {
    final allExercises = await select(exercises).get();
    final exerciseMap = {for (var e in allExercises) e.name: e.id};

    await _seedProgram(samplePPLProgram, exerciseMap);
    await _seedProgram(elitePPLProgram, exerciseMap);
    await _seedImportedPrograms(exerciseMap);
  }

  Future<void> _seedProgram(SampleProgram program, Map<String, int> exerciseMap) async {
    final templateId = await into(workoutTemplates).insert(WorkoutTemplatesCompanion.insert(
      name: program.name,
      description: Value(program.description),
    ));

    for (int i = 0; i < program.days.length; i++) {
      final day = program.days[i];
      final dayId = await into(templateDays).insert(TemplateDaysCompanion.insert(
        templateId: templateId,
        name: day.name,
        order: i,
      ));

      for (int j = 0; j < day.exercises.length; j++) {
        final ex = day.exercises[j];
        final exId = exerciseMap[ex.name];
        if (exId != null) {
          await into(templateExercises).insert(TemplateExercisesCompanion.insert(
            dayId: dayId,
            exerciseId: exId,
            order: j,
            setsJson: ex.setsJson,
            notes: Value(ex.notes),
          ));
        }
      }
    }
  }

  Future<void> seedExercisesIfEmpty() async {
    final allEx = await select(exercises).get();
    final existingNames = allEx.map((e) => e.name).toSet();
    
    final missingExercises = initialExercises.where((e) => !existingNames.contains(e.name.value)).toList();
    
    if (missingExercises.isNotEmpty) {
      debugPrint('Database: Adding ${missingExercises.length} missing exercises...');
      await batch((b) async {
        b.insertAll(exercises, missingExercises);
      });
    }
  }

  Future<void> _seedProgramsIfMissing() async {
    final allTemplates = await select(workoutTemplates).get();
    final templateNames = allTemplates.map((t) => t.name).toSet();

    final allExercises = await select(exercises).get();
    final exerciseMap = {for (var e in allExercises) e.name: e.id};

    if (!templateNames.contains(samplePPLProgram.name)) {
      await _seedProgram(samplePPLProgram, exerciseMap);
    }
    if (!templateNames.contains(elitePPLProgram.name)) {
      await _seedProgram(elitePPLProgram, exerciseMap);
    }
    await _seedImportedPrograms(exerciseMap);
  }

  Future<void> _seedImportedPrograms(Map<String, int> exerciseMap) async {
    final templateNames = await select(workoutTemplates).get();
    if (templateNames.any((t) => t.name == '6 Day PPL')) return;

    try {
      final jsonStr = await rootBundle.loadString('assets/data/imported_ppl.json');
      final data = jsonDecode(jsonStr);
      final name = data['name'] as String;
      final description = data['description'] as String?;
      final days = data['days'] as List;

      await transaction(() async {
        final templateId = await into(workoutTemplates).insert(WorkoutTemplatesCompanion.insert(
          name: name,
          description: Value(description),
        ));

        for (final dayData in days) {
          final dayId = await into(templateDays).insert(TemplateDaysCompanion.insert(
            templateId: templateId,
            name: dayData['name'],
            order: dayData['order'],
          ));

          final exercisesArr = dayData['exercises'] as List;
          
          // Also create a "Completed Workout" for history for each Day in the Excel
          final workoutId = await into(workouts).insert(WorkoutsCompanion.insert(
            name: 'PPL History: ${dayData['name']}',
            date: DateTime.now().subtract(const Duration(days: 7)),
            status: const Value('completed'),
            templateId: Value(templateId),
            dayId: Value(dayId),
          ));

          for (final exData in exercisesArr) {
            final exerciseName = exData['exerciseName'] as String;
            final exId = exerciseMap[exerciseName];
            
            // If exercise not in Drift, we insert it as custom
            final finalExId = exId ?? await into(exercises).insert(ExercisesCompanion.insert(
              name: exerciseName,
              primaryMuscle: 'Full Body',
              equipment: 'None',
              setType: 'Straight',
            ));
            
            exerciseMap[exerciseName] = finalExId;

            // Add to template
            await into(templateExercises).insert(TemplateExercisesCompanion.insert(
              dayId: dayId,
              exerciseId: finalExId,
              order: exData['order'],
              setsJson: exData['setsJson'],
              notes: Value(exData['notes']),
            ));

            // Add to session history (Logs)
            final setsData = jsonDecode(exData['setsJson']) as List;
            for (int k = 0; k < setsData.length; k++) {
              final setData = setsData[k];
              await into(workoutSets).insert(WorkoutSetsCompanion.insert(
                workoutId: workoutId,
                exerciseId: finalExId,
                exerciseOrder: exData['order'],
                setNumber: k + 1,
                reps: (setData['reps'] as num).toDouble(),
                weight: (setData['weight'] as num).toDouble(),
                completed: const Value(true),
              ));
            }
          }
        }
      });
    } catch (e) {
      debugPrint('Database: Error seeding imported program: $e');
    }
  }
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'gym_log.sqlite'));
    
    try {
      return NativeDatabase(file);
    } catch (e) {
      // If database is corrupted, move it and start fresh
      if (file.existsSync()) {
        final corruptedPath = p.join(dbFolder.path, 'gym_log_corrupted_${DateTime.now().millisecondsSinceEpoch}.sqlite');
        await file.rename(corruptedPath);
      }
      return NativeDatabase(file);
    }
  });
}
