// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_measurement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BodyMeasurement _$BodyMeasurementFromJson(Map<String, dynamic> json) {
  return _BodyMeasurement.fromJson(json);
}

/// @nodoc
mixin _$BodyMeasurement {
  int get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  double? get weight => throw _privateConstructorUsedError;
  double? get bodyFat => throw _privateConstructorUsedError;
  double? get neck => throw _privateConstructorUsedError;
  double? get chest => throw _privateConstructorUsedError;
  double? get shoulders => throw _privateConstructorUsedError;
  double? get armLeft => throw _privateConstructorUsedError;
  double? get armRight => throw _privateConstructorUsedError;
  double? get forearmLeft => throw _privateConstructorUsedError;
  double? get forearmRight => throw _privateConstructorUsedError;
  double? get waist => throw _privateConstructorUsedError;
  double? get hips => throw _privateConstructorUsedError;
  double? get thighLeft => throw _privateConstructorUsedError;
  double? get thighRight => throw _privateConstructorUsedError;
  double? get calfLeft => throw _privateConstructorUsedError;
  double? get calfRight => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this BodyMeasurement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BodyMeasurement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BodyMeasurementCopyWith<BodyMeasurement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BodyMeasurementCopyWith<$Res> {
  factory $BodyMeasurementCopyWith(
          BodyMeasurement value, $Res Function(BodyMeasurement) then) =
      _$BodyMeasurementCopyWithImpl<$Res, BodyMeasurement>;
  @useResult
  $Res call(
      {int id,
      DateTime date,
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
      String? notes});
}

/// @nodoc
class _$BodyMeasurementCopyWithImpl<$Res, $Val extends BodyMeasurement>
    implements $BodyMeasurementCopyWith<$Res> {
  _$BodyMeasurementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BodyMeasurement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? weight = freezed,
    Object? bodyFat = freezed,
    Object? neck = freezed,
    Object? chest = freezed,
    Object? shoulders = freezed,
    Object? armLeft = freezed,
    Object? armRight = freezed,
    Object? forearmLeft = freezed,
    Object? forearmRight = freezed,
    Object? waist = freezed,
    Object? hips = freezed,
    Object? thighLeft = freezed,
    Object? thighRight = freezed,
    Object? calfLeft = freezed,
    Object? calfRight = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      bodyFat: freezed == bodyFat
          ? _value.bodyFat
          : bodyFat // ignore: cast_nullable_to_non_nullable
              as double?,
      neck: freezed == neck
          ? _value.neck
          : neck // ignore: cast_nullable_to_non_nullable
              as double?,
      chest: freezed == chest
          ? _value.chest
          : chest // ignore: cast_nullable_to_non_nullable
              as double?,
      shoulders: freezed == shoulders
          ? _value.shoulders
          : shoulders // ignore: cast_nullable_to_non_nullable
              as double?,
      armLeft: freezed == armLeft
          ? _value.armLeft
          : armLeft // ignore: cast_nullable_to_non_nullable
              as double?,
      armRight: freezed == armRight
          ? _value.armRight
          : armRight // ignore: cast_nullable_to_non_nullable
              as double?,
      forearmLeft: freezed == forearmLeft
          ? _value.forearmLeft
          : forearmLeft // ignore: cast_nullable_to_non_nullable
              as double?,
      forearmRight: freezed == forearmRight
          ? _value.forearmRight
          : forearmRight // ignore: cast_nullable_to_non_nullable
              as double?,
      waist: freezed == waist
          ? _value.waist
          : waist // ignore: cast_nullable_to_non_nullable
              as double?,
      hips: freezed == hips
          ? _value.hips
          : hips // ignore: cast_nullable_to_non_nullable
              as double?,
      thighLeft: freezed == thighLeft
          ? _value.thighLeft
          : thighLeft // ignore: cast_nullable_to_non_nullable
              as double?,
      thighRight: freezed == thighRight
          ? _value.thighRight
          : thighRight // ignore: cast_nullable_to_non_nullable
              as double?,
      calfLeft: freezed == calfLeft
          ? _value.calfLeft
          : calfLeft // ignore: cast_nullable_to_non_nullable
              as double?,
      calfRight: freezed == calfRight
          ? _value.calfRight
          : calfRight // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BodyMeasurementImplCopyWith<$Res>
    implements $BodyMeasurementCopyWith<$Res> {
  factory _$$BodyMeasurementImplCopyWith(_$BodyMeasurementImpl value,
          $Res Function(_$BodyMeasurementImpl) then) =
      __$$BodyMeasurementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime date,
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
      String? notes});
}

