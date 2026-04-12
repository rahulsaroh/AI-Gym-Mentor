// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BodyMeasurement _$BodyMeasurementFromJson(Map<String, dynamic> json) =>
    _BodyMeasurement(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      weight: (json['weight'] as num?)?.toDouble(),
      bodyFat: (json['bodyFat'] as num?)?.toDouble(),
      neck: (json['neck'] as num?)?.toDouble(),
      chest: (json['chest'] as num?)?.toDouble(),
      shoulders: (json['shoulders'] as num?)?.toDouble(),
      armLeft: (json['armLeft'] as num?)?.toDouble(),
      armRight: (json['armRight'] as num?)?.toDouble(),
      forearmLeft: (json['forearmLeft'] as num?)?.toDouble(),
      forearmRight: (json['forearmRight'] as num?)?.toDouble(),
      waist: (json['waist'] as num?)?.toDouble(),
      hips: (json['hips'] as num?)?.toDouble(),
      thighLeft: (json['thighLeft'] as num?)?.toDouble(),
      thighRight: (json['thighRight'] as num?)?.toDouble(),
      calfLeft: (json['calfLeft'] as num?)?.toDouble(),
      calfRight: (json['calfRight'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$BodyMeasurementToJson(_BodyMeasurement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'weight': instance.weight,
      'bodyFat': instance.bodyFat,
      'neck': instance.neck,
      'chest': instance.chest,
      'shoulders': instance.shoulders,
      'armLeft': instance.armLeft,
      'armRight': instance.armRight,
      'forearmLeft': instance.forearmLeft,
      'forearmRight': instance.forearmRight,
      'waist': instance.waist,
      'hips': instance.hips,
      'thighLeft': instance.thighLeft,
      'thighRight': instance.thighRight,
      'calfLeft': instance.calfLeft,
      'calfRight': instance.calfRight,
      'notes': instance.notes,
    };
