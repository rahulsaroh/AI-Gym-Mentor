import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_repository.g.dart';

class WorkoutRepository {
  final AppDatabase _db;

  WorkoutRepository(this._db);

  Future<List<Workout>> getHistory({int limit = 20, int offset = 0}) async {
    return await (_db.select(_db.workouts)
          ..where((t) => t.status.equals('completed'))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
          ..limit(limit, offset: offset))
        .get();
  }

  Future<Map<String, dynamic>> getStats() async {
    final completedWorkouts = await (_db.select(_db.workouts)
          ..where((t) => t.status.equals('completed'))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)]))
        .get();

    if (completedWorkouts.isEmpty) {
      return {
        'currentStreak': 0,
        'longestStreak': 0,
        'totalWorkouts': 0,
        'totalVolume': 0.0,
      };
    }

    // Streak calculation
    int currentStreak = 0;
    int longestStreak = 0;
    int tempStreak = 0;

    final workoutDates = completedWorkouts.map((w) => DateTime(w.date.year, w.date.month, w.date.day)).toSet().toList();
    workoutDates.sort();

    if (workoutDates.isNotEmpty) {
      tempStreak = 1;
      longestStreak = 1;
      for (int i = 1; i < workoutDates.length; i++) {
        if (workoutDates[i].difference(workoutDates[i - 1]).inDays == 1) {
          tempStreak++;
        } else {
          if (tempStreak > longestStreak) longestStreak = tempStreak;
          tempStreak = 1;
        }
      }
      if (tempStreak > longestStreak) longestStreak = tempStreak;

      // Current streak check
      final today = DateTime.now();
      final lastWorkoutDay = workoutDates.last;
      final diff = DateTime(today.year, today.month, today.day).difference(lastWorkoutDay).inDays;
      
      if (diff <= 1) {
        // Find how many consecutive days back from lastWorkoutDay
        currentStreak = 1;
        for (int i = workoutDates.length - 1; i > 0; i--) {
          if (workoutDates[i].difference(workoutDates[i-1]).inDays == 1) {
            currentStreak++;
          } else {
            break;
          }
        }
      } else {
        currentStreak = 0;
      }
    }

    // Total Volume
    final volumeQuery = _db.selectOnly(_db.workoutSets)
      ..addColumns([_db.workoutSets.weight, _db.workoutSets.reps])
      ..where(_db.workoutSets.completed.equals(true));
    
    final sets = await volumeQuery.get();
    double totalVolume = 0;
    for (final row in sets) {
      final w = row.read(_db.workoutSets.weight) ?? 0;
      final r = row.read(_db.workoutSets.reps) ?? 0;
      totalVolume += w * r;
    }

    return {
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'totalWorkouts': completedWorkouts.length,
      'totalVolume': totalVolume,
    };
  }

  Future<List<WorkoutSet>> getWorkoutSets(int workoutId) async {
    return await (_db.select(_db.workoutSets)..where((t) => t.workoutId.equals(workoutId))).get();
  }

  Future<void> updateWorkout(WorkoutsCompanion companion) async {
    await (_db.update(_db.workouts)..where((t) => t.id.equals(companion.id.value))).write(companion);
  }

  Future<void> deleteWorkout(int workoutId) async {
    await _db.transaction(() async {
      await (_db.delete(_db.workoutSets)..where((t) => t.workoutId.equals(workoutId))).go();
      await (_db.delete(_db.workouts)..where((t) => t.id.equals(workoutId))).go();
    });
  }

  Future<List<WorkoutSet>> getSetsForHeatmap() async {
    return await (_db.select(_db.workoutSets)..where((t) => t.completed.equals(true))).get();
  }

  Future<Workout?> getLastWorkout() async {
    return await (_db.select(_db.workouts)
          ..where((t) => t.status.equals('completed'))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<Workout?> getActiveWorkoutDraft() async {
    return await (_db.select(_db.workouts)
          ..where((t) => t.status.equals('draft'))
          ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<Map<int, double>> getDailyVolumeRange(DateTime start, DateTime end) async {
    final query = _db.select(_db.workoutSets).join([
      innerJoin(_db.workouts, _db.workouts.id.equalsExp(_db.workoutSets.workoutId)),
    ])
      ..where(_db.workouts.date.isBiggerOrEqualValue(start) & 
              _db.workouts.date.isSmallerOrEqualValue(end) & 
              _db.workouts.status.equals('completed'));

    final rows = await query.get();
    final Map<int, double> dailyVolume = {};

    for (final row in rows) {
      final date = row.readTable(_db.workouts).date;
      final weight = row.readTable(_db.workoutSets).weight;
      final reps = row.readTable(_db.workoutSets).reps;
      
      // key is day of year or just a formatted string
      final dayKey = DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
      dailyVolume[dayKey] = (dailyVolume[dayKey] ?? 0) + (weight * reps);
    }

    return dailyVolume;
  }

  Future<WorkoutTemplate?> getActiveTemplate() async {
    return await (_db.select(_db.workoutTemplates)..limit(1)).getSingleOrNull();
  }

  Future<List<TemplateDay>> getTemplateDays(int templateId) async {
    return await (_db.select(_db.templateDays)
          ..where((t) => t.templateId.equals(templateId))
          ..orderBy([(t) => OrderingTerm(expression: t.order, mode: OrderingMode.asc)]))
        .get();
  }

  Future<List<TypedTemplateExercise>> getTemplateExercises(int dayId) async {
    final query = _db.select(_db.templateExercises).join([
      innerJoin(_db.exercises, _db.exercises.id.equalsExp(_db.templateExercises.exerciseId)),
    ])
      ..where(_db.templateExercises.dayId.equals(dayId))
      ..orderBy([OrderingTerm(expression: _db.templateExercises.order, mode: OrderingMode.asc)]);

    final rows = await query.get();
    return rows.map((row) {
      return TypedTemplateExercise(
        templateExercise: row.readTable(_db.templateExercises),
        exercise: row.readTable(_db.exercises),
      );
    }).toList();
  }

  Future<Workout?> getLastWorkoutOfTemplate(int templateId) async {
    return await (_db.select(_db.workouts)
          ..where((t) => t.templateId.equals(templateId) & t.status.equals('completed'))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> createWorkout({String name = 'New Workout', int? templateId, int? dayId}) async {
    return await _db.into(_db.workouts).insert(WorkoutsCompanion.insert(
      name: name,
      date: DateTime.now(),
      startTime: Value(DateTime.now()),
      status: const Value('draft'),
      templateId: Value(templateId),
      dayId: Value(dayId),
    ));
  }

  Future<List<WorkoutTemplate>> getAllTemplates() async {
    return await _db.select(_db.workoutTemplates).get();
  }

  Future<void> deleteTemplate(int id) async {
    await _db.transaction(() async {
      final days = await (_db.select(_db.templateDays)..where((t) => t.templateId.equals(id))).get();
      for (final day in days) {
        await (_db.delete(_db.templateExercises)..where((t) => t.dayId.equals(day.id))).go();
      }
      await (_db.delete(_db.templateDays)..where((t) => t.templateId.equals(id))).go();
      await (_db.delete(_db.workoutTemplates)..where((t) => t.id.equals(id))).go();
    });
  }

  Future<String> exportTemplateToJson(int id) async {
    final template = await (_db.select(_db.workoutTemplates)..where((t) => t.id.equals(id))).getSingle();
    final days = await getTemplateDays(id);
    final List<Map<String, dynamic>> daysJson = [];
    
    for (final day in days) {
      final exercises = await getTemplateExercises(day.id);
      daysJson.add({
        'name': day.name,
        'order': day.order,
        'exercises': exercises.map((e) => {
          'exerciseName': e.exercise.name,
          'order': e.templateExercise.order,
          'setType': e.templateExercise.setType.name,
          'setsJson': e.templateExercise.setsJson,
          'restTime': e.templateExercise.restTime,
          'notes': e.templateExercise.notes,
        }).toList(),
      });
    }

    return jsonEncode({
      'name': template.name,
      'description': template.description,
      'days': daysJson,
    });
  }

  Future<void> importTemplateFromJson(String jsonStr) async {
    final data = jsonDecode(jsonStr);
    final name = data['name'] as String;
    final description = data['description'] as String?;
    final days = data['days'] as List;

    await _db.transaction(() async {
      final templateId = await _db.into(_db.workoutTemplates).insert(WorkoutTemplatesCompanion.insert(
        name: name,
        description: Value(description),
      ));

      for (final dayData in days) {
        final dayId = await _db.into(_db.templateDays).insert(TemplateDaysCompanion.insert(
          templateId: templateId,
          name: dayData['name'],
          order: dayData['order'],
        ));

        final exercises = dayData['exercises'] as List;
        for (final exData in exercises) {
          final exerciseName = exData['exerciseName'] as String;
          final ex = await (_db.select(_db.exercises)..where((t) => t.name.equals(exerciseName))).getSingleOrNull();
          if (ex != null) {
            await _db.into(_db.templateExercises).insert(TemplateExercisesCompanion.insert(
              dayId: dayId,
              exerciseId: ex.id,
              order: exData['order'],
              setType: Value(SetType.values.byName(exData['setType'])),
              setsJson: exData['setsJson'],
              restTime: Value(exData['restTime'] ?? 90),
              notes: Value(exData['notes']),
            ));
          }
        }
      }
    });
  }

  String getSampleJson() {
    return jsonEncode({
      'name': 'Sample 3-Day Split',
      'description': 'A simple example of a workout program structure.',
      'days': [
        {
          'name': 'Upper Body',
          'order': 0,
          'exercises': [
            {
              'exerciseName': 'Bench Press',
              'order': 0,
              'setType': 'normal',
              'setsJson': '[{"reps":10, "weight": 60.0}, {"reps":10, "weight": 60.0}, {"reps":10, "weight": 60.0}]',
              'restTime': 90,
              'notes': 'Keep core tight'
            },
            {
              'exerciseName': 'Pull Ups',
              'order': 1,
              'setType': 'normal',
              'setsJson': '[{"reps":12, "weight": 0.0}, {"reps":12, "weight": 0.0}, {"reps":12, "weight": 0.0}]',
              'restTime': 60,
              'notes': 'Full extension'
            }
          ]
        },
        {
          'name': 'Lower Body',
          'order': 1,
          'exercises': [
            {
              'exerciseName': 'Squat (Barbell)',
              'order': 0,
              'setType': 'normal',
              'setsJson': '[{"reps":8, "weight": 80.0}, {"reps":8, "weight": 80.0}, {"reps":8, "weight": 80.0}]',
              'restTime': 120,
              'notes': 'Go deep'
            }
          ]
        }
      ],
    });
  }
}

class TypedTemplateExercise {
  final TemplateExercise templateExercise;
  final Exercise exercise;

  TypedTemplateExercise({
    required this.templateExercise,
    required this.exercise,
  });
}

@riverpod
WorkoutRepository workoutRepository(WorkoutRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return WorkoutRepository(db);
}
