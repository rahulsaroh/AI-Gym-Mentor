// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'programs_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProgramsState {

 List<WorkoutProgram> get templates; bool get isLoading; String? get errorMessage;
/// Create a copy of ProgramsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgramsStateCopyWith<ProgramsState> get copyWith => _$ProgramsStateCopyWithImpl<ProgramsState>(this as ProgramsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgramsState&&const DeepCollectionEquality().equals(other.templates, templates)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(templates),isLoading,errorMessage);

@override
String toString() {
  return 'ProgramsState(templates: $templates, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ProgramsStateCopyWith<$Res>  {
  factory $ProgramsStateCopyWith(ProgramsState value, $Res Function(ProgramsState) _then) = _$ProgramsStateCopyWithImpl;
@useResult
$Res call({
 List<WorkoutProgram> templates, bool isLoading, String? errorMessage
});




}
/// @nodoc
class _$ProgramsStateCopyWithImpl<$Res>
    implements $ProgramsStateCopyWith<$Res> {
  _$ProgramsStateCopyWithImpl(this._self, this._then);

  final ProgramsState _self;
  final $Res Function(ProgramsState) _then;

/// Create a copy of ProgramsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? templates = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
templates: null == templates ? _self.templates : templates // ignore: cast_nullable_to_non_nullable
as List<WorkoutProgram>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgramsState].
extension ProgramsStatePatterns on ProgramsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgramsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgramsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgramsState value)  $default,){
final _that = this;
switch (_that) {
case _ProgramsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgramsState value)?  $default,){
final _that = this;
switch (_that) {
case _ProgramsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WorkoutProgram> templates,  bool isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgramsState() when $default != null:
return $default(_that.templates,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WorkoutProgram> templates,  bool isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ProgramsState():
return $default(_that.templates,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WorkoutProgram> templates,  bool isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ProgramsState() when $default != null:
return $default(_that.templates,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ProgramsState extends ProgramsState {
  const _ProgramsState({final  List<WorkoutProgram> templates = const [], this.isLoading = false, this.errorMessage}): _templates = templates,super._();
  

 final  List<WorkoutProgram> _templates;
@override@JsonKey() List<WorkoutProgram> get templates {
  if (_templates is EqualUnmodifiableListView) return _templates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_templates);
}

@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of ProgramsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgramsStateCopyWith<_ProgramsState> get copyWith => __$ProgramsStateCopyWithImpl<_ProgramsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgramsState&&const DeepCollectionEquality().equals(other._templates, _templates)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_templates),isLoading,errorMessage);

@override
String toString() {
  return 'ProgramsState(templates: $templates, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ProgramsStateCopyWith<$Res> implements $ProgramsStateCopyWith<$Res> {
  factory _$ProgramsStateCopyWith(_ProgramsState value, $Res Function(_ProgramsState) _then) = __$ProgramsStateCopyWithImpl;
@override @useResult
$Res call({
 List<WorkoutProgram> templates, bool isLoading, String? errorMessage
});




}
/// @nodoc
class __$ProgramsStateCopyWithImpl<$Res>
    implements _$ProgramsStateCopyWith<$Res> {
  __$ProgramsStateCopyWithImpl(this._self, this._then);

  final _ProgramsState _self;
  final $Res Function(_ProgramsState) _then;

/// Create a copy of ProgramsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? templates = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_ProgramsState(
templates: null == templates ? _self._templates : templates // ignore: cast_nullable_to_non_nullable
as List<WorkoutProgram>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
