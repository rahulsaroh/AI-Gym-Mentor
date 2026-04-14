// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressPhoto _$ProgressPhotoFromJson(Map<String, dynamic> json) =>
    _ProgressPhoto(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      imagePath: json['imagePath'] as String,
      category: json['category'] as String? ?? 'front',
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ProgressPhotoToJson(_ProgressPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'imagePath': instance.imagePath,
      'category': instance.category,
      'notes': instance.notes,
    };
