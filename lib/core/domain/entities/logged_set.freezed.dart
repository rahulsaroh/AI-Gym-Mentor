// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logged_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoggedSet {
  int get id;
  int get workoutId;
  int get exerciseId;
  int get exerciseOrder;
  int get setNumber;
  double get weight;
  double get reps;
  double? get rpe;
  int? get rir;
  SetType get setType;
  String? get notes;
  bool get completed;
  DateTime? get completedAt;
  bool get isPr;
  String? get supersetGroupId;

  /// Create a copy of LoggedSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoggedSetCopyWith<LoggedSet> get copyWith =>
      _$LoggedSetCopyWithImpl<LoggedSet>(this as LoggedSet, _$identity);

  /// Serializes this LoggedSet to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoggedSet &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workoutId, workoutId) ||
                other.workoutId == workoutId) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.exerciseOrder, exerciseOrder) ||
                other.exerciseOrder == exerciseOrder) &&
            (identical(other.setNumber, setNumber) ||
                other.setNumber == setNumber) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.rpe, rpe) || other.rpe == rpe) &&
            (identical(other.rir, rir) || other.rir == rir) &&
            (identical(other.setType, setType) || other.setType == setType) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.isPr, isPr) || other.isPr == isPr) &&
            (identical(other.supersetGroupId, supersetGroupId) ||
                other.supersetGroupId == supersetGroupId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      workoutId,
      exerciseId,
      exerciseOrder,
      setNumber,
      weight,
      reps,
      rpe,
      rir,
      setType,
      notes,
      completed,
      completedAt,
      isPr,
      supersetGroupId);

  @override
  String toString() {
    return 'LoggedSet(id: $id, workoutId: $workoutId, exerciseId: $exerciseId, exerciseOrder: $exerciseOrder, setNumber: $setNumber, weight: $weight, reps: $reps, rpe: $rpe, rir: $rir, setType: $setType, notes: $notes, completed: $completed, completedAt: $completedAt, isPr: $isPr, supersetGroupId: $supersetGroupId)';
  }
}

/// @nodoc
abstract mixin class $LoggedSetCopyWith<$Res> {
  factory $LoggedSetCopyWith(LoggedSet value, $Res Function(LoggedSet) _then) =
      _$LoggedSetCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      int workoutId,
      int exerciseId,
      int exerciseOrder,
      int setNumber,
      double weight,
      double reps,
      double? rpe,
      int? rir,
      SetType setType,
      String? notes,
      bool completed,
      DateTime? completedAt,
      bool isPr,
      String? supersetGroupId});
}

/// @nodoc
class _$LoggedSetCopyWithImpl<$Res> implements $LoggedSetCopyWith<$Res> {
  _$LoggedSetCopyWithImpl(this._self, this._then);

  final LoggedSet _self;
  final $Res Function(LoggedSet) _then;

  /// Create a copy of LoggedSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workoutId = null,
    Object? exerciseId = null,
    Object? exerciseOrder = null,
    Object? setNumber = null,
    Object? weight = null,
    Object? reps = null,
    Object? rpe = freezed,
    Object? rir = freezed,
    Object? setType = null,
    Object? notes = freezed,
    Object? completed = null,
    Object? completedAt = freezed,
    Object? isPr = null,
    Object? supersetGroupId = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      workoutId: null == workoutId
          ? _self.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseId: null == exerciseId
          ? _self.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseOrder: null == exerciseOrder
          ? _self.exerciseOrder
          : exerciseOrder // ignore: cast_nullable_to_non_nullable
              as int,
      setNumber: null == setNumber
          ? _self.setNumber
          : setNumber // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      reps: null == reps
          ? _self.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as double,
      rpe: freezed == rpe
          ? _self.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as double?,
      rir: freezed == rir
          ? _self.rir
          : rir // ignore: cast_nullable_to_non_nullable
              as int?,
      setType: null == setType
          ? _self.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as SetType,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isPr: null == isPr
          ? _self.isPr
          : isPr // ignore: cast_nullable_to_non_nullable
              as bool,
      supersetGroupId: freezed == supersetGroupId
          ? _self.supersetGroupId
          : supersetGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LoggedSet].
