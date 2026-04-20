// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mesocycle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MesocycleEntity {

 int get id; String get name; MesocycleGoal get goal; String get splitType; String get experienceLevel; int get weeksCount; int get daysPerWeek; DateTime get createdAt; DateTime get updatedAt; String? get notes; bool get isArchived; List<MesocycleWeekEntity> get weeks;
/// Create a copy of MesocycleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MesocycleEntityCopyWith<MesocycleEntity> get copyWith => _$MesocycleEntityCopyWithImpl<MesocycleEntity>(this as MesocycleEntity, _$identity);

  /// Serializes this MesocycleEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MesocycleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.weeksCount, weeksCount) || other.weeksCount == weeksCount)&&(identical(other.daysPerWeek, daysPerWeek) || other.daysPerWeek == daysPerWeek)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&const DeepCollectionEquality().equals(other.weeks, weeks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,goal,splitType,experienceLevel,weeksCount,daysPerWeek,createdAt,updatedAt,notes,isArchived,const DeepCollectionEquality().hash(weeks));

@override
String toString() {
  return 'MesocycleEntity(id: $id, name: $name, goal: $goal, splitType: $splitType, experienceLevel: $experienceLevel, weeksCount: $weeksCount, daysPerWeek: $daysPerWeek, createdAt: $createdAt, updatedAt: $updatedAt, notes: $notes, isArchived: $isArchived, weeks: $weeks)';
}


}

