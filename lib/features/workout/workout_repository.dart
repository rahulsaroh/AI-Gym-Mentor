import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:ai_gym_mentor/core/domain/entities/logged_set.dart' as ent;
import 'package:ai_gym_mentor/core/domain/entities/workout_session.dart' as ent;
import 'package:ai_gym_mentor/core/domain/entities/workout_program.dart' as ent;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/core/database/initial_data.dart';

part 'workout_repository.g.dart';

class WorkoutRepository {
  final AppDatabase _db;

  WorkoutRepository(this._db);

  // Conversion Helpers
  ent.LoggedSet _toSetEntity(WorkoutSet row) {
    return ent.LoggedSet(
      id: row.id,
      workoutId: row.workoutId,
      exerciseId: row.exerciseId,
      exerciseOrder: row.exerciseOrder,
      setNumber: row.setNumber,
      weight: row.weight,
      reps: row.reps,
      rpe: row.rpe,
      rir: row.rir,
      setType: ent.SetType.values[row.setType.index],
      notes: row.notes,
      completed: row.completed,
      completedAt: row.completedAt,
      isPr: row.isPr,
      supersetGroupId: row.supersetGroupId,
    );
  }

  ent.WorkoutSession _toSessionEntity(Workout row, List<ent.LoggedExercise> exercises) {
    return ent.WorkoutSession(
      id: row.id,
      name: row.name,
      date: row.date,
      startTime: row.startTime,
      endTime: row.endTime,
      duration: row.duration,
      templateId: row.templateId,
      dayId: row.dayId,
      notes: row.notes,
      status: row.status,
      exercises: exercises,
    );
  }

  ent.WorkoutProgram _toProgramEntity(WorkoutTemplate row, List<ent.ProgramDay> days) {
    return ent.WorkoutProgram(
      id: row.id,
      name: row.name,
      description: row.description,
      lastUsed: row.lastUsed,
      days: days,
    );
  }

  ent.ProgramDay _toDayEntity(TemplateDay row, List<ent.ProgramExercise> exercises) {
    return ent.ProgramDay(
      id: row.id,
      templateId: row.templateId,
      name: row.name,
      order: row.order,
      exercises: exercises,
    );
  }

