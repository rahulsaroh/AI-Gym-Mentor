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

  Future<int> createExercise(ExercisesCompanion companion) async {
    return _db.transaction(() async {
      final id = await _db.into(_db.exercises).insert(companion);
      // For simplicity, we queue all new exercises to the spreadsheet if they are created by the user
      await _db.into(_db.syncQueue).insert(SyncQueueCompanion.insert(
            type: 'exercise',
            createdAt: DateTime.now(),
          ));
      return id;
    });
  }

  Future<bool> updateExercise(ExercisesCompanion companion) {
    return _db.update(_db.exercises).replace(companion);
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