/// @nodoc
class __$$BodyMeasurementImplCopyWithImpl<$Res>
    extends _$BodyMeasurementCopyWithImpl<$Res, _$BodyMeasurementImpl>
    implements _$$BodyMeasurementImplCopyWith<$Res> {
  __$$BodyMeasurementImplCopyWithImpl(
      _$BodyMeasurementImpl _value, $Res Function(_$BodyMeasurementImpl) _then)
      : super(_value, _then);

  /// Create a copy of BodyMeasurement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? weight = freezed,
    Object? bodyFat = freezed,
    Object? neck = freezed,
    Object? chest = freezed,
    Object? shoulders = freezed,
    Object? armLeft = freezed,
    Object? armRight = freezed,
    Object? forearmLeft = freezed,
    Object? forearmRight = freezed,
    Object? waist = freezed,
    Object? hips = freezed,
    Object? thighLeft = freezed,
    Object? thighRight = freezed,
    Object? calfLeft = freezed,
    Object? calfRight = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$BodyMeasurementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      bodyFat: freezed == bodyFat
          ? _value.bodyFat
          : bodyFat // ignore: cast_nullable_to_non_nullable
              as double?,
      neck: freezed == neck
          ? _value.neck
          : neck // ignore: cast_nullable_to_non_nullable
              as double?,
      chest: freezed == chest
          ? _value.chest
          : chest // ignore: cast_nullable_to_non_nullable
              as double?,
      shoulders: freezed == shoulders
          ? _value.shoulders
          : shoulders // ignore: cast_nullable_to_non_nullable
              as double?,
      armLeft: freezed == armLeft
          ? _value.armLeft
          : armLeft // ignore: cast_nullable_to_non_nullable
              as double?,
      armRight: freezed == armRight
          ? _value.armRight
          : armRight // ignore: cast_nullable_to_non_nullable
              as double?,
      forearmLeft: freezed == forearmLeft
          ? _value.forearmLeft
          : forearmLeft // ignore: cast_nullable_to_non_nullable
              as double?,
      forearmRight: freezed == forearmRight
          ? _value.forearmRight
          : forearmRight // ignore: cast_nullable_to_non_nullable
              as double?,
      waist: freezed == waist
          ? _value.waist
          : waist // ignore: cast_nullable_to_non_nullable
              as double?,
      hips: freezed == hips
          ? _value.hips
          : hips // ignore: cast_nullable_to_non_nullable
              as double?,
      thighLeft: freezed == thighLeft
          ? _value.thighLeft
          : thighLeft // ignore: cast_nullable_to_non_nullable
              as double?,
      thighRight: freezed == thighRight
          ? _value.thighRight
          : thighRight // ignore: cast_nullable_to_non_nullable
              as double?,
      calfLeft: freezed == calfLeft
          ? _value.calfLeft
          : calfLeft // ignore: cast_nullable_to_non_nullable
              as double?,
      calfRight: freezed == calfRight
          ? _value.calfRight
          : calfRight // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BodyMeasurementImpl implements _BodyMeasurement {
  const _$BodyMeasurementImpl(
      {required this.id,
      required this.date,
      this.weight,
      this.bodyFat,
      this.neck,
      this.chest,
      this.shoulders,
      this.armLeft,
      this.armRight,
      this.forearmLeft,
      this.forearmRight,
      this.waist,
      this.hips,
      this.thighLeft,
      this.thighRight,
      this.calfLeft,
      this.calfRight,
      this.notes});

  factory _$BodyMeasurementImpl.fromJson(Map<String, dynamic> json) =>
      _$$BodyMeasurementImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime date;
  @override
  final double? weight;
  @override
  final double? bodyFat;
  @override
  final double? neck;
  @override
  final double? chest;
  @override
  final double? shoulders;
  @override
  final double? armLeft;
  @override
  final double? armRight;
  @override
  final double? forearmLeft;
  @override
  final double? forearmRight;
  @override
  final double? waist;
  @override
  final double? hips;
  @override
  final double? thighLeft;
  @override
  final double? thighRight;
  @override
  final double? calfLeft;
  @override
  final double? calfRight;
  @override
  final String? notes;

  @override
  String toString() {
    return 'BodyMeasurement(id: $id, date: $date, weight: $weight, bodyFat: $bodyFat, neck: $neck, chest: $chest, shoulders: $shoulders, armLeft: $armLeft, armRight: $armRight, forearmLeft: $forearmLeft, forearmRight: $forearmRight, waist: $waist, hips: $hips, thighLeft: $thighLeft, thighRight: $thighRight, calfLeft: $calfLeft, calfRight: $calfRight, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BodyMeasurementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.bodyFat, bodyFat) || other.bodyFat == bodyFat) &&
            (identical(other.neck, neck) || other.neck == neck) &&
            (identical(other.chest, chest) || other.chest == chest) &&
            (identical(other.shoulders, shoulders) ||
                other.shoulders == shoulders) &&
            (identical(other.armLeft, armLeft) || other.armLeft == armLeft) &&
            (identical(other.armRight, armRight) ||
                other.armRight == armRight) &&
            (identical(other.forearmLeft, forearmLeft) ||
                other.forearmLeft == forearmLeft) &&
            (identical(other.forearmRight, forearmRight) ||
                other.forearmRight == forearmRight) &&
            (identical(other.waist, waist) || other.waist == waist) &&
            (identical(other.hips, hips) || other.hips == hips) &&
            (identical(other.thighLeft, thighLeft) ||
                other.thighLeft == thighLeft) &&
            (identical(other.thighRight, thighRight) ||
                other.thighRight == thighRight) &&
            (identical(other.calfLeft, calfLeft) ||
                other.calfLeft == calfLeft) &&
            (identical(other.calfRight, calfRight) ||
                other.calfRight == calfRight) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      weight,
      bodyFat,
      neck,
      chest,
      shoulders,
      armLeft,
      armRight,
      forearmLeft,
      forearmRight,
      waist,
      hips,
      thighLeft,
      thighRight,
      calfLeft,
      calfRight,
      notes);

  /// Create a copy of BodyMeasurement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BodyMeasurementImplCopyWith<_$BodyMeasurementImpl> get copyWith =>
      __$$BodyMeasurementImplCopyWithImpl<_$BodyMeasurementImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BodyMeasurementImplToJson(
      this,
    );
  }
}

