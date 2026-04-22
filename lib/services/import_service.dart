import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart';

final importServiceProvider = Provider((ref) => ImportService(ref));

class ImportService {
  final Ref ref;
  ImportService(this.ref);

  Future<Map<String, int>> importFromXlsx([File? file]) async {
    File? fileToImport = file;

    if (fileToImport == null) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );
      if (result == null || result.files.single.path == null) return {};
      fileToImport = File(result.files.single.path!);
    }

    final bytes = fileToImport.readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);
    final db = ref.read(appDatabaseProvider);
    final exerciseRepo = ref.read(exerciseRepositoryProvider);
    final exercises = await exerciseRepo.getAllExercises();
    final exerciseByName = {for (final e in exercises) e.name.toLowerCase(): e};

    int importedWorkouts = 0;
    int importedMeasurements = 0;

    // 1. Parse Sheet 1 — Raw Log (Import-Safe)
    final exerciseSheet = excel.tables['Raw Log'];
    if (exerciseSheet != null && exerciseSheet.maxRows > 1) {
      final Map<String, List<Map<String, dynamic>>> workoutGroups = {};

      for (var i = 1; i < exerciseSheet.maxRows; i++) {
        final row = exerciseSheet.row(i);
        if (row.isEmpty || row[0] == null) continue;

        try {
          final dateStr = row[0]?.value?.toString() ?? '';
          final date = DateFormat('yyyy-MM-dd').parse(dateStr);
          final workoutName = row[2]?.value?.toString() ?? 'Imported Workout';
          final exerciseName = row[3]?.value?.toString() ?? 'Unknown';
          final setNum = int.tryParse(row[4]?.value?.toString() ?? '1') ?? 1;
          final setTypeStr = row[5]?.value?.toString() ?? 'Main';
          final weight = double.tryParse(row[6]?.value?.toString() ?? '0') ?? 0.0;
          final reps = double.tryParse(row[7]?.value?.toString() ?? '0') ?? 0.0;
          final rpe = double.tryParse(row[8]?.value?.toString() ?? '');
          final isPr = row[10]?.value?.toString().toUpperCase() == 'YES';
          final notes = row[11]?.value?.toString() ?? '';

          final workoutKey = '${dateStr}_$workoutName';
          if (!workoutGroups.containsKey(workoutKey)) {
            workoutGroups[workoutKey] = [];
          }

          workoutGroups[workoutKey]!.add({
            'date': date,
            'workoutName': workoutName,
            'exerciseName': exerciseName,
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
            final exName = itemEntry.key;
            var ex = exerciseByName[exName.toLowerCase()];
            
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
    final measurementSheet = excel.tables['Body Measurements'];
    if (measurementSheet != null && measurementSheet.maxRows > 1) {
      for (var i = 1; i < measurementSheet.maxRows; i++) {
        final row = measurementSheet.row(i);
        if (row.isEmpty || row[0] == null) continue;

        try {
          final dateStr = row[0]?.value?.toString() ?? '';
          final date = DateFormat('yyyy-MM-dd').parse(dateStr);
          
          final weight = double.tryParse(row[1]?.value?.toString() ?? '');
          // Skip row[2] as it is "Delta Weight" calculated column
          final bodyFat = double.tryParse(row[3]?.value?.toString() ?? '');
          final chest = double.tryParse(row[4]?.value?.toString() ?? '');
          final shoulders = double.tryParse(row[5]?.value?.toString() ?? '');
          final waist = double.tryParse(row[6]?.value?.toString() ?? '');
          final hips = double.tryParse(row[7]?.value?.toString() ?? '');
          final armL = double.tryParse(row[8]?.value?.toString() ?? '');
          final armR = double.tryParse(row[9]?.value?.toString() ?? '');
          final thighL = double.tryParse(row[10]?.value?.toString() ?? '');
          final thighR = double.tryParse(row[11]?.value?.toString() ?? '');
          final calfL = double.tryParse(row[12]?.value?.toString() ?? '');
          final calfR = double.tryParse(row[13]?.value?.toString() ?? '');
          final notes = row[14]?.value?.toString();

          final companion = BodyMeasurementsCompanion.insert(
            date: date,
            weight: Value(weight),
            bodyFat: Value(bodyFat),
            chest: Value(chest),
            shoulders: Value(shoulders),
            waist: Value(waist),
            hips: Value(hips),
            armLeft: Value(armL),
            armRight: Value(armR),
            thighLeft: Value(thighL),
            thighRight: Value(thighR),
            calfLeft: Value(calfL),
            calfRight: Value(calfR),
            notes: Value(notes),
          );

          final existing = await (db.select(db.bodyMeasurements)
                ..where((t) => t.date.year.equals(date.year) & t.date.month.equals(date.month) & t.date.day.equals(date.day))
                ..limit(1))
              .getSingleOrNull();

          if (existing == null) {
            await db.into(db.bodyMeasurements).insert(companion);
            importedMeasurements++;
          } else {
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

  Map<K, List<V>> _groupBy<V, K>(Iterable<V> values, K Function(V) key) {
    var map = <K, List<V>>{};
    for (var value in values) {
      (map[key(value)] ??= []).add(value);
    }
    return map;
  }
}
