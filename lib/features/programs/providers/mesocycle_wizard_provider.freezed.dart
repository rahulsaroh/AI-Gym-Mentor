// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mesocycle_wizard_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MesocycleWizardState {

 int get currentStep; String get name; MesocycleGoal get goal; String get experienceLevel; String get splitType; int get weeksCount; int get daysPerWeek; List<List<ExerciseEntity>> get exercisesPerDay; bool get isGenerating; MesocycleEntity? get previewedMesocycle;
/// Create a copy of MesocycleWizardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MesocycleWizardStateCopyWith<MesocycleWizardState> get copyWith => _$MesocycleWizardStateCopyWithImpl<MesocycleWizardState>(this as MesocycleWizardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MesocycleWizardState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.name, name) || other.name == name)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&(identical(other.weeksCount, weeksCount) || other.weeksCount == weeksCount)&&(identical(other.daysPerWeek, daysPerWeek) || other.daysPerWeek == daysPerWeek)&&const DeepCollectionEquality().equals(other.exercisesPerDay, exercisesPerDay)&&(identical(other.isGenerating, isGenerating) || other.isGenerating == isGenerating)&&(identical(other.previewedMesocycle, previewedMesocycle) || other.previewedMesocycle == previewedMesocycle));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,name,goal,experienceLevel,splitType,weeksCount,daysPerWeek,const DeepCollectionEquality().hash(exercisesPerDay),isGenerating,previewedMesocycle);

@override
String toString() {
  return 'MesocycleWizardState(currentStep: $currentStep, name: $name, goal: $goal, experienceLevel: $experienceLevel, splitType: $splitType, weeksCount: $weeksCount, daysPerWeek: $daysPerWeek, exercisesPerDay: $exercisesPerDay, isGenerating: $isGenerating, previewedMesocycle: $previewedMesocycle)';
}


}

/// @nodoc
abstract mixin class $MesocycleWizardStateCopyWith<$Res>  {
  factory $MesocycleWizardStateCopyWith(MesocycleWizardState value, $Res Function(MesocycleWizardState) _then) = _$MesocycleWizardStateCopyWithImpl;
@useResult
$Res call({
 int currentStep, String name, MesocycleGoal goal, String experienceLevel, String splitType, int weeksCount, int daysPerWeek, List<List<ExerciseEntity>> exercisesPerDay, bool isGenerating, MesocycleEntity? previewedMesocycle
});


$MesocycleEntityCopyWith<$Res>? get previewedMesocycle;

}
/// @nodoc
class _$MesocycleWizardStateCopyWithImpl<$Res>
    implements $MesocycleWizardStateCopyWith<$Res> {
  _$MesocycleWizardStateCopyWithImpl(this._self, this._then);

  final MesocycleWizardState _self;
  final $Res Function(MesocycleWizardState) _then;

/// Create a copy of MesocycleWizardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStep = null,Object? name = null,Object? goal = null,Object? experienceLevel = null,Object? splitType = null,Object? weeksCount = null,Object? daysPerWeek = null,Object? exercisesPerDay = null,Object? isGenerating = null,Object? previewedMesocycle = freezed,}) {
  return _then(_self.copyWith(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as MesocycleGoal,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as String,weeksCount: null == weeksCount ? _self.weeksCount : weeksCount // ignore: cast_nullable_to_non_nullable
as int,daysPerWeek: null == daysPerWeek ? _self.daysPerWeek : daysPerWeek // ignore: cast_nullable_to_non_nullable
as int,exercisesPerDay: null == exercisesPerDay ? _self.exercisesPerDay : exercisesPerDay // ignore: cast_nullable_to_non_nullable
as List<List<ExerciseEntity>>,isGenerating: null == isGenerating ? _self.isGenerating : isGenerating // ignore: cast_nullable_to_non_nullable
as bool,previewedMesocycle: freezed == previewedMesocycle ? _self.previewedMesocycle : previewedMesocycle // ignore: cast_nullable_to_non_nullable
as MesocycleEntity?,
  ));
}
/// Create a copy of MesocycleWizardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MesocycleEntityCopyWith<$Res>? get previewedMesocycle {
    if (_self.previewedMesocycle == null) {
    return null;
  }

  return $MesocycleEntityCopyWith<$Res>(_self.previewedMesocycle!, (value) {
    return _then(_self.copyWith(previewedMesocycle: value));
  });
}
}


