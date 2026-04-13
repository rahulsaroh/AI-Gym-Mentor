import 'dart:io';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:ai_gym_mentor/core/database/initial_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

enum SetType {
  straight,
  warmup,
  superset,
  dropSet,
  amrap,
  timed,
  restPause,
  cluster
}

@DataClassName('ExerciseTable')
class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseId => text().nullable()(); // String ID from source (e.g., yuhonas_3_4_Sit-Up)
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get description => text().nullable()();
  TextColumn get category => text().withDefault(const Constant('Strength'))();
  TextColumn get difficulty => text().withDefault(const Constant('Beginner'))();
  TextColumn get primaryMuscle => text()();
  TextColumn get secondaryMuscle => text().nullable()();
  TextColumn get equipment => text()();
  TextColumn get setType => text()(); // e.g. Straight, Weighted, Bodyweight
  IntColumn get restTime => integer().withDefault(const Constant(90))();
  TextColumn get instructions => text().nullable()(); // Pipe-separated or JSON
  TextColumn get gifUrl => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get videoUrl => text().nullable()();
  TextColumn get mechanic => text().nullable()(); // Compound or Isolation
  TextColumn get force => text().nullable()(); // Push, Pull, Static
  TextColumn get source => text().withDefault(const Constant('local'))();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isEnriched => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUsed => dateTime().nullable()();
}

class WorkoutTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  TextColumn get goal => text().nullable()(); // e.g. Aesthetics, Strength
  TextColumn get duration => text().nullable()(); // e.g. 12 weeks
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
  TextColumn get setsJson =>
      text()(); // JSON representation of TemplateSet list
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
  IntColumn get templateId =>
      integer().nullable().references(WorkoutTemplates, #id)();
  IntColumn get dayId => integer().nullable().references(TemplateDays, #id)();
  TextColumn get notes => text().nullable()();
  TextColumn get status =>
      text().withDefault(const Constant('draft'))(); // draft, completed
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

@DataClassName('BodyMeasurementTable')
class BodyMeasurements extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  RealColumn get weight => real().nullable()();
  RealColumn get bodyFat => real().nullable()();
  RealColumn get neck => real().nullable()();
  RealColumn get chest => real().nullable()();
  RealColumn get shoulders => real().nullable()();
  RealColumn get armLeft => real().nullable()();
  RealColumn get armRight => real().nullable()();
  RealColumn get forearmLeft => real().nullable()();
  RealColumn get forearmRight => real().nullable()();
  RealColumn get waist => real().nullable()();
  RealColumn get hips => real().nullable()();
  RealColumn get thighLeft => real().nullable()();
  RealColumn get thighRight => real().nullable()();
  RealColumn get calfLeft => real().nullable()();
  RealColumn get calfRight => real().nullable()();
  TextColumn get notes => text().nullable()();
}


class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workoutId => integer().nullable().references(Workouts, #id)();
  IntColumn get measurementId =>
      integer().nullable().references(BodyMeasurements, #id)();
  TextColumn get type => text()(); // workout, measurement
  TextColumn get status =>
      text().withDefault(const Constant('pending'))(); // pending, done, failed
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get error => text().nullable()();
}

class ExerciseProgressionSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  RealColumn get incrementOverride =>
      real().nullable()(); // Exercise-specific increment
  IntColumn get targetReps => integer().withDefault(const Constant(10))();
  IntColumn get targetSets => integer().withDefault(const Constant(3))();
  BoolColumn get autoSuggest => boolean().withDefault(const Constant(true))();
}

// Phase 3: New tables for exercise database feature
class ExerciseMuscles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  TextColumn get muscleName => text()();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(true))();
}

class ExerciseBodyParts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  TextColumn get bodyPart => text()();
}

class ExerciseEnrichedContent extends Table {
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  TextColumn get safetyTips => text().nullable()(); // JSON-encoded List<String>
  TextColumn get commonMistakes => text().nullable()(); // JSON-encoded List<String>
  TextColumn get variations => text().nullable()(); // JSON-encoded List<String>
  TextColumn get enrichedOverview => text().nullable()();
  DateTimeColumn get enrichedAt => dateTime().nullable()();
  TextColumn get enrichmentSource => text().nullable()(); // 'manual', 'llm-gemini', 'llm-gpt4', 'auto-extracted'
}

class RecentExercises extends Table {
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  DateTimeColumn get viewedAt => dateTime()();
}

class ExerciseProgressions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  IntColumn get progressionExerciseId => integer().references(Exercises, #id)();
  IntColumn get position => integer()(); // 0 = current, negative = easier, positive = harder
}