/// @nodoc
abstract mixin class $MesocycleEntityCopyWith<$Res>  {
  factory $MesocycleEntityCopyWith(MesocycleEntity value, $Res Function(MesocycleEntity) _then) = _$MesocycleEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, MesocycleGoal goal, String splitType, String experienceLevel, int weeksCount, int daysPerWeek, DateTime createdAt, DateTime updatedAt, String? notes, bool isArchived, List<MesocycleWeekEntity> weeks
});




}
/// @nodoc
class _$MesocycleEntityCopyWithImpl<$Res>
    implements $MesocycleEntityCopyWith<$Res> {
  _$MesocycleEntityCopyWithImpl(this._self, this._then);

  final MesocycleEntity _self;
  final $Res Function(MesocycleEntity) _then;

/// Create a copy of MesocycleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? goal = null,Object? splitType = null,Object? experienceLevel = null,Object? weeksCount = null,Object? daysPerWeek = null,Object? createdAt = null,Object? updatedAt = null,Object? notes = freezed,Object? isArchived = null,Object? weeks = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as MesocycleGoal,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as String,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String,weeksCount: null == weeksCount ? _self.weeksCount : weeksCount // ignore: cast_nullable_to_non_nullable
as int,daysPerWeek: null == daysPerWeek ? _self.daysPerWeek : daysPerWeek // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,weeks: null == weeks ? _self.weeks : weeks // ignore: cast_nullable_to_non_nullable
as List<MesocycleWeekEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [MesocycleEntity].
extension MesocycleEntityPatterns on MesocycleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MesocycleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MesocycleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MesocycleEntity value)  $default,){
final _that = this;
switch (_that) {
case _MesocycleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MesocycleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MesocycleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  MesocycleGoal goal,  String splitType,  String experienceLevel,  int weeksCount,  int daysPerWeek,  DateTime createdAt,  DateTime updatedAt,  String? notes,  bool isArchived,  List<MesocycleWeekEntity> weeks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MesocycleEntity() when $default != null:
return $default(_that.id,_that.name,_that.goal,_that.splitType,_that.experienceLevel,_that.weeksCount,_that.daysPerWeek,_that.createdAt,_that.updatedAt,_that.notes,_that.isArchived,_that.weeks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  MesocycleGoal goal,  String splitType,  String experienceLevel,  int weeksCount,  int daysPerWeek,  DateTime createdAt,  DateTime updatedAt,  String? notes,  bool isArchived,  List<MesocycleWeekEntity> weeks)  $default,) {final _that = this;
switch (_that) {
case _MesocycleEntity():
return $default(_that.id,_that.name,_that.goal,_that.splitType,_that.experienceLevel,_that.weeksCount,_that.daysPerWeek,_that.createdAt,_that.updatedAt,_that.notes,_that.isArchived,_that.weeks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  MesocycleGoal goal,  String splitType,  String experienceLevel,  int weeksCount,  int daysPerWeek,  DateTime createdAt,  DateTime updatedAt,  String? notes,  bool isArchived,  List<MesocycleWeekEntity> weeks)?  $default,) {final _that = this;
switch (_that) {
case _MesocycleEntity() when $default != null:
return $default(_that.id,_that.name,_that.goal,_that.splitType,_that.experienceLevel,_that.weeksCount,_that.daysPerWeek,_that.createdAt,_that.updatedAt,_that.notes,_that.isArchived,_that.weeks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MesocycleEntity implements MesocycleEntity {
  const _MesocycleEntity({required this.id, required this.name, required this.goal, required this.splitType, required this.experienceLevel, required this.weeksCount, required this.daysPerWeek, required this.createdAt, required this.updatedAt, this.notes, this.isArchived = false, final  List<MesocycleWeekEntity> weeks = const []}): _weeks = weeks;
  factory _MesocycleEntity.fromJson(Map<String, dynamic> json) => _$MesocycleEntityFromJson(json);

@override final  int id;
@override final  String name;
@override final  MesocycleGoal goal;
@override final  String splitType;
@override final  String experienceLevel;
@override final  int weeksCount;
@override final  int daysPerWeek;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? notes;
@override@JsonKey() final  bool isArchived;
 final  List<MesocycleWeekEntity> _weeks;
@override@JsonKey() List<MesocycleWeekEntity> get weeks {
  if (_weeks is EqualUnmodifiableListView) return _weeks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeks);
}


/// Create a copy of MesocycleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MesocycleEntityCopyWith<_MesocycleEntity> get copyWith => __$MesocycleEntityCopyWithImpl<_MesocycleEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MesocycleEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MesocycleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.weeksCount, weeksCount) || other.weeksCount == weeksCount)&&(identical(other.daysPerWeek, daysPerWeek) || other.daysPerWeek == daysPerWeek)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&const DeepCollectionEquality().equals(other._weeks, _weeks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,goal,splitType,experienceLevel,weeksCount,daysPerWeek,createdAt,updatedAt,notes,isArchived,const DeepCollectionEquality().hash(_weeks));

@override
String toString() {
  return 'MesocycleEntity(id: $id, name: $name, goal: $goal, splitType: $splitType, experienceLevel: $experienceLevel, weeksCount: $weeksCount, daysPerWeek: $daysPerWeek, createdAt: $createdAt, updatedAt: $updatedAt, notes: $notes, isArchived: $isArchived, weeks: $weeks)';
}


}

/// @nodoc
abstract mixin class _$MesocycleEntityCopyWith<$Res> implements $MesocycleEntityCopyWith<$Res> {
  factory _$MesocycleEntityCopyWith(_MesocycleEntity value, $Res Function(_MesocycleEntity) _then) = __$MesocycleEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, MesocycleGoal goal, String splitType, String experienceLevel, int weeksCount, int daysPerWeek, DateTime createdAt, DateTime updatedAt, String? notes, bool isArchived, List<MesocycleWeekEntity> weeks
});




}
/// @nodoc
class __$MesocycleEntityCopyWithImpl<$Res>
    implements _$MesocycleEntityCopyWith<$Res> {
  __$MesocycleEntityCopyWithImpl(this._self, this._then);

  final _MesocycleEntity _self;
  final $Res Function(_MesocycleEntity) _then;

/// Create a copy of MesocycleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? goal = null,Object? splitType = null,Object? experienceLevel = null,Object? weeksCount = null,Object? daysPerWeek = null,Object? createdAt = null,Object? updatedAt = null,Object? notes = freezed,Object? isArchived = null,Object? weeks = null,}) {
  return _then(_MesocycleEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as MesocycleGoal,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as String,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String,weeksCount: null == weeksCount ? _self.weeksCount : weeksCount // ignore: cast_nullable_to_non_nullable
as int,daysPerWeek: null == daysPerWeek ? _self.daysPerWeek : daysPerWeek // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,weeks: null == weeks ? _self._weeks : weeks // ignore: cast_nullable_to_non_nullable
as List<MesocycleWeekEntity>,
  ));
}


}


