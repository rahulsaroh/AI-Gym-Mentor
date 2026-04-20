import 'package:ai_gym_mentor/core/domain/entities/mesocycle.dart' as ent;
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';

class MesocycleGeneratorService {
  
  ent.MesocycleEntity generateStructure({
    required String name,
    required ent.MesocycleGoal goal,
    required String splitType,
    required String experienceLevel,
    required int weeksCount,
    required int daysPerWeek,
    required List<List<ExerciseEntity>> exercisesPerDay,
  }) {
    final now = DateTime.now();
    final weeks = <ent.MesocycleWeekEntity>[];

    for (int w = 1; w <= weeksCount; w++) {
      final phase = _determinePhase(w, weeksCount);
      final multipliers = _getMultipliers(phase);

      final days = <ent.MesocycleDayEntity>[];
      for (int d = 1; d <= daysPerWeek; d++) {
        final dayExercises = <ent.MesocycleExerciseEntity>[];
        final sourceExercises = exercisesPerDay[d - 1];

        for (int e =0; e < sourceExercises.length; e++) {
          final baseSets = 3;
          final targetSets = (baseSets * multipliers['volume']!).round();
          
          dayExercises.add(ent.MesocycleExerciseEntity(
            id: 0,
            mesocycleDayId: 0,
            exercise: sourceExercises[e],
            exerciseOrder: e,
            targetSets: targetSets,
            minReps: 8,
            maxReps: 12,
            targetRpe: multipliers['intensity'],
            progressionType: ent.ProgressionType.none,
          ));
        }

        days.add(ent.MesocycleDayEntity(
          id: 0,
          mesocycleWeekId: 0,
          dayNumber: d,
          title: 'Day $d',
          splitLabel: _getSplitDayLabel(splitType, d),
          exercises: dayExercises,
        ));
      }

      weeks.add(ent.MesocycleWeekEntity(
        id: 0,
        mesocycleId: 0,
        weekNumber: w,
        phaseName: phase,
        volumeMultiplier: multipliers['volume']!,
        intensityMultiplier: multipliers['intensity'] ?? 1.0,
        days: days,
      ));
    }

    return ent.MesocycleEntity(
      id: 0,
      name: name,
      goal: goal,
      splitType: splitType,
      experienceLevel: experienceLevel,
      weeksCount: weeksCount,
      daysPerWeek: daysPerWeek,
      createdAt: now,
      updatedAt: now,
      weeks: weeks,
    );
  }

  ent.MesocyclePhase _determinePhase(int week, int totalWeeks) {
    if (week == 1) return ent.MesocyclePhase.onRamp;
    if (week == totalWeeks) return ent.MesocyclePhase.deload;
    if (week >= totalWeeks - 1) return ent.MesocyclePhase.intensification;
    return ent.MesocyclePhase.accumulation;
  }

  Map<String, double> _getMultipliers(ent.MesocyclePhase phase) {
    switch (phase) {
      case ent.MesocyclePhase.onRamp:
        return {'volume': 0.7, 'intensity': 6.5};
      case ent.MesocyclePhase.accumulation:
        return {'volume': 1.0, 'intensity': 7.5};
      case ent.MesocyclePhase.intensification:
        return {'volume': 1.1, 'intensity': 8.5};
      case ent.MesocyclePhase.deload:
        return {'volume': 0.5, 'intensity': 5.5};
      case ent.MesocyclePhase.custom:
        return {'volume': 1.0, 'intensity': 7.0};
    }
  }

  String? _getSplitDayLabel(String splitType, int day) {
    final lower = splitType.toLowerCase();
    if (lower.contains('ppl')) {
      final labels = ['Push', 'Pull', 'Legs', 'Push', 'Pull', 'Legs'];
      if (day <= labels.length) return labels[day - 1];
    } else if (lower.contains('upper') || lower.contains('lower')) {
      return day % 2 == 1 ? 'Upper' : 'Lower';
    }
    return null;
  }
}
