// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'program_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProgramProgressEntity {

 int get id; int get mesocycleId; DateTime get startDate; int get currentPhaseIndex; bool get isCompleted; DateTime? get lastPhaseAlertAt;
/// Create a copy of UserProgramProgressEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProgramProgressEntityCopyWith<UserProgramProgressEntity> get copyWith => _$UserProgramProgressEntityCopyWithImpl<UserProgramProgressEntity>(this as UserProgramProgressEntity, _$identity);

  /// Serializes this UserProgramProgressEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProgramProgressEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.mesocycleId, mesocycleId) || other.mesocycleId == mesocycleId)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.currentPhaseIndex, currentPhaseIndex) || other.currentPhaseIndex == currentPhaseIndex)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.lastPhaseAlertAt, lastPhaseAlertAt) || other.lastPhaseAlertAt == lastPhaseAlertAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mesocycleId,startDate,currentPhaseIndex,isCompleted,lastPhaseAlertAt);

@override
String toString() {
  return 'UserProgramProgressEntity(id: $id, mesocycleId: $mesocycleId, startDate: $startDate, currentPhaseIndex: $currentPhaseIndex, isCompleted: $isCompleted, lastPhaseAlertAt: $lastPhaseAlertAt)';
}


}

/// @nodoc
abstract mixin class $UserProgramProgressEntityCopyWith<$Res>  {
  factory $UserProgramProgressEntityCopyWith(UserProgramProgressEntity value, $Res Function(UserProgramProgressEntity) _then) = _$UserProgramProgressEntityCopyWithImpl;
@useResult
$Res call({
 int id, int mesocycleId, DateTime startDate, int currentPhaseIndex, bool isCompleted, DateTime? lastPhaseAlertAt
});




}
/// @nodoc
class _$UserProgramProgressEntityCopyWithImpl<$Res>
    implements $UserProgramProgressEntityCopyWith<$Res> {
  _$UserProgramProgressEntityCopyWithImpl(this._self, this._then);

  final UserProgramProgressEntity _self;
  final $Res Function(UserProgramProgressEntity) _then;

/// Create a copy of UserProgramProgressEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mesocycleId = null,Object? startDate = null,Object? currentPhaseIndex = null,Object? isCompleted = null,Object? lastPhaseAlertAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,mesocycleId: null == mesocycleId ? _self.mesocycleId : mesocycleId // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,currentPhaseIndex: null == currentPhaseIndex ? _self.currentPhaseIndex : currentPhaseIndex // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,lastPhaseAlertAt: freezed == lastPhaseAlertAt ? _self.lastPhaseAlertAt : lastPhaseAlertAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProgramProgressEntity].
extension UserProgramProgressEntityPatterns on UserProgramProgressEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProgramProgressEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProgramProgressEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProgramProgressEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserProgramProgressEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProgramProgressEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserProgramProgressEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int mesocycleId,  DateTime startDate,  int currentPhaseIndex,  bool isCompleted,  DateTime? lastPhaseAlertAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProgramProgressEntity() when $default != null:
return $default(_that.id,_that.mesocycleId,_that.startDate,_that.currentPhaseIndex,_that.isCompleted,_that.lastPhaseAlertAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int mesocycleId,  DateTime startDate,  int currentPhaseIndex,  bool isCompleted,  DateTime? lastPhaseAlertAt)  $default,) {final _that = this;
switch (_that) {
case _UserProgramProgressEntity():
return $default(_that.id,_that.mesocycleId,_that.startDate,_that.currentPhaseIndex,_that.isCompleted,_that.lastPhaseAlertAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int mesocycleId,  DateTime startDate,  int currentPhaseIndex,  bool isCompleted,  DateTime? lastPhaseAlertAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProgramProgressEntity() when $default != null:
return $default(_that.id,_that.mesocycleId,_that.startDate,_that.currentPhaseIndex,_that.isCompleted,_that.lastPhaseAlertAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProgramProgressEntity implements UserProgramProgressEntity {
  const _UserProgramProgressEntity({required this.id, required this.mesocycleId, required this.startDate, this.currentPhaseIndex = 0, this.isCompleted = false, this.lastPhaseAlertAt});
  factory _UserProgramProgressEntity.fromJson(Map<String, dynamic> json) => _$UserProgramProgressEntityFromJson(json);

@override final  int id;
@override final  int mesocycleId;
@override final  DateTime startDate;
@override@JsonKey() final  int currentPhaseIndex;
@override@JsonKey() final  bool isCompleted;
@override final  DateTime? lastPhaseAlertAt;

/// Create a copy of UserProgramProgressEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProgramProgressEntityCopyWith<_UserProgramProgressEntity> get copyWith => __$UserProgramProgressEntityCopyWithImpl<_UserProgramProgressEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProgramProgressEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProgramProgressEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.mesocycleId, mesocycleId) || other.mesocycleId == mesocycleId)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.currentPhaseIndex, currentPhaseIndex) || other.currentPhaseIndex == currentPhaseIndex)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.lastPhaseAlertAt, lastPhaseAlertAt) || other.lastPhaseAlertAt == lastPhaseAlertAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mesocycleId,startDate,currentPhaseIndex,isCompleted,lastPhaseAlertAt);

@override
String toString() {
  return 'UserProgramProgressEntity(id: $id, mesocycleId: $mesocycleId, startDate: $startDate, currentPhaseIndex: $currentPhaseIndex, isCompleted: $isCompleted, lastPhaseAlertAt: $lastPhaseAlertAt)';
}


}

/// @nodoc
abstract mixin class _$UserProgramProgressEntityCopyWith<$Res> implements $UserProgramProgressEntityCopyWith<$Res> {
  factory _$UserProgramProgressEntityCopyWith(_UserProgramProgressEntity value, $Res Function(_UserProgramProgressEntity) _then) = __$UserProgramProgressEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int mesocycleId, DateTime startDate, int currentPhaseIndex, bool isCompleted, DateTime? lastPhaseAlertAt
});




}
/// @nodoc
class __$UserProgramProgressEntityCopyWithImpl<$Res>
    implements _$UserProgramProgressEntityCopyWith<$Res> {
  __$UserProgramProgressEntityCopyWithImpl(this._self, this._then);

  final _UserProgramProgressEntity _self;
  final $Res Function(_UserProgramProgressEntity) _then;

/// Create a copy of UserProgramProgressEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mesocycleId = null,Object? startDate = null,Object? currentPhaseIndex = null,Object? isCompleted = null,Object? lastPhaseAlertAt = freezed,}) {
  return _then(_UserProgramProgressEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,mesocycleId: null == mesocycleId ? _self.mesocycleId : mesocycleId // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,currentPhaseIndex: null == currentPhaseIndex ? _self.currentPhaseIndex : currentPhaseIndex // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,lastPhaseAlertAt: freezed == lastPhaseAlertAt ? _self.lastPhaseAlertAt : lastPhaseAlertAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
