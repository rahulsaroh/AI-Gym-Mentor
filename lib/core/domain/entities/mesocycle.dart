import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';

part 'mesocycle.freezed.dart';
part 'mesocycle.g.dart';

enum MesocycleGoal {
  hypertrophy,
  strength,
  fatLoss,
  generalFitness;

  String get label {
    switch (this) {
      case MesocycleGoal.hypertrophy: return 'Hypertrophy';
      case MesocycleGoal.strength: return 'Strength';
      case MesocycleGoal.fatLoss: return 'Fat Loss';
      case MesocycleGoal.generalFitness: return 'General Fitness';
    }
  }
}

enum MesocyclePhase {
  onRamp,
  accumulation,
  intensification,
  deload,
  custom;

  String get label {
    switch (this) {
      case MesocyclePhase.onRamp: return 'On-Ramp';
      case MesocyclePhase.accumulation: return 'Accumulation';
      case MesocyclePhase.intensification: return 'Intensification';
      case MesocyclePhase.deload: return 'Deload';
      case MesocyclePhase.custom: return 'Custom';
    }
  }
}

enum ProgressionType {
  none,
  load,
  reps,
  sets;

  String get label {
    switch (this) {
      case ProgressionType.none: return 'Standard';
      case ProgressionType.load: return 'Increase Load';
      case ProgressionType.reps: return 'Increase Reps';
      case ProgressionType.sets: return 'Increase Sets';
    }
  }
}

@freezed
abstract class MesocycleEntity with _$MesocycleEntity {
  const factory MesocycleEntity({
    required int id,
    required String name,
    required MesocycleGoal goal,
    required String splitType,
    required String experienceLevel,
    required int weeksCount,
    required int daysPerWeek,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? notes,
    @Default(false) bool isArchived,
    @Default([]) List<MesocycleWeekEntity> weeks,
  }) = _MesocycleEntity;

  factory MesocycleEntity.fromJson(Map<String, dynamic> json) => _$MesocycleEntityFromJson(json);
}

@freezed
abstract class MesocycleWeekEntity with _$MesocycleWeekEntity {
  const factory MesocycleWeekEntity({
    required int id,
    required int mesocycleId,
    required int weekNumber,
    required MesocyclePhase phaseName,
    @Default(1.0) double volumeMultiplier,
    @Default(1.0) double intensityMultiplier,
    String? notes,
    @Default([]) List<MesocycleDayEntity> days,
  }) = _MesocycleWeekEntity;

  factory MesocycleWeekEntity.fromJson(Map<String, dynamic> json) => _$MesocycleWeekEntityFromJson(json);
}

@freezed
abstract class MesocycleDayEntity with _$MesocycleDayEntity {
  const factory MesocycleDayEntity({
    required int id,
    required int mesocycleWeekId,
    required int dayNumber,
    required String title,
    String? splitLabel,
    @Default([]) List<MesocycleExerciseEntity> exercises,
  }) = _MesocycleDayEntity;

  factory MesocycleDayEntity.fromJson(Map<String, dynamic> json) => _$MesocycleDayEntityFromJson(json);
}

@freezed
abstract class MesocycleExerciseEntity with _$MesocycleExerciseEntity {
  const factory MesocycleExerciseEntity({
    required int id,
    required int mesocycleDayId,
    required ExerciseEntity exercise,
    required int exerciseOrder,
    required int targetSets,
    required int minReps,
    required int maxReps,
    double? targetRpe,
    @Default(ProgressionType.none) ProgressionType progressionType,
    double? progressionValue,
    String? notes,
  }) = _MesocycleExerciseEntity;

  factory MesocycleExerciseEntity.fromJson(Map<String, dynamic> json) => _$MesocycleExerciseEntityFromJson(json);
}
