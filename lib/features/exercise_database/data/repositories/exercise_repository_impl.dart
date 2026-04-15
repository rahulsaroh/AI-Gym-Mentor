import 'dart:convert';
import 'package:ai_gym_mentor/services/github_exercise_service.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/exercise_database/data/datasources/exercise_local_datasource.dart';
import 'package:ai_gym_mentor/features/exercise_database/data/datasources/exercise_db_seeder.dart';
import 'package:ai_gym_mentor/features/exercise_database/data/datasources/exercise_remote_datasource.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/repositories/exercise_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseLocalDatasource _localDatasource;
  final ExerciseRemoteDatasource _remoteDatasource;

  ExerciseRepositoryImpl({
    required ExerciseLocalDatasource localDatasource,
    required ExerciseRemoteDatasource remoteDatasource,
  })  : _localDatasource = localDatasource,
        _remoteDatasource = remoteDatasource;

  ExerciseEntity _toEntity(
    ExerciseTable row, {
    List<String>? primaryMuscles,
    List<String>? secondaryMuscles,
    List<String>? bodyParts,
    List<String>? safetyTips,
    List<String>? commonMistakes,
    List<String>? variations,
  }) {
    return ExerciseEntity(
      id: row.id,
      exerciseId: row.exerciseId ?? '',
      name: row.name,
      alternateNames: [], // Add if stored in DB later
      category: row.category,
      difficulty: row.difficulty,
      force: row.force,
      mechanic: row.mechanic,
      equipment: row.equipment,
      primaryMuscles: primaryMuscles ?? [],
      secondaryMuscles: secondaryMuscles ?? [],
      targetBodyParts: bodyParts ?? [],
      instructions: row.instructions?.split('|') ?? [],
      safetyTips: safetyTips ?? [],
      commonMistakes: commonMistakes ?? [],
      overview: row.description, // Mapping description to overview
      imageUrls: row.imageUrl != null ? [row.imageUrl!] : [],
      gifUrl: row.gifUrl,
      videoUrl: row.videoUrl,
      variations: variations ?? [],
      relatedExerciseIds: [],
      progressionPath: [],
      isFavorite: row.isFavorite,
      isEnriched: row.isEnriched,
      nameHi: row.nameHi,
      nameMr: row.nameMr,
      setType: row.setType,
      restTime: row.restTime,
      source: row.source,
      isCustom: row.isCustom,
      lastUsed: row.lastUsed,
      usageCount: row.usageCount,
    );
  }

  @override
  Future<List<ExerciseEntity>> getExercises({
    int page = 0,
    int pageSize = 20,
    String? muscleGroup,
    String? bodyPart,
    String? category,
    String? equipment,
    String? difficulty,
    String? searchQuery,
    bool favoritesOnly = false,
    bool sortByUsage = false,
  }) async {
    final rows = await _localDatasource.getExercises(
      page: page,
      pageSize: pageSize,
      bodyPart: bodyPart,
      category: category,
      equipment: equipment,
      level: difficulty,
      searchQuery: searchQuery,
      favoritesOnly: favoritesOnly,
      sortByUsage: sortByUsage,
    );
    return rows.map((row) => _toEntity(row)).toList();
  }

  @override
  Future<List<ExerciseEntity>> searchExercises(String query, {int limit = 30}) async {
    final rows = await _localDatasource.searchExercises(query, limit: limit);
    return rows.map((row) => _toEntity(row)).toList();
  }

  @override
  Future<ExerciseEntity?> getExerciseById(int id) async {
    final row = await _localDatasource.getExerciseById(id);
    if (row == null) return null;

    final muscles = await _localDatasource.getExerciseMuscles(id);
    final primaryMuscles = muscles.where((m) => m.isPrimary).map((m) => m.muscleName).toList();
    final secondaryMuscles = muscles.where((m) => !m.isPrimary).map((m) => m.muscleName).toList();

    final bodyParts = await _localDatasource.getExerciseBodyParts(id);
    final bodyPartList = bodyParts.map((b) => b.bodyPart).toList();

    final enriched = await _localDatasource.getEnrichedContent(id);

    List<String>? safetyTips;
    List<String>? commonMistakes;
    List<String>? variations;
    if (enriched != null) {
      if (enriched.safetyTips != null) {
        safetyTips = List<String>.from(jsonDecode(enriched.safetyTips!));
      }
      if (enriched.commonMistakes != null) {
        commonMistakes = List<String>.from(jsonDecode(enriched.commonMistakes!));
      }
      if (enriched.variations != null) {
        variations = List<String>.from(jsonDecode(enriched.variations!));
      }
    }

    return _toEntity(
      row,
      primaryMuscles: primaryMuscles,
      secondaryMuscles: secondaryMuscles,
      bodyParts: bodyPartList,
      safetyTips: safetyTips,
      commonMistakes: commonMistakes,
      variations: variations,
    );
  }

  @override
  Future<List<ExerciseEntity>> getRelatedExercises(int exerciseId, {int limit = 8}) async {
    final rows = await _localDatasource.getRelatedExercises(exerciseId, limit: limit);
    return rows.map((row) => _toEntity(row)).toList();
  }

  @override
  Future<List<ExerciseEntity>> getProgressionChain(int exerciseId) async {
    final rows = await _localDatasource.getProgressionChain(exerciseId);
    return rows.map((row) => _toEntity(row)).toList();
  }

  @override
  Future<List<ExerciseEntity>> getRecentlyViewed() async {
    final rows = await _localDatasource.getRecentlyViewed();
    return rows.map((row) => _toEntity(row)).toList();
  }

  @override
  Future<void> markRecentlyViewed(int exerciseId) async {
    await _localDatasource.markRecentlyViewed(exerciseId);
  }

  @override
  Future<void> toggleFavorite(int exerciseId, bool isFavorite) async {
    await _localDatasource.toggleFavorite(exerciseId, isFavorite);
  }

  @override
  Future<void> incrementUsageCount(int exerciseId) async {
    await _localDatasource.incrementUsageCount(exerciseId);
  }

  @override
  Future<List<String>> getAvailableBodyParts() async {
    return await _localDatasource.getAvailableBodyParts();
  }

  @override
  Future<List<String>> getAvailableEquipment() async {
    return await _localDatasource.getAvailableEquipment();
  }

  @override
  Future<List<String>> getAvailableCategories() async {
    return await _localDatasource.getAvailableCategories();
  }

  @override
  Future<Map<String, int>> getExerciseCountByBodyPart() async {
    return await _localDatasource.getExerciseCountByBodyPart();
  }

  @override
  Future<String?> fetchGifUrl(String exerciseName) async {
    // 1. Check if we already have it in local DB
    final query = await searchExercises(exerciseName, limit: 1);
    if (query.isNotEmpty && query.first.gifUrl != null) {
      return query.first.gifUrl;
    }

    // 2. Check connectivity
    final connectivity = await Connectivity().checkConnectivity();
    final isOnline = connectivity.isNotEmpty && !connectivity.contains(ConnectivityResult.none);
    
    if (!isOnline) return null;

    // 3. Fetch from remote
    final url = await _remoteDatasource.fetchGifUrl(exerciseName);
    
    // 4. If fetched, persist it to DB for offline use
    if (url != null && query.isNotEmpty) {
      final exerciseId = query.first.id;
      // We need a way to update the exercise record. 
      // I'll add a specific update method or use the datasource's raw DB access if available.
      // Since ExerciseRepository can update, let's use the local datasource.
      await _localDatasource.updateExercise(exerciseId, ExercisesCompanion(gifUrl: Value(url)));
    }

    return url;
  }

  @override
  Future<void> saveEnrichedContent(int exerciseId, {
    List<String>? safetyTips,
    List<String>? commonMistakes,
    List<String>? variations,
    String? enrichedOverview,
    String? nameHi,
    String? nameMr,
    String enrichmentSource = 'llm',
  }) async {
    await _localDatasource.saveEnrichedContent(
      exerciseId,
      safetyTips: safetyTips,
      commonMistakes: commonMistakes,
      variations: variations,
      enrichedOverview: enrichedOverview,
      enrichmentSource: enrichmentSource,
    );

    // Update localized names in main exercises table
    await _localDatasource.updateExercise(
      exerciseId,
      ExercisesCompanion(
        nameHi: Value(nameHi),
        nameMr: Value(nameMr),
      ),
    );
  }

  @override
  Future<List<ExerciseEntity>> getAllExercises() async {
    final rows = await _localDatasource.getAllExercises();
    return rows.map((row) => _toEntity(row)).toList();
  }

  @override
  Future<Map<String, dynamic>> getExerciseStats(int exerciseId) async {
    return await _localDatasource.getExerciseStats(exerciseId);
  }

  @override
  Future<List<Map<String, dynamic>>> getExerciseHistory(int exerciseId) async {
    return await _localDatasource.getExerciseHistory(exerciseId);
  }

  @override
  Future<List<Map<String, dynamic>>> getChartData(int exerciseId, Duration range) async {
    return await _localDatasource.getChartData(exerciseId, range);
  }

  @override
  Future<void> wipeAllData() async {
    // 1. Clear database tables
    await _localDatasource.clearAllExercises();
    
    // 2. Reset seeding flags in SharedPreferences
    await ExerciseDbSeeder.instance.reset();
  }

  @override
  Future<int> createExercise(ExerciseEntity exercise) async {
    final companion = ExercisesCompanion.insert(
      name: exercise.name,
      category: Value(exercise.category),
      difficulty: Value(exercise.difficulty),
      primaryMuscle: exercise.primaryMuscles.isNotEmpty ? exercise.primaryMuscles.first : 'Other',
      equipment: exercise.equipment ?? 'None',
      setType: exercise.setType,
      restTime: Value(exercise.restTime),
      mechanic: Value(exercise.mechanic),
      force: Value(exercise.force),
      source: const Value('custom'),
      isCustom: const Value(true),
    );

    final id = await _localDatasource.insertExercise(companion);

    // Save muscles
    for (final m in exercise.primaryMuscles) {
      await _localDatasource.insertExerciseMuscle(id, m, true);
    }
    for (final m in exercise.secondaryMuscles) {
      await _localDatasource.insertExerciseMuscle(id, m, false);
    }

    // Save body parts (auto-mapped during insert usually, but let's be explicit if needed)
    // For now, let's assume the datasource/seeder logic or we can add it here.

    return id;
  }

  @override
  Future<int> ensureGithubExercise(GithubExercise githubEx) async {
    // Check if exercise already exists by name
    final existing = await _localDatasource.getExercises(searchQuery: githubEx.name);
    final match = existing
        .where((e) => e.name.toLowerCase() == githubEx.name.toLowerCase())
        .firstOrNull;

    if (match != null) {
      return match.id;
    }

    // Insert new exercise from GitHub
    final companion = ExercisesCompanion.insert(
      name: githubEx.name,
      equipment: githubEx.equipment,
      primaryMuscle: githubEx.target,
      category: const Value('Strength'),
      setType: 'Straight',
      difficulty: const Value('Beginner'),
      gifUrl: Value(githubEx.gifUrl),
      source: const Value('github'),
      instructions: Value(githubEx.instructions.join('|')),
    );

    final id = await _localDatasource.insertExercise(companion);

    // Add muscles
    if (githubEx.target.isNotEmpty) {
      await _localDatasource.insertExerciseMuscle(id, githubEx.target, true);
    }
    for (final muscle in githubEx.secondaryMuscles) {
      await _localDatasource.insertExerciseMuscle(id, muscle, false);
    }

    // Add body part
    if (githubEx.bodyPart.isNotEmpty) {
      await _localDatasource.database
          .into(_localDatasource.database.exerciseBodyParts)
          .insert(
            ExerciseBodyPartsCompanion.insert(
              exerciseId: id,
              bodyPart: githubEx.bodyPart,
            ),
          );
    }

    return id;
  }
}
