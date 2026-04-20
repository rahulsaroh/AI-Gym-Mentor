import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/domain/entities/mesocycle.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/repositories/exercise_repository.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mesocycle_repository.g.dart';

class MesocycleRepository {
  final AppDatabase _db;
  final ExerciseRepository _exerciseRepo;

  MesocycleRepository(this._db, this._exerciseRepo);

  // --- Conversion Helpers ---

  Future<MesocycleEntity> _toMesocycleEntity(Mesocycle row) async {
    final weeks = await _getWeeksForMesocycle(row.id);
    return MesocycleEntity(
      id: row.id,
      name: row.name,
      goal: MesocycleGoal.values.firstWhere((e) => e.toString().split('.').last == row.goal, orElse: () => MesocycleGoal.generalFitness),
      splitType: row.splitType,
      experienceLevel: row.experienceLevel,
      weeksCount: row.weeksCount,
      daysPerWeek: row.daysPerWeek,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      notes: row.notes,
      isArchived: row.isArchived,
      weeks: weeks,
    );
  }

  Future<List<MesocycleWeekEntity>> _getWeeksForMesocycle(int mesocycleId) async {
    final rows = await (_db.select(_db.mesocycleWeeks)
          ..where((t) => t.mesocycleId.equals(mesocycleId))
          ..orderBy([(t) => OrderingTerm(expression: t.weekNumber)]))
        .get();

    final result = <MesocycleWeekEntity>[];
    for (var row in rows) {
      final days = await _getDaysForWeek(row.id);
      result.add(MesocycleWeekEntity(
        id: row.id,
        mesocycleId: row.mesocycleId,
        weekNumber: row.weekNumber,
        phaseName: MesocyclePhase.values.firstWhere((e) => e.label == row.phaseName, orElse: () => MesocyclePhase.custom),
        volumeMultiplier: row.volumeMultiplier,
        intensityMultiplier: row.intensityMultiplier,
        notes: row.notes,
        days: days,
      ));
    }
    return result;
  }

  Future<List<MesocycleDayEntity>> _getDaysForWeek(int weekId) async {
    final rows = await (_db.select(_db.mesocycleDays)
          ..where((t) => t.mesocycleWeekId.equals(weekId))
          ..orderBy([(t) => OrderingTerm(expression: t.dayNumber)]))
        .get();

    final result = <MesocycleDayEntity>[];
    for (var row in rows) {
      final exercises = await _getExercisesForDay(row.id);
      result.add(MesocycleDayEntity(
        id: row.id,
        mesocycleWeekId: row.mesocycleWeekId,
        dayNumber: row.dayNumber,
        title: row.title,
        splitLabel: row.splitLabel,
        exercises: exercises,
      ));
    }
    return result;
  }

  Future<List<MesocycleExerciseEntity>> _getExercisesForDay(int dayId) async {
    final rows = await (_db.select(_db.mesocycleExercises)
          ..where((t) => t.mesocycleDayId.equals(dayId))
          ..orderBy([(t) => OrderingTerm(expression: t.exerciseOrder)]))
        .get();

    final result = <MesocycleExerciseEntity>[];
    for (var row in rows) {
      final exercise = await _exerciseRepo.getExerciseById(row.exerciseId);
      if (exercise != null) {
        result.add(MesocycleExerciseEntity(
          id: row.id,
          mesocycleDayId: row.mesocycleDayId,
          exercise: exercise,
          exerciseOrder: row.exerciseOrder,
          targetSets: row.targetSets,
          minReps: row.minReps,
          maxReps: row.maxReps,
          targetRpe: row.targetRpe,
          progressionType: ProgressionType.values.firstWhere((e) => e.toString().split('.').last == row.progressionType, orElse: () => ProgressionType.none),
          progressionValue: row.progressionValue,
          notes: row.notes,
        ));
      }
    }
    return result;
  }

  // --- CRUD Operations ---

  Future<List<MesocycleEntity>> getAllMesocycles({bool includeArchived = false}) async {
    final query = _db.select(_db.mesocycles);
    if (!includeArchived) {
      query.where((t) => t.isArchived.equals(false));
    }
    query.orderBy([(t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.desc)]);
    
    final rows = await query.get();
    final result = <MesocycleEntity>[];
    for (var row in rows) {
      result.add(await _toMesocycleEntity(row));
    }
    return result;
  }