/// @nodoc
mixin _$MesocycleWeekEntity {

 int get id; int get mesocycleId; int get weekNumber; MesocyclePhase get phaseName; double get volumeMultiplier; double get intensityMultiplier; String? get notes; List<MesocycleDayEntity> get days;
/// Create a copy of MesocycleWeekEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MesocycleWeekEntityCopyWith<MesocycleWeekEntity> get copyWith => _$MesocycleWeekEntityCopyWithImpl<MesocycleWeekEntity>(this as MesocycleWeekEntity, _$identity);

  /// Serializes this MesocycleWeekEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MesocycleWeekEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.mesocycleId, mesocycleId) || other.mesocycleId == mesocycleId)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.phaseName, phaseName) || other.phaseName == phaseName)&&(identical(other.volumeMultiplier, volumeMultiplier) || other.volumeMultiplier == volumeMultiplier)&&(identical(other.intensityMultiplier, intensityMultiplier) || other.intensityMultiplier == intensityMultiplier)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mesocycleId,weekNumber,phaseName,volumeMultiplier,intensityMultiplier,notes,const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'MesocycleWeekEntity(id: $id, mesocycleId: $mesocycleId, weekNumber: $weekNumber, phaseName: $phaseName, volumeMultiplier: $volumeMultiplier, intensityMultiplier: $intensityMultiplier, notes: $notes, days: $days)';
}


}

