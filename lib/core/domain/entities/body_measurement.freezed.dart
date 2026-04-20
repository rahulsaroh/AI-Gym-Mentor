// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_measurement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BodyMeasurement {

 int get id; DateTime get date; double? get weight; double? get bodyFat; double? get neck; double? get chest; double? get shoulders; double? get armLeft; double? get armRight; double? get forearmLeft; double? get forearmRight; double? get waist; double? get hips; double? get thighLeft; double? get thighRight; double? get calfLeft; double? get calfRight; double? get height; Map<String, double>? get customValues; String? get notes;
/// Create a copy of BodyMeasurement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyMeasurementCopyWith<BodyMeasurement> get copyWith => _$BodyMeasurementCopyWithImpl<BodyMeasurement>(this as BodyMeasurement, _$identity);

  /// Serializes this BodyMeasurement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyMeasurement&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.bodyFat, bodyFat) || other.bodyFat == bodyFat)&&(identical(other.neck, neck) || other.neck == neck)&&(identical(other.chest, chest) || other.chest == chest)&&(identical(other.shoulders, shoulders) || other.shoulders == shoulders)&&(identical(other.armLeft, armLeft) || other.armLeft == armLeft)&&(identical(other.armRight, armRight) || other.armRight == armRight)&&(identical(other.forearmLeft, forearmLeft) || other.forearmLeft == forearmLeft)&&(identical(other.forearmRight, forearmRight) || other.forearmRight == forearmRight)&&(identical(other.waist, waist) || other.waist == waist)&&(identical(other.hips, hips) || other.hips == hips)&&(identical(other.thighLeft, thighLeft) || other.thighLeft == thighLeft)&&(identical(other.thighRight, thighRight) || other.thighRight == thighRight)&&(identical(other.calfLeft, calfLeft) || other.calfLeft == calfLeft)&&(identical(other.calfRight, calfRight) || other.calfRight == calfRight)&&(identical(other.height, height) || other.height == height)&&const DeepCollectionEquality().equals(other.customValues, customValues)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,date,weight,bodyFat,neck,chest,shoulders,armLeft,armRight,forearmLeft,forearmRight,waist,hips,thighLeft,thighRight,calfLeft,calfRight,height,const DeepCollectionEquality().hash(customValues),notes]);

