// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkoutProgram _$WorkoutProgramFromJson(Map<String, dynamic> json) {
  return _WorkoutProgram.fromJson(json);
}

/// @nodoc
mixin _$WorkoutProgram {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get lastUsed => throw _privateConstructorUsedError;
  List<ProgramDay> get days => throw _privateConstructorUsedError;

  /// Serializes this WorkoutProgram to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutProgram
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutProgramCopyWith<WorkoutProgram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutProgramCopyWith<$Res> {
  factory $WorkoutProgramCopyWith(
          WorkoutProgram value, $Res Function(WorkoutProgram) then) =
      _$WorkoutProgramCopyWithImpl<$Res, WorkoutProgram>;
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      DateTime? lastUsed,
      List<ProgramDay> days});
}

/// @nodoc
class _$WorkoutProgramCopyWithImpl<$Res, $Val extends WorkoutProgram>
    implements $WorkoutProgramCopyWith<$Res> {
  _$WorkoutProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutProgram
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? lastUsed = freezed,
    Object? days = null,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUsed: freezed == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<ProgramDay>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutProgramImplCopyWith<$Res>
    implements $WorkoutProgramCopyWith<$Res> {
  factory _$$WorkoutProgramImplCopyWith(_$WorkoutProgramImpl value,
          $Res Function(_$WorkoutProgramImpl) then) =
      __$$WorkoutProgramImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      DateTime? lastUsed,
      List<ProgramDay> days});
}

/// @nodoc
class __$$WorkoutProgramImplCopyWithImpl<$Res>
    extends _$WorkoutProgramCopyWithImpl<$Res, _$WorkoutProgramImpl>
    implements _$$WorkoutProgramImplCopyWith<$Res> {
  __$$WorkoutProgramImplCopyWithImpl(
      _$WorkoutProgramImpl _value, $Res Function(_$WorkoutProgramImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutProgram
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? lastUsed = freezed,
    Object? days = null,
  }) {
    return _then(_$WorkoutProgramImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUsed: freezed == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      days: null == days
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<ProgramDay>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutProgramImpl implements _WorkoutProgram {
  const _$WorkoutProgramImpl(
      {required this.id,
      required this.name,
      this.description,
      this.lastUsed,
      final List<ProgramDay> days = const []})
      : _days = days;

  factory _$WorkoutProgramImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutProgramImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final DateTime? lastUsed;
  final List<ProgramDay> _days;
  @override
  @JsonKey()
  List<ProgramDay> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  String toString() {
    return 'WorkoutProgram(id: $id, name: $name, description: $description, lastUsed: $lastUsed, days: $days)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutProgramImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.lastUsed, lastUsed) ||
                other.lastUsed == lastUsed) &&
            const DeepCollectionEquality().equals(other._days, _days));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, lastUsed,
      const DeepCollectionEquality().hash(_days));

  /// Create a copy of WorkoutProgram
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutProgramImplCopyWith<_$WorkoutProgramImpl> get copyWith =>
      __$$WorkoutProgramImplCopyWithImpl<_$WorkoutProgramImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutProgramImplToJson(
      this,
    );
  }
}

abstract class _WorkoutProgram implements WorkoutProgram {
  const factory _WorkoutProgram(
      {required final int id,
      required final String name,
      final String? description,
      final DateTime? lastUsed,
      final List<ProgramDay> days}) = _$WorkoutProgramImpl;

  factory _WorkoutProgram.fromJson(Map<String, dynamic> json) =
      _$WorkoutProgramImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  DateTime? get lastUsed;
  @override
  List<ProgramDay> get days;

  /// Create a copy of WorkoutProgram
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutProgramImplCopyWith<_$WorkoutProgramImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgramDay _$ProgramDayFromJson(Map<String, dynamic> json) {
  return _ProgramDay.fromJson(json);
}

/// @nodoc
mixin _$ProgramDay {
  int get id => throw _privateConstructorUsedError;
  int get templateId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  List<ProgramExercise> get exercises => throw _privateConstructorUsedError;

  /// Serializes this ProgramDay to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramDayCopyWith<ProgramDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramDayCopyWith<$Res> {
  factory $ProgramDayCopyWith(
          ProgramDay value, $Res Function(ProgramDay) then) =
      _$ProgramDayCopyWithImpl<$Res, ProgramDay>;
  @useResult
  $Res call(
      {int id,
      int templateId,
      String name,
      int order,
      List<ProgramExercise> exercises});
}

/// @nodoc
class _$ProgramDayCopyWithImpl<$Res, $Val extends ProgramDay>
    implements $ProgramDayCopyWith<$Res> {
  _$ProgramDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? templateId = null,
    Object? name = null,
    Object? order = null,
    Object? exercises = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      templateId: null == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<ProgramExercise>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgramDayImplCopyWith<$Res>
    implements $ProgramDayCopyWith<$Res> {
  factory _$$ProgramDayImplCopyWith(
          _$ProgramDayImpl value, $Res Function(_$ProgramDayImpl) then) =
      __$$ProgramDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int templateId,
      String name,
      int order,
      List<ProgramExercise> exercises});
}

