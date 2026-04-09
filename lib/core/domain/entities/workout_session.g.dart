// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutSessionImpl _$$WorkoutSessionImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutSessionImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      duration: (json['duration'] as num?)?.toInt(),
      templateId: (json['templateId'] as num?)?.toInt(),
      dayId: (json['dayId'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      status: json['status'] as String? ?? 'draft',
      exercises: (json['exercises'] as List<dynamic>?)
              ?.map((e) => LoggedExercise.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WorkoutSessionImplToJson(
        _$WorkoutSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date.toIso8601String(),
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'duration': instance.duration,
      'templateId': instance.templateId,
      'dayId': instance.dayId,
      'notes': instance.notes,
      'status': instance.status,
      'exercises': instance.exercises,
    };

_$LoggedExerciseImpl _$$LoggedExerciseImplFromJson(Map<String, dynamic> json) =>
    _$LoggedExerciseImpl(
      exerciseId: (json['exerciseId'] as num).toInt(),
      exerciseName: json['exerciseName'] as String,
      order: (json['order'] as num).toInt(),
      sets: (json['sets'] as List<dynamic>?)
              ?.map((e) => LoggedSet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LoggedExerciseImplToJson(
        _$LoggedExerciseImpl instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'exerciseName': instance.exerciseName,
      'order': instance.order,
      'sets': instance.sets,
    };