/// Adds pattern-matching-related methods to [MesocycleWizardState].
extension MesocycleWizardStatePatterns on MesocycleWizardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MesocycleWizardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MesocycleWizardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MesocycleWizardState value)  $default,){
final _that = this;
switch (_that) {
case _MesocycleWizardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MesocycleWizardState value)?  $default,){
final _that = this;
switch (_that) {
case _MesocycleWizardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentStep,  String name,  MesocycleGoal goal,  String experienceLevel,  String splitType,  int weeksCount,  int daysPerWeek,  List<List<ExerciseEntity>> exercisesPerDay,  bool isGenerating,  MesocycleEntity? previewedMesocycle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MesocycleWizardState() when $default != null:
return $default(_that.currentStep,_that.name,_that.goal,_that.experienceLevel,_that.splitType,_that.weeksCount,_that.daysPerWeek,_that.exercisesPerDay,_that.isGenerating,_that.previewedMesocycle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentStep,  String name,  MesocycleGoal goal,  String experienceLevel,  String splitType,  int weeksCount,  int daysPerWeek,  List<List<ExerciseEntity>> exercisesPerDay,  bool isGenerating,  MesocycleEntity? previewedMesocycle)  $default,) {final _that = this;
switch (_that) {
case _MesocycleWizardState():
return $default(_that.currentStep,_that.name,_that.goal,_that.experienceLevel,_that.splitType,_that.weeksCount,_that.daysPerWeek,_that.exercisesPerDay,_that.isGenerating,_that.previewedMesocycle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentStep,  String name,  MesocycleGoal goal,  String experienceLevel,  String splitType,  int weeksCount,  int daysPerWeek,  List<List<ExerciseEntity>> exercisesPerDay,  bool isGenerating,  MesocycleEntity? previewedMesocycle)?  $default,) {final _that = this;
switch (_that) {
case _MesocycleWizardState() when $default != null:
return $default(_that.currentStep,_that.name,_that.goal,_that.experienceLevel,_that.splitType,_that.weeksCount,_that.daysPerWeek,_that.exercisesPerDay,_that.isGenerating,_that.previewedMesocycle);case _:
  return null;

}
}

}

/// @nodoc


class _MesocycleWizardState implements MesocycleWizardState {
  const _MesocycleWizardState({this.currentStep = 0, this.name = '', this.goal = MesocycleGoal.hypertrophy, this.experienceLevel = 'Intermediate', this.splitType = 'PPL (Push/Pull/Legs)', this.weeksCount = 4, this.daysPerWeek = 3, final  List<List<ExerciseEntity>> exercisesPerDay = const [], this.isGenerating = false, this.previewedMesocycle}): _exercisesPerDay = exercisesPerDay;
  

@override@JsonKey() final  int currentStep;
@override@JsonKey() final  String name;
@override@JsonKey() final  MesocycleGoal goal;
@override@JsonKey() final  String experienceLevel;
@override@JsonKey() final  String splitType;
@override@JsonKey() final  int weeksCount;
@override@JsonKey() final  int daysPerWeek;
 final  List<List<ExerciseEntity>> _exercisesPerDay;
@override@JsonKey() List<List<ExerciseEntity>> get exercisesPerDay {
  if (_exercisesPerDay is EqualUnmodifiableListView) return _exercisesPerDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercisesPerDay);
}

@override@JsonKey() final  bool isGenerating;
@override final  MesocycleEntity? previewedMesocycle;

/// Create a copy of MesocycleWizardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MesocycleWizardStateCopyWith<_MesocycleWizardState> get copyWith => __$MesocycleWizardStateCopyWithImpl<_MesocycleWizardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MesocycleWizardState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.name, name) || other.name == name)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&(identical(other.weeksCount, weeksCount) || other.weeksCount == weeksCount)&&(identical(other.daysPerWeek, daysPerWeek) || other.daysPerWeek == daysPerWeek)&&const DeepCollectionEquality().equals(other._exercisesPerDay, _exercisesPerDay)&&(identical(other.isGenerating, isGenerating) || other.isGenerating == isGenerating)&&(identical(other.previewedMesocycle, previewedMesocycle) || other.previewedMesocycle == previewedMesocycle));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,name,goal,experienceLevel,splitType,weeksCount,daysPerWeek,const DeepCollectionEquality().hash(_exercisesPerDay),isGenerating,previewedMesocycle);

@override
String toString() {
  return 'MesocycleWizardState(currentStep: $currentStep, name: $name, goal: $goal, experienceLevel: $experienceLevel, splitType: $splitType, weeksCount: $weeksCount, daysPerWeek: $daysPerWeek, exercisesPerDay: $exercisesPerDay, isGenerating: $isGenerating, previewedMesocycle: $previewedMesocycle)';
}


}