/// @nodoc
abstract mixin class $MesocycleWeekEntityCopyWith<$Res>  {
  factory $MesocycleWeekEntityCopyWith(MesocycleWeekEntity value, $Res Function(MesocycleWeekEntity) _then) = _$MesocycleWeekEntityCopyWithImpl;
@useResult
$Res call({
 int id, int mesocycleId, int weekNumber, MesocyclePhase phaseName, double volumeMultiplier, double intensityMultiplier, String? notes, List<MesocycleDayEntity> days
});




}
/// @nodoc
class _$MesocycleWeekEntityCopyWithImpl<$Res>
    implements $MesocycleWeekEntityCopyWith<$Res> {
  _$MesocycleWeekEntityCopyWithImpl(this._self, this._then);

  final MesocycleWeekEntity _self;
  final $Res Function(MesocycleWeekEntity) _then;

/// Create a copy of MesocycleWeekEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mesocycleId = null,Object? weekNumber = null,Object? phaseName = null,Object? volumeMultiplier = null,Object? intensityMultiplier = null,Object? notes = freezed,Object? days = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,mesocycleId: null == mesocycleId ? _self.mesocycleId : mesocycleId // ignore: cast_nullable_to_non_nullable
as int,weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,phaseName: null == phaseName ? _self.phaseName : phaseName // ignore: cast_nullable_to_non_nullable
as MesocyclePhase,volumeMultiplier: null == volumeMultiplier ? _self.volumeMultiplier : volumeMultiplier // ignore: cast_nullable_to_non_nullable
as double,intensityMultiplier: null == intensityMultiplier ? _self.intensityMultiplier : intensityMultiplier // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<MesocycleDayEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [MesocycleWeekEntity].
extension MesocycleWeekEntityPatterns on MesocycleWeekEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MesocycleWeekEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MesocycleWeekEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MesocycleWeekEntity value)  $default,){
final _that = this;
switch (_that) {
case _MesocycleWeekEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MesocycleWeekEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MesocycleWeekEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int mesocycleId,  int weekNumber,  MesocyclePhase phaseName,  double volumeMultiplier,  double intensityMultiplier,  String? notes,  List<MesocycleDayEntity> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MesocycleWeekEntity() when $default != null:
return $default(_that.id,_that.mesocycleId,_that.weekNumber,_that.phaseName,_that.volumeMultiplier,_that.intensityMultiplier,_that.notes,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int mesocycleId,  int weekNumber,  MesocyclePhase phaseName,  double volumeMultiplier,  double intensityMultiplier,  String? notes,  List<MesocycleDayEntity> days)  $default,) {final _that = this;
switch (_that) {
case _MesocycleWeekEntity():
return $default(_that.id,_that.mesocycleId,_that.weekNumber,_that.phaseName,_that.volumeMultiplier,_that.intensityMultiplier,_that.notes,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int mesocycleId,  int weekNumber,  MesocyclePhase phaseName,  double volumeMultiplier,  double intensityMultiplier,  String? notes,  List<MesocycleDayEntity> days)?  $default,) {final _that = this;
switch (_that) {
case _MesocycleWeekEntity() when $default != null:
return $default(_that.id,_that.mesocycleId,_that.weekNumber,_that.phaseName,_that.volumeMultiplier,_that.intensityMultiplier,_that.notes,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MesocycleWeekEntity implements MesocycleWeekEntity {
  const _MesocycleWeekEntity({required this.id, required this.mesocycleId, required this.weekNumber, required this.phaseName, this.volumeMultiplier = 1.0, this.intensityMultiplier = 1.0, this.notes, final  List<MesocycleDayEntity> days = const []}): _days = days;
  factory _MesocycleWeekEntity.fromJson(Map<String, dynamic> json) => _$MesocycleWeekEntityFromJson(json);

@override final  int id;
@override final  int mesocycleId;
@override final  int weekNumber;
@override final  MesocyclePhase phaseName;
@override@JsonKey() final  double volumeMultiplier;
@override@JsonKey() final  double intensityMultiplier;
@override final  String? notes;
 final  List<MesocycleDayEntity> _days;
@override@JsonKey() List<MesocycleDayEntity> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of MesocycleWeekEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MesocycleWeekEntityCopyWith<_MesocycleWeekEntity> get copyWith => __$MesocycleWeekEntityCopyWithImpl<_MesocycleWeekEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MesocycleWeekEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MesocycleWeekEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.mesocycleId, mesocycleId) || other.mesocycleId == mesocycleId)&&(identical(other.weekNumber, weekNumber) || other.weekNumber == weekNumber)&&(identical(other.phaseName, phaseName) || other.phaseName == phaseName)&&(identical(other.volumeMultiplier, volumeMultiplier) || other.volumeMultiplier == volumeMultiplier)&&(identical(other.intensityMultiplier, intensityMultiplier) || other.intensityMultiplier == intensityMultiplier)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mesocycleId,weekNumber,phaseName,volumeMultiplier,intensityMultiplier,notes,const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'MesocycleWeekEntity(id: $id, mesocycleId: $mesocycleId, weekNumber: $weekNumber, phaseName: $phaseName, volumeMultiplier: $volumeMultiplier, intensityMultiplier: $intensityMultiplier, notes: $notes, days: $days)';
}


}

/// @nodoc
abstract mixin class _$MesocycleWeekEntityCopyWith<$Res> implements $MesocycleWeekEntityCopyWith<$Res> {
  factory _$MesocycleWeekEntityCopyWith(_MesocycleWeekEntity value, $Res Function(_MesocycleWeekEntity) _then) = __$MesocycleWeekEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int mesocycleId, int weekNumber, MesocyclePhase phaseName, double volumeMultiplier, double intensityMultiplier, String? notes, List<MesocycleDayEntity> days
});




}
/// @nodoc
class __$MesocycleWeekEntityCopyWithImpl<$Res>
    implements _$MesocycleWeekEntityCopyWith<$Res> {
  __$MesocycleWeekEntityCopyWithImpl(this._self, this._then);

  final _MesocycleWeekEntity _self;
  final $Res Function(_MesocycleWeekEntity) _then;

/// Create a copy of MesocycleWeekEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mesocycleId = null,Object? weekNumber = null,Object? phaseName = null,Object? volumeMultiplier = null,Object? intensityMultiplier = null,Object? notes = freezed,Object? days = null,}) {
  return _then(_MesocycleWeekEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,mesocycleId: null == mesocycleId ? _self.mesocycleId : mesocycleId // ignore: cast_nullable_to_non_nullable
as int,weekNumber: null == weekNumber ? _self.weekNumber : weekNumber // ignore: cast_nullable_to_non_nullable
as int,phaseName: null == phaseName ? _self.phaseName : phaseName // ignore: cast_nullable_to_non_nullable
as MesocyclePhase,volumeMultiplier: null == volumeMultiplier ? _self.volumeMultiplier : volumeMultiplier // ignore: cast_nullable_to_non_nullable
as double,intensityMultiplier: null == intensityMultiplier ? _self.intensityMultiplier : intensityMultiplier // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<MesocycleDayEntity>,
  ));
}


}


