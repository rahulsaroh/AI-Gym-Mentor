// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mesocycle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MesocycleEntity _$MesocycleEntityFromJson(Map<String, dynamic> json) =>
    _MesocycleEntity(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      goal: $enumDecode(_$MesocycleGoalEnumMap, json['goal']),
      splitType: json['splitType'] as String,
      experienceLevel: json['experienceLevel'] as String,
      weeksCount: (json['weeksCount'] as num).toInt(),
      daysPerWeek: (json['daysPerWeek'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      notes: json['notes'] as String?,
      isArchived: json['isArchived'] as bool? ?? false,
      weeks:
          (json['weeks'] as List<dynamic>?)
              ?.map(
                (e) => MesocycleWeekEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MesocycleEntityToJson(_MesocycleEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'goal': _$MesocycleGoalEnumMap[instance.goal]!,
      'splitType': instance.splitType,
      'experienceLevel': instance.experienceLevel,
      'weeksCount': instance.weeksCount,
      'daysPerWeek': instance.daysPerWeek,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'notes': instance.notes,
      'isArchived': instance.isArchived,
      'weeks': instance.weeks,
    };

const _$MesocycleGoalEnumMap = {
  MesocycleGoal.hypertrophy: 'hypertrophy',
  MesocycleGoal.strength: 'strength',
  MesocycleGoal.fatLoss: 'fatLoss',
  MesocycleGoal.generalFitness: 'generalFitness',
};

_MesocycleWeekEntity _$MesocycleWeekEntityFromJson(
  Map<String, dynamic> json,
) => _MesocycleWeekEntity(
  id: (json['id'] as num).toInt(),
  mesocycleId: (json['mesocycleId'] as num).toInt(),
  weekNumber: (json['weekNumber'] as num).toInt(),
  phaseName: $enumDecode(_$MesocyclePhaseEnumMap, json['phaseName']),
  volumeMultiplier: (json['volumeMultiplier'] as num?)?.toDouble() ?? 1.0,
  intensityMultiplier: (json['intensityMultiplier'] as num?)?.toDouble() ?? 1.0,
  notes: json['notes'] as String?,
  days:
      (json['days'] as List<dynamic>?)
          ?.map((e) => MesocycleDayEntity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$MesocycleWeekEntityToJson(
  _MesocycleWeekEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'mesocycleId': instance.mesocycleId,
  'weekNumber': instance.weekNumber,
  'phaseName': _$MesocyclePhaseEnumMap[instance.phaseName]!,
  'volumeMultiplier': instance.volumeMultiplier,
  'intensityMultiplier': instance.intensityMultiplier,
  'notes': instance.notes,
  'days': instance.days,
};

const _$MesocyclePhaseEnumMap = {
  MesocyclePhase.onRamp: 'onRamp',
  MesocyclePhase.accumulation: 'accumulation',
  MesocyclePhase.intensification: 'intensification',
  MesocyclePhase.deload: 'deload',
  MesocyclePhase.custom: 'custom',
};

_MesocycleDayEntity _$MesocycleDayEntityFromJson(Map<String, dynamic> json) =>
    _MesocycleDayEntity(
      id: (json['id'] as num).toInt(),
      mesocycleWeekId: (json['mesocycleWeekId'] as num).toInt(),
      dayNumber: (json['dayNumber'] as num).toInt(),
      title: json['title'] as String,
      splitLabel: json['splitLabel'] as String?,
      exercises:
          (json['exercises'] as List<dynamic>?)
              ?.map(
                (e) =>
                    MesocycleExerciseEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MesocycleDayEntityToJson(_MesocycleDayEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mesocycleWeekId': instance.mesocycleWeekId,
      'dayNumber': instance.dayNumber,
      'title': instance.title,
      'splitLabel': instance.splitLabel,
      'exercises': instance.exercises,
    };

_MesocycleExerciseEntity _$MesocycleExerciseEntityFromJson(
  Map<String, dynamic> json,
) => _MesocycleExerciseEntity(
  id: (json['id'] as num).toInt(),
  mesocycleDayId: (json['mesocycleDayId'] as num).toInt(),
  exercise: ExerciseEntity.fromJson(json['exercise'] as Map<String, dynamic>),
  exerciseOrder: (json['exerciseOrder'] as num).toInt(),
  targetSets: (json['targetSets'] as num).toInt(),
  minReps: (json['minReps'] as num).toInt(),
  maxReps: (json['maxReps'] as num).toInt(),
  targetRpe: (json['targetRpe'] as num?)?.toDouble(),
  progressionType:
      $enumDecodeNullable(_$ProgressionTypeEnumMap, json['progressionType']) ??
      ProgressionType.none,
  progressionValue: (json['progressionValue'] as num?)?.toDouble(),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$MesocycleExerciseEntityToJson(
  _MesocycleExerciseEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'mesocycleDayId': instance.mesocycleDayId,
  'exercise': instance.exercise,
  'exerciseOrder': instance.exerciseOrder,
  'targetSets': instance.targetSets,
  'minReps': instance.minReps,
  'maxReps': instance.maxReps,
  'targetRpe': instance.targetRpe,
  'progressionType': _$ProgressionTypeEnumMap[instance.progressionType]!,
  'progressionValue': instance.progressionValue,
  'notes': instance.notes,
};

const _$ProgressionTypeEnumMap = {
  ProgressionType.none: 'none',
  ProgressionType.load: 'load',
  ProgressionType.reps: 'reps',
  ProgressionType.sets: 'sets',
};
