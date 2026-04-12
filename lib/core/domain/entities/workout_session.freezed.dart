// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutSession {
  int get id;
  String get name;
  DateTime get date;
  DateTime? get startTime;
  DateTime? get endTime;
  int? get duration;
  int? get templateId;
  int? get dayId;
  String? get notes;
  String get status;
  List<LoggedExercise> get exercises;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutSessionCopyWith<WorkoutSession> get copyWith =>
      _$WorkoutSessionCopyWithImpl<WorkoutSession>(
          this as WorkoutSession, _$identity);

  /// Serializes this WorkoutSession to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutSession &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.dayId, dayId) || other.dayId == dayId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.exercises, exercises));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      date,
      startTime,
      endTime,
      duration,
      templateId,
      dayId,
      notes,
      status,
      const DeepCollectionEquality().hash(exercises));

  @override
  String toString() {
    return 'WorkoutSession(id: $id, name: $name, date: $date, startTime: $startTime, endTime: $endTime, duration: $duration, templateId: $templateId, dayId: $dayId, notes: $notes, status: $status, exercises: $exercises)';
  }
}

/// @nodoc
abstract mixin class $WorkoutSessionCopyWith<$Res> {
  factory $WorkoutSessionCopyWith(
          WorkoutSession value, $Res Function(WorkoutSession) _then) =
      _$WorkoutSessionCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      DateTime date,
      DateTime? startTime,
      DateTime? endTime,
      int? duration,
      int? templateId,
      int? dayId,
      String? notes,
      String status,
      List<LoggedExercise> exercises});
}

/// @nodoc
class _$WorkoutSessionCopyWithImpl<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  _$WorkoutSessionCopyWithImpl(this._self, this._then);

  final WorkoutSession _self;
  final $Res Function(WorkoutSession) _then;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? date = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? duration = freezed,
    Object? templateId = freezed,
    Object? dayId = freezed,
    Object? notes = freezed,
    Object? status = null,
    Object? exercises = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: freezed == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      templateId: freezed == templateId
          ? _self.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as int?,
      dayId: freezed == dayId
          ? _self.dayId
          : dayId // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      exercises: null == exercises
          ? _self.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<LoggedExercise>,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkoutSession].
extension WorkoutSessionPatterns on WorkoutSession {
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
    TResult Function(_WorkoutSession value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutSession() when $default != null:
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
    TResult Function(_WorkoutSession value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutSession():
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
    TResult? Function(_WorkoutSession value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutSession() when $default != null:
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
            String name,
            DateTime date,
            DateTime? startTime,
            DateTime? endTime,
            int? duration,
            int? templateId,
            int? dayId,
            String? notes,
            String status,
            List<LoggedExercise> exercises)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutSession() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.date,
            _that.startTime,
            _that.endTime,
            _that.duration,
            _that.templateId,
            _that.dayId,
            _that.notes,
            _that.status,
            _that.exercises);
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
            String name,
            DateTime date,
            DateTime? startTime,
            DateTime? endTime,
            int? duration,
            int? templateId,
            int? dayId,
            String? notes,
            String status,
            List<LoggedExercise> exercises)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutSession():
        return $default(
            _that.id,
            _that.name,
            _that.date,
            _that.startTime,
            _that.endTime,
            _that.duration,
            _that.templateId,
            _that.dayId,
            _that.notes,
            _that.status,
            _that.exercises);
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
            String name,
            DateTime date,
            DateTime? startTime,
            DateTime? endTime,
            int? duration,
            int? templateId,
            int? dayId,
            String? notes,
            String status,
            List<LoggedExercise> exercises)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutSession() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.date,
            _that.startTime,
            _that.endTime,
            _that.duration,
            _that.templateId,
            _that.dayId,
            _that.notes,
            _that.status,
            _that.exercises);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkoutSession extends WorkoutSession {
  const _WorkoutSession(
      {required this.id,
      required this.name,
      required this.date,
      this.startTime,
      this.endTime,
      this.duration,
      this.templateId,
      this.dayId,
      this.notes,
      this.status = 'draft',
      final List<LoggedExercise> exercises = const []})
      : _exercises = exercises,
        super._();
  factory _WorkoutSession.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSessionFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final DateTime date;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final int? duration;
  @override
  final int? templateId;
  @override
  final int? dayId;
  @override
  final String? notes;
  @override
  @JsonKey()
  final String status;
  final List<LoggedExercise> _exercises;
  @override
  @JsonKey()
  List<LoggedExercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutSessionCopyWith<_WorkoutSession> get copyWith =>
      __$WorkoutSessionCopyWithImpl<_WorkoutSession>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutSessionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutSession &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.dayId, dayId) || other.dayId == dayId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._exercises, _exercises));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      date,
      startTime,
      endTime,
      duration,
      templateId,
      dayId,
      notes,
      status,
      const DeepCollectionEquality().hash(_exercises));

  @override
  String toString() {
    return 'WorkoutSession(id: $id, name: $name, date: $date, startTime: $startTime, endTime: $endTime, duration: $duration, templateId: $templateId, dayId: $dayId, notes: $notes, status: $status, exercises: $exercises)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutSessionCopyWith<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  factory _$WorkoutSessionCopyWith(
          _WorkoutSession value, $Res Function(_WorkoutSession) _then) =
      __$WorkoutSessionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      DateTime date,
      DateTime? startTime,
      DateTime? endTime,
      int? duration,
      int? templateId,
      int? dayId,
      String? notes,
      String status,
      List<LoggedExercise> exercises});
}

