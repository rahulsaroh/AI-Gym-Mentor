// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_target.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BodyTarget {
  int get id;
  String get metric;
  double get targetValue;
  DateTime? get deadline;
  DateTime get createdAt;

  /// Create a copy of BodyTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BodyTargetCopyWith<BodyTarget> get copyWith =>
      _$BodyTargetCopyWithImpl<BodyTarget>(this as BodyTarget, _$identity);

  /// Serializes this BodyTarget to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BodyTarget &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.metric, metric) || other.metric == metric) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, metric, targetValue, deadline, createdAt);

  @override
  String toString() {
    return 'BodyTarget(id: $id, metric: $metric, targetValue: $targetValue, deadline: $deadline, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $BodyTargetCopyWith<$Res> {
  factory $BodyTargetCopyWith(
          BodyTarget value, $Res Function(BodyTarget) _then) =
      _$BodyTargetCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String metric,
      double targetValue,
      DateTime? deadline,
      DateTime createdAt});
}

/// @nodoc
class _$BodyTargetCopyWithImpl<$Res> implements $BodyTargetCopyWith<$Res> {
  _$BodyTargetCopyWithImpl(this._self, this._then);

  final BodyTarget _self;
  final $Res Function(BodyTarget) _then;

  /// Create a copy of BodyTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? metric = null,
    Object? targetValue = null,
    Object? deadline = freezed,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      metric: null == metric
          ? _self.metric
          : metric // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: null == targetValue
          ? _self.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      deadline: freezed == deadline
          ? _self.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [BodyTarget].
extension BodyTargetPatterns on BodyTarget {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BodyTarget value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BodyTarget() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BodyTarget value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BodyTarget():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BodyTarget value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BodyTarget() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, String metric, double targetValue,
            DateTime? deadline, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BodyTarget() when $default != null:
        return $default(_that.id, _that.metric, _that.targetValue,
            _that.deadline, _that.createdAt);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, String metric, double targetValue,
            DateTime? deadline, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BodyTarget():
        return $default(_that.id, _that.metric, _that.targetValue,
            _that.deadline, _that.createdAt);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, String metric, double targetValue,
            DateTime? deadline, DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BodyTarget() when $default != null:
        return $default(_that.id, _that.metric, _that.targetValue,
            _that.deadline, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BodyTarget extends BodyTarget {
  const _BodyTarget(
      {required this.id,
      required this.metric,
      required this.targetValue,
      this.deadline,
      required this.createdAt})
      : super._();
  factory _BodyTarget.fromJson(Map<String, dynamic> json) =>
      _$BodyTargetFromJson(json);

  @override
  final int id;
  @override
  final String metric;
  @override
  final double targetValue;
  @override
  final DateTime? deadline;
  @override
  final DateTime createdAt;

  /// Create a copy of BodyTarget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BodyTargetCopyWith<_BodyTarget> get copyWith =>
      __$BodyTargetCopyWithImpl<_BodyTarget>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BodyTargetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BodyTarget &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.metric, metric) || other.metric == metric) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, metric, targetValue, deadline, createdAt);

  @override
  String toString() {
    return 'BodyTarget(id: $id, metric: $metric, targetValue: $targetValue, deadline: $deadline, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$BodyTargetCopyWith<$Res>
    implements $BodyTargetCopyWith<$Res> {
  factory _$BodyTargetCopyWith(
          _BodyTarget value, $Res Function(_BodyTarget) _then) =
      __$BodyTargetCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String metric,
      double targetValue,
      DateTime? deadline,
      DateTime createdAt});
}

/// @nodoc
class __$BodyTargetCopyWithImpl<$Res> implements _$BodyTargetCopyWith<$Res> {
  __$BodyTargetCopyWithImpl(this._self, this._then);

  final _BodyTarget _self;
  final $Res Function(_BodyTarget) _then;

  /// Create a copy of BodyTarget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? metric = null,
    Object? targetValue = null,
    Object? deadline = freezed,
    Object? createdAt = null,
  }) {
    return _then(_BodyTarget(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      metric: null == metric
          ? _self.metric
          : metric // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: null == targetValue
          ? _self.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      deadline: freezed == deadline
          ? _self.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
