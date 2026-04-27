import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:ai_gym_mentor/core/domain/entities/logged_set.dart' as ent;
import 'package:ai_gym_mentor/core/domain/entities/workout_session.dart' as ent;
import 'package:ai_gym_mentor/core/domain/entities/workout_program.dart' as ent;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/core/database/initial_data.dart';
import 'package:ai_gym_mentor/services/github_exercise_service.dart';
import 'package:ai_gym_mentor/core/services/workout_logic_service.dart';

part 'workout_repository.g.dart';

final _githubService = GithubExerciseService();

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
      weekday: row.weekday,
      exercises: exercises,
    );
  }

  Future<List<Map<String, dynamic>>> getHistoryWithVolume({
    int limit = 20,
    int offset = 0,
    String? searchQuery,
    List<String>? muscleGroups,
    int? templateId,
  }) async {
    final query = _db.select(_db.workouts);

    query.where((t) => t.status.equals('completed'));

    if (templateId != null) {
      query.where((t) => t.templateId.equals(templateId));
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query.where((t) => t.name.contains(searchQuery));
    }

    if (muscleGroups != null && muscleGroups.isNotEmpty) {
      // Filter workouts that have at least one exercise targeting these muscles
      final workoutIdsWithMuscles = _db.selectOnly(_db.workoutSets).join([
        innerJoin(_db.exercises, _db.exercises.id.equalsExp(_db.workoutSets.exerciseId)),
      ]);
      workoutIdsWithMuscles.addColumns([_db.workoutSets.workoutId]);
      
      Expression<bool> muscleFilter = _db.exercises.primaryMuscle.isIn(muscleGroups) |
          _db.exercises.secondaryMuscle.isIn(muscleGroups);
      workoutIdsWithMuscles.where(muscleFilter);
      
      final ids = await workoutIdsWithMuscles.map((row) => row.read(_db.workoutSets.workoutId)).get();
      query.where((t) => t.id.isIn(ids.whereType<int>().toList()));
    }

    query.orderBy([
      (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)
    ]);
    query.limit(limit, offset: offset);

    final workouts = await query.get();

    final List<Map<String, dynamic>> result = [];
    for (final w in workouts) {
      // Fix: Fetch sets and join with exercises to provide a full LoggedExercise list
      final setsQuery = _db.select(_db.workoutSets).join([
        innerJoin(_db.exercises, _db.exercises.id.equalsExp(_db.workoutSets.exerciseId)),
      ])..where(_db.workoutSets.workoutId.equals(w.id));

      final setsRows = await setsQuery.get();
      final exercisesMap = <int, ent.LoggedExercise>{};
      double volume = 0;
      int completedSets = 0;

      for (final row in setsRows) {
        final s = row.readTable(_db.workoutSets);
        final ex = row.readTable(_db.exercises);
        final setEntity = _toSetEntity(s);
        
        if (s.completed) {
          volume += s.weight * s.reps;
          completedSets++;
        }

        if (!exercisesMap.containsKey(s.exerciseId)) {
          exercisesMap[s.exerciseId] = ent.LoggedExercise(
            exerciseId: s.exerciseId,
            exerciseName: ex.name,
            order: s.exerciseOrder,
            sets: [setEntity],
          );
        } else {
          final existingEx = exercisesMap[s.exerciseId]!;
          exercisesMap[s.exerciseId] = existingEx.copyWith(sets: [...existingEx.sets, setEntity]);
        }
      }

      result.add({
        'workout': _toSessionEntity(w, exercisesMap.values.toList()..sort((a,b) => a.order.compareTo(b.order))),
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

    final workoutDates = completedWorkouts.map((w) => w.date).toList();
    final streaks = WorkoutLogicService.calculateStreaks(workoutDates);

    // Total Volume using selectOnly
    // Fix #18: Exclude 'Timed' exercise sets from volume calculation
    final volumeQuery = _db.selectOnly(_db.workoutSets).join([
      innerJoin(_db.exercises, _db.exercises.id.equalsExp(_db.workoutSets.exerciseId)),
    ])
      ..addColumns([_db.workoutSets.weight, _db.workoutSets.reps])
      ..where(_db.workoutSets.completed.equals(true) & 
              _db.exercises.setType.equals('Timed').not());

    final rows = await volumeQuery.get();
    double totalVolume = 0;
    for (final row in rows) {
      final w = row.read(_db.workoutSets.weight) ?? 0;
      final r = row.read(_db.workoutSets.reps) ?? 0;
      totalVolume += w * r;
    }

    double avgDuration = 0;
    double avgExercises = 0;
    if (completedWorkouts.isNotEmpty) {
      final totalDuration = completedWorkouts.fold(0, (a, b) => a + (b.duration ?? 0));
      avgDuration = totalDuration / completedWorkouts.length / 60; // minutes
      
      // Approximate exercises per workout from history
      // We could query workoutSets grouped by workoutId but stats already has completedWorkouts
      // To keep it simple and efficient, we query total sets and divide by workouts, assuming ~4 sets per ex.
      final countExp = _db.workoutSets.id.count();
      final totalSetsQuery = _db.selectOnly(_db.workoutSets)
        ..addColumns([countExp])
        ..where(_db.workoutSets.completed.equals(true));
      final totalSets = (await totalSetsQuery.map((r) => r.read<int>(countExp)).getSingle()) ?? 0;
      avgExercises = (totalSets.toDouble() / completedWorkouts.length) / 4; 
      if (avgExercises < 1) avgExercises = 5; // Fallback
    }

    return {
      'currentStreak': streaks['currentStreak'],
      'longestStreak': streaks['longestStreak'],
      'totalWorkouts': completedWorkouts.length,
      'totalVolume': totalVolume,
      'avgDuration': avgDuration > 0 ? avgDuration : 45,
      'avgExercises': avgExercises > 0 ? avgExercises : 5,
    };
  }

  Future<Workout?> getWorkout(int id) async {
    return await (_db.select(_db.workouts)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
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
      await (_db.delete(_db.syncQueue)
            ..where((t) => t.workoutId.equals(workoutId)))
          .go();
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

  Future<int> saveWorkoutAsTemplate(int workoutId, String templateName) async {
    final workout = await (_db.select(_db.workouts)..where((t) => t.id.equals(workoutId))).getSingle();
    final sets = await (_db.select(_db.workoutSets)..where((t) => t.workoutId.equals(workoutId))).get();
    
    return await _db.transaction(() async {
      // 1. Create Template
      final templateId = await _db.into(_db.workoutTemplates).insert(
        WorkoutTemplatesCompanion.insert(
          name: templateName,
          description: Value('Created from workout on ${DateFormat.yMMMd().format(workout.date)}'),
        )
      );

      // 2. Create Day
      final dayId = await _db.into(_db.templateDays).insert(
        TemplateDaysCompanion.insert(
          templateId: templateId,
          name: 'Day 1',
          order: 0,
        )
      );

      // 3. Create Template Exercises
      // Fix #11: Group by exerciseOrder instead of exerciseId to preserve same-exercise-multi-occurrence
      final exerciseGroups = <int, List<WorkoutSet>>{};
      for (var s in sets) {
        exerciseGroups.putIfAbsent(s.exerciseOrder, () => []).add(s);
      }

      final sortedOrders = exerciseGroups.keys.toList()..sort();

      for (var i = 0; i < sortedOrders.length; i++) {
        final order = sortedOrders[i];
        final exSets = exerciseGroups[order]!;
        final firstSet = exSets.first;
        final exId = firstSet.exerciseId;
        
        final setsJson = jsonEncode(exSets.map((s) => {
          'reps': s.reps,
          'weight': s.weight,
        }).toList());

        await _db.into(_db.templateExercises).insert(
          TemplateExercisesCompanion.insert(
            dayId: dayId,
            exerciseId: exId,
            order: i,
            setType: Value(firstSet.setType),
            setsJson: setsJson,
            restTime: const Value(90),
            notes: Value(firstSet.notes),
          )
        );
      }
      return templateId;
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

    // Fetch sets and exercise info for this workout to populate the session
    final query = _db.select(_db.workoutSets).join([
      innerJoin(_db.exercises, _db.exercises.id.equalsExp(_db.workoutSets.exerciseId)),
    ])
      ..where(_db.workoutSets.workoutId.equals(row.id))
      ..orderBy([
        OrderingTerm(expression: _db.workoutSets.exerciseOrder, mode: OrderingMode.asc),
        OrderingTerm(expression: _db.workoutSets.setNumber, mode: OrderingMode.asc),
      ]);

    final rows = await query.get();

    // Group sets by exercise for the domain entity
    final exercisesMap = <int, ent.LoggedExercise>{};
    for (final row_data in rows) {
      final s = row_data.readTable(_db.workoutSets);
      final ex = row_data.readTable(_db.exercises);
      final setEntity = _toSetEntity(s);
      
      if (!exercisesMap.containsKey(s.exerciseId)) {
        exercisesMap[s.exerciseId] = ent.LoggedExercise(
          exerciseId: s.exerciseId,
          exerciseName: ex.name,
          order: s.exerciseOrder,
          sets: [setEntity],
        );
      } else {
        final existingEx = exercisesMap[s.exerciseId]!;
        exercisesMap[s.exerciseId] = existingEx.copyWith(sets: [...existingEx.sets, setEntity]);
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

    template ??= await (_db.select(_db.workoutTemplates)..limit(1)).getSingleOrNull();

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

    debugPrint('WorkoutRepository.getTemplateDays: found ${rows.length} days for template $templateId');
    for (final r in rows) {
      debugPrint('WorkoutRepository.getTemplateDays: day id=${r.id}, name=${r.name}');
    }

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
    debugPrint('WorkoutRepository.getTemplateExercises: found ${rows.length} exercises for day $dayId');
    return rows.map((row) {
      final te = row.readTable(_db.templateExercises);
      final ex = row.readTable(_db.exercises);
      
      debugPrint('WorkoutRepository.getTemplateExercises: exercise id=${ex.id}, name=${ex.name}, exerciseId=${ex.exerciseId}');
      
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
    debugPrint('WorkoutRepository.createWorkout: name=$name, templateId=$templateId, dayId=$dayId');
    final id = await _db.into(_db.workouts).insert(WorkoutsCompanion.insert(
          name: name,
          date: DateTime.now(),
          startTime: Value(DateTime.now()),
          status: const Value('draft'),
          templateId: Value(templateId),
          dayId: Value(dayId),
        ));
    debugPrint('WorkoutRepository.createWorkout: inserted workout with id=$id');
    return id;
  }

  /// Deletes draft workouts that are abandoned or stale.
  /// Empty drafts are removed after 2 hours.
  /// Drafts with progress are removed after 24 hours.
  Future<void> cleanupStaleDrafts() async {
    try {
      final now = DateTime.now();
      final emptyStaleThreshold = now.subtract(const Duration(hours: 2));
      final activeStaleThreshold = now.subtract(const Duration(hours: 24));
      
      // Find all drafts older than at least the empty threshold
      final candidateDrafts = await (_db.select(_db.workouts)
            ..where((t) => t.status.equals('draft') & t.date.isSmallerThanValue(emptyStaleThreshold)))
          .get();

      if (candidateDrafts.isEmpty) return;

      int cleanupCount = 0;
      for (var draft in candidateDrafts) {
        final isOlderThan24h = draft.date.isBefore(activeStaleThreshold);
        
        // Check if it has any completed sets
        final completedSetsCount = await (_db.selectOnly(_db.workoutSets)
              ..addColumns([_db.workoutSets.id])
              ..where(_db.workoutSets.workoutId.equals(draft.id) & _db.workoutSets.completed.equals(true))
              ..limit(1))
            .get();
        
        // Cleanup if:
        // 1. It's truly stale (> 24 hours) regardless of progress
        // 2. It has no progress and is older than 2 hours
        if (isOlderThan24h || completedSetsCount.isEmpty) {
          debugPrint('WorkoutRepository: Cleaning up stale draft workout ${draft.id} ("${draft.name}")');
          await deleteWorkout(draft.id);
          cleanupCount++;
        }
      }
      if (cleanupCount > 0) {
        debugPrint('WorkoutRepository: Performance cleanup completed, removed $cleanupCount stale drafts.');
      }
    } catch (e) {
      debugPrint('WorkoutRepository: Error during stale draft cleanup: $e');
    }
  }

  /// Finds an existing draft for the same template/day created within the last 4 hours.
  Future<int?> findExistingRecentDraft({int? templateId, int? dayId}) async {
    final recentTime = DateTime.now().subtract(const Duration(hours: 4));
    
    final query = _db.select(_db.workouts);
    
    Expression<bool> whereClause = _db.workouts.status.equals('draft') & 
                                  _db.workouts.date.isBiggerThanValue(recentTime);
    
    if (templateId != null) {
      whereClause = whereClause & _db.workouts.templateId.equals(templateId);
    }
    if (dayId != null) {
      whereClause = whereClause & _db.workouts.dayId.equals(dayId);
    }
    
    query.where((t) => whereClause);
    query.orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]);
    query.limit(1);
    
    final draft = await query.getSingleOrNull();
    return draft?.id;
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
      // 1. Get all day IDs for this template
      final dayIds = await (_db.select(_db.templateDays)
            ..where((t) => t.templateId.equals(id)))
          .map((d) => d.id)
          .get();

      // 2. Nullify workout references to this template and its days
      // to avoid FOREIGN KEY constraint failure
      await (_db.update(_db.workouts)..where((t) => t.templateId.equals(id)))
          .write(const WorkoutsCompanion(templateId: Value(null), dayId: Value(null)));

      // 3. Delete template exercises
      for (final dayId in dayIds) {
        await (_db.delete(_db.templateExercises)
              ..where((t) => t.dayId.equals(dayId)))
            .go();
      }

      // 4. Delete template days
      await (_db.delete(_db.templateDays)
            ..where((t) => t.templateId.equals(id)))
          .go();

      // 5. Delete the template itself
      await (_db.delete(_db.workoutTemplates)..where((t) => t.id.equals(id)))
          .go();
    });
  }

  Future<void> updateDayWeekday(int dayId, int? weekday) async {
    await (_db.update(_db.templateDays)..where((t) => t.id.equals(dayId)))
        .write(TemplateDaysCompanion(weekday: Value(weekday)));
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

  Future<ExerciseTable?> _findExerciseMatch(String name, {String? githubId}) async {
    // 1. Exact match (ignore case and whitespace)
    final normalized = name.trim().toLowerCase();

    final exactMatches = await (_db.select(_db.exercises)
          ..where((t) => t.name.lower().equals(normalized)))
        .get();

    if (exactMatches.isNotEmpty) return exactMatches.first;

    // 2. Try to match by GitHub ID if provided
    if (githubId != null && githubId.isNotEmpty) {
      final githubMatches = await (_db.select(_db.exercises)
            ..where((t) => t.exerciseId.equals(githubId)))
          .get();
      if (githubMatches.isNotEmpty) return githubMatches.first;
    }

    // 3. FTS match fallback
    try {
      final ftsMatches = await _db.searchExercises(name);
      if (ftsMatches.isNotEmpty) {
        // Take the first FTS result as it's ranked by relevance
        return ftsMatches.first;
      }
    } catch (e) {
      print('FTS search failed for "$name": $e');
    }

    // 4. Try GitHub exercise matching as last resort
    try {
      final githubExercises = await _githubService.getAllExercises();
      final lowerName = name.toLowerCase();
      
      // Try exact match on GitHub
      var matched = githubExercises.where((g) => 
        g.name.toLowerCase() == lowerName ||
        g.name.toLowerCase().replaceAll(' ', '') == lowerName.replaceAll(' ', '')
      ).toList();
      
      if (matched.isEmpty) {
        // Try partial match
        matched = githubExercises.where((g) => 
          g.name.toLowerCase().contains(lowerName) || 
          lowerName.contains(g.name.toLowerCase())
        ).toList();
      }
      
      if (matched.isNotEmpty) {
        final ghEx = matched.first;
        // Check if we already have this exercise in local DB
        final existingByGithubId = await (_db.select(_db.exercises)
              ..where((t) => t.exerciseId.equals(ghEx.id)))
            .getSingleOrNull();
        
        if (existingByGithubId != null) return existingByGithubId;
        
        // Create new exercise from GitHub data
        final newId = await _db.into(_db.exercises).insert(
          ExercisesCompanion.insert(
            name: ghEx.name,
            exerciseId: Value(ghEx.id),
            primaryMuscle: ghEx.target,
            secondaryMuscle: Value(ghEx.secondaryMuscles.isNotEmpty ? ghEx.secondaryMuscles.first : null),
            equipment: ghEx.equipment,
            setType: 'Straight',
            description: Value(ghEx.instructions.isNotEmpty ? ghEx.instructions.first : null),
            instructions: Value(ghEx.instructions.isNotEmpty ? ghEx.instructions.join('|') : null),
            gifUrl: Value(ghEx.gifUrl),
            source: const Value('github'),
          ),
        );
        
        return await (_db.select(_db.exercises)
              ..where((t) => t.id.equals(newId)))
            .getSingle();
      }
    } catch (e) {
      debugPrint('GitHub exercise matching failed for "$name": $e');
    }

    return null;
  }

  Future<void> importTemplateFromJson(String jsonStr) async {
    try {
      final data = jsonDecode(jsonStr);

      // Handle both formats: Full Program (Map) or Exercise List (List)
      if (data is List) {
        await _importExercisesAsPlan(data);
        return;
      }

      final name = data['name'] as String? ?? 'Imported Plan';
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
                weekday: Value(dayData['weekday'] as int?),
              ));

          final exercisesList = dayData['exercises'] as List;
          for (final exData in exercisesList) {
            final exerciseName = exData['exerciseName'] as String;
            final githubId = exData['githubId'] as String?;

            // Find or create exercise with robust matching
            var ex = await _findExerciseMatch(exerciseName, githubId: githubId);

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
      debugPrint('Import successful: $name');
    } catch (e, stack) {
      debugPrint('Import failed: $e');
      debugPrint(stack.toString());
      rethrow;
    }
  }

  Future<void> _importExercisesAsPlan(List exercises) async {
    final now = DateTime.now();
    final name = 'Imported List - ${DateFormat.yMd().format(now)}';

    await _db.transaction(() async {
      final templateId = await _db.into(_db.workoutTemplates).insert(
            WorkoutTemplatesCompanion.insert(
              name: name,
              description: Value('Imported from exercise list on ${DateFormat.yMMMd().format(now)}'),
            ),
          );

      final dayId = await _db.into(_db.templateDays).insert(
            TemplateDaysCompanion.insert(
              templateId: templateId,
              name: 'Exercises',
              order: 0,
            ),
          );

      for (int i = 0; i < exercises.length; i++) {
        final item = exercises[i];
        String exerciseName;
        String? setsJson;

        if (item is String) {
          exerciseName = item;
        } else if (item is Map) {
          exerciseName = item['name'] ?? item['exerciseName'] ?? 'Unknown Exercise';
          if (item['setsJson'] != null) {
            setsJson = item['setsJson'] is String ? item['setsJson'] : jsonEncode(item['setsJson']);
          }
        } else {
          continue;
        }

        var ex = await _findExerciseMatch(exerciseName, githubId: item is Map ? item['githubId'] as String? : null);

        if (ex == null) {
          final newId = await _db.into(_db.exercises).insert(
                ExercisesCompanion.insert(
                  name: exerciseName,
                  primaryMuscle: 'Full Body',
                  equipment: 'None',
                  setType: 'Straight',
                  source: const Value('imported'),
                ),
              );
          ex = await (_db.select(_db.exercises)..where((t) => t.id.equals(newId))).getSingle();
        }

        await _db.into(_db.templateExercises).insert(
              TemplateExercisesCompanion.insert(
                dayId: dayId,
                exerciseId: ex.id,
                order: i,
                setType: const Value(SetType.straight),
                setsJson: setsJson ?? '[{"reps":10, "weight": 0.0}, {"reps":10, "weight": 0.0}, {"reps":10, "weight": 0.0}]',
                restTime: const Value(90),
              ),
            );
      }
    });
    debugPrint('Import successful: $name');
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
  Future<ExerciseTable?> findExerciseMatch(String name, {String? githubId}) async {
    return _findExerciseMatch(name, githubId: githubId);
  }

  Future<void> addExercisesWithSets(int workoutId, List<Map<String, dynamic>> suggestions) async {
    await _db.transaction(() async {
      for (var i = 0; i < suggestions.length; i++) {
        final suggestion = suggestions[i];
        final ex = await findExerciseMatch(suggestion['exercise_name'] as String);
        if (ex == null) continue;

        final setsCount = suggestion['sets'] is int ? suggestion['sets'] as int : 3;
        final repsStr = suggestion['reps'] as String? ?? '10';
        final reps = int.tryParse(repsStr.replaceAll(RegExp(r'[^0-9]'), '')) ?? 10;

        for (var s = 1; s <= setsCount; s++) {
          await _db.into(_db.workoutSets).insert(WorkoutSetsCompanion.insert(
            workoutId: workoutId,
            exerciseId: ex.id,
            exerciseOrder: i,
            setNumber: s,
            reps: reps.toDouble(),
            weight: 0.0,
            setType: const Value(SetType.straight),
          ));
        }
      }
    });
  }
}

@riverpod
WorkoutRepository workoutRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return WorkoutRepository(db);
}