/// @nodoc
class __$$ProgramDayImplCopyWithImpl<$Res>
    extends _$ProgramDayCopyWithImpl<$Res, _$ProgramDayImpl>
    implements _$$ProgramDayImplCopyWith<$Res> {
  __$$ProgramDayImplCopyWithImpl(
      _$ProgramDayImpl _value, $Res Function(_$ProgramDayImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? templateId = null,
    Object? name = null,
    Object? order = null,
    Object? exercises = null,
  }) {
    return _then(_$ProgramDayImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      templateId: null == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<ProgramExercise>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramDayImpl implements _ProgramDay {
  const _$ProgramDayImpl(
      {required this.id,
      required this.templateId,
      required this.name,
      required this.order,
      final List<ProgramExercise> exercises = const []})
      : _exercises = exercises;

  factory _$ProgramDayImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramDayImplFromJson(json);

  @override
  final int id;
  @override
  final int templateId;
  @override
  final String name;
  @override
  final int order;
  final List<ProgramExercise> _exercises;
  @override
  @JsonKey()
  List<ProgramExercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  String toString() {
    return 'ProgramDay(id: $id, templateId: $templateId, name: $name, order: $order, exercises: $exercises)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramDayImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality()
                .equals(other._exercises, _exercises));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, templateId, name, order,
      const DeepCollectionEquality().hash(_exercises));

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramDayImplCopyWith<_$ProgramDayImpl> get copyWith =>
      __$$ProgramDayImplCopyWithImpl<_$ProgramDayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramDayImplToJson(
      this,
    );
  }
}

abstract class _ProgramDay implements ProgramDay {
  const factory _ProgramDay(
      {required final int id,
      required final int templateId,
      required final String name,
      required final int order,
      final List<ProgramExercise> exercises}) = _$ProgramDayImpl;

  factory _ProgramDay.fromJson(Map<String, dynamic> json) =
      _$ProgramDayImpl.fromJson;

  @override
  int get id;
  @override
  int get templateId;
  @override
  String get name;
  @override
  int get order;
  @override
  List<ProgramExercise> get exercises;

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramDayImplCopyWith<_$ProgramDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgramExercise _$ProgramExerciseFromJson(Map<String, dynamic> json) {
  return _ProgramExercise.fromJson(json);
}

/// @nodoc
mixin _$ProgramExercise {
  int get id => throw _privateConstructorUsedError;
  int get dayId => throw _privateConstructorUsedError;
  Exercise get exercise => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  String get setType => throw _privateConstructorUsedError;
  String get setsJson =>
      throw _privateConstructorUsedError; // Simplified for now, or use typed sets
  int get restTime => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get supersetGroupId => throw _privateConstructorUsedError;

  /// Serializes this ProgramExercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgramExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramExerciseCopyWith<ProgramExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramExerciseCopyWith<$Res> {
  factory $ProgramExerciseCopyWith(
          ProgramExercise value, $Res Function(ProgramExercise) then) =
      _$ProgramExerciseCopyWithImpl<$Res, ProgramExercise>;
  @useResult
  $Res call(
      {int id,
      int dayId,
      Exercise exercise,
      int order,
      String setType,
      String setsJson,
      int restTime,
      String? notes,
      String? supersetGroupId});

  $ExerciseCopyWith<$Res> get exercise;
}

/// @nodoc
class _$ProgramExerciseCopyWithImpl<$Res, $Val extends ProgramExercise>
    implements $ProgramExerciseCopyWith<$Res> {
  _$ProgramExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dayId = null,
    Object? exercise = null,
    Object? order = null,
    Object? setType = null,
    Object? setsJson = null,
    Object? restTime = null,
    Object? notes = freezed,
    Object? supersetGroupId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      dayId: null == dayId
          ? _value.dayId
          : dayId // ignore: cast_nullable_to_non_nullable
              as int,
      exercise: null == exercise
          ? _value.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as Exercise,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      setType: null == setType
          ? _value.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as String,
      setsJson: null == setsJson
          ? _value.setsJson
          : setsJson // ignore: cast_nullable_to_non_nullable
              as String,
      restTime: null == restTime
          ? _value.restTime
          : restTime // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      supersetGroupId: freezed == supersetGroupId
          ? _value.supersetGroupId
          : supersetGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ProgramExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseCopyWith<$Res> get exercise {
    return $ExerciseCopyWith<$Res>(_value.exercise, (value) {
      return _then(_value.copyWith(exercise: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProgramExerciseImplCopyWith<$Res>
    implements $ProgramExerciseCopyWith<$Res> {
  factory _$$ProgramExerciseImplCopyWith(_$ProgramExerciseImpl value,
          $Res Function(_$ProgramExerciseImpl) then) =
      __$$ProgramExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int dayId,
      Exercise exercise,
      int order,
      String setType,
      String setsJson,
      int restTime,
      String? notes,
      String? supersetGroupId});

  @override
  $ExerciseCopyWith<$Res> get exercise;
}

/// @nodoc
class __$$ProgramExerciseImplCopyWithImpl<$Res>
    extends _$ProgramExerciseCopyWithImpl<$Res, _$ProgramExerciseImpl>
    implements _$$ProgramExerciseImplCopyWith<$Res> {
  __$$ProgramExerciseImplCopyWithImpl(
      _$ProgramExerciseImpl _value, $Res Function(_$ProgramExerciseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgramExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dayId = null,
    Object? exercise = null,
    Object? order = null,
    Object? setType = null,
    Object? setsJson = null,
    Object? restTime = null,
    Object? notes = freezed,
    Object? supersetGroupId = freezed,
  }) {
    return _then(_$ProgramExerciseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      dayId: null == dayId
          ? _value.dayId
          : dayId // ignore: cast_nullable_to_non_nullable
              as int,
      exercise: null == exercise
          ? _value.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as Exercise,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      setType: null == setType
          ? _value.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as String,
      setsJson: null == setsJson
          ? _value.setsJson
          : setsJson // ignore: cast_nullable_to_non_nullable
              as String,
      restTime: null == restTime
          ? _value.restTime
          : restTime // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      supersetGroupId: freezed == supersetGroupId
          ? _value.supersetGroupId
          : supersetGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramExerciseImpl implements _ProgramExercise {
  const _$ProgramExerciseImpl(
      {required this.id,
      required this.dayId,
      required this.exercise,
      required this.order,
      this.setType = 'Straight',
      this.setsJson = '[]',
      this.restTime = 90,
      this.notes,
      this.supersetGroupId});

  factory _$ProgramExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramExerciseImplFromJson(json);

  @override
  final int id;
  @override
  final int dayId;
  @override
  final Exercise exercise;
  @override
  final int order;
  @override
  @JsonKey()
  final String setType;
  @override
  @JsonKey()
  final String setsJson;
// Simplified for now, or use typed sets
  @override
  @JsonKey()
  final int restTime;
  @override
  final String? notes;
  @override
  final String? supersetGroupId;

  @override
  String toString() {
    return 'ProgramExercise(id: $id, dayId: $dayId, exercise: $exercise, order: $order, setType: $setType, setsJson: $setsJson, restTime: $restTime, notes: $notes, supersetGroupId: $supersetGroupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dayId, dayId) || other.dayId == dayId) &&
            (identical(other.exercise, exercise) ||
                other.exercise == exercise) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.setType, setType) || other.setType == setType) &&
            (identical(other.setsJson, setsJson) ||
                other.setsJson == setsJson) &&
            (identical(other.restTime, restTime) ||
                other.restTime == restTime) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.supersetGroupId, supersetGroupId) ||
                other.supersetGroupId == supersetGroupId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, dayId, exercise, order,
      setType, setsJson, restTime, notes, supersetGroupId);

  /// Create a copy of ProgramExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramExerciseImplCopyWith<_$ProgramExerciseImpl> get copyWith =>
      __$$ProgramExerciseImplCopyWithImpl<_$ProgramExerciseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramExerciseImplToJson(
      this,
    );
  }
}

abstract class _ProgramExercise implements ProgramExercise {
  const factory _ProgramExercise(
      {required final int id,
      required final int dayId,
      required final Exercise exercise,
      required final int order,
      final String setType,
      final String setsJson,
      final int restTime,
      final String? notes,
      final String? supersetGroupId}) = _$ProgramExerciseImpl;

  factory _ProgramExercise.fromJson(Map<String, dynamic> json) =
      _$ProgramExerciseImpl.fromJson;

  @override
  int get id;
  @override
  int get dayId;
  @override
  Exercise get exercise;
  @override
  int get order;
  @override
  String get setType;
  @override
  String get setsJson; // Simplified for now, or use typed sets
  @override
  int get restTime;
  @override
  String? get notes;
  @override
  String? get supersetGroupId;

  /// Create a copy of ProgramExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramExerciseImplCopyWith<_$ProgramExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