@override
String toString() {
  return 'BodyMeasurement(id: $id, date: $date, weight: $weight, bodyFat: $bodyFat, neck: $neck, chest: $chest, shoulders: $shoulders, armLeft: $armLeft, armRight: $armRight, forearmLeft: $forearmLeft, forearmRight: $forearmRight, waist: $waist, hips: $hips, thighLeft: $thighLeft, thighRight: $thighRight, calfLeft: $calfLeft, calfRight: $calfRight, height: $height, customValues: $customValues, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $BodyMeasurementCopyWith<$Res>  {
  factory $BodyMeasurementCopyWith(BodyMeasurement value, $Res Function(BodyMeasurement) _then) = _$BodyMeasurementCopyWithImpl;
@useResult
$Res call({
 int id, DateTime date, double? weight, double? bodyFat, double? neck, double? chest, double? shoulders, double? armLeft, double? armRight, double? forearmLeft, double? forearmRight, double? waist, double? hips, double? thighLeft, double? thighRight, double? calfLeft, double? calfRight, double? height, Map<String, double>? customValues, String? notes
});




}
/// @nodoc
class _$BodyMeasurementCopyWithImpl<$Res>
    implements $BodyMeasurementCopyWith<$Res> {
  _$BodyMeasurementCopyWithImpl(this._self, this._then);

  final BodyMeasurement _self;
  final $Res Function(BodyMeasurement) _then;

/// Create a copy of BodyMeasurement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? weight = freezed,Object? bodyFat = freezed,Object? neck = freezed,Object? chest = freezed,Object? shoulders = freezed,Object? armLeft = freezed,Object? armRight = freezed,Object? forearmLeft = freezed,Object? forearmRight = freezed,Object? waist = freezed,Object? hips = freezed,Object? thighLeft = freezed,Object? thighRight = freezed,Object? calfLeft = freezed,Object? calfRight = freezed,Object? height = freezed,Object? customValues = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,bodyFat: freezed == bodyFat ? _self.bodyFat : bodyFat // ignore: cast_nullable_to_non_nullable
as double?,neck: freezed == neck ? _self.neck : neck // ignore: cast_nullable_to_non_nullable
as double?,chest: freezed == chest ? _self.chest : chest // ignore: cast_nullable_to_non_nullable
as double?,shoulders: freezed == shoulders ? _self.shoulders : shoulders // ignore: cast_nullable_to_non_nullable
as double?,armLeft: freezed == armLeft ? _self.armLeft : armLeft // ignore: cast_nullable_to_non_nullable
as double?,armRight: freezed == armRight ? _self.armRight : armRight // ignore: cast_nullable_to_non_nullable
as double?,forearmLeft: freezed == forearmLeft ? _self.forearmLeft : forearmLeft // ignore: cast_nullable_to_non_nullable
as double?,forearmRight: freezed == forearmRight ? _self.forearmRight : forearmRight // ignore: cast_nullable_to_non_nullable
as double?,waist: freezed == waist ? _self.waist : waist // ignore: cast_nullable_to_non_nullable
as double?,hips: freezed == hips ? _self.hips : hips // ignore: cast_nullable_to_non_nullable
as double?,thighLeft: freezed == thighLeft ? _self.thighLeft : thighLeft // ignore: cast_nullable_to_non_nullable
as double?,thighRight: freezed == thighRight ? _self.thighRight : thighRight // ignore: cast_nullable_to_non_nullable
as double?,calfLeft: freezed == calfLeft ? _self.calfLeft : calfLeft // ignore: cast_nullable_to_non_nullable
as double?,calfRight: freezed == calfRight ? _self.calfRight : calfRight // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,customValues: freezed == customValues ? _self.customValues : customValues // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyMeasurement].
extension BodyMeasurementPatterns on BodyMeasurement {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyMeasurement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyMeasurement() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyMeasurement value)  $default,){
final _that = this;
switch (_that) {
case _BodyMeasurement():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyMeasurement value)?  $default,){
final _that = this;
switch (_that) {
case _BodyMeasurement() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime date,  double? weight,  double? bodyFat,  double? neck,  double? chest,  double? shoulders,  double? armLeft,  double? armRight,  double? forearmLeft,  double? forearmRight,  double? waist,  double? hips,  double? thighLeft,  double? thighRight,  double? calfLeft,  double? calfRight,  double? height,  Map<String, double>? customValues,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyMeasurement() when $default != null:
return $default(_that.id,_that.date,_that.weight,_that.bodyFat,_that.neck,_that.chest,_that.shoulders,_that.armLeft,_that.armRight,_that.forearmLeft,_that.forearmRight,_that.waist,_that.hips,_that.thighLeft,_that.thighRight,_that.calfLeft,_that.calfRight,_that.height,_that.customValues,_that.notes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime date,  double? weight,  double? bodyFat,  double? neck,  double? chest,  double? shoulders,  double? armLeft,  double? armRight,  double? forearmLeft,  double? forearmRight,  double? waist,  double? hips,  double? thighLeft,  double? thighRight,  double? calfLeft,  double? calfRight,  double? height,  Map<String, double>? customValues,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _BodyMeasurement():
return $default(_that.id,_that.date,_that.weight,_that.bodyFat,_that.neck,_that.chest,_that.shoulders,_that.armLeft,_that.armRight,_that.forearmLeft,_that.forearmRight,_that.waist,_that.hips,_that.thighLeft,_that.thighRight,_that.calfLeft,_that.calfRight,_that.height,_that.customValues,_that.notes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime date,  double? weight,  double? bodyFat,  double? neck,  double? chest,  double? shoulders,  double? armLeft,  double? armRight,  double? forearmLeft,  double? forearmRight,  double? waist,  double? hips,  double? thighLeft,  double? thighRight,  double? calfLeft,  double? calfRight,  double? height,  Map<String, double>? customValues,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _BodyMeasurement() when $default != null:
return $default(_that.id,_that.date,_that.weight,_that.bodyFat,_that.neck,_that.chest,_that.shoulders,_that.armLeft,_that.armRight,_that.forearmLeft,_that.forearmRight,_that.waist,_that.hips,_that.thighLeft,_that.thighRight,_that.calfLeft,_that.calfRight,_that.height,_that.customValues,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BodyMeasurement extends BodyMeasurement {
  const _BodyMeasurement({required this.id, required this.date, this.weight, this.bodyFat, this.neck, this.chest, this.shoulders, this.armLeft, this.armRight, this.forearmLeft, this.forearmRight, this.waist, this.hips, this.thighLeft, this.thighRight, this.calfLeft, this.calfRight, this.height, final  Map<String, double>? customValues, this.notes}): _customValues = customValues,super._();
  factory _BodyMeasurement.fromJson(Map<String, dynamic> json) => _$BodyMeasurementFromJson(json);

@override final  int id;
@override final  DateTime date;
@override final  double? weight;
@override final  double? bodyFat;
@override final  double? neck;
@override final  double? chest;
@override final  double? shoulders;
@override final  double? armLeft;
@override final  double? armRight;
@override final  double? forearmLeft;
@override final  double? forearmRight;
@override final  double? waist;
@override final  double? hips;
@override final  double? thighLeft;
@override final  double? thighRight;
@override final  double? calfLeft;
@override final  double? calfRight;
@override final  double? height;
 final  Map<String, double>? _customValues;
@override Map<String, double>? get customValues {
  final value = _customValues;
  if (value == null) return null;
  if (_customValues is EqualUnmodifiableMapView) return _customValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? notes;

/// Create a copy of BodyMeasurement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyMeasurementCopyWith<_BodyMeasurement> get copyWith => __$BodyMeasurementCopyWithImpl<_BodyMeasurement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BodyMeasurementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyMeasurement&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.bodyFat, bodyFat) || other.bodyFat == bodyFat)&&(identical(other.neck, neck) || other.neck == neck)&&(identical(other.chest, chest) || other.chest == chest)&&(identical(other.shoulders, shoulders) || other.shoulders == shoulders)&&(identical(other.armLeft, armLeft) || other.armLeft == armLeft)&&(identical(other.armRight, armRight) || other.armRight == armRight)&&(identical(other.forearmLeft, forearmLeft) || other.forearmLeft == forearmLeft)&&(identical(other.forearmRight, forearmRight) || other.forearmRight == forearmRight)&&(identical(other.waist, waist) || other.waist == waist)&&(identical(other.hips, hips) || other.hips == hips)&&(identical(other.thighLeft, thighLeft) || other.thighLeft == thighLeft)&&(identical(other.thighRight, thighRight) || other.thighRight == thighRight)&&(identical(other.calfLeft, calfLeft) || other.calfLeft == calfLeft)&&(identical(other.calfRight, calfRight) || other.calfRight == calfRight)&&(identical(other.height, height) || other.height == height)&&const DeepCollectionEquality().equals(other._customValues, _customValues)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,date,weight,bodyFat,neck,chest,shoulders,armLeft,armRight,forearmLeft,forearmRight,waist,hips,thighLeft,thighRight,calfLeft,calfRight,height,const DeepCollectionEquality().hash(_customValues),notes]);

@override
String toString() {
  return 'BodyMeasurement(id: $id, date: $date, weight: $weight, bodyFat: $bodyFat, neck: $neck, chest: $chest, shoulders: $shoulders, armLeft: $armLeft, armRight: $armRight, forearmLeft: $forearmLeft, forearmRight: $forearmRight, waist: $waist, hips: $hips, thighLeft: $thighLeft, thighRight: $thighRight, calfLeft: $calfLeft, calfRight: $calfRight, height: $height, customValues: $customValues, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$BodyMeasurementCopyWith<$Res> implements $BodyMeasurementCopyWith<$Res> {
  factory _$BodyMeasurementCopyWith(_BodyMeasurement value, $Res Function(_BodyMeasurement) _then) = __$BodyMeasurementCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime date, double? weight, double? bodyFat, double? neck, double? chest, double? shoulders, double? armLeft, double? armRight, double? forearmLeft, double? forearmRight, double? waist, double? hips, double? thighLeft, double? thighRight, double? calfLeft, double? calfRight, double? height, Map<String, double>? customValues, String? notes
});




}
/// @nodoc
class __$BodyMeasurementCopyWithImpl<$Res>
    implements _$BodyMeasurementCopyWith<$Res> {
  __$BodyMeasurementCopyWithImpl(this._self, this._then);

  final _BodyMeasurement _self;
  final $Res Function(_BodyMeasurement) _then;

/// Create a copy of BodyMeasurement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? weight = freezed,Object? bodyFat = freezed,Object? neck = freezed,Object? chest = freezed,Object? shoulders = freezed,Object? armLeft = freezed,Object? armRight = freezed,Object? forearmLeft = freezed,Object? forearmRight = freezed,Object? waist = freezed,Object? hips = freezed,Object? thighLeft = freezed,Object? thighRight = freezed,Object? calfLeft = freezed,Object? calfRight = freezed,Object? height = freezed,Object? customValues = freezed,Object? notes = freezed,}) {
  return _then(_BodyMeasurement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,bodyFat: freezed == bodyFat ? _self.bodyFat : bodyFat // ignore: cast_nullable_to_non_nullable
as double?,neck: freezed == neck ? _self.neck : neck // ignore: cast_nullable_to_non_nullable
as double?,chest: freezed == chest ? _self.chest : chest // ignore: cast_nullable_to_non_nullable
as double?,shoulders: freezed == shoulders ? _self.shoulders : shoulders // ignore: cast_nullable_to_non_nullable
as double?,armLeft: freezed == armLeft ? _self.armLeft : armLeft // ignore: cast_nullable_to_non_nullable
as double?,armRight: freezed == armRight ? _self.armRight : armRight // ignore: cast_nullable_to_non_nullable
as double?,forearmLeft: freezed == forearmLeft ? _self.forearmLeft : forearmLeft // ignore: cast_nullable_to_non_nullable
as double?,forearmRight: freezed == forearmRight ? _self.forearmRight : forearmRight // ignore: cast_nullable_to_non_nullable
as double?,waist: freezed == waist ? _self.waist : waist // ignore: cast_nullable_to_non_nullable
as double?,hips: freezed == hips ? _self.hips : hips // ignore: cast_nullable_to_non_nullable
as double?,thighLeft: freezed == thighLeft ? _self.thighLeft : thighLeft // ignore: cast_nullable_to_non_nullable
as double?,thighRight: freezed == thighRight ? _self.thighRight : thighRight // ignore: cast_nullable_to_non_nullable
as double?,calfLeft: freezed == calfLeft ? _self.calfLeft : calfLeft // ignore: cast_nullable_to_non_nullable
as double?,calfRight: freezed == calfRight ? _self.calfRight : calfRight // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,customValues: freezed == customValues ? _self._customValues : customValues // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
