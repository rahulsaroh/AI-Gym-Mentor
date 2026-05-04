// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutProgram {

 int get id; String get name; String? get description; DateTime? get lastUsed; bool get isSelected; List<ProgramDay> get days;
/// Create a copy of WorkoutProgram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutProgramCopyWith<WorkoutProgram> get copyWith => _$WorkoutProgramCopyWithImpl<WorkoutProgram>(this as WorkoutProgram, _$identity);

  /// Serializes this WorkoutProgram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutProgram&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.lastUsed, lastUsed) || other.lastUsed == lastUsed)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,lastUsed,isSelected,const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'WorkoutProgram(id: $id, name: $name, description: $description, lastUsed: $lastUsed, isSelected: $isSelected, days: $days)';
}


}

/// @nodoc
abstract mixin class $WorkoutProgramCopyWith<$Res>  {
  factory $WorkoutProgramCopyWith(WorkoutProgram value, $Res Function(WorkoutProgram) _then) = _$WorkoutProgramCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, DateTime? lastUsed, bool isSelected, List<ProgramDay> days
});




}
/// @nodoc
class _$WorkoutProgramCopyWithImpl<$Res>
    implements $WorkoutProgramCopyWith<$Res> {
  _$WorkoutProgramCopyWithImpl(this._self, this._then);

  final WorkoutProgram _self;
  final $Res Function(WorkoutProgram) _then;

/// Create a copy of WorkoutProgram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? lastUsed = freezed,Object? isSelected = null,Object? days = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,lastUsed: freezed == lastUsed ? _self.lastUsed : lastUsed // ignore: cast_nullable_to_non_nullable
as DateTime?,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<ProgramDay>,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutProgram].
extension WorkoutProgramPatterns on WorkoutProgram {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutProgram value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutProgram() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutProgram value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutProgram():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutProgram value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutProgram() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  DateTime? lastUsed,  bool isSelected,  List<ProgramDay> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutProgram() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.lastUsed,_that.isSelected,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  DateTime? lastUsed,  bool isSelected,  List<ProgramDay> days)  $default,) {final _that = this;
switch (_that) {
case _WorkoutProgram():
return $default(_that.id,_that.name,_that.description,_that.lastUsed,_that.isSelected,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  DateTime? lastUsed,  bool isSelected,  List<ProgramDay> days)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutProgram() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.lastUsed,_that.isSelected,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkoutProgram extends WorkoutProgram {
  const _WorkoutProgram({required this.id, required this.name, this.description, this.lastUsed, this.isSelected = false, final  List<ProgramDay> days = const []}): _days = days,super._();
  factory _WorkoutProgram.fromJson(Map<String, dynamic> json) => _$WorkoutProgramFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override final  DateTime? lastUsed;
@override@JsonKey() final  bool isSelected;
 final  List<ProgramDay> _days;
@override@JsonKey() List<ProgramDay> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of WorkoutProgram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutProgramCopyWith<_WorkoutProgram> get copyWith => __$WorkoutProgramCopyWithImpl<_WorkoutProgram>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkoutProgramToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutProgram&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.lastUsed, lastUsed) || other.lastUsed == lastUsed)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,lastUsed,isSelected,const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'WorkoutProgram(id: $id, name: $name, description: $description, lastUsed: $lastUsed, isSelected: $isSelected, days: $days)';
}


}

/// @nodoc
abstract mixin class _$WorkoutProgramCopyWith<$Res> implements $WorkoutProgramCopyWith<$Res> {
  factory _$WorkoutProgramCopyWith(_WorkoutProgram value, $Res Function(_WorkoutProgram) _then) = __$WorkoutProgramCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, DateTime? lastUsed, bool isSelected, List<ProgramDay> days
});




}
/// @nodoc
class __$WorkoutProgramCopyWithImpl<$Res>
    implements _$WorkoutProgramCopyWith<$Res> {
  __$WorkoutProgramCopyWithImpl(this._self, this._then);

  final _WorkoutProgram _self;
  final $Res Function(_WorkoutProgram) _then;

/// Create a copy of WorkoutProgram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? lastUsed = freezed,Object? isSelected = null,Object? days = null,}) {
  return _then(_WorkoutProgram(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,lastUsed: freezed == lastUsed ? _self.lastUsed : lastUsed // ignore: cast_nullable_to_non_nullable
as DateTime?,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<ProgramDay>,
  ));
}


}