abstract class _BodyMeasurement implements BodyMeasurement {
  const factory _BodyMeasurement(
      {required final int id,
      required final DateTime date,
      final double? weight,
      final double? bodyFat,
      final double? neck,
      final double? chest,
      final double? shoulders,
      final double? armLeft,
      final double? armRight,
      final double? forearmLeft,
      final double? forearmRight,
      final double? waist,
      final double? hips,
      final double? thighLeft,
      final double? thighRight,
      final double? calfLeft,
      final double? calfRight,
      final String? notes}) = _$BodyMeasurementImpl;

  factory _BodyMeasurement.fromJson(Map<String, dynamic> json) =
      _$BodyMeasurementImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get date;
  @override
  double? get weight;
  @override
  double? get bodyFat;
  @override
  double? get neck;
  @override
  double? get chest;
  @override
  double? get shoulders;
  @override
  double? get armLeft;
  @override
  double? get armRight;
  @override
  double? get forearmLeft;
  @override
  double? get forearmRight;
  @override
  double? get waist;
  @override
  double? get hips;
  @override
  double? get thighLeft;
  @override
  double? get thighRight;
  @override
  double? get calfLeft;
  @override
  double? get calfRight;
  @override
  String? get notes;

  /// Create a copy of BodyMeasurement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BodyMeasurementImplCopyWith<_$BodyMeasurementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
