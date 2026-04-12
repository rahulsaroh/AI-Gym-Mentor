import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/domain/entities/exercise.dart' as entity;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_library_repository.g.dart';

class ExerciseLibraryRepository {
  final AppDatabase _db;

  ExerciseLibraryRepository(this._db);

  // Conversion helper
  entity.Exercise _toEntity(ExerciseTable row) {
    return entity.Exercise(
      id: row.id,
      name: row.name,
      description: row.description,
      category: row.category,
      difficulty: row.difficulty,
      primaryMuscle: row.primaryMuscle,
      secondaryMuscle: row.secondaryMuscle,
      equipment: row.equipment,
      setType: row.setType,
      restTime: row.restTime,
      instructions: row.instructions?.split('|'),
      gifUrl: row.gifUrl,
      imageUrl: row.imageUrl,
      videoUrl: row.videoUrl,
      mechanic: row.mechanic,
      force: row.force,
      source: row.source,
      isCustom: row.isCustom,
      lastUsed: row.lastUsed,
    );
  }

  Future<List<entity.Exercise>> getAllExercises({int limit = 50, int offset = 0}) async {
    final rows = await (_db.select(_db.exercises)
          ..limit(limit, offset: offset)
          ..orderBy([(t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc)]))
        .get();
    return rows.map(_toEntity).toList();
  }

  Future<List<entity.Exercise>> searchExercises(String query, {int limit = 50}) async {
    final rows = await (_db.select(_db.exercises)
          ..where((t) =>
              t.name.like('%$query%') |
              t.primaryMuscle.like('%$query%') |
              t.equipment.like('%$query%'))
          ..limit(limit)
          ..orderBy([(t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc)]))
        .get();
    return rows.map(_toEntity).toList();
  }

  Future<List<entity.Exercise>> filterExercises({
    String? category,
    String? equipment,
    String? difficulty,
    int limit = 50,
    int offset = 0,
  }) async {
    final query = _db.select(_db.exercises);
    if (category != null && category.isNotEmpty) {
      query.where((t) => t.category.equals(category));
    }
    if (equipment != null && equipment.isNotEmpty) {
      query.where((t) => t.equipment.equals(equipment));
    }
    if (difficulty != null && difficulty.isNotEmpty) {
      query.where((t) => t.difficulty.equals(difficulty));
    }

    final rows = await (query
          ..limit(limit, offset: offset)
          ..orderBy([(t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc)]))
        .get();
    return rows.map(_toEntity).toList();
  }

  Future<entity.Exercise?> getExerciseById(int id) async {
    final row = await (_db.select(_db.exercises)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row != null ? _toEntity(row) : null;
  }

  Future<void> seedDatabase() async {
    // Database seeding is handled during initialization in database.dart
    // This is a stub to maintain compatibility with existing provider logic
  }
}

@riverpod
ExerciseLibraryRepository exerciseLibraryRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ExerciseLibraryRepository(db);
}