class ExerciseInstructions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  IntColumn get stepNumber => integer()();
  TextColumn get instructionText => text()();
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
  ExerciseMuscles,
  ExerciseBodyParts,
  ExerciseEnrichedContent,
  RecentExercises,
  ExerciseProgressions,
  ExerciseInstructions,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  Future<List<ExerciseTable>> searchExercises(String query) async {
    final results = await customSelect(
      'SELECT rowid FROM exercises_fts WHERE exercises_fts MATCH ?',
      variables: [Variable.withString(query)],
    ).get();
    
    final ids = results.map((row) => row.read<int>('rowid')).toList();
    if (ids.isEmpty) return [];
    
    return (select(exercises)..where((t) => t.id.isIn(ids))).get();
  }

  @override
  int get schemaVersion => 15;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          // Helper to check if a column exists to avoid duplicate column errors
          Future<bool> hasColumn(String table, String column) async {
            final result =
                await customSelect('PRAGMA table_info("$table")').get();
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
              await m.addColumn(
                  templateExercises, templateExercises.supersetGroupId);
            }
          }
          if (from < 5) {
            await m.createTable(exerciseProgressionSettings);
          }
          if (from < 6) {
            try {
              await m.createIndex(Index('idx_sets_exercise_id',
                  'CREATE INDEX idx_sets_exercise_id ON workout_sets(exercise_id)'));
              await m.createIndex(Index('idx_workouts_date',
                  'CREATE INDEX idx_workouts_date ON workouts(date)'));
              await m.createIndex(Index('idx_exercises_muscle',
                  'CREATE INDEX idx_exercises_muscle ON exercises(primary_muscle)'));
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
          if (from < 10) {
            // Bulk update for Unified Exercise Library
            if (!await hasColumn('exercises', 'description')) {
              await customStatement('ALTER TABLE exercises ADD COLUMN description TEXT');
            }
            if (!await hasColumn('exercises', 'category')) {
              await customStatement("ALTER TABLE exercises ADD COLUMN category TEXT DEFAULT 'Strength'");
            }
            if (!await hasColumn('exercises', 'difficulty')) {
              await customStatement("ALTER TABLE exercises ADD COLUMN difficulty TEXT DEFAULT 'Beginner'");
            }
            if (!await hasColumn('exercises', 'gif_url')) {
              await customStatement('ALTER TABLE exercises ADD COLUMN gif_url TEXT');
            }
            if (!await hasColumn('exercises', 'image_url')) {
              await customStatement('ALTER TABLE exercises ADD COLUMN image_url TEXT');
            }
            if (!await hasColumn('exercises', 'video_url')) {
              await customStatement('ALTER TABLE exercises ADD COLUMN video_url TEXT');
            }
            if (!await hasColumn('exercises', 'mechanic')) {
              await customStatement('ALTER TABLE exercises ADD COLUMN mechanic TEXT');
            }
            if (!await hasColumn('exercises', 'force')) {
              await customStatement('ALTER TABLE exercises ADD COLUMN force TEXT');
            }
            if (!await hasColumn('exercises', 'source')) {
              await customStatement("ALTER TABLE exercises ADD COLUMN source TEXT DEFAULT 'local'");
            }
          }
          if (from < 12) {
            if (!await hasColumn('workout_templates', 'goal')) {
              await m.addColumn(workoutTemplates, workoutTemplates.goal);
            }
            if (!await hasColumn('workout_templates', 'duration')) {
              await m.addColumn(workoutTemplates, workoutTemplates.duration);
            }
          }
          // Phase 3: New tables for exercise database
          if (from < 13) {
            if (!await hasColumn('exercises', 'is_favorite')) {
              await m.addColumn(exercises, exercises.isFavorite);
            }
            await m.createTable(exerciseMuscles);
            await m.createTable(exerciseBodyParts);
          }
          if (from < 13) {
            await m.createTable(exerciseEnrichedContent);
            await m.createTable(recentExercises);
            await m.createTable(exerciseProgressions);
          }
          if (from < 14) {
            await m.createTable(exerciseInstructions);
            await _handleFtsSetup();
          }
          if (from < 15) {
            if (!await hasColumn('exercises', 'exercise_id')) {
              await m.addColumn(exercises, exercises.exerciseId);
            }
            if (!await hasColumn('exercises', 'is_custom')) {
              await m.addColumn(exercises, exercises.isCustom);
            }
            if (!await hasColumn('exercises', 'is_enriched')) {
              await m.addColumn(exercises, exercises.isEnriched);
            }
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');

          if (details.wasCreated || details.hadUpgrade) {
            // Use the external seeder
            // import is needed but we are inside the file. 
            // I'll add the import at the top later or use a callback.
            // For now, I'll trigger it from a provider or main.dart.
          }
        },
      );

  Future<void> _handleFtsSetup() async {
    // Create FTS5 virtual table
    await customStatement('''
      CREATE VIRTUAL TABLE IF NOT EXISTS exercises_fts USING fts5(
        id UNINDEXED,
        name,
        category,
        equipment,
        primary_muscle,
        content='exercises',
        content_rowid='rowid'
      );
    ''');
    // Trigger to keep FTS in sync
    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS exercises_ai AFTER INSERT ON exercises BEGIN
        INSERT INTO exercises_fts(rowid, id, name, category, equipment, primary_muscle)
        VALUES (new.rowid, new.id, new.name, new.category, COALESCE(new.equipment, ''), new.primary_muscle);
      END;
    ''');
  }

  // Seeding is now handled by ExerciseDbSeeder
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
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
        final corruptedPath = p.join(dbFolder.path,
            'gym_log_corrupted_${DateTime.now().millisecondsSinceEpoch}.sqlite');
        await file.rename(corruptedPath);
      }
      return NativeDatabase(file);
    }
  });
}
