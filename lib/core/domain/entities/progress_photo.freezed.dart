// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProgressPhoto {

 int get id; DateTime get date; String get imagePath; String get category; String? get notes;
/// Create a copy of ProgressPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressPhotoCopyWith<ProgressPhoto> get copyWith => _$ProgressPhotoCopyWithImpl<ProgressPhoto>(this as ProgressPhoto, _$identity);

  /// Serializes this ProgressPhoto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.category, category) || other.category == category)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,imagePath,category,notes);

@override
String toString() {
  return 'ProgressPhoto(id: $id, date: $date, imagePath: $imagePath, category: $category, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $ProgressPhotoCopyWith<$Res>  {
  factory $ProgressPhotoCopyWith(ProgressPhoto value, $Res Function(ProgressPhoto) _then) = _$ProgressPhotoCopyWithImpl;
@useResult
$Res call({
 int id, DateTime date, String imagePath, String category, String? notes
});




}
/// @nodoc
class _$ProgressPhotoCopyWithImpl<$Res>
    implements $ProgressPhotoCopyWith<$Res> {
  _$ProgressPhotoCopyWithImpl(this._self, this._then);

  final ProgressPhoto _self;
  final $Res Function(ProgressPhoto) _then;

/// Create a copy of ProgressPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? imagePath = null,Object? category = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgressPhoto].
extension ProgressPhotoPatterns on ProgressPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgressPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgressPhoto value)  $default,){
final _that = this;
switch (_that) {
case _ProgressPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgressPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _ProgressPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime date,  String imagePath,  String category,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressPhoto() when $default != null:
return $default(_that.id,_that.date,_that.imagePath,_that.category,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime date,  String imagePath,  String category,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _ProgressPhoto():
return $default(_that.id,_that.date,_that.imagePath,_that.category,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime date,  String imagePath,  String category,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _ProgressPhoto() when $default != null:
return $default(_that.id,_that.date,_that.imagePath,_that.category,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressPhoto extends ProgressPhoto {
  const _ProgressPhoto({required this.id, required this.date, required this.imagePath, this.category = 'front', this.notes}): super._();
  factory _ProgressPhoto.fromJson(Map<String, dynamic> json) => _$ProgressPhotoFromJson(json);

@override final  int id;
@override final  DateTime date;
@override final  String imagePath;
@override@JsonKey() final  String category;
@override final  String? notes;

/// Create a copy of ProgressPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressPhotoCopyWith<_ProgressPhoto> get copyWith => __$ProgressPhotoCopyWithImpl<_ProgressPhoto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressPhotoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.category, category) || other.category == category)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,imagePath,category,notes);

@override
String toString() {
  return 'ProgressPhoto(id: $id, date: $date, imagePath: $imagePath, category: $category, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$ProgressPhotoCopyWith<$Res> implements $ProgressPhotoCopyWith<$Res> {
  factory _$ProgressPhotoCopyWith(_ProgressPhoto value, $Res Function(_ProgressPhoto) _then) = __$ProgressPhotoCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime date, String imagePath, String category, String? notes
});




}
/// @nodoc
class __$ProgressPhotoCopyWithImpl<$Res>
    implements _$ProgressPhotoCopyWith<$Res> {
  __$ProgressPhotoCopyWithImpl(this._self, this._then);

  final _ProgressPhoto _self;
  final $Res Function(_ProgressPhoto) _then;

/// Create a copy of ProgressPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? imagePath = null,Object? category = null,Object? notes = freezed,}) {
  return _then(_ProgressPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
