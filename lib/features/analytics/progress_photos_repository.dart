import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/domain/entities/progress_photo.dart' as ent;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress_photos_repository.g.dart';

class ProgressPhotosRepository {
  final AppDatabase db;
  ProgressPhotosRepository(this.db);

  ent.ProgressPhoto _toEntity(ProgressPhoto row) {
    return ent.ProgressPhoto(
      id: row.id,
      date: row.date,
      imagePath: row.imagePath,
      category: row.category,
      notes: row.notes,
    );
  }

  Future<List<ent.ProgressPhoto>> getAllPhotos() async {
    final rows = await (db.select(db.progressPhotos)
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]))
        .get();
    return rows.map(_toEntity).toList();
  }

  Future<List<ent.ProgressPhoto>> getPhotosByCategory(String category) async {
    final rows = await (db.select(db.progressPhotos)
          ..where((t) => t.category.equals(category))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)]))
        .get();
    return rows.map(_toEntity).toList();
  }

  Future<int> addPhoto(ent.ProgressPhoto photo) async {
    return await db.into(db.progressPhotos).insert(ProgressPhotosCompanion.insert(
          date: photo.date,
          imagePath: photo.imagePath,
          category: Value(photo.category),
          notes: Value(photo.notes),
        ));
  }

  Future<void> deletePhoto(int id) async {
    await (db.delete(db.progressPhotos)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
ProgressPhotosRepository progressPhotosRepository(Ref ref) {
  return ProgressPhotosRepository(ref.watch(appDatabaseProvider));
}
