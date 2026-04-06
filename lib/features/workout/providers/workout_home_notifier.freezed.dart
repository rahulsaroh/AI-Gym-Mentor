// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_home_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MotivationTip {
  String get text => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MotivationTipCopyWith<MotivationTip> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MotivationTipCopyWith<$Res> {
  factory $MotivationTipCopyWith(
          MotivationTip value, $Res Function(MotivationTip) then) =
      _$MotivationTipCopyWithImpl<$Res, MotivationTip>;
  @useResult
  $Res call({String text, String category});
}

/// @nodoc
class _$MotivationTipCopyWithImpl<$Res, $Val extends MotivationTip>
    implements $MotivationTipCopyWith<$Res> {
  _$MotivationTipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? category = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MotivationTipImplCopyWith<$Res>
    implements $MotivationTipCopyWith<$Res> {
  factory _$$MotivationTipImplCopyWith(
          _$MotivationTipImpl value, $Res Function(_$MotivationTipImpl) then) =
      __$$MotivationTipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String category});
}

/// @nodoc
class __$$MotivationTipImplCopyWithImpl<$Res>
    extends _$MotivationTipCopyWithImpl<$Res, _$MotivationTipImpl>
    implements _$$MotivationTipImplCopyWith<$Res> {
  __$$MotivationTipImplCopyWithImpl(
      _$MotivationTipImpl _value, $Res Function(_$MotivationTipImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? category = null,
  }) {
    return _then(_$MotivationTipImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MotivationTipImpl implements _MotivationTip {
  const _$MotivationTipImpl({required this.text, required this.category});

  @override
  final String text;
  @override
  final String category;

  @override
  String toString() {
    return 'MotivationTip(text: $text, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MotivationTipImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MotivationTipImplCopyWith<_$MotivationTipImpl> get copyWith =>
      __$$MotivationTipImplCopyWithImpl<_$MotivationTipImpl>(this, _$identity);
}

abstract class _MotivationTip implements MotivationTip {
  const factory _MotivationTip(
      {required final String text,
      required final String category}) = _$MotivationTipImpl;

  @override
  String get text;
  @override
  String get category;
  @override
  @JsonKey(ignore: true)
  _$$MotivationTipImplCopyWith<_$MotivationTipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WorkoutHomeState {
  String get greeting => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get dateString => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  MotivationTip get dailyTip => throw _privateConstructorUsedError;
  Workout? get lastWorkout => throw _privateConstructorUsedError;
  Workout? get activeDraft => throw _privateConstructorUsedError;
  Map<int, double> get weeklyVolume =>
      throw _privateConstructorUsedError; // millisecondsSinceEpoch -> volume
  BodyMeasurement? get lastWeight => throw _privateConstructorUsedError;
  bool get isRestDay => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WorkoutHomeStateCopyWith<WorkoutHomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutHomeStateCopyWith<$Res> {
  factory $WorkoutHomeStateCopyWith(
          WorkoutHomeState value, $Res Function(WorkoutHomeState) then) =
      _$WorkoutHomeStateCopyWithImpl<$Res, WorkoutHomeState>;
  @useResult
  $Res call(
      {String greeting,
      String userName,
      String dateString,
      int currentStreak,
      MotivationTip dailyTip,
      Workout? lastWorkout,
      Workout? activeDraft,
      Map<int, double> weeklyVolume,
      BodyMeasurement? lastWeight,
      bool isRestDay});

  $MotivationTipCopyWith<$Res> get dailyTip;
}

/// @nodoc
class _$WorkoutHomeStateCopyWithImpl<$Res, $Val extends WorkoutHomeState>
    implements $WorkoutHomeStateCopyWith<$Res> {
  _$WorkoutHomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? greeting = null,
    Object? userName = null,
    Object? dateString = null,
    Object? currentStreak = null,
    Object? dailyTip = null,
    Object? lastWorkout = freezed,
    Object? activeDraft = freezed,
    Object? weeklyVolume = null,
    Object? lastWeight = freezed,
    Object? isRestDay = null,
  }) {
    return _then(_value.copyWith(
      greeting: null == greeting
          ? _value.greeting
          : greeting // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      dateString: null == dateString
          ? _value.dateString
          : dateString // ignore: cast_nullable_to_non_nullable
              as String,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      dailyTip: null == dailyTip
          ? _value.dailyTip
          : dailyTip // ignore: cast_nullable_to_non_nullable
              as MotivationTip,
      lastWorkout: freezed == lastWorkout
          ? _value.lastWorkout
          : lastWorkout // ignore: cast_nullable_to_non_nullable
              as Workout?,
      activeDraft: freezed == activeDraft
          ? _value.activeDraft
          : activeDraft // ignore: cast_nullable_to_non_nullable
              as Workout?,
      weeklyVolume: null == weeklyVolume
          ? _value.weeklyVolume
          : weeklyVolume // ignore: cast_nullable_to_non_nullable
              as Map<int, double>,
      lastWeight: freezed == lastWeight
          ? _value.lastWeight
          : lastWeight // ignore: cast_nullable_to_non_nullable
              as BodyMeasurement?,
      isRestDay: null == isRestDay
          ? _value.isRestDay
          : isRestDay // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MotivationTipCopyWith<$Res> get dailyTip {
    return $MotivationTipCopyWith<$Res>(_value.dailyTip, (value) {
      return _then(_value.copyWith(dailyTip: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkoutHomeStateImplCopyWith<$Res>
    implements $WorkoutHomeStateCopyWith<$Res> {
  factory _$$WorkoutHomeStateImplCopyWith(_$WorkoutHomeStateImpl value,
          $Res Function(_$WorkoutHomeStateImpl) then) =
      __$$WorkoutHomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String greeting,
      String userName,
      String dateString,
      int currentStreak,
      MotivationTip dailyTip,
      Workout? lastWorkout,
      Workout? activeDraft,
      Map<int, double> weeklyVolume,
      BodyMeasurement? lastWeight,
      bool isRestDay});

  @override
  $MotivationTipCopyWith<$Res> get dailyTip;
}

/// @nodoc
class __$$WorkoutHomeStateImplCopyWithImpl<$Res>
    extends _$WorkoutHomeStateCopyWithImpl<$Res, _$WorkoutHomeStateImpl>
    implements _$$WorkoutHomeStateImplCopyWith<$Res> {
  __$$WorkoutHomeStateImplCopyWithImpl(_$WorkoutHomeStateImpl _value,
      $Res Function(_$WorkoutHomeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? greeting = null,
    Object? userName = null,
    Object? dateString = null,
    Object? currentStreak = null,
    Object? dailyTip = null,
    Object? lastWorkout = freezed,
    Object? activeDraft = freezed,
    Object? weeklyVolume = null,
    Object? lastWeight = freezed,
    Object? isRestDay = null,
  }) {
    return _then(_$WorkoutHomeStateImpl(
      greeting: null == greeting
          ? _value.greeting
          : greeting // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      dateString: null == dateString
          ? _value.dateString
          : dateString // ignore: cast_nullable_to_non_nullable
              as String,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      dailyTip: null == dailyTip
          ? _value.dailyTip
          : dailyTip // ignore: cast_nullable_to_non_nullable
              as MotivationTip,
      lastWorkout: freezed == lastWorkout
          ? _value.lastWorkout
          : lastWorkout // ignore: cast_nullable_to_non_nullable
              as Workout?,
      activeDraft: freezed == activeDraft
          ? _value.activeDraft
          : activeDraft // ignore: cast_nullable_to_non_nullable
              as Workout?,
      weeklyVolume: null == weeklyVolume
          ? _value._weeklyVolume
          : weeklyVolume // ignore: cast_nullable_to_non_nullable
              as Map<int, double>,
      lastWeight: freezed == lastWeight
          ? _value.lastWeight
          : lastWeight // ignore: cast_nullable_to_non_nullable
              as BodyMeasurement?,
      isRestDay: null == isRestDay
          ? _value.isRestDay
          : isRestDay // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$WorkoutHomeStateImpl implements _WorkoutHomeState {
  const _$WorkoutHomeStateImpl(
      {required this.greeting,
      required this.userName,
      required this.dateString,
      required this.currentStreak,
      required this.dailyTip,
      this.lastWorkout,
      this.activeDraft,
      final Map<int, double> weeklyVolume = const {},
      this.lastWeight,
      this.isRestDay = false})
      : _weeklyVolume = weeklyVolume;

  @override
  final String greeting;
  @override
  final String userName;
  @override
  final String dateString;
  @override
  final int currentStreak;
  @override
  final MotivationTip dailyTip;
  @override
  final Workout? lastWorkout;
  @override
  final Workout? activeDraft;
  final Map<int, double> _weeklyVolume;
  @override
  @JsonKey()
  Map<int, double> get weeklyVolume {
    if (_weeklyVolume is EqualUnmodifiableMapView) return _weeklyVolume;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_weeklyVolume);
  }

// millisecondsSinceEpoch -> volume
  @override
  final BodyMeasurement? lastWeight;
  @override
  @JsonKey()
  final bool isRestDay;

  @override
  String toString() {
    return 'WorkoutHomeState(greeting: $greeting, userName: $userName, dateString: $dateString, currentStreak: $currentStreak, dailyTip: $dailyTip, lastWorkout: $lastWorkout, activeDraft: $activeDraft, weeklyVolume: $weeklyVolume, lastWeight: $lastWeight, isRestDay: $isRestDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutHomeStateImpl &&
            (identical(other.greeting, greeting) ||
                other.greeting == greeting) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.dateString, dateString) ||
                other.dateString == dateString) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.dailyTip, dailyTip) ||
                other.dailyTip == dailyTip) &&
            (identical(other.lastWorkout, lastWorkout) ||
                other.lastWorkout == lastWorkout) &&
            (identical(other.activeDraft, activeDraft) ||
                other.activeDraft == activeDraft) &&
            const DeepCollectionEquality()
                .equals(other._weeklyVolume, _weeklyVolume) &&
            (identical(other.lastWeight, lastWeight) ||
                other.lastWeight == lastWeight) &&
            (identical(other.isRestDay, isRestDay) ||
                other.isRestDay == isRestDay));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      greeting,
      userName,
      dateString,
      currentStreak,
      dailyTip,
      lastWorkout,
      activeDraft,
      const DeepCollectionEquality().hash(_weeklyVolume),
      lastWeight,
      isRestDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutHomeStateImplCopyWith<_$WorkoutHomeStateImpl> get copyWith =>
      __$$WorkoutHomeStateImplCopyWithImpl<_$WorkoutHomeStateImpl>(
          this, _$identity);
}

abstract class _WorkoutHomeState implements WorkoutHomeState {
  const factory _WorkoutHomeState(
      {required final String greeting,
      required final String userName,
      required final String dateString,
      required final int currentStreak,
      required final MotivationTip dailyTip,
      final Workout? lastWorkout,
      final Workout? activeDraft,
      final Map<int, double> weeklyVolume,
      final BodyMeasurement? lastWeight,
      final bool isRestDay}) = _$WorkoutHomeStateImpl;

  @override
  String get greeting;
  @override
  String get userName;
  @override
  String get dateString;
  @override
  int get currentStreak;
  @override
  MotivationTip get dailyTip;
  @override
  Workout? get lastWorkout;
  @override
  Workout? get activeDraft;
  @override
  Map<int, double> get weeklyVolume;
  @override // millisecondsSinceEpoch -> volume
  BodyMeasurement? get lastWeight;
  @override
  bool get isRestDay;
  @override
  @JsonKey(ignore: true)
  _$$WorkoutHomeStateImplCopyWith<_$WorkoutHomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