/// @nodoc
mixin _$MesocycleDayEntity {

 int get id; int get mesocycleWeekId; int get dayNumber; String get title; String? get splitLabel; List<MesocycleExerciseEntity> get exercises;
/// Create a copy of MesocycleDayEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MesocycleDayEntityCopyWith<MesocycleDayEntity> get copyWith => _$MesocycleDayEntityCopyWithImpl<MesocycleDayEntity>(this as MesocycleDayEntity, _$identity);

  /// Serializes this MesocycleDayEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MesocycleDayEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.mesocycleWeekId, mesocycleWeekId) || other.mesocycleWeekId == mesocycleWeekId)&&(identical(other.dayNumber, dayNumber) || other.dayNumber == dayNumber)&&(identical(other.title, title) || other.title == title)&&(identical(other.splitLabel, splitLabel) || other.splitLabel == splitLabel)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mesocycleWeekId,dayNumber,title,splitLabel,const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'MesocycleDayEntity(id: $id, mesocycleWeekId: $mesocycleWeekId, dayNumber: $dayNumber, title: $title, splitLabel: $splitLabel, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $MesocycleDayEntityCopyWith<$Res>  {
  factory $MesocycleDayEntityCopyWith(MesocycleDayEntity value, $Res Function(MesocycleDayEntity) _then) = _$MesocycleDayEntityCopyWithImpl;
@useResult
$Res call({
 int id, int mesocycleWeekId, int dayNumber, String title, String? splitLabel, List<MesocycleExerciseEntity> exercises
});




}
/// @nodoc
class _$MesocycleDayEntityCopyWithImpl<$Res>
    implements $MesocycleDayEntityCopyWith<$Res> {
  _$MesocycleDayEntityCopyWithImpl(this._self, this._then);

  final MesocycleDayEntity _self;
  final $Res Function(MesocycleDayEntity) _then;

/// Create a copy of MesocycleDayEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mesocycleWeekId = null,Object? dayNumber = null,Object? title = null,Object? splitLabel = freezed,Object? exercises = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,mesocycleWeekId: null == mesocycleWeekId ? _self.mesocycleWeekId : mesocycleWeekId // ignore: cast_nullable_to_non_nullable
as int,dayNumber: null == dayNumber ? _self.dayNumber : dayNumber // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,splitLabel: freezed == splitLabel ? _self.splitLabel : splitLabel // ignore: cast_nullable_to_non_nullable
as String?,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<MesocycleExerciseEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [MesocycleDayEntity].
extension MesocycleDayEntityPatterns on MesocycleDayEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MesocycleDayEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MesocycleDayEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MesocycleDayEntity value)  $default,){
final _that = this;
switch (_that) {
case _MesocycleDayEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MesocycleDayEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MesocycleDayEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int mesocycleWeekId,  int dayNumber,  String title,  String? splitLabel,  List<MesocycleExerciseEntity> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MesocycleDayEntity() when $default != null:
return $default(_that.id,_that.mesocycleWeekId,_that.dayNumber,_that.title,_that.splitLabel,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int mesocycleWeekId,  int dayNumber,  String title,  String? splitLabel,  List<MesocycleExerciseEntity> exercises)  $default,) {final _that = this;
switch (_that) {
case _MesocycleDayEntity():
return $default(_that.id,_that.mesocycleWeekId,_that.dayNumber,_that.title,_that.splitLabel,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int mesocycleWeekId,  int dayNumber,  String title,  String? splitLabel,  List<MesocycleExerciseEntity> exercises)?  $default,) {final _that = this;
switch (_that) {
case _MesocycleDayEntity() when $default != null:
return $default(_that.id,_that.mesocycleWeekId,_that.dayNumber,_that.title,_that.splitLabel,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MesocycleDayEntity implements MesocycleDayEntity {
  const _MesocycleDayEntity({required this.id, required this.mesocycleWeekId, required this.dayNumber, required this.title, this.splitLabel, final  List<MesocycleExerciseEntity> exercises = const []}): _exercises = exercises;
  factory _MesocycleDayEntity.fromJson(Map<String, dynamic> json) => _$MesocycleDayEntityFromJson(json);

@override final  int id;
@override final  int mesocycleWeekId;
@override final  int dayNumber;
@override final  String title;
@override final  String? splitLabel;
 final  List<MesocycleExerciseEntity> _exercises;
@override@JsonKey() List<MesocycleExerciseEntity> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of MesocycleDayEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MesocycleDayEntityCopyWith<_MesocycleDayEntity> get copyWith => __$MesocycleDayEntityCopyWithImpl<_MesocycleDayEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MesocycleDayEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MesocycleDayEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.mesocycleWeekId, mesocycleWeekId) || other.mesocycleWeekId == mesocycleWeekId)&&(identical(other.dayNumber, dayNumber) || other.dayNumber == dayNumber)&&(identical(other.title, title) || other.title == title)&&(identical(other.splitLabel, splitLabel) || other.splitLabel == splitLabel)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mesocycleWeekId,dayNumber,title,splitLabel,const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'MesocycleDayEntity(id: $id, mesocycleWeekId: $mesocycleWeekId, dayNumber: $dayNumber, title: $title, splitLabel: $splitLabel, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$MesocycleDayEntityCopyWith<$Res> implements $MesocycleDayEntityCopyWith<$Res> {
  factory _$MesocycleDayEntityCopyWith(_MesocycleDayEntity value, $Res Function(_MesocycleDayEntity) _then) = __$MesocycleDayEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int mesocycleWeekId, int dayNumber, String title, String? splitLabel, List<MesocycleExerciseEntity> exercises
});




}
/// @nodoc
class __$MesocycleDayEntityCopyWithImpl<$Res>
    implements _$MesocycleDayEntityCopyWith<$Res> {
  __$MesocycleDayEntityCopyWithImpl(this._self, this._then);

  final _MesocycleDayEntity _self;
  final $Res Function(_MesocycleDayEntity) _then;

/// Create a copy of MesocycleDayEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mesocycleWeekId = null,Object? dayNumber = null,Object? title = null,Object? splitLabel = freezed,Object? exercises = null,}) {
  return _then(_MesocycleDayEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,mesocycleWeekId: null == mesocycleWeekId ? _self.mesocycleWeekId : mesocycleWeekId // ignore: cast_nullable_to_non_nullable
as int,dayNumber: null == dayNumber ? _self.dayNumber : dayNumber // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,splitLabel: freezed == splitLabel ? _self.splitLabel : splitLabel // ignore: cast_nullable_to_non_nullable
as String?,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<MesocycleExerciseEntity>,
  ));
}


}


