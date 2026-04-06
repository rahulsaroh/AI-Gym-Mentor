import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  final AppDatabase db;
  DataService(this.db);

  Future<void> clearWorkoutHistory() async {
    await db.transaction(() async {
      await db.delete(db.workoutSets).go();
      await db.delete(db.workouts).go();
    });
  }

  Future<void> factoryReset() async {
    // 1. Clear database tables in order of dependencies
    await db.transaction(() async {
      await db.delete(db.syncQueue).go();
      await db.delete(db.workoutSets).go();
      await db.delete(db.workouts).go();
      await db.delete(db.templateExercises).go();
      await db.delete(db.templateDays).go();
      await db.delete(db.workoutTemplates).go();
      await db.delete(db.bodyMeasurements).go();
      await db.delete(db.exercises).go();
    });
    
    // 2. Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<String> exportWorkoutsJson() async {
    final workoutList = await db.select(db.workouts).get();
    final setsList = await db.select(db.workoutSets).get();
    final exercisesList = await db.select(db.exercises).get();

    final data = {
      'exportDate': DateTime.now().toIso8601String(),
      'workouts': workoutList.map((w) => w.toJson()).toList(),
      'sets': setsList.map((s) => s.toJson()).toList(),
      'exercises': exercisesList.map((e) => e.toJson()).toList(),
    };

    return jsonEncode(data);
  }

  Future<String> exportWorkoutsCsv() async {
    final query = db.select(db.workoutSets).join([
      innerJoin(db.workouts, db.workouts.id.equalsExp(db.workoutSets.workoutId)),
      innerJoin(db.exercises, db.exercises.id.equalsExp(db.workoutSets.exerciseId)),
    ])..orderBy([OrderingTerm.desc(db.workouts.date)]);

    final rows = await query.get();
    
    StringBuffer csv = StringBuffer();
    csv.writeln('Date,Workout,Exercise,Set,Weight,Reps,RPE,Type');

    for (final row in rows) {
      final s = row.readTable(db.workoutSets);
      final w = row.readTable(db.workouts);
      final e = row.readTable(db.exercises);
      
      final dateStr = w.date.toIso8601String().split('T')[0];
      
      csv.writeln('$dateStr,"${w.name}","${e.name}",${s.setNumber},${s.weight},${s.reps},${s.rpe ?? ""},${s.setType.name}');
    }

    return csv.toString();
  }
}