  Future<List<Map<String, dynamic>>> getHistoryWithVolume(
      {int limit = 20, int offset = 0}) async {
    final workouts = await (_db.select(_db.workouts)
          ..where((t) => t.status.equals('completed'))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)
          ])
          ..limit(limit, offset: offset))
        .get();

    final List<Map<String, dynamic>> result = [];
    for (final w in workouts) {
      final setsQuery = _db.select(_db.workoutSets)
        ..where((t) => t.workoutId.equals(w.id));

      final sets = await setsQuery.get();
      double volume = 0;
      int completedSets = 0;
      for (final s in sets) {
        if (s.completed) {
          volume += s.weight * s.reps;
          completedSets++;
        }
      }
      result.add({
        'workout': _toSessionEntity(w, []), // Changed key from 'session' to 'workout' for consistency with HistoryItem
        'volume': volume,
        'setCount': completedSets
      });
    }
    return result;
  }

  Future<Map<String, dynamic>> getStats() async {
    final completedWorkouts = await (_db.select(_db.workouts)
          ..where((t) => t.status.equals('completed'))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)
          ]))
        .get();

    if (completedWorkouts.isEmpty) {
      return {
        'currentStreak': 0,
        'longestStreak': 0,
        'totalWorkouts': 0,
        'totalVolume': 0.0,
      };
    }

    // Streak calculation
    int currentStreak = 0;
    int longestStreak = 0;
    int tempStreak = 0;

    final workoutDates = completedWorkouts
        .map((w) => DateTime(w.date.year, w.date.month, w.date.day))
        .toSet()
        .toList();
    workoutDates.sort();

    if (workoutDates.isNotEmpty) {
      tempStreak = 1;
      longestStreak = 1;
      for (int i = 1; i < workoutDates.length; i++) {
        if (workoutDates[i].difference(workoutDates[i - 1]).inDays == 1) {
          tempStreak++;
        } else {
          if (tempStreak > longestStreak) longestStreak = tempStreak;
          tempStreak = 1;
        }
      }
      if (tempStreak > longestStreak) longestStreak = tempStreak;

      // Current streak check
      final today = DateTime.now();
      final lastWorkoutDay = workoutDates.last;
      final diff = DateTime(today.year, today.month, today.day)
          .difference(lastWorkoutDay)
          .inDays;

      if (diff <= 1) {
        currentStreak = 1;
        for (int i = workoutDates.length - 1; i > 0; i--) {
          if (workoutDates[i].difference(workoutDates[i - 1]).inDays == 1) {
            currentStreak++;
          } else {
            break;
          }
        }
      } else {
        currentStreak = 0;
      }
    }

    // Total Volume using selectOnly
    final volumeQuery = _db.selectOnly(_db.workoutSets)
      ..addColumns([_db.workoutSets.weight, _db.workoutSets.reps])
      ..where(_db.workoutSets.completed.equals(true));

    final sets = await volumeQuery.get();
    double totalVolume = 0;
    for (final row in sets) {
      final w = row.read(_db.workoutSets.weight) ?? 0;
      final r = row.read(_db.workoutSets.reps) ?? 0;
      totalVolume += w * r;
    }

    return {
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'totalWorkouts': completedWorkouts.length,
      'totalVolume': totalVolume,
    };
  }

  Future<List<ent.LoggedSet>> getWorkoutSets(int workoutId) async {
    final rows = await (_db.select(_db.workoutSets)
          ..where((t) => t.workoutId.equals(workoutId)))
        .get();
    return rows.map(_toSetEntity).toList();
  }

  Future<void> updateWorkout(WorkoutsCompanion companion) async {
    await (_db.update(_db.workouts)
          ..where((t) => t.id.equals(companion.id.value)))
        .write(companion);
  }

  Future<void> deleteWorkout(int workoutId) async {
    await _db.transaction(() async {
      await (_db.delete(_db.workoutSets)
            ..where((t) => t.workoutId.equals(workoutId)))
          .go();
      await (_db.delete(_db.workouts)..where((t) => t.id.equals(workoutId)))
          .go();
    });
  }

  Future<Map<String, ent.LoggedSet>> getWorkoutSummary(int workoutId) async {
    final query = _db.select(_db.workoutSets).join([
      innerJoin(_db.exercises,
          _db.exercises.id.equalsExp(_db.workoutSets.exerciseId)),
    ])
      ..where(_db.workoutSets.workoutId.equals(workoutId) &
          _db.workoutSets.completed.equals(true))
      ..orderBy([
        OrderingTerm(
            expression: _db.workoutSets.exerciseOrder, mode: OrderingMode.asc),
        OrderingTerm(
            expression: _db.workoutSets.setNumber, mode: OrderingMode.asc)
      ]);

    final rows = await query.get();
    final Map<String, ent.LoggedSet> summary = {};

    for (final row in rows) {
      final exerciseName = row.readTable(_db.exercises).name;
      final setData = row.readTable(_db.workoutSets);
      final setEntity = _toSetEntity(setData);

      if (!summary.containsKey(exerciseName)) {
        summary[exerciseName] = setEntity;
      } else {
        final existing = summary[exerciseName]!;
        if ((setEntity.weight * setEntity.reps) > (existing.weight * existing.reps)) {
          summary[exerciseName] = setEntity;
        }
      }
    }
    return summary;
  }

  Future<int> repeatWorkout(int sourceWorkoutId) async {
    final sourceWorkout = await (_db.select(_db.workouts)
          ..where((t) => t.id.equals(sourceWorkoutId)))
        .getSingle();
    final sourceSets = await (_db.select(_db.workoutSets)
          ..where((t) => t.workoutId.equals(sourceWorkoutId)))
        .get();

    return await _db.transaction(() async {
      final newWorkoutId =
          await _db.into(_db.workouts).insert(WorkoutsCompanion.insert(
                name: '${sourceWorkout.name} (Repeat)',
                date: DateTime.now(),
                startTime: Value(DateTime.now()),
                status: const Value('draft'),
                templateId: Value(sourceWorkout.templateId),
                dayId: Value(sourceWorkout.dayId),
              ));

      for (var s in sourceSets) {
        await _db.into(_db.workoutSets).insert(WorkoutSetsCompanion.insert(
              workoutId: newWorkoutId,
              exerciseId: s.exerciseId,
              exerciseOrder: s.exerciseOrder,
              setNumber: s.setNumber,
              reps: s.reps,
              weight: s.weight,
              setType: Value(s.setType),
              rpe: Value(s.rpe),
              notes: Value(s.notes),
              supersetGroupId: Value(s.supersetGroupId),
            ));
      }
      return newWorkoutId;
    });
  }

  Future<List<ent.LoggedSet>> getSetsForHeatmap() async {
    final rows = await (_db.select(_db.workoutSets)
          ..where((t) => t.completed.equals(true)))
        .get();
    return rows.map(_toSetEntity).toList();
  }

  Future<ent.WorkoutSession?> getLastWorkout() async {
    final row = await (_db.select(_db.workouts)
          ..where((t) => t.status.equals('completed'))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingleOrNull();

    if (row == null) return null;
    return _toSessionEntity(row, []); // Groups fetched separately if needed
  }

  Future<ent.WorkoutSession?> getActiveWorkoutDraft() async {
    final row = await (_db.select(_db.workouts)
          ..where((t) => t.status.equals('draft'))
          ..orderBy(
              [(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
    
    if (row == null) return null;

    // Fetch sets for this workout to populate the session
    final sets = await (_db.select(_db.workoutSets)
          ..where((t) => t.workoutId.equals(row.id))
          ..orderBy([
            (t) => OrderingTerm(expression: t.exerciseOrder, mode: OrderingMode.asc),
            (t) => OrderingTerm(expression: t.setNumber, mode: OrderingMode.asc),
          ]))
        .get();

    // Group sets by exercise for the domain entity
    final exercisesMap = <int, ent.LoggedExercise>{};
    for (final s in sets) {
      final setEntity = _toSetEntity(s);
      if (!exercisesMap.containsKey(s.exerciseId)) {
        // We'd ideally fetch the exercise name here too, but for simplicity:
        exercisesMap[s.exerciseId] = ent.LoggedExercise(
          exerciseId: s.exerciseId,
          exerciseName: 'Exercise ${s.exerciseId}', // Placeholder
          order: s.exerciseOrder,
          sets: [setEntity],
        );
      } else {
        final ex = exercisesMap[s.exerciseId]!;
        exercisesMap[s.exerciseId] = ex.copyWith(sets: [...ex.sets, setEntity]);
      }
    }

    return _toSessionEntity(row, exercisesMap.values.toList());
  }

  Future<Map<int, double>> getDailyVolumeRange(
      DateTime start, DateTime end) async {
    final query = _db.select(_db.workoutSets).join([
      innerJoin(
          _db.workouts, _db.workouts.id.equalsExp(_db.workoutSets.workoutId)),
    ])
      ..where(_db.workouts.date.isBiggerOrEqualValue(start) &
          _db.workouts.date.isSmallerOrEqualValue(end) &
          _db.workouts.status.equals('completed'));

    final rows = await query.get();
    final Map<int, double> dailyVolume = {};

    for (final row in rows) {
      final date = row.readTable(_db.workouts).date;
      final weight = row.readTable(_db.workoutSets).weight;
      final reps = row.readTable(_db.workoutSets).reps;

      // key is day of year or just a formatted string
      final dayKey =
          DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
      dailyVolume[dayKey] = (dailyVolume[dayKey] ?? 0) + (weight * reps);
    }

    return dailyVolume;
  }

  Future<ent.WorkoutProgram?> getActiveTemplate() async {
    final prefs = await SharedPreferences.getInstance();
    final activeId = prefs.getInt('active_template_id');

    WorkoutTemplate? template;
    if (activeId != null) {
      template = await (_db.select(_db.workoutTemplates)
            ..where((t) => t.id.equals(activeId)))
          .getSingleOrNull();
    }

    if (template == null) {
      template = await (_db.select(_db.workoutTemplates)..limit(1)).getSingleOrNull();
    }

    if (template == null) return null;

    final days = await getTemplateDays(template.id);
    return _toProgramEntity(template, days);
  }

  Future<void> setActiveTemplate(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('active_template_id', id);
  }

  Future<List<ent.ProgramDay>> getTemplateDays(int templateId) async {
    final rows = await (_db.select(_db.templateDays)
          ..where((t) => t.templateId.equals(templateId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.order, mode: OrderingMode.asc)
          ]))
        .get();

    final List<ent.ProgramDay> days = [];
    for (final r in rows) {
      final exercises = await getTemplateExercises(r.id);
      days.add(_toDayEntity(r, exercises));
    }
    return days;
  }

  Future<List<ent.ProgramExercise>> getTemplateExercises(int dayId) async {
    final query = _db.select(_db.templateExercises).join([
      innerJoin(_db.exercises,
          _db.exercises.id.equalsExp(_db.templateExercises.exerciseId)),
    ])
      ..where(_db.templateExercises.dayId.equals(dayId))
      ..orderBy([
        OrderingTerm(
            expression: _db.templateExercises.order, mode: OrderingMode.asc)
      ]);

    final rows = await query.get();
    return rows.map((row) {
      final te = row.readTable(_db.templateExercises);
      final ex = row.readTable(_db.exercises);
      
      // Map back to Exercise Library Repository instance or use toEntity
      final exerciseEntity = ExerciseEntity(
        id: ex.id,
        exerciseId: ex.exerciseId ?? '',
        name: ex.name,
        overview: ex.description,
        category: ex.category,
        difficulty: ex.difficulty,
        primaryMuscles: [ex.primaryMuscle],
        secondaryMuscles: ex.secondaryMuscle != null ? [ex.secondaryMuscle!] : [],
        equipment: ex.equipment,
        setType: ex.setType,
        restTime: ex.restTime,
        instructions: ex.instructions?.split('|') ?? [],
        gifUrl: ex.gifUrl,
        imageUrls: ex.imageUrl != null ? [ex.imageUrl!] : [],
        videoUrl: ex.videoUrl,
        mechanic: ex.mechanic,
        force: ex.force,
        source: ex.source,
        isCustom: ex.isCustom,
        isFavorite: ex.isFavorite,
        isEnriched: ex.isEnriched,
        lastUsed: ex.lastUsed,
      );

      return ent.ProgramExercise(
        id: te.id,
        dayId: te.dayId,
        exercise: exerciseEntity,
        order: te.order,
        setType: te.setType.name,
        setsJson: te.setsJson,
        restTime: te.restTime,
        notes: te.notes,
        supersetGroupId: te.supersetGroupId,
      );
    }).toList();
  }

  Future<ent.WorkoutSession?> getLastWorkoutOfTemplate(int templateId) async {
    final row = await (_db.select(_db.workouts)
          ..where((t) =>
              t.templateId.equals(templateId) & t.status.equals('completed'))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingleOrNull();

    if (row == null) return null;
    return _toSessionEntity(row, []);
  }

  Future<int> createWorkout(
      {String name = 'New Workout', int? templateId, int? dayId}) async {
    return await _db.into(_db.workouts).insert(WorkoutsCompanion.insert(
          name: name,
          date: DateTime.now(),
          startTime: Value(DateTime.now()),
          status: const Value('draft'),
          templateId: Value(templateId),
          dayId: Value(dayId),
        ));
  }

  Future<List<ent.WorkoutProgram>> getAllTemplates() async {
    final rows = await _db.select(_db.workoutTemplates).get();
    final List<ent.WorkoutProgram> result = [];
    for (final r in rows) {
      final days = await getTemplateDays(r.id);
      result.add(_toProgramEntity(r, days));
    }
    return result;
  }

  Future<List<ExerciseTable>> getAllExercises() async {
    return await _db.select(_db.exercises).get();
  }

  Future<void> deleteTemplate(int id) async {
    await _db.transaction(() async {
      final days = await (_db.select(_db.templateDays)
            ..where((t) => t.templateId.equals(id)))
          .get();
      for (final day in days) {
        await (_db.delete(_db.templateExercises)
              ..where((t) => t.dayId.equals(day.id)))
            .go();
      }
      await (_db.delete(_db.templateDays)
            ..where((t) => t.templateId.equals(id)))
          .go();
      await (_db.delete(_db.workoutTemplates)..where((t) => t.id.equals(id)))
          .go();
    });
  }

  Future<String> exportTemplateToJson(int id) async {
    final template = await (_db.select(_db.workoutTemplates)
          ..where((t) => t.id.equals(id)))
        .getSingle();
    final days = await getTemplateDays(id);
    final List<Map<String, dynamic>> daysJson = [];

    for (final day in days) {
      daysJson.add({
        'name': day.name,
        'order': day.order,
        'exercises': day.exercises
            .map((e) => {
                  'exerciseName': e.exercise.name,
                  'order': e.order,
                  'setType': e.setType,
                  'setsJson': e.setsJson,
                  'restTime': e.restTime,
                  'notes': e.notes,
                })
            .toList(),
      });
    }

    return jsonEncode({
      'name': template.name,
      'description': template.description,
      'days': daysJson,
    });
  }

  Future<void> importTemplateFromJson(String jsonStr) async {
    try {
      final data = jsonDecode(jsonStr);
      final name = data['name'] as String;
      final description = data['description'] as String?;
      final goal = data['goal'] as String?;
      final duration = data['duration'] as String?;
      final days = data['days'] as List;

      await _db.transaction(() async {
        final templateId = await _db
            .into(_db.workoutTemplates)
            .insert(WorkoutTemplatesCompanion.insert(
              name: name,
              description: Value(description),
              goal: Value(goal),
              duration: Value(duration),
            ));

        for (final dayData in days) {
          final dayId = await _db
              .into(_db.templateDays)
              .insert(TemplateDaysCompanion.insert(
                templateId: templateId,
                name: dayData['name'],
                order: dayData['order'],
              ));

          final exercisesList = dayData['exercises'] as List;
          for (final exData in exercisesList) {
            final exerciseName = exData['exerciseName'] as String;

            // Find or create exercise
            final existingExs = await (_db.select(_db.exercises)
                  ..where((t) => t.name.equals(exerciseName)))
              .get();
            var ex = existingExs.isNotEmpty ? existingExs.first : null;

            if (ex == null) {
              final newId = await _db
                  .into(_db.exercises)
                  .insert(ExercisesCompanion.insert(
                    name: exerciseName,
                    primaryMuscle: 'Full Body',
                    equipment: 'None',
                    setType: 'Straight',
                    source: const Value('imported'),
                  ));
              ex = await (_db.select(_db.exercises)
                    ..where((t) => t.id.equals(newId)))
                .getSingle();
            }

            // Handle SetType mapping (e.g., 'normal' -> 'straight')
            SetType resolvedType;
            try {
              String typeStr = exData['setType'] as String? ?? 'straight';
              if (typeStr == 'normal') typeStr = 'straight';
              resolvedType = SetType.values.byName(typeStr);
            } catch (_) {
              resolvedType = SetType.straight;
            }

            await _db
                .into(_db.templateExercises)
                .insert(TemplateExercisesCompanion.insert(
                  dayId: dayId,
                  exerciseId: ex.id,
                  order: exData['order'] as int? ?? 0,
                  setType: Value(resolvedType),
                  setsJson: exData['setsJson'] is String
                      ? exData['setsJson']
                      : jsonEncode(exData['setsJson']),
                  restTime: Value(exData['restTime'] as int? ?? 90),
                  notes: Value(exData['notes'] as String?),
                ));
          }
        }
      });
      print('Import successful: $name');
    } catch (e, stack) {
      print('Import failed: $e');
      print(stack);
    }
  }

  Future<void> clearAllTemplatesAndInsertSample() async {
    await _db.transaction(() async {
      // 1. Delete all existing templates
      final allTemplates = await (_db.select(_db.workoutTemplates)).get();
      for (final t in allTemplates) {
        await deleteTemplate(t.id);
      }

      // 2. Insert all professional samples from initial_data.dart
      for (final program in allSamplePrograms) {
        await importTemplateFromJson(jsonEncode(program.toJson()));
      }
    });
  }

  String getSampleJson() {
    return jsonEncode({
      'name': 'V-Shape Transformation',
      'description': 'Focused upper-body width and core tightening plan to improve shoulder-to-waist ratio with professional hypertrophy techniques.',
      'goal': 'Aesthetics', // New field for UI tags
      'duration': '12 weeks', // New field for UI tags
      'tags': ['Aesthetics', 'Muscle Gain', 'Fat Loss'],
      'days': [
        {
          'name': 'Push (Chest/Shoulders/Triceps)',
          'order': 0,
          'exercises': [
            {
              'exerciseName': 'Bench Press (Dumbbell)',
              'order': 0,
              'setType': 'straight',
              'setsJson': '[{"reps":10, "weight": 20.0}, {"reps":10, "weight": 20.0}, {"reps":10, "weight": 20.0}]',
              'restTime': 90,
              'notes': 'Focus on the stretch at the bottom'
            },
            {
              'exerciseName': 'Lateral Raise (Dumbbell)',
              'order': 1,
              'setType': 'straight',
              'setsJson': '[{"reps":15, "weight": 8.0}, {"reps":15, "weight": 8.0}, {"reps":15, "weight": 8.0}]',
              'restTime': 60,
              'notes': 'Lead with elbows'
            }
          ]
        },
        {
          'name': 'Pull (Back/Biceps)',
          'order': 1,
          'exercises': [
            {
              'exerciseName': 'Lat Pulldown',
              'order': 0,
              'setType': 'straight',
              'setsJson': '[{"reps":12, "weight": 45.0}, {"reps":12, "weight": 45.0}, {"reps":12, "weight": 45.0}]',
              'restTime': 90,
              'notes': 'Squeeze lats at the bottom'
            }
          ]
        },
        {
          'name': 'Legs/Core',
          'order': 2,
          'exercises': [
            {
              'exerciseName': 'Squat (Crossover)',
              'order': 0,
              'setType': 'straight',
              'setsJson': '[{"reps":12, "weight": 40.0}, {"reps":12, "weight": 40.0}, {"reps":12, "weight": 40.0}]',
              'restTime': 120,
              'notes': 'Controlled descent'
            }
          ]
        }
      ],
    });
  }
}

@riverpod
WorkoutRepository workoutRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return WorkoutRepository(db);
}
