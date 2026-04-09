import 'package:drift/drift.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/core/domain/entities/body_measurement.dart' as ent;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'measurements_repository.g.dart';

class MeasurementsRepository {
  final AppDatabase db;
  MeasurementsRepository(this.db);

  ent.BodyMeasurement _toEntity(BodyMeasurement row) {
    return ent.BodyMeasurement(
      id: row.id,
      date: row.date,
      weight: row.weight,
      bodyFat: row.bodyFat,
      neck: row.neck,
      chest: row.chest,
      shoulders: row.shoulders,
      armLeft: row.armLeft,
      armRight: row.armRight,
      forearmLeft: row.forearmLeft,
      forearmRight: row.forearmRight,
      waist: row.waist,
      hips: row.hips,
      thighLeft: row.thighLeft,
      thighRight: row.thighRight,
      calfLeft: row.calfLeft,
      calfRight: row.calfRight,
      notes: row.notes,
    );
  }

  Future<List<ent.BodyMeasurement>> getAllMeasurements() async {
    final rows = await (db.select(db.bodyMeasurements)
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]))
        .get();
    return rows.map(_toEntity).toList();
  }

  Future<int> addWeight(double weight, DateTime date) async {
    return await db.transaction(() async {
      final id = await db.into(db.bodyMeasurements).insert(BodyMeasurementsCompanion.insert(
            weight: Value(weight),
            date: date,
          ));
      await db.into(db.syncQueue).insert(SyncQueueCompanion.insert(
            measurementId: Value(id),
            type: 'measurement',
            createdAt: DateTime.now(),
          ));
      return id;
    });
  }

  Future<int> addMeasurement(ent.BodyMeasurement measurement) async {
    return await db.transaction(() async {
      final id = await db.into(db.bodyMeasurements).insert(BodyMeasurementsCompanion.insert(
            date: measurement.date,
            weight: Value(measurement.weight),
            bodyFat: Value(measurement.bodyFat),
            neck: Value(measurement.neck),
            chest: Value(measurement.chest),
            shoulders: Value(measurement.shoulders),
            armLeft: Value(measurement.armLeft),
            armRight: Value(measurement.armRight),
            forearmLeft: Value(measurement.forearmLeft),
            forearmRight: Value(measurement.forearmRight),
            waist: Value(measurement.waist),
            hips: Value(measurement.hips),
            thighLeft: Value(measurement.thighLeft),
            thighRight: Value(measurement.thighRight),
            calfLeft: Value(measurement.calfLeft),
            calfRight: Value(measurement.calfRight),
            notes: Value(measurement.notes),
          ));
      await db.into(db.syncQueue).insert(SyncQueueCompanion.insert(
            measurementId: Value(id),
            type: 'measurement',
            createdAt: DateTime.now(),
          ));
      return id;
    });
  }

  Future<void> updateMeasurement(ent.BodyMeasurement measurement) async {
    await db.update(db.bodyMeasurements).replace(BodyMeasurement(
      id: measurement.id,
      date: measurement.date,
      weight: measurement.weight,
      bodyFat: measurement.bodyFat,
      neck: measurement.neck,
      chest: measurement.chest,
      shoulders: measurement.shoulders,
      armLeft: measurement.armLeft,
      armRight: measurement.armRight,
      forearmLeft: measurement.forearmLeft,
      forearmRight: measurement.forearmRight,
      waist: measurement.waist,
      hips: measurement.hips,
      thighLeft: measurement.thighLeft,
      thighRight: measurement.thighRight,
      calfLeft: measurement.calfLeft,
      calfRight: measurement.calfRight,
      notes: measurement.notes,
    ));
  }

  Future<void> deleteMeasurement(int id) async {
    await (db.delete(db.bodyMeasurements)..where((t) => t.id.equals(id))).go();
  }

  Future<List<ent.BodyMeasurement>> getTrendData(String metric) async {
    // Return last 20 entries for a specific metric to avoid chart clutter
    final rows = await (db.select(db.bodyMeasurements)
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)])
          ..limit(20))
        .get();
    return rows.map(_toEntity).toList();
  }
}

@riverpod
MeasurementsRepository measurementsRepository(MeasurementsRepositoryRef ref) {
  return MeasurementsRepository(ref.watch(appDatabaseProvider));
}
