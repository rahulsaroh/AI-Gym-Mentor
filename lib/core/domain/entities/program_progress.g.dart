// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProgramProgressEntity _$UserProgramProgressEntityFromJson(
  Map<String, dynamic> json,
) => _UserProgramProgressEntity(
  id: (json['id'] as num).toInt(),
  mesocycleId: (json['mesocycleId'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  currentPhaseIndex: (json['currentPhaseIndex'] as num?)?.toInt() ?? 0,
  isCompleted: json['isCompleted'] as bool? ?? false,
  lastPhaseAlertAt: json['lastPhaseAlertAt'] == null
      ? null
      : DateTime.parse(json['lastPhaseAlertAt'] as String),
);

Map<String, dynamic> _$UserProgramProgressEntityToJson(
  _UserProgramProgressEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'mesocycleId': instance.mesocycleId,
  'startDate': instance.startDate.toIso8601String(),
  'currentPhaseIndex': instance.currentPhaseIndex,
  'isCompleted': instance.isCompleted,
  'lastPhaseAlertAt': instance.lastPhaseAlertAt?.toIso8601String(),
};
