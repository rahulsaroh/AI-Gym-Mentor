// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mesocycles_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MesocyclesState {

 List<MesocycleEntity> get mesocycles; bool get isLoading; String? get errorMessage;
/// Create a copy of MesocyclesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MesocyclesStateCopyWith<MesocyclesState> get copyWith => _$MesocyclesStateCopyWithImpl<MesocyclesState>(this as MesocyclesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MesocyclesState&&const DeepCollectionEquality().equals(other.mesocycles, mesocycles)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(mesocycles),isLoading,errorMessage);

@override
String toString() {
  return 'MesocyclesState(mesocycles: $mesocycles, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $MesocyclesStateCopyWith<$Res>  {
  factory $MesocyclesStateCopyWith(MesocyclesState value, $Res Function(MesocyclesState) _then) = _$MesocyclesStateCopyWithImpl;
@useResult
$Res call({
 List<MesocycleEntity> mesocycles, bool isLoading, String? errorMessage
});




}
/// @nodoc
class _$MesocyclesStateCopyWithImpl<$Res>
    implements $MesocyclesStateCopyWith<$Res> {
  _$MesocyclesStateCopyWithImpl(this._self, this._then);

  final MesocyclesState _self;
  final $Res Function(MesocyclesState) _then;

/// Create a copy of MesocyclesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mesocycles = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
mesocycles: null == mesocycles ? _self.mesocycles : mesocycles // ignore: cast_nullable_to_non_nullable
as List<MesocycleEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MesocyclesState].
extension MesocyclesStatePatterns on MesocyclesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MesocyclesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MesocyclesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MesocyclesState value)  $default,){
final _that = this;
switch (_that) {
case _MesocyclesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MesocyclesState value)?  $default,){
final _that = this;
switch (_that) {
case _MesocyclesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MesocycleEntity> mesocycles,  bool isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MesocyclesState() when $default != null:
return $default(_that.mesocycles,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MesocycleEntity> mesocycles,  bool isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _MesocyclesState():
return $default(_that.mesocycles,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MesocycleEntity> mesocycles,  bool isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _MesocyclesState() when $default != null:
return $default(_that.mesocycles,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _MesocyclesState implements MesocyclesState {
  const _MesocyclesState({final  List<MesocycleEntity> mesocycles = const [], this.isLoading = false, this.errorMessage}): _mesocycles = mesocycles;
  

 final  List<MesocycleEntity> _mesocycles;
@override@JsonKey() List<MesocycleEntity> get mesocycles {
  if (_mesocycles is EqualUnmodifiableListView) return _mesocycles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mesocycles);
}

@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of MesocyclesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MesocyclesStateCopyWith<_MesocyclesState> get copyWith => __$MesocyclesStateCopyWithImpl<_MesocyclesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MesocyclesState&&const DeepCollectionEquality().equals(other._mesocycles, _mesocycles)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_mesocycles),isLoading,errorMessage);

@override
String toString() {
  return 'MesocyclesState(mesocycles: $mesocycles, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$MesocyclesStateCopyWith<$Res> implements $MesocyclesStateCopyWith<$Res> {
  factory _$MesocyclesStateCopyWith(_MesocyclesState value, $Res Function(_MesocyclesState) _then) = __$MesocyclesStateCopyWithImpl;
@override @useResult
$Res call({
 List<MesocycleEntity> mesocycles, bool isLoading, String? errorMessage
});




}
/// @nodoc
class __$MesocyclesStateCopyWithImpl<$Res>
    implements _$MesocyclesStateCopyWith<$Res> {
  __$MesocyclesStateCopyWithImpl(this._self, this._then);

  final _MesocyclesState _self;
  final $Res Function(_MesocyclesState) _then;

/// Create a copy of MesocyclesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mesocycles = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_MesocyclesState(
mesocycles: null == mesocycles ? _self._mesocycles : mesocycles // ignore: cast_nullable_to_non_nullable
as List<MesocycleEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