/// @nodoc
mixin _$MesocycleExerciseEntity {

 int get id; int get mesocycleDayId; ExerciseEntity get exercise; int get exerciseOrder; int get targetSets; int get minReps; int get maxReps; double? get targetRpe; ProgressionType get progressionType; double? get progressionValue; String? get notes;
/// Create a copy of MesocycleExerciseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MesocycleExerciseEntityCopyWith<MesocycleExerciseEntity> get copyWith => _$MesocycleExerciseEntityCopyWithImpl<MesocycleExerciseEntity>(this as MesocycleExerciseEntity, _$identity);

  /// Serializes this MesocycleExerciseEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MesocycleExerciseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.mesocycleDayId, mesocycleDayId) || other.mesocycleDayId == mesocycleDayId)&&(identical(other.exercise, exercise) || other.exercise == exercise)&&(identical(other.exerciseOrder, exerciseOrder) || other.exerciseOrder == exerciseOrder)&&(identical(other.targetSets, targetSets) || other.targetSets == targetSets)&&(identical(other.minReps, minReps) || other.minReps == minReps)&&(identical(other.maxReps, maxReps) || other.maxReps == maxReps)&&(identical(other.targetRpe, targetRpe) || other.targetRpe == targetRpe)&&(identical(other.progressionType, progressionType) || other.progressionType == progressionType)&&(identical(other.progressionValue, progressionValue) || other.progressionValue == progressionValue)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mesocycleDayId,exercise,exerciseOrder,targetSets,minReps,maxReps,targetRpe,progressionType,progressionValue,notes);

@override
String toString() {
  return 'MesocycleExerciseEntity(id: $id, mesocycleDayId: $mesocycleDayId, exercise: $exercise, exerciseOrder: $exerciseOrder, targetSets: $targetSets, minReps: $minReps, maxReps: $maxReps, targetRpe: $targetRpe, progressionType: $progressionType, progressionValue: $progressionValue, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $MesocycleExerciseEntityCopyWith<$Res>  {
  factory $MesocycleExerciseEntityCopyWith(MesocycleExerciseEntity value, $Res Function(MesocycleExerciseEntity) _then) = _$MesocycleExerciseEntityCopyWithImpl;
@useResult
$Res call({
 int id, int mesocycleDayId, ExerciseEntity exercise, int exerciseOrder, int targetSets, int minReps, int maxReps, double? targetRpe, ProgressionType progressionType, double? progressionValue, String? notes
});




}
/// @nodoc
class _$MesocycleExerciseEntityCopyWithImpl<$Res>
    implements $MesocycleExerciseEntityCopyWith<$Res> {
  _$MesocycleExerciseEntityCopyWithImpl(this._self, this._then);

  final MesocycleExerciseEntity _self;
  final $Res Function(MesocycleExerciseEntity) _then;

/// Create a copy of MesocycleExerciseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mesocycleDayId = null,Object? exercise = null,Object? exerciseOrder = null,Object? targetSets = null,Object? minReps = null,Object? maxReps = null,Object? targetRpe = freezed,Object? progressionType = null,Object? progressionValue = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,mesocycleDayId: null == mesocycleDayId ? _self.mesocycleDayId : mesocycleDayId // ignore: cast_nullable_to_non_nullable
as int,exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as ExerciseEntity,exerciseOrder: null == exerciseOrder ? _self.exerciseOrder : exerciseOrder // ignore: cast_nullable_to_non_nullable
as int,targetSets: null == targetSets ? _self.targetSets : targetSets // ignore: cast_nullable_to_non_nullable
as int,minReps: null == minReps ? _self.minReps : minReps // ignore: cast_nullable_to_non_nullable
as int,maxReps: null == maxReps ? _self.maxReps : maxReps // ignore: cast_nullable_to_non_nullable
as int,targetRpe: freezed == targetRpe ? _self.targetRpe : targetRpe // ignore: cast_nullable_to_non_nullable
as double?,progressionType: null == progressionType ? _self.progressionType : progressionType // ignore: cast_nullable_to_non_nullable
as ProgressionType,progressionValue: freezed == progressionValue ? _self.progressionValue : progressionValue // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MesocycleExerciseEntity].
extension MesocycleExerciseEntityPatterns on MesocycleExerciseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MesocycleExerciseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MesocycleExerciseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MesocycleExerciseEntity value)  $default,){
final _that = this;
switch (_that) {
case _MesocycleExerciseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MesocycleExerciseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MesocycleExerciseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int mesocycleDayId,  ExerciseEntity exercise,  int exerciseOrder,  int targetSets,  int minReps,  int maxReps,  double? targetRpe,  ProgressionType progressionType,  double? progressionValue,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MesocycleExerciseEntity() when $default != null:
return $default(_that.id,_that.mesocycleDayId,_that.exercise,_that.exerciseOrder,_that.targetSets,_that.minReps,_that.maxReps,_that.targetRpe,_that.progressionType,_that.progressionValue,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int mesocycleDayId,  ExerciseEntity exercise,  int exerciseOrder,  int targetSets,  int minReps,  int maxReps,  double? targetRpe,  ProgressionType progressionType,  double? progressionValue,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _MesocycleExerciseEntity():
return $default(_that.id,_that.mesocycleDayId,_that.exercise,_that.exerciseOrder,_that.targetSets,_that.minReps,_that.maxReps,_that.targetRpe,_that.progressionType,_that.progressionValue,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int mesocycleDayId,  ExerciseEntity exercise,  int exerciseOrder,  int targetSets,  int minReps,  int maxReps,  double? targetRpe,  ProgressionType progressionType,  double? progressionValue,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _MesocycleExerciseEntity() when $default != null:
return $default(_that.id,_that.mesocycleDayId,_that.exercise,_that.exerciseOrder,_that.targetSets,_that.minReps,_that.maxReps,_that.targetRpe,_that.progressionType,_that.progressionValue,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MesocycleExerciseEntity implements MesocycleExerciseEntity {
  const _MesocycleExerciseEntity({required this.id, required this.mesocycleDayId, required this.exercise, required this.exerciseOrder, required this.targetSets, required this.minReps, required this.maxReps, this.targetRpe, this.progressionType = ProgressionType.none, this.progressionValue, this.notes});
  factory _MesocycleExerciseEntity.fromJson(Map<String, dynamic> json) => _$MesocycleExerciseEntityFromJson(json);

@override final  int id;
@override final  int mesocycleDayId;
@override final  ExerciseEntity exercise;
@override final  int exerciseOrder;
@override final  int targetSets;
@override final  int minReps;
@override final  int maxReps;
@override final  double? targetRpe;
@override@JsonKey() final  ProgressionType progressionType;
@override final  double? progressionValue;
@override final  String? notes;

/// Create a copy of MesocycleExerciseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MesocycleExerciseEntityCopyWith<_MesocycleExerciseEntity> get copyWith => __$MesocycleExerciseEntityCopyWithImpl<_MesocycleExerciseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MesocycleExerciseEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MesocycleExerciseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.mesocycleDayId, mesocycleDayId) || other.mesocycleDayId == mesocycleDayId)&&(identical(other.exercise, exercise) || other.exercise == exercise)&&(identical(other.exerciseOrder, exerciseOrder) || other.exerciseOrder == exerciseOrder)&&(identical(other.targetSets, targetSets) || other.targetSets == targetSets)&&(identical(other.minReps, minReps) || other.minReps == minReps)&&(identical(other.maxReps, maxReps) || other.maxReps == maxReps)&&(identical(other.targetRpe, targetRpe) || other.targetRpe == targetRpe)&&(identical(other.progressionType, progressionType) || other.progressionType == progressionType)&&(identical(other.progressionValue, progressionValue) || other.progressionValue == progressionValue)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mesocycleDayId,exercise,exerciseOrder,targetSets,minReps,maxReps,targetRpe,progressionType,progressionValue,notes);

@override
String toString() {
  return 'MesocycleExerciseEntity(id: $id, mesocycleDayId: $mesocycleDayId, exercise: $exercise, exerciseOrder: $exerciseOrder, targetSets: $targetSets, minReps: $minReps, maxReps: $maxReps, targetRpe: $targetRpe, progressionType: $progressionType, progressionValue: $progressionValue, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$MesocycleExerciseEntityCopyWith<$Res> implements $MesocycleExerciseEntityCopyWith<$Res> {
  factory _$MesocycleExerciseEntityCopyWith(_MesocycleExerciseEntity value, $Res Function(_MesocycleExerciseEntity) _then) = __$MesocycleExerciseEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int mesocycleDayId, ExerciseEntity exercise, int exerciseOrder, int targetSets, int minReps, int maxReps, double? targetRpe, ProgressionType progressionType, double? progressionValue, String? notes
});




}
/// @nodoc
class __$MesocycleExerciseEntityCopyWithImpl<$Res>
    implements _$MesocycleExerciseEntityCopyWith<$Res> {
  __$MesocycleExerciseEntityCopyWithImpl(this._self, this._then);

  final _MesocycleExerciseEntity _self;
  final $Res Function(_MesocycleExerciseEntity) _then;

/// Create a copy of MesocycleExerciseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mesocycleDayId = null,Object? exercise = null,Object? exerciseOrder = null,Object? targetSets = null,Object? minReps = null,Object? maxReps = null,Object? targetRpe = freezed,Object? progressionType = null,Object? progressionValue = freezed,Object? notes = freezed,}) {
  return _then(_MesocycleExerciseEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,mesocycleDayId: null == mesocycleDayId ? _self.mesocycleDayId : mesocycleDayId // ignore: cast_nullable_to_non_nullable
as int,exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as ExerciseEntity,exerciseOrder: null == exerciseOrder ? _self.exerciseOrder : exerciseOrder // ignore: cast_nullable_to_non_nullable
as int,targetSets: null == targetSets ? _self.targetSets : targetSets // ignore: cast_nullable_to_non_nullable
as int,minReps: null == minReps ? _self.minReps : minReps // ignore: cast_nullable_to_non_nullable
as int,maxReps: null == maxReps ? _self.maxReps : maxReps // ignore: cast_nullable_to_non_nullable
as int,targetRpe: freezed == targetRpe ? _self.targetRpe : targetRpe // ignore: cast_nullable_to_non_nullable
as double?,progressionType: null == progressionType ? _self.progressionType : progressionType // ignore: cast_nullable_to_non_nullable
as ProgressionType,progressionValue: freezed == progressionValue ? _self.progressionValue : progressionValue // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