/// @nodoc
abstract mixin class _$MesocycleWizardStateCopyWith<$Res> implements $MesocycleWizardStateCopyWith<$Res> {
  factory _$MesocycleWizardStateCopyWith(_MesocycleWizardState value, $Res Function(_MesocycleWizardState) _then) = __$MesocycleWizardStateCopyWithImpl;
@override @useResult
$Res call({
 int currentStep, String name, MesocycleGoal goal, String experienceLevel, String splitType, int weeksCount, int daysPerWeek, List<List<ExerciseEntity>> exercisesPerDay, bool isGenerating, MesocycleEntity? previewedMesocycle
});


@override $MesocycleEntityCopyWith<$Res>? get previewedMesocycle;

}
/// @nodoc
class __$MesocycleWizardStateCopyWithImpl<$Res>
    implements _$MesocycleWizardStateCopyWith<$Res> {
  __$MesocycleWizardStateCopyWithImpl(this._self, this._then);

  final _MesocycleWizardState _self;
  final $Res Function(_MesocycleWizardState) _then;

/// Create a copy of MesocycleWizardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStep = null,Object? name = null,Object? goal = null,Object? experienceLevel = null,Object? splitType = null,Object? weeksCount = null,Object? daysPerWeek = null,Object? exercisesPerDay = null,Object? isGenerating = null,Object? previewedMesocycle = freezed,}) {
  return _then(_MesocycleWizardState(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as MesocycleGoal,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as String,weeksCount: null == weeksCount ? _self.weeksCount : weeksCount // ignore: cast_nullable_to_non_nullable
as int,daysPerWeek: null == daysPerWeek ? _self.daysPerWeek : daysPerWeek // ignore: cast_nullable_to_non_nullable
as int,exercisesPerDay: null == exercisesPerDay ? _self._exercisesPerDay : exercisesPerDay // ignore: cast_nullable_to_non_nullable
as List<List<ExerciseEntity>>,isGenerating: null == isGenerating ? _self.isGenerating : isGenerating // ignore: cast_nullable_to_non_nullable
as bool,previewedMesocycle: freezed == previewedMesocycle ? _self.previewedMesocycle : previewedMesocycle // ignore: cast_nullable_to_non_nullable
as MesocycleEntity?,
  ));
}

/// Create a copy of MesocycleWizardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MesocycleEntityCopyWith<$Res>? get previewedMesocycle {
    if (_self.previewedMesocycle == null) {
    return null;
  }

  return $MesocycleEntityCopyWith<$Res>(_self.previewedMesocycle!, (value) {
    return _then(_self.copyWith(previewedMesocycle: value));
  });
}
}

// dart format on
