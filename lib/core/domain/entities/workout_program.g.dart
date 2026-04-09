// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutProgramImpl _$$WorkoutProgramImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutProgramImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      lastUsed: json['lastUsed'] == null
          ? null
          : DateTime.parse(json['lastUsed'] as String),
      days: (json['days'] as List<dynamic>?)
              ?.map((e) => ProgramDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WorkoutProgramImplToJson(
        _$WorkoutProgramImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'lastUsed': instance.lastUsed?.toIso8601String(),
      'days': instance.days,
    };

_$ProgramDayImpl _$$ProgramDayImplFromJson(Map<String, dynamic> json) =>
    _$ProgramDayImpl(
      id: (json['id'] as num).toInt(),
      templateId: (json['templateId'] as num).toInt(),
      name: json['name'] as String,
      order: (json['order'] as num).toInt(),
      exercises: (json['exercises'] as List<dynamic>?)
              ?.map((e) => ProgramExercise.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ProgramDayImplToJson(_$ProgramDayImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'templateId': instance.templateId,
      'name': instance.name,
      'order': instance.order,
      'exercises': instance.exercises,
    };

_$ProgramExerciseImpl _$$ProgramExerciseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProgramExerciseImpl(
      id: (json['id'] as num).toInt(),
      dayId: (json['dayId'] as num).toInt(),
      exercise: Exercise.fromJson(json['exercise'] as Map<String, dynamic>),
      order: (json['order'] as num).toInt(),
      setType: json['setType'] as String? ?? 'Straight',
      setsJson: json['setsJson'] as String? ?? '[]',
      restTime: (json['restTime'] as num?)?.toInt() ?? 90,
      notes: json['notes'] as String?,
      supersetGroupId: json['supersetGroupId'] as String?,
    );

Map<String, dynamic> _$$ProgramExerciseImplToJson(
        _$ProgramExerciseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dayId': instance.dayId,
      'exercise': instance.exercise,
      'order': instance.order,
      'setType': instance.setType,
      'setsJson': instance.setsJson,
      'restTime': instance.restTime,
      'notes': instance.notes,
      'supersetGroupId': instance.supersetGroupId,
    };
