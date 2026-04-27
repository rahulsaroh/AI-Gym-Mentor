import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart';

final importServiceProvider = Provider((ref) => ImportService(ref));

class ExcelSchema {
  final File file;
  final Map<String, List<String>> sheets; // sheetName -> headers
  ExcelSchema({required this.file, required this.sheets});
}

class WorksheetMapping {
  final String sheetName;
  final Map<String, int> fieldToColumnIndex;
  
  WorksheetMapping({required this.sheetName, required this.fieldToColumnIndex});

  int? getIndex(String field) => fieldToColumnIndex[field];
}

class ImportMappingResult {
  final WorksheetMapping? rawLogMapping;
  final WorksheetMapping? bodyMeasurementsMapping;

  ImportMappingResult({this.rawLogMapping, this.bodyMeasurementsMapping});
}

class ImportService {
  final Ref ref;
  ImportService(this.ref);

  static String? testImportPath;

  Future<ExcelSchema?> getExcelSchema() async {
    String? path;
    if (testImportPath != null) {
      path = testImportPath;
    } else {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );
      if (result == null || result.files.single.path == null) return null;
      path = result.files.single.path!;
    }
    final pathChecked = testImportPath ?? path;
    if (pathChecked == null) return null;
    final file = File(pathChecked);
    final bytes = file.readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);
    
    final Map<String, List<String>> sheets = {};
    for (final table in excel.tables.keys) {
      final sheet = excel.tables[table]!;
      if (sheet.maxRows > 0) {
        final row = sheet.row(0);
        sheets[table] = row.map((c) => c?.value?.toString() ?? '').toList();
      } else {
        sheets[table] = [];
      }
    }

    return ExcelSchema(file: file, sheets: sheets);
  }

  Future<Map<String, int>> importFromXlsx(File file, {ImportMappingResult? mapping}) async {
    final bytes = file.readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);
    final db = ref.read(appDatabaseProvider);
    final exerciseRepo = ref.read(exerciseRepositoryProvider);
    final exercises = await exerciseRepo.getAllExercises();
    final exerciseByName = {for (final e in exercises) e.name.toLowerCase(): e};

    int importedWorkouts = 0;
    int importedMeasurements = 0;

    // 1. Parse Sheet 1 — Raw Log (Import-Safe)
    final rawLogSheetName = mapping?.rawLogMapping?.sheetName ?? 'Raw Log';
    final exerciseSheet = excel.tables[rawLogSheetName];
    
    if (exerciseSheet != null && exerciseSheet.maxRows > 1) {
      final Map<String, List<Map<String, dynamic>>> workoutGroups = {};
      
      final rawMapping = mapping?.rawLogMapping?.fieldToColumnIndex;

      for (var i = 1; i < exerciseSheet.maxRows; i++) {
        final row = exerciseSheet.row(i);
        if (row.isEmpty) continue;

        try {
          // Dynamic indices based on mapping
          final dateIdx = rawMapping?['Date'] ?? 0;
          final workoutNameIdx = rawMapping?['Workout Name'] ?? 2;
          final exerciseNameIdx = rawMapping?['Exercise Name'] ?? 3;
          final exerciseIdIdx = rawMapping?['Exercise ID'] ?? 4;
          final setNumIdx = rawMapping?['Set Number'] ?? 5;
          final setTypeIdx = rawMapping?['Set Type'] ?? 6;
          final weightIdx = rawMapping?['Weight'] ?? 7;
          final repsIdx = rawMapping?['Reps'] ?? 8;
          final rpeIdx = rawMapping?['RPE'] ?? 9;
          final isPrIdx = rawMapping?['Is PR'] ?? 11;
          final notesIdx = rawMapping?['Notes'] ?? 12;

          final dateStr = row[dateIdx]?.value?.toString() ?? '';
          final date = _parseDate(dateStr);
          if (date == null) continue;
          final workoutName = row.length > workoutNameIdx ? row[workoutNameIdx]?.value?.toString() ?? 'Imported Workout' : 'Imported Workout';
          final exerciseName = row.length > exerciseNameIdx ? row[exerciseNameIdx]?.value?.toString() ?? 'Unknown' : 'Unknown';
          final exerciseId = int.tryParse(row.length > exerciseIdIdx ? row[exerciseIdIdx]?.value?.toString() ?? '' : '');
          final setNum = int.tryParse(row.length > setNumIdx ? row[setNumIdx]?.value?.toString() ?? '1' : '1') ?? 1;
          final setTypeStr = row.length > setTypeIdx ? row[setTypeIdx]?.value?.toString() ?? 'Main' : 'Main';
          final weight = double.tryParse(row.length > weightIdx ? row[weightIdx]?.value?.toString() ?? '0' : '0') ?? 0.0;
          final reps = double.tryParse(row.length > repsIdx ? row[repsIdx]?.value?.toString() ?? '0' : '0') ?? 0.0;
          final rpe = double.tryParse(row.length > rpeIdx ? row[rpeIdx]?.value?.toString() ?? '' : '');
          final isPr = row.length > isPrIdx ? row[isPrIdx]?.value?.toString().toUpperCase() == 'YES' : false;
          final notes = row.length > notesIdx ? row[notesIdx]?.value?.toString() ?? '' : '';

          final workoutKey = '${dateStr}_$workoutName';
          if (!workoutGroups.containsKey(workoutKey)) {
            workoutGroups[workoutKey] = [];
          }

          workoutGroups[workoutKey]!.add({
            'date': date,
            'workoutName': workoutName,
            'exerciseName': exerciseName,
            'exerciseId': exerciseId,
            'setNum': setNum,
            'setType': setTypeStr,
            'weight': weight,
            'reps': reps,
            'rpe': rpe,
            'isPr': isPr,
            'notes': notes,
          });
        } catch (e) {
          print('Error parsing raw log row $i: $e');
        }
      }

      // Upsert Workouts and Sets
      for (var entry in workoutGroups.entries) {
        await db.transaction(() async {
          final first = entry.value.first;
          final date = first['date'] as DateTime;
          final wName = first['workoutName'] as String;
          
          var workout = await (db.select(db.workouts)
                ..where((t) => t.date.year.equals(date.year) & t.date.month.equals(date.month) & t.date.day.equals(date.day) & t.name.equals(wName))
                ..limit(1))
              .getSingleOrNull();

          if (workout == null) {
            final id = await db.into(db.workouts).insert(WorkoutsCompanion.insert(
              name: wName,
              date: date,
              startTime: Value(date),
              status: const Value('completed'),
            ));
            workout = await (db.select(db.workouts)..where((t) => t.id.equals(id))).getSingle();
            importedWorkouts++;
          }

          // Delete existing sets for this workout to avoid duplicates on re-import
          await (db.delete(db.workoutSets)..where((t) => t.workoutId.equals(workout!.id))).go();

          int exerciseOrder = 0;
          final setsByEx = _groupBy(entry.value, (s) => s['exerciseName'] as String);
          
          for (var itemEntry in setsByEx.entries) {
            final firstSet = itemEntry.value.first;
            final exName = itemEntry.key;
            final exIdFromExcel = firstSet['exerciseId'] as int?;

            ExerciseEntity? ex;
            if (exIdFromExcel != null) {
              ex = await exerciseRepo.getExerciseById(exIdFromExcel);
            }
            
            if (ex == null) {
              ex = exerciseByName[exName.toLowerCase()];
            }
            
            if (ex == null) {
               final exId = await db.into(db.exercises).insert(ExercisesCompanion.insert(
                 name: exName,
                 category: const Value('Strength'),
                 primaryMuscle: 'Unknown',
                 equipment: 'Unknown',
                 setType: 'Straight',
                 isCustom: const Value(true),
               ));
               ex = (await exerciseRepo.getAllExercises()).firstWhere((e) => e.id == exId);
               exerciseByName[exName.toLowerCase()] = ex;
            }

            for (var setItem in itemEntry.value) {
              await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
                workoutId: workout.id,
                exerciseId: ex.id,
                exerciseOrder: exerciseOrder,
                setNumber: setItem['setNum'],
                reps: setItem['reps'],
                weight: setItem['weight'],
                rpe: Value(setItem['rpe']),
                notes: Value(setItem['notes']),
                isPr: Value(setItem['isPr']),
                completed: const Value(true),
              ));
            }
            exerciseOrder++;
          }
        });
      }
    }

    // 2. Parse Sheet 5 — Body Measurements
    final measurementSheetName = mapping?.bodyMeasurementsMapping?.sheetName ?? 'Body Measurements';
    final measurementSheet = excel.tables[measurementSheetName];
    
    if (measurementSheet != null && measurementSheet.maxRows > 1) {
      // ── Build a header→columnIndex map from the actual first row ──────────
      // Normalise: strip units like "(kg)", "(%)", "Δ ", leading/trailing spaces,
      // and lowercase for fuzzy matching.
      String _norm(String s) => s
          .replaceAll(RegExp(r'\([^)]*\)'), '') // strip (…)
          .replaceAll('Δ', '')
          .trim()
          .toLowerCase();

      final headerRow = measurementSheet.row(0);
      final Map<String, int> hIdx = {};
      for (var ci = 0; ci < headerRow.length; ci++) {
        final raw = headerRow[ci]?.value?.toString() ?? '';
        if (raw.isEmpty) continue;
        hIdx[_norm(raw)] = ci;
      }

      // Helper: get a double value by normalised header name
      double? col(List<Data?> row, String header) {
        final idx = hIdx[header.toLowerCase()];
        if (idx == null || idx >= row.length) return null;
        return double.tryParse(row[idx]?.value?.toString() ?? '');
      }
      String? colStr(List<Data?> row, String header) {
        final idx = hIdx[header.toLowerCase()];
        if (idx == null || idx >= row.length) return null;
        final v = row[idx]?.value?.toString();
        return (v == null || v.isEmpty) ? null : v;
      }

      for (var i = 1; i < measurementSheet.maxRows; i++) {
        final row = measurementSheet.row(i);
        if (row.isEmpty) continue;

        try {
          // Date — always column 0 (or mapped)
          final dateColIdx = hIdx['date'] ?? (mapping?.bodyMeasurementsMapping?.getIndex('Date') ?? 0);
          final dateRaw = row.length > dateColIdx ? row[dateColIdx]?.value : null;
          final dateStr = dateRaw?.toString() ?? '';
          final date = _parseDate(dateStr);
          if (date == null) continue;

          final companion = BodyMeasurementsCompanion.insert(
            date: date,
            weight:          Value(col(row, 'weight')),
            bodyFat:         Value(col(row, 'body fat')),
            subcutaneousFat: Value(col(row, 'subcutaneous fat')),
            visceralFat:     Value(col(row, 'visceral fat')),
            neck:            Value(col(row, 'neck')),
            chest:           Value(col(row, 'chest')),
            shoulders:       Value(col(row, 'shoulders')),
            waist:           Value(col(row, 'waist')),
            waistNaval:      Value(col(row, 'naval waist') ?? col(row, 'navel waist')),
            hips:            Value(col(row, 'hips')),
            armLeft:         Value(col(row, 'left bicep') ?? col(row, 'left arm')),
            armRight:        Value(col(row, 'right bicep') ?? col(row, 'right arm')),
            forearmLeft:     Value(col(row, 'left forearm')),
            forearmRight:    Value(col(row, 'right forearm')),
            thighLeft:       Value(col(row, 'left thigh')),
            thighRight:      Value(col(row, 'right thigh')),
            calfLeft:        Value(col(row, 'left calf')),
            calfRight:       Value(col(row, 'right calf')),
            notes:           Value(colStr(row, 'notes')),
          );

          final existing = await (db.select(db.bodyMeasurements)
                ..where((t) => t.date.year.equals(date.year) & t.date.month.equals(date.month) & t.date.day.equals(date.day))
                ..limit(1))
              .getSingleOrNull();

          if (existing == null) {
            await db.into(db.bodyMeasurements).insert(companion);
          } else {
            await (db.update(db.bodyMeasurements)..where((t) => t.id.equals(existing.id))).write(companion);
          }
          importedMeasurements++;
        } catch (e) {
          print('Error parsing measurement row $i: $e');
        }
      }
    }

    return {
      'workouts': importedWorkouts,
      'measurements': importedMeasurements,
    };
  }

  DateTime? _parseDate(String dateStr) {
    if (dateStr.isEmpty) return null;
    try {
      return DateFormat('yyyy-MM-dd').parse(dateStr);
    } catch (_) {
      try {
        // Handle common Excel format yyyy-MM-dd HH:mm:ss
        if (dateStr.contains(' ')) {
          return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateStr);
        }
        return DateTime.parse(dateStr);
      } catch (_) {
        return DateTime.tryParse(dateStr);
      }
    }
  }

  Map<K, List<V>> _groupBy<V, K>(Iterable<V> values, K Function(V) key) {
    var map = <K, List<V>>{};
    for (var value in values) {
      (map[key(value)] ??= []).add(value);
    }
    return map;
  }
}
