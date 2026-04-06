import 'package:drift/drift.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'measurements_repository.g.dart';

class MeasurementsRepository {
  final AppDatabase db;
  MeasurementsRepository(this.db);

  Future<List<BodyMeasurement>> getAllMeasurements() async {
    return await (db.select(db.bodyMeasurements)
      ..orderBy([(t) => OrderingTerm.desc(t.date)]))
      .get();
  }

  Future<int> addMeasurement(BodyMeasurementsCompanion companion) async {
    return await db.transaction(() async {
      final id = await db.into(db.bodyMeasurements).insert(companion);
      await db.into(db.syncQueue).insert(SyncQueueCompanion.insert(
            measurementId: Value(id),
            type: 'measurement',
            createdAt: DateTime.now(),
          ));
      return id;
    });
  }

  Future<void> updateMeasurement(BodyMeasurement measurement) async {
    await db.update(db.bodyMeasurements).replace(measurement);
  }

  Future<void> deleteMeasurement(int id) async {
    await (db.delete(db.bodyMeasurements)..where((t) => t.id.equals(id))).go();
  }

  Future<List<BodyMeasurement>> getTrendData(String metric) async {
    // Return last 20 entries for a specific metric to avoid chart clutter
    return await (db.select(db.bodyMeasurements)
      ..orderBy([(t) => OrderingTerm.asc(t.date)])
      ..limit(20))
      .get();
  }
}

@riverpod
MeasurementsRepository measurementsRepository(MeasurementsRepositoryRef ref) {
  return MeasurementsRepository(ref.watch(appDatabaseProvider));
}
