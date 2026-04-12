import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_measurement.freezed.dart';
part 'body_measurement.g.dart';

@freezed
abstract class BodyMeasurement with _$BodyMeasurement {
  const BodyMeasurement._();

  const factory BodyMeasurement({
    required int id,
    required DateTime date,
    double? weight,
    double? bodyFat,
    double? neck,
    double? chest,
    double? shoulders,
    double? armLeft,
    double? armRight,
    double? forearmLeft,
    double? forearmRight,
    double? waist,
    double? hips,
    double? thighLeft,
    double? thighRight,
    double? calfLeft,
    double? calfRight,
    String? notes,
  }) = _BodyMeasurement;

  factory BodyMeasurement.fromJson(Map<String, dynamic> json) => _$BodyMeasurementFromJson(json);
}