/// @nodoc
class __$WorkoutSessionCopyWithImpl<$Res>
    implements _$WorkoutSessionCopyWith<$Res> {
  __$WorkoutSessionCopyWithImpl(this._self, this._then);

  final _WorkoutSession _self;
  final $Res Function(_WorkoutSession) _then;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? date = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? duration = freezed,
    Object? templateId = freezed,
    Object? dayId = freezed,
    Object? notes = freezed,
    Object? status = null,
    Object? exercises = null,
  }) {
    return _then(_WorkoutSession(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: freezed == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      templateId: freezed == templateId
          ? _self.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as int?,
      dayId: freezed == dayId
          ? _self.dayId
          : dayId // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      exercises: null == exercises
          ? _self._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<LoggedExercise>,
    ));
  }
}

/// @nodoc
mixin _$LoggedExercise {
  int get exerciseId;
  String get exerciseName;
  int get order;
  List<LoggedSet> get sets;

  /// Create a copy of LoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoggedExerciseCopyWith<LoggedExercise> get copyWith =>
      _$LoggedExerciseCopyWithImpl<LoggedExercise>(
          this as LoggedExercise, _$identity);

  /// Serializes this LoggedExercise to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoggedExercise &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.exerciseName, exerciseName) ||
                other.exerciseName == exerciseName) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality().equals(other.sets, sets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, exerciseId, exerciseName, order,
      const DeepCollectionEquality().hash(sets));

  @override
  String toString() {
    return 'LoggedExercise(exerciseId: $exerciseId, exerciseName: $exerciseName, order: $order, sets: $sets)';
  }
}

/// @nodoc
abstract mixin class $LoggedExerciseCopyWith<$Res> {
  factory $LoggedExerciseCopyWith(
          LoggedExercise value, $Res Function(LoggedExercise) _then) =
      _$LoggedExerciseCopyWithImpl;
  @useResult
  $Res call(
      {int exerciseId, String exerciseName, int order, List<LoggedSet> sets});
}

/// @nodoc
class _$LoggedExerciseCopyWithImpl<$Res>
    implements $LoggedExerciseCopyWith<$Res> {
  _$LoggedExerciseCopyWithImpl(this._self, this._then);

  final LoggedExercise _self;
  final $Res Function(LoggedExercise) _then;

  /// Create a copy of LoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? exerciseName = null,
    Object? order = null,
    Object? sets = null,
  }) {
    return _then(_self.copyWith(
      exerciseId: null == exerciseId
          ? _self.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseName: null == exerciseName
          ? _self.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      sets: null == sets
          ? _self.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<LoggedSet>,
    ));
  }
}

/// Adds pattern-matching-related methods to [LoggedExercise].
extension LoggedExercisePatterns on LoggedExercise {
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
    TResult Function(_LoggedExercise value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoggedExercise() when $default != null:
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
    TResult Function(_LoggedExercise value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoggedExercise():
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
    TResult? Function(_LoggedExercise value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoggedExercise() when $default != null:
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
    TResult Function(int exerciseId, String exerciseName, int order,
            List<LoggedSet> sets)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoggedExercise() when $default != null:
        return $default(
            _that.exerciseId, _that.exerciseName, _that.order, _that.sets);
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
    TResult Function(int exerciseId, String exerciseName, int order,
            List<LoggedSet> sets)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoggedExercise():
        return $default(
            _that.exerciseId, _that.exerciseName, _that.order, _that.sets);
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
    TResult? Function(int exerciseId, String exerciseName, int order,
            List<LoggedSet> sets)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoggedExercise() when $default != null:
        return $default(
            _that.exerciseId, _that.exerciseName, _that.order, _that.sets);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LoggedExercise extends LoggedExercise {
  const _LoggedExercise(
      {required this.exerciseId,
      required this.exerciseName,
      required this.order,
      final List<LoggedSet> sets = const []})
      : _sets = sets,
        super._();
  factory _LoggedExercise.fromJson(Map<String, dynamic> json) =>
      _$LoggedExerciseFromJson(json);

  @override
  final int exerciseId;
  @override
  final String exerciseName;
  @override
  final int order;
  final List<LoggedSet> _sets;
  @override
  @JsonKey()
  List<LoggedSet> get sets {
    if (_sets is EqualUnmodifiableListView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sets);
  }

  /// Create a copy of LoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoggedExerciseCopyWith<_LoggedExercise> get copyWith =>
      __$LoggedExerciseCopyWithImpl<_LoggedExercise>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LoggedExerciseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoggedExercise &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.exerciseName, exerciseName) ||
                other.exerciseName == exerciseName) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality().equals(other._sets, _sets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, exerciseId, exerciseName, order,
      const DeepCollectionEquality().hash(_sets));

  @override
  String toString() {
    return 'LoggedExercise(exerciseId: $exerciseId, exerciseName: $exerciseName, order: $order, sets: $sets)';
  }
}

/// @nodoc
abstract mixin class _$LoggedExerciseCopyWith<$Res>
    implements $LoggedExerciseCopyWith<$Res> {
  factory _$LoggedExerciseCopyWith(
          _LoggedExercise value, $Res Function(_LoggedExercise) _then) =
      __$LoggedExerciseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int exerciseId, String exerciseName, int order, List<LoggedSet> sets});
}

/// @nodoc
class __$LoggedExerciseCopyWithImpl<$Res>
    implements _$LoggedExerciseCopyWith<$Res> {
  __$LoggedExerciseCopyWithImpl(this._self, this._then);

  final _LoggedExercise _self;
  final $Res Function(_LoggedExercise) _then;

  /// Create a copy of LoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? exerciseId = null,
    Object? exerciseName = null,
    Object? order = null,
    Object? sets = null,
  }) {
    return _then(_LoggedExercise(
      exerciseId: null == exerciseId
          ? _self.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseName: null == exerciseName
          ? _self.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      sets: null == sets
          ? _self._sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<LoggedSet>,
    ));
  }
}

// dart format on
