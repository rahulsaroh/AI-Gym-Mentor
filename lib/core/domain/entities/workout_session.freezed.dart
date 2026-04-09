// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkoutSession _$WorkoutSessionFromJson(Map<String, dynamic> json) {
  return _WorkoutSession.fromJson(json);
}

/// @nodoc
mixin _$WorkoutSession {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  int? get templateId => throw _privateConstructorUsedError;
  int? get dayId => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<LoggedExercise> get exercises => throw _privateConstructorUsedError;

  /// Serializes this WorkoutSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSessionCopyWith<WorkoutSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSessionCopyWith<$Res> {
  factory $WorkoutSessionCopyWith(
          WorkoutSession value, $Res Function(WorkoutSession) then) =
      _$WorkoutSessionCopyWithImpl<$Res, WorkoutSession>;
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
class _$WorkoutSessionCopyWithImpl<$Res, $Val extends WorkoutSession>
    implements $WorkoutSessionCopyWith<$Res> {
  _$WorkoutSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as int?,
      dayId: freezed == dayId
          ? _value.dayId
          : dayId // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<LoggedExercise>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutSessionImplCopyWith<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  factory _$$WorkoutSessionImplCopyWith(_$WorkoutSessionImpl value,
          $Res Function(_$WorkoutSessionImpl) then) =
      __$$WorkoutSessionImplCopyWithImpl<$Res>;
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
class __$$WorkoutSessionImplCopyWithImpl<$Res>
    extends _$WorkoutSessionCopyWithImpl<$Res, _$WorkoutSessionImpl>
    implements _$$WorkoutSessionImplCopyWith<$Res> {
  __$$WorkoutSessionImplCopyWithImpl(
      _$WorkoutSessionImpl _value, $Res Function(_$WorkoutSessionImpl) _then)
      : super(_value, _then);

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
    return _then(_$WorkoutSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as int?,
      dayId: freezed == dayId
          ? _value.dayId
          : dayId // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<LoggedExercise>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutSessionImpl implements _WorkoutSession {
  const _$WorkoutSessionImpl(
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
      : _exercises = exercises;

  factory _$WorkoutSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutSessionImplFromJson(json);

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

  @override
  String toString() {
    return 'WorkoutSession(id: $id, name: $name, date: $date, startTime: $startTime, endTime: $endTime, duration: $duration, templateId: $templateId, dayId: $dayId, notes: $notes, status: $status, exercises: $exercises)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSessionImpl &&
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

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      __$$WorkoutSessionImplCopyWithImpl<_$WorkoutSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutSessionImplToJson(
      this,
    );
  }
}

abstract class _WorkoutSession implements WorkoutSession {
  const factory _WorkoutSession(
      {required final int id,
      required final String name,
      required final DateTime date,
      final DateTime? startTime,
      final DateTime? endTime,
      final int? duration,
      final int? templateId,
      final int? dayId,
      final String? notes,
      final String status,
      final List<LoggedExercise> exercises}) = _$WorkoutSessionImpl;

  factory _WorkoutSession.fromJson(Map<String, dynamic> json) =
      _$WorkoutSessionImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  DateTime get date;
  @override
  DateTime? get startTime;
  @override
  DateTime? get endTime;
  @override
  int? get duration;
  @override
  int? get templateId;
  @override
  int? get dayId;
  @override
  String? get notes;
  @override
  String get status;
  @override
  List<LoggedExercise> get exercises;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoggedExercise _$LoggedExerciseFromJson(Map<String, dynamic> json) {
  return _LoggedExercise.fromJson(json);
}

/// @nodoc
mixin _$LoggedExercise {
  int get exerciseId => throw _privateConstructorUsedError;
  String get exerciseName => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  List<LoggedSet> get sets => throw _privateConstructorUsedError;

  /// Serializes this LoggedExercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoggedExerciseCopyWith<LoggedExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoggedExerciseCopyWith<$Res> {
  factory $LoggedExerciseCopyWith(
          LoggedExercise value, $Res Function(LoggedExercise) then) =
      _$LoggedExerciseCopyWithImpl<$Res, LoggedExercise>;
  @useResult
  $Res call(
      {int exerciseId, String exerciseName, int order, List<LoggedSet> sets});
}

/// @nodoc
class _$LoggedExerciseCopyWithImpl<$Res, $Val extends LoggedExercise>
    implements $LoggedExerciseCopyWith<$Res> {
  _$LoggedExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      exerciseId: null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseName: null == exerciseName
          ? _value.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      sets: null == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<LoggedSet>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoggedExerciseImplCopyWith<$Res>
    implements $LoggedExerciseCopyWith<$Res> {
  factory _$$LoggedExerciseImplCopyWith(_$LoggedExerciseImpl value,
          $Res Function(_$LoggedExerciseImpl) then) =
      __$$LoggedExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int exerciseId, String exerciseName, int order, List<LoggedSet> sets});
}

/// @nodoc
class __$$LoggedExerciseImplCopyWithImpl<$Res>
    extends _$LoggedExerciseCopyWithImpl<$Res, _$LoggedExerciseImpl>
    implements _$$LoggedExerciseImplCopyWith<$Res> {
  __$$LoggedExerciseImplCopyWithImpl(
      _$LoggedExerciseImpl _value, $Res Function(_$LoggedExerciseImpl) _then)
      : super(_value, _then);

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
    return _then(_$LoggedExerciseImpl(
      exerciseId: null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseName: null == exerciseName
          ? _value.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      sets: null == sets
          ? _value._sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<LoggedSet>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoggedExerciseImpl implements _LoggedExercise {
  const _$LoggedExerciseImpl(
      {required this.exerciseId,
      required this.exerciseName,
      required this.order,
      final List<LoggedSet> sets = const []})
      : _sets = sets;

  factory _$LoggedExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoggedExerciseImplFromJson(json);

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

  @override
  String toString() {
    return 'LoggedExercise(exerciseId: $exerciseId, exerciseName: $exerciseName, order: $order, sets: $sets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoggedExerciseImpl &&
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

  /// Create a copy of LoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoggedExerciseImplCopyWith<_$LoggedExerciseImpl> get copyWith =>
      __$$LoggedExerciseImplCopyWithImpl<_$LoggedExerciseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoggedExerciseImplToJson(
      this,
    );
  }
}

abstract class _LoggedExercise implements LoggedExercise {
  const factory _LoggedExercise(
      {required final int exerciseId,
      required final String exerciseName,
      required final int order,
      final List<LoggedSet> sets}) = _$LoggedExerciseImpl;

  factory _LoggedExercise.fromJson(Map<String, dynamic> json) =
      _$LoggedExerciseImpl.fromJson;

  @override
  int get exerciseId;
  @override
  String get exerciseName;
  @override
  int get order;
  @override
  List<LoggedSet> get sets;

  /// Create a copy of LoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoggedExerciseImplCopyWith<_$LoggedExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
