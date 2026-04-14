import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';

abstract class ExerciseRepository {
  // List queries — return lightweight ExerciseEntity
  Future<List<ExerciseEntity>> getExercises({
    int page = 0,
    int pageSize = 20,
    String? muscleGroup,
    String? bodyPart,
    String? category,
    String? equipment,
    String? difficulty,
    bool favoritesOnly = false,
  });

  // Full-text search using FTS5
  Future<List<ExerciseEntity>> searchExercises(String query, {int limit = 30});

  // Full detail — loads all related tables
  Future<ExerciseEntity?> getExerciseById(int id);

  // Related exercises sharing at least one primary muscle
  Future<List<ExerciseEntity>> getRelatedExercises(int exerciseId, {int limit = 8});

  // Progression chain for an exercise
  Future<List<ExerciseEntity>> getProgressionChain(int exerciseId);

  // Recently viewed
  Future<List<ExerciseEntity>> getRecentlyViewed();
  Future<void> markRecentlyViewed(int exerciseId);

  // Favorites
  Future<void> toggleFavorite(int exerciseId, bool isFavorite);

  // Filter option lists
  Future<List<String>> getAvailableBodyParts();
  Future<List<String>> getAvailableEquipment();
  Future<List<String>> getAvailableCategories();
  Future<Map<String, int>> getExerciseCountByBodyPart();

  // GIF supplement
  Future<String?> fetchGifUrl(String exerciseName);

  // Enrichment
  Future<void> saveEnrichedContent(int exerciseId, {
    List<String>? safetyTips,
    List<String>? commonMistakes,
    List<String>? variations,
    String? enrichedOverview,
    String? nameHi,
    String? nameMr,
    String enrichmentSource = 'llm',
  });
  
  // History and Stats
  Future<Map<String, dynamic>> getExerciseStats(int exerciseId);
  Future<List<Map<String, dynamic>>> getExerciseHistory(int exerciseId);
  Future<List<Map<String, dynamic>>> getChartData(int exerciseId, Duration range);

  // Helper for internal use
  Future<List<ExerciseEntity>> getAllExercises();
}
