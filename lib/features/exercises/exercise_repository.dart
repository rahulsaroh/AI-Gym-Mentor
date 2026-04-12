import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/domain/entities/exercise.dart' as entity;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_repository.g.dart';

class ExerciseRepository {
  final AppDatabase _db;

  ExerciseRepository(this._db);

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

  Stream<List<entity.Exercise>> watchAllExercises() {
    return (_db.select(_db.exercises)
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .watch()
        .map((rows) => rows.map(_toEntity).toList());
  }

  Future<List<entity.Exercise>> getAllExercises() async {
    final rows = await (_db.select(_db.exercises)
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .get();
    return rows.map(_toEntity).toList();
  }

  Future<entity.Exercise?> getExerciseById(int id) async {
    final row = await (_db.select(_db.exercises)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row != null ? _toEntity(row) : null;
  }

  Future<int> saveExercise(ExercisesCompanion companion) async {
    return _db.transaction(() async {
      int id;
      if (companion.id.present) {
        await _db.update(_db.exercises).replace(companion);
        id = companion.id.value;
      } else {
        id = await _db.into(_db.exercises).insert(companion);
      }

      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            type: 'exercise',
            createdAt: DateTime.now(),
          ));
      return id;
    });
  }

  Future<int> deleteExercise(int id) {
    return (_db.delete(_db.exercises)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
ExerciseRepository exerciseRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ExerciseRepository(db);
}
