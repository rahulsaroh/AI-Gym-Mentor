import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart' as ent_m;
import 'package:ai_gym_mentor/core/domain/entities/body_target.dart' as ent_t;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'measurements_repository.g.dart';

class MeasurementsRepository {
  final AppDatabase db;
  MeasurementsRepository(this.db);

  ent_m.BodyMeasurement _toEntity(BodyMeasurementTable row) {
    return ent_m.BodyMeasurement(
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
      height: row.height,
      customValues: row.customValues != null ? Map<String, double>.from(json.decode(row.customValues!)) : null,
      notes: row.notes,
    );
  }

  ent_t.BodyTarget _toTargetEntity(BodyTarget row) {
    return ent_t.BodyTarget(
      id: row.id,
      metric: row.metric,
      targetValue: row.targetValue,
      deadline: row.deadline,
      createdAt: row.createdAt,
    );
  }

  Future<List<ent_m.BodyMeasurement>> getAllMeasurements() async {
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

  Future<int> addMeasurement(ent_m.BodyMeasurement measurement) async {
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
            height: Value(measurement.height),
            customValues: Value(measurement.customValues != null ? json.encode(measurement.customValues) : null),
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

  Future<void> updateMeasurement(ent_m.BodyMeasurement measurement) async {
    await db.update(db.bodyMeasurements).replace(BodyMeasurementTable(
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
      height: measurement.height,
      customValues: measurement.customValues != null ? json.encode(measurement.customValues) : null,
      notes: measurement.notes,
    ));
  }

  Future<void> deleteMeasurement(int id) async {
    await (db.delete(db.bodyMeasurements)..where((t) => t.id.equals(id))).go();
  }

  Future<List<ent_m.BodyMeasurement>> getTrendData(String metric) async {
    final rows = await (db.select(db.bodyMeasurements)
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)])
          ..limit(20))
        .get();
    return rows.map(_toEntity).toList();
  }

  Future<List<ent_t.BodyTarget>> getAllTargets() async {
    final rows = await (db.select(db.bodyTargets)
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)]))
        .get();
    return rows.map(_toTargetEntity).toList();
  }

  Future<ent_t.BodyTarget?> getTargetForMetric(String metric) async {
    final row = await (db.select(db.bodyTargets)
          ..where((t) => t.metric.equals(metric))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
    return row != null ? _toTargetEntity(row) : null;
  }

  Future<int> addTarget(ent_t.BodyTarget tb) async {
    return await db.into(db.bodyTargets).insert(BodyTargetsCompanion.insert(
          metric: tb.metric,
          targetValue: tb.targetValue,
          deadline: Value(tb.deadline),
          createdAt: DateTime.now(),
        ));
  }

  Future<void> deleteTarget(int id) async {
    await (db.delete(db.bodyTargets)..where((t) => t.id.equals(id))).go();
  }
}

@riverpod
MeasurementsRepository measurementsRepository(Ref ref) {
  return MeasurementsRepository(ref.watch(appDatabaseProvider));
}
