import 'package:drift/drift.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_repository.g.dart';

class ExerciseRepository {
  final AppDatabase _db;

  ExerciseRepository(this._db);

  Stream<List<Exercise>> watchAllExercises() {
    return (_db.select(_db.exercises)..orderBy([(t) => OrderingTerm(expression: t.name)])).watch();
  }

  Future<List<Exercise>> getAllExercises() {
    return (_db.select(_db.exercises)..orderBy([(t) => OrderingTerm(expression: t.name)])).get();
  }

  Future<Exercise?> getExerciseById(int id) {
    return (_db.select(_db.exercises)..where((t) => t.id.equals(id))).getSingleOrNull();
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
      
      // Queue for sync if it's a custom exercise or being modified
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
ExerciseRepository exerciseRepository(ExerciseRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return ExerciseRepository(db);
}
