import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:gym_gemini_pro/core/database/initial_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

enum SetType { straight, warmup, superset, dropSet, amrap, timed, restPause, cluster }

class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
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
  IntColumn get setType => intEnum<SetType>().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
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
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 7;

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
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');

          if (details.wasCreated) {
            // Prepopulate database with initial exercises
            await batch((batch) {
              batch.insertAll(exercises, initialExercises);
            });

            // Seed sample PPL program
            final allExercises = await select(exercises).get();
            final exerciseMap = {for (var e in allExercises) e.name: e.id};

            final templateId = await into(workoutTemplates).insert(WorkoutTemplatesCompanion.insert(
              name: samplePPLProgram.name,
              description: Value(samplePPLProgram.description),
            ));

            for (int i = 0; i < samplePPLProgram.days.length; i++) {
              final day = samplePPLProgram.days[i];
              final dayId = await into(templateDays).insert(TemplateDaysCompanion.insert(
                templateId: templateId,
                name: day.name,
                order: i,
              ));

              for (int j = 0; j < day.exerciseNames.length; j++) {
                final exName = day.exerciseNames[j];
                final exId = exerciseMap[exName];
                if (exId != null) {
                  await into(templateExercises).insert(TemplateExercisesCompanion.insert(
                    dayId: dayId,
                    exerciseId: exId,
                    order: j,
                    setsJson: '[]', // Start with empty sets
                  ));
                }
              }
            }
          }
        },
      );
}

@riverpod
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