extension LoggedSetPatterns on LoggedSet {
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
    TResult Function(_LoggedSet value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoggedSet() when $default != null:
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
    TResult Function(_LoggedSet value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoggedSet():
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
    TResult? Function(_LoggedSet value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoggedSet() when $default != null:
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
    TResult Function(
            int id,
            int workoutId,
            int exerciseId,
            int exerciseOrder,
            int setNumber,
            double weight,
            double reps,
            double? rpe,
            int? rir,
            SetType setType,
            String? notes,
            bool completed,
            DateTime? completedAt,
            bool isPr,
            String? supersetGroupId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoggedSet() when $default != null:
        return $default(
            _that.id,
            _that.workoutId,
            _that.exerciseId,
            _that.exerciseOrder,
            _that.setNumber,
            _that.weight,
            _that.reps,
            _that.rpe,
            _that.rir,
            _that.setType,
            _that.notes,
            _that.completed,
            _that.completedAt,
            _that.isPr,
            _that.supersetGroupId);
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
    TResult Function(
            int id,
            int workoutId,
            int exerciseId,
            int exerciseOrder,
            int setNumber,
            double weight,
            double reps,
            double? rpe,
            int? rir,
            SetType setType,
            String? notes,
            bool completed,
            DateTime? completedAt,
            bool isPr,
            String? supersetGroupId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoggedSet():
        return $default(
            _that.id,
            _that.workoutId,
            _that.exerciseId,
            _that.exerciseOrder,
            _that.setNumber,
            _that.weight,
            _that.reps,
            _that.rpe,
            _that.rir,
            _that.setType,
            _that.notes,
            _that.completed,
            _that.completedAt,
            _that.isPr,
            _that.supersetGroupId);
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
    TResult? Function(
            int id,
            int workoutId,
            int exerciseId,
            int exerciseOrder,
            int setNumber,
            double weight,
            double reps,
            double? rpe,
            int? rir,
            SetType setType,
            String? notes,
            bool completed,
            DateTime? completedAt,
            bool isPr,
            String? supersetGroupId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoggedSet() when $default != null:
        return $default(
            _that.id,
            _that.workoutId,
            _that.exerciseId,
            _that.exerciseOrder,
            _that.setNumber,
            _that.weight,
            _that.reps,
            _that.rpe,
            _that.rir,
            _that.setType,
            _that.notes,
            _that.completed,
            _that.completedAt,
            _that.isPr,
            _that.supersetGroupId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LoggedSet extends LoggedSet {
  const _LoggedSet(
      {required this.id,
      required this.workoutId,
      required this.exerciseId,
      required this.exerciseOrder,
      required this.setNumber,
      required this.weight,
      required this.reps,
      this.rpe,
      this.rir,
      this.setType = SetType.straight,
      this.notes,
      this.completed = false,
      this.completedAt,
      this.isPr = false,
      this.supersetGroupId})
      : super._();
  factory _LoggedSet.fromJson(Map<String, dynamic> json) =>
      _$LoggedSetFromJson(json);

  @override
  final int id;
  @override
  final int workoutId;
  @override
  final int exerciseId;
  @override
  final int exerciseOrder;
  @override
  final int setNumber;
  @override
  final double weight;
  @override
  final double reps;
  @override
  final double? rpe;
  @override
  final int? rir;
  @override
  @JsonKey()
  final SetType setType;
  @override
  final String? notes;
  @override
  @JsonKey()
  final bool completed;
  @override
  final DateTime? completedAt;
  @override
  @JsonKey()
  final bool isPr;
  @override
  final String? supersetGroupId;

  /// Create a copy of LoggedSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoggedSetCopyWith<_LoggedSet> get copyWith =>
      __$LoggedSetCopyWithImpl<_LoggedSet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LoggedSetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoggedSet &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workoutId, workoutId) ||
                other.workoutId == workoutId) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.exerciseOrder, exerciseOrder) ||
                other.exerciseOrder == exerciseOrder) &&
            (identical(other.setNumber, setNumber) ||
                other.setNumber == setNumber) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.rpe, rpe) || other.rpe == rpe) &&
            (identical(other.rir, rir) || other.rir == rir) &&
            (identical(other.setType, setType) || other.setType == setType) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.isPr, isPr) || other.isPr == isPr) &&
            (identical(other.supersetGroupId, supersetGroupId) ||
                other.supersetGroupId == supersetGroupId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      workoutId,
      exerciseId,
      exerciseOrder,
      setNumber,
      weight,
      reps,
      rpe,
      rir,
      setType,
      notes,
      completed,
      completedAt,
      isPr,
      supersetGroupId);

  @override
  String toString() {
    return 'LoggedSet(id: $id, workoutId: $workoutId, exerciseId: $exerciseId, exerciseOrder: $exerciseOrder, setNumber: $setNumber, weight: $weight, reps: $reps, rpe: $rpe, rir: $rir, setType: $setType, notes: $notes, completed: $completed, completedAt: $completedAt, isPr: $isPr, supersetGroupId: $supersetGroupId)';
  }
}

/// @nodoc
abstract mixin class _$LoggedSetCopyWith<$Res>
    implements $LoggedSetCopyWith<$Res> {
  factory _$LoggedSetCopyWith(
          _LoggedSet value, $Res Function(_LoggedSet) _then) =
      __$LoggedSetCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      int workoutId,
      int exerciseId,
      int exerciseOrder,
      int setNumber,
      double weight,
      double reps,
      double? rpe,
      int? rir,
      SetType setType,
      String? notes,
      bool completed,
      DateTime? completedAt,
      bool isPr,
      String? supersetGroupId});
}

/// @nodoc
class __$LoggedSetCopyWithImpl<$Res> implements _$LoggedSetCopyWith<$Res> {
  __$LoggedSetCopyWithImpl(this._self, this._then);

  final _LoggedSet _self;
  final $Res Function(_LoggedSet) _then;

  /// Create a copy of LoggedSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? workoutId = null,
    Object? exerciseId = null,
    Object? exerciseOrder = null,
    Object? setNumber = null,
    Object? weight = null,
    Object? reps = null,
    Object? rpe = freezed,
    Object? rir = freezed,
    Object? setType = null,
    Object? notes = freezed,
    Object? completed = null,
    Object? completedAt = freezed,
    Object? isPr = null,
    Object? supersetGroupId = freezed,
  }) {
    return _then(_LoggedSet(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      workoutId: null == workoutId
          ? _self.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseId: null == exerciseId
          ? _self.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseOrder: null == exerciseOrder
          ? _self.exerciseOrder
          : exerciseOrder // ignore: cast_nullable_to_non_nullable
              as int,
      setNumber: null == setNumber
          ? _self.setNumber
          : setNumber // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      reps: null == reps
          ? _self.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as double,
      rpe: freezed == rpe
          ? _self.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as double?,
      rir: freezed == rir
          ? _self.rir
          : rir // ignore: cast_nullable_to_non_nullable
              as int?,
      setType: null == setType
          ? _self.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as SetType,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isPr: null == isPr
          ? _self.isPr
          : isPr // ignore: cast_nullable_to_non_nullable
              as bool,
      supersetGroupId: freezed == supersetGroupId
          ? _self.supersetGroupId
          : supersetGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
