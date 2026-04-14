// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_target.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BodyTarget _$BodyTargetFromJson(Map<String, dynamic> json) => _BodyTarget(
      id: (json['id'] as num).toInt(),
      metric: json['metric'] as String,
      targetValue: (json['targetValue'] as num).toDouble(),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$BodyTargetToJson(_BodyTarget instance) =>
    <String, dynamic>{
      'id': instance.id,
      'metric': instance.metric,
      'targetValue': instance.targetValue,
      'deadline': instance.deadline?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