  Future<int> createMesocycle(MesocycleEntity entity) async {
    return _db.transaction(() async {
      final mesocycleId = await _db.into(_db.mesocycles).insert(
            MesocyclesCompanion.insert(
              name: entity.name,
              goal: entity.goal.toString().split('.').last,
              splitType: entity.splitType,
              experienceLevel: entity.experienceLevel,
              weeksCount: entity.weeksCount,
              daysPerWeek: entity.daysPerWeek,
              createdAt: entity.createdAt,
              updatedAt: entity.updatedAt,
              notes: Value(entity.notes),
              isArchived: Value(entity.isArchived),
            ),
          );

      for (var week in entity.weeks) {
        final weekId = await _db.into(_db.mesocycleWeeks).insert(
              MesocycleWeeksCompanion.insert(
                mesocycleId: mesocycleId,
                weekNumber: week.weekNumber,
                phaseName: week.phaseName.label,
                volumeMultiplier: Value(week.volumeMultiplier),
                intensityMultiplier: Value(week.intensityMultiplier),
                notes: Value(week.notes),
              ),
            );

        for (var day in week.days) {
          final dayId = await _db.into(_db.mesocycleDays).insert(
                MesocycleDaysCompanion.insert(
                  mesocycleWeekId: weekId,
                  dayNumber: day.dayNumber,
                  title: day.title,
                  splitLabel: Value(day.splitLabel),
                ),
              );

          for (var ex in day.exercises) {
            await _db.into(_db.mesocycleExercises).insert(
                  MesocycleExercisesCompanion.insert(
                    mesocycleDayId: dayId,
                    exerciseId: ex.exercise.id,
                    exerciseOrder: ex.exerciseOrder,
                    targetSets: ex.targetSets,
                    minReps: ex.minReps,
                    maxReps: ex.maxReps,
                    targetRpe: Value(ex.targetRpe),
                    progressionType: Value(ex.progressionType.toString().split('.').last),
                    progressionValue: Value(ex.progressionValue),
                    notes: Value(ex.notes),
                  ),
                );
          }
        }
      }
      return mesocycleId;
    });
  }

  Future<void> deleteMesocycle(int id) async {
    return _db.transaction(() async {
      // 1. Delete exercises for all days in all weeks of this mesocycle
      final weeks = await (_db.select(_db.mesocycleWeeks)..where((t) => t.mesocycleId.equals(id))).get();
      for (var week in weeks) {
        final days = await (_db.select(_db.mesocycleDays)..where((t) => t.mesocycleWeekId.equals(week.id))).get();
        for (var day in days) {
          await (_db.delete(_db.mesocycleExercises)..where((t) => t.mesocycleDayId.equals(day.id))).go();
        }
        await (_db.delete(_db.mesocycleDays)..where((t) => t.mesocycleWeekId.equals(week.id))).go();
      }
      await (_db.delete(_db.mesocycleWeeks)..where((t) => t.mesocycleId.equals(id))).go();
      await (_db.delete(_db.mesocycles)..where((t) => t.id.equals(id))).go();
    });
  }

  Future<void> archiveMesocycle(int id, bool archive) async {
    await (_db.update(_db.mesocycles)..where((t) => t.id.equals(id))).write(
      MesocyclesCompanion(isArchived: Value(archive), updatedAt: Value(DateTime.now())),
    );
  }

  Future<int> startMesocycleWorkout(MesocycleDayEntity dayEntity, String mesocycleName) async {
    // This will eventually integrate with WorkoutHomeNotifier
    // For now, it just creates the workout and links it
    return _db.transaction(() async {
      final week = await (_db.select(_db.mesocycleWeeks)..where((t) => t.id.equals(dayEntity.mesocycleWeekId))).getSingle();
      
      final id = await _db.into(_db.workouts).insert(
        WorkoutsCompanion.insert(
          name: '$mesocycleName - W${week.weekNumber} ${dayEntity.title}',
          date: DateTime.now(),
          startTime: Value(DateTime.now()),
          status: const Value('draft'),
          mesocycleId: Value(week.mesocycleId),
          mesocycleWeekId: Value(week.id),
          mesocycleDayId: Value(dayEntity.id),
        ),
      );

      // Initialize sets from the mesocycle exercise targets
      for (var mesEx in dayEntity.exercises) {
        for (var i = 0; i < mesEx.targetSets; i++) {
          await _db.into(_db.workoutSets).insert(
            WorkoutSetsCompanion.insert(
              workoutId: id,
              exerciseId: mesEx.exercise.id,
              exerciseOrder: mesEx.exerciseOrder,
              setNumber: i + 1,
              reps: mesEx.minReps.toDouble(), // Start at min reps
              weight: 0, // Load will be decided by user or last session
              notes: Value(mesEx.notes),
            ),
          );
        }
      }
      return id;
    });
  }
}

@Riverpod(keepAlive: true)
MesocycleRepository mesocycleRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  final exerciseRepo = ref.watch(exerciseRepositoryProvider);
  return MesocycleRepository(db, exerciseRepo);
}
