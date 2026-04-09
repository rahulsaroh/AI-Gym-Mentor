// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logged_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoggedSet _$LoggedSetFromJson(Map<String, dynamic> json) {
  return _LoggedSet.fromJson(json);
}

/// @nodoc
mixin _$LoggedSet {
  int get id => throw _privateConstructorUsedError;
  int get workoutId => throw _privateConstructorUsedError;
  int get exerciseId => throw _privateConstructorUsedError;
  int get exerciseOrder => throw _privateConstructorUsedError;
  int get setNumber => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  double get reps => throw _privateConstructorUsedError;
  double? get rpe => throw _privateConstructorUsedError;
  int? get rir => throw _privateConstructorUsedError;
  SetType get setType => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  bool get isPr => throw _privateConstructorUsedError;
  String? get supersetGroupId => throw _privateConstructorUsedError;

  /// Serializes this LoggedSet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoggedSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoggedSetCopyWith<LoggedSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoggedSetCopyWith<$Res> {
  factory $LoggedSetCopyWith(LoggedSet value, $Res Function(LoggedSet) then) =
      _$LoggedSetCopyWithImpl<$Res, LoggedSet>;
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
class _$LoggedSetCopyWithImpl<$Res, $Val extends LoggedSet>
    implements $LoggedSetCopyWith<$Res> {
  _$LoggedSetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      workoutId: null == workoutId
          ? _value.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseId: null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseOrder: null == exerciseOrder
          ? _value.exerciseOrder
          : exerciseOrder // ignore: cast_nullable_to_non_nullable
              as int,
      setNumber: null == setNumber
          ? _value.setNumber
          : setNumber // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as double,
      rpe: freezed == rpe
          ? _value.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as double?,
      rir: freezed == rir
          ? _value.rir
          : rir // ignore: cast_nullable_to_non_nullable
              as int?,
      setType: null == setType
          ? _value.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as SetType,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isPr: null == isPr
          ? _value.isPr
          : isPr // ignore: cast_nullable_to_non_nullable
              as bool,
      supersetGroupId: freezed == supersetGroupId
          ? _value.supersetGroupId
          : supersetGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoggedSetImplCopyWith<$Res>
    implements $LoggedSetCopyWith<$Res> {
  factory _$$LoggedSetImplCopyWith(
          _$LoggedSetImpl value, $Res Function(_$LoggedSetImpl) then) =
      __$$LoggedSetImplCopyWithImpl<$Res>;
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
class __$$LoggedSetImplCopyWithImpl<$Res>
    extends _$LoggedSetCopyWithImpl<$Res, _$LoggedSetImpl>
    implements _$$LoggedSetImplCopyWith<$Res> {
  __$$LoggedSetImplCopyWithImpl(
      _$LoggedSetImpl _value, $Res Function(_$LoggedSetImpl) _then)
      : super(_value, _then);

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
    return _then(_$LoggedSetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      workoutId: null == workoutId
          ? _value.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseId: null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseOrder: null == exerciseOrder
          ? _value.exerciseOrder
          : exerciseOrder // ignore: cast_nullable_to_non_nullable
              as int,
      setNumber: null == setNumber
          ? _value.setNumber
          : setNumber // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as double,
      rpe: freezed == rpe
          ? _value.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as double?,
      rir: freezed == rir
          ? _value.rir
          : rir // ignore: cast_nullable_to_non_nullable
              as int?,
      setType: null == setType
          ? _value.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as SetType,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isPr: null == isPr
          ? _value.isPr
          : isPr // ignore: cast_nullable_to_non_nullable
              as bool,
      supersetGroupId: freezed == supersetGroupId
          ? _value.supersetGroupId
          : supersetGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoggedSetImpl implements _LoggedSet {
  const _$LoggedSetImpl(
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
      this.supersetGroupId});

  factory _$LoggedSetImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoggedSetImplFromJson(json);

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

  @override
  String toString() {
    return 'LoggedSet(id: $id, workoutId: $workoutId, exerciseId: $exerciseId, exerciseOrder: $exerciseOrder, setNumber: $setNumber, weight: $weight, reps: $reps, rpe: $rpe, rir: $rir, setType: $setType, notes: $notes, completed: $completed, completedAt: $completedAt, isPr: $isPr, supersetGroupId: $supersetGroupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoggedSetImpl &&
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

  /// Create a copy of LoggedSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoggedSetImplCopyWith<_$LoggedSetImpl> get copyWith =>
      __$$LoggedSetImplCopyWithImpl<_$LoggedSetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoggedSetImplToJson(
      this,
    );
  }
}

abstract class _LoggedSet implements LoggedSet {
  const factory _LoggedSet(
      {required final int id,
      required final int workoutId,
      required final int exerciseId,
      required final int exerciseOrder,
      required final int setNumber,
      required final double weight,
      required final double reps,
      final double? rpe,
      final int? rir,
      final SetType setType,
      final String? notes,
      final bool completed,
      final DateTime? completedAt,
      final bool isPr,
      final String? supersetGroupId}) = _$LoggedSetImpl;

  factory _LoggedSet.fromJson(Map<String, dynamic> json) =
      _$LoggedSetImpl.fromJson;

  @override
  int get id;
  @override
  int get workoutId;
  @override
  int get exerciseId;
  @override
  int get exerciseOrder;
  @override
  int get setNumber;
  @override
  double get weight;
  @override
  double get reps;
  @override
  double? get rpe;
  @override
  int? get rir;
  @override
  SetType get setType;
  @override
  String? get notes;
  @override
  bool get completed;
  @override
  DateTime? get completedAt;
  @override
  bool get isPr;
  @override
  String? get supersetGroupId;

  /// Create a copy of LoggedSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoggedSetImplCopyWith<_$LoggedSetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
