import 'dart:convert';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:drift/drift.dart';

class ExerciseLocalDatasource {
  final AppDatabase _db;

  ExerciseLocalDatasource(this._db);

  Future<List<ExerciseTable>> getExercises({
    int page = 0,
    int pageSize = 20,
    String? bodyPart,
    String? category,
    String? equipment,
    String? level,
    String? searchQuery,
    bool favoritesOnly = false,
    bool sortByUsage = false,
  }) async {
    final query = _db.select(_db.exercises);

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query.where((t) => t.name.contains(searchQuery));
    }

    if (category != null) {
      query.where((t) => t.category.lower().equals(category.toLowerCase()));
    }
    if (equipment != null) {
      query.where((t) => t.equipment.lower().equals(equipment.toLowerCase()));
    }
    if (level != null) {
      query.where((t) => t.difficulty.lower().equals(level.toLowerCase()));
    }
    if (favoritesOnly) {
      query.where((t) => t.isFavorite.equals(true));
    }
    if (bodyPart != null) {
      final exerciseIds = await (_db.select(_db.exerciseBodyParts)
        ..where((t) => t.bodyPart.lower().equals(bodyPart.toLowerCase())))
        .get();
      final ids = exerciseIds.map((e) => e.exerciseId).toList();
      if (ids.isNotEmpty) {
        query.where((t) => t.id.isIn(ids));
      } else {
        return [];
      }
    }

    query.limit(pageSize, offset: page * pageSize);
    if (sortByUsage) {
      query.orderBy([(t) => OrderingTerm(expression: t.usageCount, mode: OrderingMode.desc)]);
    } else {
      query.orderBy([(t) => OrderingTerm(expression: t.name)]);
    }

