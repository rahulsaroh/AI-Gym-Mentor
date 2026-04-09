// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseImpl _$$ExerciseImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      category: json['category'] as String? ?? 'Strength',
      difficulty: json['difficulty'] as String? ?? 'Beginner',
      primaryMuscle: json['primaryMuscle'] as String? ?? '',
      secondaryMuscle: json['secondaryMuscle'] as String?,
      equipment: json['equipment'] as String? ?? 'Barbell',
      setType: json['setType'] as String? ?? 'Straight',
      restTime: (json['restTime'] as num?)?.toInt() ?? 90,
      instructions: (json['instructions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      gifUrl: json['gifUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      mechanic: json['mechanic'] as String?,
      force: json['force'] as String?,
      source: json['source'] as String? ?? 'local',
      isCustom: json['isCustom'] as bool? ?? false,
      lastUsed: json['lastUsed'] == null
          ? null
          : DateTime.parse(json['lastUsed'] as String),
    );

Map<String, dynamic> _$$ExerciseImplToJson(_$ExerciseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'difficulty': instance.difficulty,
      'primaryMuscle': instance.primaryMuscle,
      'secondaryMuscle': instance.secondaryMuscle,
      'equipment': instance.equipment,
      'setType': instance.setType,
      'restTime': instance.restTime,
      'instructions': instance.instructions,
      'gifUrl': instance.gifUrl,
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
      'mechanic': instance.mechanic,
      'force': instance.force,
      'source': instance.source,
      'isCustom': instance.isCustom,
      'lastUsed': instance.lastUsed?.toIso8601String(),
    };