/// @nodoc
mixin _$ProgramDay {

 int get id; int get templateId; String get name; int get order; int? get weekday; List<ProgramExercise> get exercises;
/// Create a copy of ProgramDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgramDayCopyWith<ProgramDay> get copyWith => _$ProgramDayCopyWithImpl<ProgramDay>(this as ProgramDay, _$identity);

  /// Serializes this ProgramDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgramDay&&(identical(other.id, id) || other.id == id)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,templateId,name,order,weekday,const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'ProgramDay(id: $id, templateId: $templateId, name: $name, order: $order, weekday: $weekday, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $ProgramDayCopyWith<$Res>  {
  factory $ProgramDayCopyWith(ProgramDay value, $Res Function(ProgramDay) _then) = _$ProgramDayCopyWithImpl;
@useResult
$Res call({
 int id, int templateId, String name, int order, int? weekday, List<ProgramExercise> exercises
});




}
/// @nodoc
class _$ProgramDayCopyWithImpl<$Res>
    implements $ProgramDayCopyWith<$Res> {
  _$ProgramDayCopyWithImpl(this._self, this._then);

  final ProgramDay _self;
  final $Res Function(ProgramDay) _then;

/// Create a copy of ProgramDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? templateId = null,Object? name = null,Object? order = null,Object? weekday = freezed,Object? exercises = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,weekday: freezed == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int?,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ProgramExercise>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgramDay].
extension ProgramDayPatterns on ProgramDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgramDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgramDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgramDay value)  $default,){
final _that = this;
switch (_that) {
case _ProgramDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgramDay value)?  $default,){
final _that = this;
switch (_that) {
case _ProgramDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int templateId,  String name,  int order,  int? weekday,  List<ProgramExercise> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgramDay() when $default != null:
return $default(_that.id,_that.templateId,_that.name,_that.order,_that.weekday,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int templateId,  String name,  int order,  int? weekday,  List<ProgramExercise> exercises)  $default,) {final _that = this;
switch (_that) {
case _ProgramDay():
return $default(_that.id,_that.templateId,_that.name,_that.order,_that.weekday,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int templateId,  String name,  int order,  int? weekday,  List<ProgramExercise> exercises)?  $default,) {final _that = this;
switch (_that) {
case _ProgramDay() when $default != null:
return $default(_that.id,_that.templateId,_that.name,_that.order,_that.weekday,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgramDay extends ProgramDay {
  const _ProgramDay({required this.id, required this.templateId, required this.name, required this.order, this.weekday, final  List<ProgramExercise> exercises = const []}): _exercises = exercises,super._();
  factory _ProgramDay.fromJson(Map<String, dynamic> json) => _$ProgramDayFromJson(json);

@override final  int id;
@override final  int templateId;
@override final  String name;
@override final  int order;
@override final  int? weekday;
 final  List<ProgramExercise> _exercises;
@override@JsonKey() List<ProgramExercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of ProgramDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgramDayCopyWith<_ProgramDay> get copyWith => __$ProgramDayCopyWithImpl<_ProgramDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgramDayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgramDay&&(identical(other.id, id) || other.id == id)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,templateId,name,order,weekday,const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'ProgramDay(id: $id, templateId: $templateId, name: $name, order: $order, weekday: $weekday, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$ProgramDayCopyWith<$Res> implements $ProgramDayCopyWith<$Res> {
  factory _$ProgramDayCopyWith(_ProgramDay value, $Res Function(_ProgramDay) _then) = __$ProgramDayCopyWithImpl;
@override @useResult
$Res call({
 int id, int templateId, String name, int order, int? weekday, List<ProgramExercise> exercises
});




}
/// @nodoc
class __$ProgramDayCopyWithImpl<$Res>
    implements _$ProgramDayCopyWith<$Res> {
  __$ProgramDayCopyWithImpl(this._self, this._then);

  final _ProgramDay _self;
  final $Res Function(_ProgramDay) _then;

/// Create a copy of ProgramDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? templateId = null,Object? name = null,Object? order = null,Object? weekday = freezed,Object? exercises = null,}) {
  return _then(_ProgramDay(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,templateId: null == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,weekday: freezed == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int?,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ProgramExercise>,
  ));
}


}


/// @nodoc
mixin _$ProgramExercise {

 int get id; int get dayId; ExerciseEntity get exercise; int get order; String get setType; String get setsJson;// Simplified for now, or use typed sets
 int get restTime; String? get notes; String? get supersetGroupId;
/// Create a copy of ProgramExercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgramExerciseCopyWith<ProgramExercise> get copyWith => _$ProgramExerciseCopyWithImpl<ProgramExercise>(this as ProgramExercise, _$identity);

  /// Serializes this ProgramExercise to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgramExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.dayId, dayId) || other.dayId == dayId)&&(identical(other.exercise, exercise) || other.exercise == exercise)&&(identical(other.order, order) || other.order == order)&&(identical(other.setType, setType) || other.setType == setType)&&(identical(other.setsJson, setsJson) || other.setsJson == setsJson)&&(identical(other.restTime, restTime) || other.restTime == restTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.supersetGroupId, supersetGroupId) || other.supersetGroupId == supersetGroupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,dayId,exercise,order,setType,setsJson,restTime,notes,supersetGroupId);

@override
String toString() {
  return 'ProgramExercise(id: $id, dayId: $dayId, exercise: $exercise, order: $order, setType: $setType, setsJson: $setsJson, restTime: $restTime, notes: $notes, supersetGroupId: $supersetGroupId)';
}


}

/// @nodoc
abstract mixin class $ProgramExerciseCopyWith<$Res>  {
  factory $ProgramExerciseCopyWith(ProgramExercise value, $Res Function(ProgramExercise) _then) = _$ProgramExerciseCopyWithImpl;
@useResult
$Res call({
 int id, int dayId, ExerciseEntity exercise, int order, String setType, String setsJson, int restTime, String? notes, String? supersetGroupId
});




}
/// @nodoc
class _$ProgramExerciseCopyWithImpl<$Res>
    implements $ProgramExerciseCopyWith<$Res> {
  _$ProgramExerciseCopyWithImpl(this._self, this._then);

  final ProgramExercise _self;
  final $Res Function(ProgramExercise) _then;

/// Create a copy of ProgramExercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? dayId = null,Object? exercise = null,Object? order = null,Object? setType = null,Object? setsJson = null,Object? restTime = null,Object? notes = freezed,Object? supersetGroupId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,dayId: null == dayId ? _self.dayId : dayId // ignore: cast_nullable_to_non_nullable
as int,exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as ExerciseEntity,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,setType: null == setType ? _self.setType : setType // ignore: cast_nullable_to_non_nullable
as String,setsJson: null == setsJson ? _self.setsJson : setsJson // ignore: cast_nullable_to_non_nullable
as String,restTime: null == restTime ? _self.restTime : restTime // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,supersetGroupId: freezed == supersetGroupId ? _self.supersetGroupId : supersetGroupId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgramExercise].
extension ProgramExercisePatterns on ProgramExercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgramExercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgramExercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgramExercise value)  $default,){
final _that = this;
switch (_that) {
case _ProgramExercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgramExercise value)?  $default,){
final _that = this;
switch (_that) {
case _ProgramExercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int dayId,  ExerciseEntity exercise,  int order,  String setType,  String setsJson,  int restTime,  String? notes,  String? supersetGroupId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgramExercise() when $default != null:
return $default(_that.id,_that.dayId,_that.exercise,_that.order,_that.setType,_that.setsJson,_that.restTime,_that.notes,_that.supersetGroupId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int dayId,  ExerciseEntity exercise,  int order,  String setType,  String setsJson,  int restTime,  String? notes,  String? supersetGroupId)  $default,) {final _that = this;
switch (_that) {
case _ProgramExercise():
return $default(_that.id,_that.dayId,_that.exercise,_that.order,_that.setType,_that.setsJson,_that.restTime,_that.notes,_that.supersetGroupId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int dayId,  ExerciseEntity exercise,  int order,  String setType,  String setsJson,  int restTime,  String? notes,  String? supersetGroupId)?  $default,) {final _that = this;
switch (_that) {
case _ProgramExercise() when $default != null:
return $default(_that.id,_that.dayId,_that.exercise,_that.order,_that.setType,_that.setsJson,_that.restTime,_that.notes,_that.supersetGroupId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgramExercise extends ProgramExercise {
  const _ProgramExercise({required this.id, required this.dayId, required this.exercise, required this.order, this.setType = 'Straight', this.setsJson = '[]', this.restTime = 90, this.notes, this.supersetGroupId}): super._();
  factory _ProgramExercise.fromJson(Map<String, dynamic> json) => _$ProgramExerciseFromJson(json);

@override final  int id;
@override final  int dayId;
@override final  ExerciseEntity exercise;
@override final  int order;
@override@JsonKey() final  String setType;
@override@JsonKey() final  String setsJson;
// Simplified for now, or use typed sets
@override@JsonKey() final  int restTime;
@override final  String? notes;
@override final  String? supersetGroupId;

/// Create a copy of ProgramExercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgramExerciseCopyWith<_ProgramExercise> get copyWith => __$ProgramExerciseCopyWithImpl<_ProgramExercise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgramExerciseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgramExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.dayId, dayId) || other.dayId == dayId)&&(identical(other.exercise, exercise) || other.exercise == exercise)&&(identical(other.order, order) || other.order == order)&&(identical(other.setType, setType) || other.setType == setType)&&(identical(other.setsJson, setsJson) || other.setsJson == setsJson)&&(identical(other.restTime, restTime) || other.restTime == restTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.supersetGroupId, supersetGroupId) || other.supersetGroupId == supersetGroupId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,dayId,exercise,order,setType,setsJson,restTime,notes,supersetGroupId);

@override
String toString() {
  return 'ProgramExercise(id: $id, dayId: $dayId, exercise: $exercise, order: $order, setType: $setType, setsJson: $setsJson, restTime: $restTime, notes: $notes, supersetGroupId: $supersetGroupId)';
}


}

/// @nodoc
abstract mixin class _$ProgramExerciseCopyWith<$Res> implements $ProgramExerciseCopyWith<$Res> {
  factory _$ProgramExerciseCopyWith(_ProgramExercise value, $Res Function(_ProgramExercise) _then) = __$ProgramExerciseCopyWithImpl;
@override @useResult
$Res call({
 int id, int dayId, ExerciseEntity exercise, int order, String setType, String setsJson, int restTime, String? notes, String? supersetGroupId
});




}
/// @nodoc
class __$ProgramExerciseCopyWithImpl<$Res>
    implements _$ProgramExerciseCopyWith<$Res> {
  __$ProgramExerciseCopyWithImpl(this._self, this._then);

  final _ProgramExercise _self;
  final $Res Function(_ProgramExercise) _then;

/// Create a copy of ProgramExercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? dayId = null,Object? exercise = null,Object? order = null,Object? setType = null,Object? setsJson = null,Object? restTime = null,Object? notes = freezed,Object? supersetGroupId = freezed,}) {
  return _then(_ProgramExercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,dayId: null == dayId ? _self.dayId : dayId // ignore: cast_nullable_to_non_nullable
as int,exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as ExerciseEntity,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,setType: null == setType ? _self.setType : setType // ignore: cast_nullable_to_non_nullable
as String,setsJson: null == setsJson ? _self.setsJson : setsJson // ignore: cast_nullable_to_non_nullable
as String,restTime: null == restTime ? _self.restTime : restTime // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,supersetGroupId: freezed == supersetGroupId ? _self.supersetGroupId : supersetGroupId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