    return await query.get();
  }

  Future<List<ExerciseTable>> searchExercises(String query, {int limit = 30}) async {
    return await _db.searchExercises(query);
  }

  Future<ExerciseTable?> getExerciseById(int id) async {
    return await (_db.select(_db.exercises)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<ExerciseMuscle>> getExerciseMuscles(int exerciseId) async {
    return await (_db.select(_db.exerciseMuscles)
      ..where((t) => t.exerciseId.equals(exerciseId)))
      .get();
  }

  Future<List<ExerciseBodyPart>> getExerciseBodyParts(int exerciseId) async {
    return await (_db.select(_db.exerciseBodyParts)
      ..where((t) => t.exerciseId.equals(exerciseId)))
      .get();
  }

  Future<ExerciseEnrichedContentData?> getEnrichedContent(int exerciseId) async {
    return await (_db.select(_db.exerciseEnrichedContent)
          ..where((t) => t.exerciseId.equals(exerciseId)))
        .get()
        .then((rows) => rows.isNotEmpty ? rows.first : null);
  }

  Future<List<ExerciseTable>> getRelatedExercises(int exerciseId, {int limit = 8}) async {
    final muscles = await (_db.select(_db.exerciseMuscles)
      ..where((t) => t.exerciseId.equals(exerciseId) & t.isPrimary.equals(true)))
      .get();
    
    if (muscles.isEmpty) return [];

    final muscleNames = muscles.map((m) => m.muscleName).toList();
    
    final exerciseIds = await (_db.select(_db.exerciseMuscles)
      ..where((t) => t.muscleName.isIn(muscleNames) & t.isPrimary.equals(true)))
      .get();
    
    final relatedIds = exerciseIds.map((e) => e.exerciseId).where((id) => id != exerciseId).toSet().take(limit).toList();
    
    if (relatedIds.isEmpty) return [];

    return await (_db.select(_db.exercises)
      ..where((t) => t.id.isIn(relatedIds)))
      .get();
  }

  Future<List<ExerciseTable>> getProgressionChain(int exerciseId) async {
    final progressions = await (_db.select(_db.exerciseProgressions)
      ..where((t) => t.exerciseId.equals(exerciseId))
      ..orderBy([(t) => OrderingTerm(expression: t.position)]))
      .get();

    final allIds = [exerciseId, ...progressions.map((p) => p.progressionExerciseId)];
    
    return await (_db.select(_db.exercises)
      ..where((t) => t.id.isIn(allIds)))
      .get();
  }

  Future<List<ExerciseTable>> getRecentlyViewed() async {
    final recent = await (_db.select(_db.recentExercises)
      ..orderBy([(t) => OrderingTerm(expression: t.viewedAt, mode: OrderingMode.desc)])
      ..limit(10))
      .get();

    if (recent.isEmpty) return [];

    final ids = recent.map((r) => r.exerciseId).toList();
    return await (_db.select(_db.exercises)
      ..where((t) => t.id.isIn(ids)))
      .get();
  }

  Future<void> markRecentlyViewed(int exerciseId) async {
    await _db.into(_db.recentExercises).insertOnConflictUpdate(
      RecentExercisesCompanion.insert(
        exerciseId: Value(exerciseId),
        viewedAt: DateTime.now(),
      ),
    );

    // Keep max 10
    await _db.customStatement('''
      DELETE FROM recent_exercises 
      WHERE exercise_id NOT IN (
        SELECT exercise_id FROM recent_exercises 
        ORDER BY viewed_at DESC LIMIT 10
      )
    ''');
  }

  Future<void> toggleFavorite(int exerciseId, bool isFavorite) async {
    await updateExercise(exerciseId, ExercisesCompanion(isFavorite: Value(isFavorite)));
  }

  Future<void> incrementUsageCount(int exerciseId) async {
    final row = await getExerciseById(exerciseId);
    if (row != null) {
      await updateExercise(exerciseId, ExercisesCompanion(usageCount: Value(row.usageCount + 1)));
    }
  }

  Future<void> updateExercise(int id, ExercisesCompanion companion) async {
    await (_db.update(_db.exercises)..where((t) => t.id.equals(id)))
        .write(companion);
  }

  Future<List<String>> getAvailableBodyParts() async {
    final bodyParts = await _db.select(_db.exerciseBodyParts).get();
    return bodyParts.map((b) => b.bodyPart).toSet().toList()..sort();
  }

  Future<List<String>> getAvailableEquipment() async {
    final exercises = await _db.select(_db.exercises).get();
    return exercises.map((e) => e.equipment).toSet().toList()..sort();
  }

  Future<List<String>> getAvailableCategories() async {
    final exercises = await _db.select(_db.exercises).get();
    return exercises.map((e) => e.category).toSet().toList()..sort();
  }

  Future<Map<String, int>> getExerciseCountByBodyPart() async {
    final bodyParts = await _db.select(_db.exerciseBodyParts).get();
    final counts = <String, int>{};
    for (final bp in bodyParts) {
      counts[bp.bodyPart] = (counts[bp.bodyPart] ?? 0) + 1;
    }
    return counts;
  }

  Future<void> saveEnrichedContent(int exerciseId, {
    List<String>? safetyTips,
    List<String>? commonMistakes,
    List<String>? variations,
    String? enrichedOverview,
    String enrichmentSource = 'llm',
  }) async {
    await _db.into(_db.exerciseEnrichedContent).insertOnConflictUpdate(
      ExerciseEnrichedContentCompanion(
        exerciseId: Value(exerciseId),
        safetyTips: Value(safetyTips != null ? jsonEncode(safetyTips) : null),
        commonMistakes: Value(commonMistakes != null ? jsonEncode(commonMistakes) : null),
        variations: Value(variations != null ? jsonEncode(variations) : null),
        enrichedOverview: Value(enrichedOverview),
        enrichedAt: Value(DateTime.now()),
        enrichmentSource: Value(enrichmentSource),
      ),
    );

    await (_db.update(_db.exercises)..where((t) => t.id.equals(exerciseId)))
        .write(const ExercisesCompanion(isEnriched: Value(true)));
  }

  Future<List<ExerciseTable>> getAllExercises() async {
    return await _db.select(_db.exercises).get();
  }

  Future<Map<String, dynamic>> getExerciseStats(int exerciseId) async {
    final sets = await (_db.select(_db.workoutSets)
          ..where((t) =>
              t.exerciseId.equals(exerciseId) & t.completed.equals(true)))
        .get();

    if (sets.isEmpty) return {};

    double maxWeight = 0;
    double maxReps = 0;
    double best1RM = 0;
    int totalSets = sets.length;

    for (var s in sets) {
      if (s.weight > maxWeight) maxWeight = s.weight;
      if (s.reps > maxReps) maxReps = s.reps;
      final rm = s.weight * (1 + s.reps / 30);
      if (rm > best1RM) best1RM = rm;
    }

    return {
      'maxWeight': maxWeight,
      'maxReps': maxReps,
      'best1RM': best1RM,
      'totalSets': totalSets,
    };
  }

  Future<List<Map<String, dynamic>>> getExerciseHistory(int exerciseId) async {
    final query = _db.select(_db.workoutSets).join([
      innerJoin(
          _db.workouts, _db.workouts.id.equalsExp(_db.workoutSets.workoutId)),
    ])
      ..where(_db.workoutSets.exerciseId.equals(exerciseId) &
          _db.workoutSets.completed.equals(true))
      ..orderBy([
        OrderingTerm(expression: _db.workouts.date, mode: OrderingMode.desc)
      ]);

    final rows = await query.get();

    final Map<int, Map<String, dynamic>> sessions = {};
    for (final row in rows) {
      final workout = row.readTable(_db.workouts);
      final set = row.readTable(_db.workoutSets);

      sessions.putIfAbsent(
          workout.id,
          () => {
                'date': workout.date,
                'workoutName': workout.name,
                'sets': <WorkoutSet>[],
              });
      (sessions[workout.id]!['sets'] as List<WorkoutSet>).add(set);
    }

    return sessions.values.toList();
  }

  Future<List<Map<String, dynamic>>> getChartData(
      int exerciseId, Duration range) async {
    final cutoffDate = DateTime.now().subtract(range);

    final query = _db.select(_db.workoutSets).join([
      innerJoin(
          _db.workouts, _db.workouts.id.equalsExp(_db.workoutSets.workoutId)),
    ])
      ..where(_db.workoutSets.exerciseId.equals(exerciseId) &
          _db.workoutSets.completed.equals(true) &
          _db.workouts.date.isBiggerThanValue(cutoffDate))
      ..orderBy([
        OrderingTerm(expression: _db.workouts.date, mode: OrderingMode.asc)
      ]);

    final rows = await query.get();

    final Map<DateTime, double> daily1RM = {};
    final Map<DateTime, double> dailyVolume = {};

    for (final row in rows) {
      final date = row.readTable(_db.workouts).date;
      final day = DateTime(date.year, date.month, date.day);
      final set = row.readTable(_db.workoutSets);

      final rm = set.weight * (1 + set.reps / 30);
      daily1RM[day] = (daily1RM[day] ?? 0) > rm ? daily1RM[day]! : rm;

      dailyVolume[day] = (dailyVolume[day] ?? 0) + (set.weight * set.reps);
    }

    final result = <Map<String, dynamic>>[];
    final sortedDates = daily1RM.keys.toList()..sort();
    for (var d in sortedDates) {
      result.add({
        'date': d,
        'rm': daily1RM[d],
        'volume': dailyVolume[d],
      });
    }

    return result;
  }

  Future<void> clearAllExercises() async {
    await _db.transaction(() async {
      await _db.delete(_db.exerciseEnrichedContent).go();
      await _db.delete(_db.exerciseMuscles).go();
      await _db.delete(_db.exerciseBodyParts).go();
      await _db.delete(_db.exerciseInstructions).go();
      await _db.delete(_db.exerciseProgressions).go();
      await _db.delete(_db.recentExercises).go();
      await _db.delete(_db.exercises).go();
    });
  }
}
