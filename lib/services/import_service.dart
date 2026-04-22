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

  Future<ExcelSchema?> getExcelSchema() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (result == null || result.files.single.path == null) return null;

    final file = File(result.files.single.path!);
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
      final measMapping = mapping?.bodyMeasurementsMapping?.fieldToColumnIndex;

      for (var i = 1; i < measurementSheet.maxRows; i++) {
        final row = measurementSheet.row(i);
        if (row.isEmpty) continue;

        try {
          final dateIdx = measMapping?['Date'] ?? 0;
          final dateStr = row[dateIdx]?.value?.toString() ?? '';
          final date = _parseDate(dateStr);
          if (date == null) continue;
          
          final weight = double.tryParse(row.length > (measMapping?['Weight'] ?? 1) ? row[measMapping?['Weight'] ?? 1]?.value?.toString() ?? '' : '');
          final bodyFat = double.tryParse(row.length > (measMapping?['Body Fat'] ?? 3) ? row[measMapping?['Body Fat'] ?? 3]?.value?.toString() ?? '' : '');
          final subFat = double.tryParse(row.length > (measMapping?['Subcutaneous Fat'] ?? -1) ? row[measMapping?['Subcutaneous Fat'] ?? -1]?.value?.toString() ?? '' : '');
          final visFat = double.tryParse(row.length > (measMapping?['Visceral Fat'] ?? -1) ? row[measMapping?['Visceral Fat'] ?? -1]?.value?.toString() ?? '' : '');
          final neck = double.tryParse(row.length > (measMapping?['Neck'] ?? -1) ? row[measMapping?['Neck'] ?? -1]?.value?.toString() ?? '' : '');
          final chest = double.tryParse(row.length > (measMapping?['Chest'] ?? 4) ? row[measMapping?['Chest'] ?? 4]?.value?.toString() ?? '' : '');
          final shoulders = double.tryParse(row.length > (measMapping?['Shoulders'] ?? 5) ? row[measMapping?['Shoulders'] ?? 5]?.value?.toString() ?? '' : '');
          final waist = double.tryParse(row.length > (measMapping?['Waist'] ?? 6) ? row[measMapping?['Waist'] ?? 6]?.value?.toString() ?? '' : '');
          final waistNaval = double.tryParse(row.length > (measMapping?['Naval Waist'] ?? -1) ? row[measMapping?['Naval Waist'] ?? -1]?.value?.toString() ?? '' : '');
          final hips = double.tryParse(row.length > (measMapping?['Hips'] ?? 7) ? row[measMapping?['Hips'] ?? 7]?.value?.toString() ?? '' : '');
          final armL = double.tryParse(row.length > (measMapping?['Left Bicep'] ?? 8) ? row[measMapping?['Left Bicep'] ?? 8]?.value?.toString() ?? '' : '');
          final armR = double.tryParse(row.length > (measMapping?['Right Bicep'] ?? 9) ? row[measMapping?['Right Bicep'] ?? 9]?.value?.toString() ?? '' : '');
          final forearmL = double.tryParse(row.length > (measMapping?['Left Forearm'] ?? -1) ? row[measMapping?['Left Forearm'] ?? -1]?.value?.toString() ?? '' : '');
          final forearmR = double.tryParse(row.length > (measMapping?['Right Forearm'] ?? -1) ? row[measMapping?['Right Forearm'] ?? -1]?.value?.toString() ?? '' : '');
          final thighL = double.tryParse(row.length > (measMapping?['Left Thigh'] ?? 10) ? row[measMapping?['Left Thigh'] ?? 10]?.value?.toString() ?? '' : '');
          final thighR = double.tryParse(row.length > (measMapping?['Right Thigh'] ?? 11) ? row[measMapping?['Right Thigh'] ?? 11]?.value?.toString() ?? '' : '');
          final calfL = double.tryParse(row.length > (measMapping?['Left Calf'] ?? 12) ? row[measMapping?['Left Calf'] ?? 12]?.value?.toString() ?? '' : '');
          final calfR = double.tryParse(row.length > (measMapping?['Right Calf'] ?? 13) ? row[measMapping?['Right Calf'] ?? 13]?.value?.toString() ?? '' : '');
          final notes = row.length > (measMapping?['Notes'] ?? 14) ? row[measMapping?['Notes'] ?? 14]?.value?.toString() : null;

          final companion = BodyMeasurementsCompanion.insert(
            date: date,
            weight: Value(weight),
            bodyFat: Value(bodyFat),
            subcutaneousFat: Value(subFat),
            visceralFat: Value(visFat),
            neck: Value(neck),
            chest: Value(chest),
            shoulders: Value(shoulders),
            waist: Value(waist),
            waistNaval: Value(waistNaval),
            hips: Value(hips),
            armLeft: Value(armL),
            armRight: Value(armR),
            forearmLeft: Value(forearmL),
            forearmRight: Value(forearmR),
            thighLeft: Value(thighL),
            thighRight: Value(thighR),
            calfLeft: Value(calfL),
            calfRight: Value(calfR),
            notes: Value(notes),
          );

          print('Saving measurement for $date: $companion');
          final existing = await (db.select(db.bodyMeasurements)
                ..where((t) => t.date.year.equals(date.year) & t.date.month.equals(date.month) & t.date.day.equals(date.day))
                ..limit(1))
              .getSingleOrNull();

          if (existing == null) {
            print('Inserting new record for $date');
            await db.into(db.bodyMeasurements).insert(companion);
            importedMeasurements++;
          } else {
            print('Updating existing record ID ${existing.id} for $date');
             await (db.update(db.bodyMeasurements)..where((t) => t.id.equals(existing.id))).write(companion);
             importedMeasurements++;
          }
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
