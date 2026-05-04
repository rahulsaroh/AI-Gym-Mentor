// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoggedSet _$LoggedSetFromJson(Map<String, dynamic> json) => _LoggedSet(
  id: (json['id'] as num).toInt(),
  workoutId: (json['workoutId'] as num).toInt(),
  exerciseId: (json['exerciseId'] as num).toInt(),
  exerciseOrder: (json['exerciseOrder'] as num).toInt(),
  setNumber: (json['setNumber'] as num).toInt(),
  weight: (json['weight'] as num).toDouble(),
  reps: (json['reps'] as num).toDouble(),
  rpe: (json['rpe'] as num?)?.toDouble(),
  rir: (json['rir'] as num?)?.toInt(),
  setType:
      $enumDecodeNullable(_$SetTypeEnumMap, json['setType']) ??
      SetType.straight,
  notes: json['notes'] as String?,
  completed: json['completed'] as bool? ?? false,
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  isPr: json['isPr'] as bool? ?? false,
  supersetGroupId: json['supersetGroupId'] as String?,
);

Map<String, dynamic> _$LoggedSetToJson(_LoggedSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workoutId': instance.workoutId,
      'exerciseId': instance.exerciseId,
      'exerciseOrder': instance.exerciseOrder,
      'setNumber': instance.setNumber,
      'weight': instance.weight,
      'reps': instance.reps,
      'rpe': instance.rpe,
      'rir': instance.rir,
      'setType': _$SetTypeEnumMap[instance.setType]!,
      'notes': instance.notes,
      'completed': instance.completed,
      'completedAt': instance.completedAt?.toIso8601String(),
      'isPr': instance.isPr,
      'supersetGroupId': instance.supersetGroupId,
    };

const _$SetTypeEnumMap = {
  SetType.straight: 'straight',
  SetType.warmup: 'warmup',
  SetType.superset: 'superset',
  SetType.dropSet: 'dropSet',
  SetType.amrap: 'amrap',
  SetType.timed: 'timed',
  SetType.restPause: 'restPause',
  SetType.cluster: 'cluster',
};
