// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_home_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MotivationTip {
  String get text;
  String get category;

  /// Create a copy of MotivationTip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MotivationTipCopyWith<MotivationTip> get copyWith =>
      _$MotivationTipCopyWithImpl<MotivationTip>(
          this as MotivationTip, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MotivationTip &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, category);

  @override
  String toString() {
    return 'MotivationTip(text: $text, category: $category)';
  }
}

/// @nodoc
abstract mixin class $MotivationTipCopyWith<$Res> {
  factory $MotivationTipCopyWith(
          MotivationTip value, $Res Function(MotivationTip) _then) =
      _$MotivationTipCopyWithImpl;
  @useResult
  $Res call({String text, String category});
}

/// @nodoc
class _$MotivationTipCopyWithImpl<$Res>
    implements $MotivationTipCopyWith<$Res> {
  _$MotivationTipCopyWithImpl(this._self, this._then);

  final MotivationTip _self;
  final $Res Function(MotivationTip) _then;

  /// Create a copy of MotivationTip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? category = null,
  }) {
    return _then(_self.copyWith(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [MotivationTip].
extension MotivationTipPatterns on MotivationTip {
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
    TResult Function(_MotivationTip value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MotivationTip() when $default != null:
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
    TResult Function(_MotivationTip value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MotivationTip():
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
    TResult? Function(_MotivationTip value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MotivationTip() when $default != null:
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
    TResult Function(String text, String category)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MotivationTip() when $default != null:
        return $default(_that.text, _that.category);
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
    TResult Function(String text, String category) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MotivationTip():
        return $default(_that.text, _that.category);
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
    TResult? Function(String text, String category)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MotivationTip() when $default != null:
        return $default(_that.text, _that.category);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MotivationTip extends MotivationTip {
  const _MotivationTip({required this.text, required this.category})
      : super._();

  @override
  final String text;
  @override
  final String category;

  /// Create a copy of MotivationTip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MotivationTipCopyWith<_MotivationTip> get copyWith =>
      __$MotivationTipCopyWithImpl<_MotivationTip>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MotivationTip &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, category);

  @override
  String toString() {
    return 'MotivationTip(text: $text, category: $category)';
  }
}

/// @nodoc
abstract mixin class _$MotivationTipCopyWith<$Res>
    implements $MotivationTipCopyWith<$Res> {
  factory _$MotivationTipCopyWith(
          _MotivationTip value, $Res Function(_MotivationTip) _then) =
      __$MotivationTipCopyWithImpl;
  @override
  @useResult
  $Res call({String text, String category});
}

/// @nodoc
class __$MotivationTipCopyWithImpl<$Res>
    implements _$MotivationTipCopyWith<$Res> {
  __$MotivationTipCopyWithImpl(this._self, this._then);

  final _MotivationTip _self;
  final $Res Function(_MotivationTip) _then;

  /// Create a copy of MotivationTip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? category = null,
  }) {
    return _then(_MotivationTip(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$WorkoutHomeState {
  String get greeting;
  String get userName;
  String get dateString;
  int get currentStreak;
  MotivationTip get dailyTip;
  WorkoutSession? get lastWorkout;
  WorkoutSession? get activeDraft;
  Map<int, double> get weeklyVolume;
  BodyMeasurement? get lastWeight;
  String? get lastWorkoutSummary;
  bool get isRestDay;
  String? get todayDayName;
  List<String> get todayExercises;
  int get estimatedDuration;
  int? get nextDayId;
  int? get templateId;
  int? get manualDayId;

  /// Create a copy of WorkoutHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutHomeStateCopyWith<WorkoutHomeState> get copyWith =>
      _$WorkoutHomeStateCopyWithImpl<WorkoutHomeState>(
          this as WorkoutHomeState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutHomeState &&
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
                .equals(other.weeklyVolume, weeklyVolume) &&
            (identical(other.lastWeight, lastWeight) ||
                other.lastWeight == lastWeight) &&
            (identical(other.lastWorkoutSummary, lastWorkoutSummary) ||
                other.lastWorkoutSummary == lastWorkoutSummary) &&
            (identical(other.isRestDay, isRestDay) ||
                other.isRestDay == isRestDay) &&
            (identical(other.todayDayName, todayDayName) ||
                other.todayDayName == todayDayName) &&
            const DeepCollectionEquality()
                .equals(other.todayExercises, todayExercises) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            (identical(other.nextDayId, nextDayId) ||
                other.nextDayId == nextDayId) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.manualDayId, manualDayId) ||
                other.manualDayId == manualDayId));
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
      const DeepCollectionEquality().hash(weeklyVolume),
      lastWeight,
      lastWorkoutSummary,
      isRestDay,
      todayDayName,
      const DeepCollectionEquality().hash(todayExercises),
      estimatedDuration,
      nextDayId,
      templateId,
      manualDayId);

  @override
  String toString() {
    return 'WorkoutHomeState(greeting: $greeting, userName: $userName, dateString: $dateString, currentStreak: $currentStreak, dailyTip: $dailyTip, lastWorkout: $lastWorkout, activeDraft: $activeDraft, weeklyVolume: $weeklyVolume, lastWeight: $lastWeight, lastWorkoutSummary: $lastWorkoutSummary, isRestDay: $isRestDay, todayDayName: $todayDayName, todayExercises: $todayExercises, estimatedDuration: $estimatedDuration, nextDayId: $nextDayId, templateId: $templateId, manualDayId: $manualDayId)';
  }
}

/// @nodoc
abstract mixin class $WorkoutHomeStateCopyWith<$Res> {
  factory $WorkoutHomeStateCopyWith(
          WorkoutHomeState value, $Res Function(WorkoutHomeState) _then) =
      _$WorkoutHomeStateCopyWithImpl;
  @useResult
  $Res call(
      {String greeting,
      String userName,
      String dateString,
      int currentStreak,
      MotivationTip dailyTip,
      WorkoutSession? lastWorkout,
      WorkoutSession? activeDraft,
      Map<int, double> weeklyVolume,
      BodyMeasurement? lastWeight,
      String? lastWorkoutSummary,
      bool isRestDay,
      String? todayDayName,
      List<String> todayExercises,
      int estimatedDuration,
      int? nextDayId,
      int? templateId,
      int? manualDayId});

  $MotivationTipCopyWith<$Res> get dailyTip;
  $WorkoutSessionCopyWith<$Res>? get lastWorkout;
  $WorkoutSessionCopyWith<$Res>? get activeDraft;
  $BodyMeasurementCopyWith<$Res>? get lastWeight;
}

/// @nodoc
class _$WorkoutHomeStateCopyWithImpl<$Res>
    implements $WorkoutHomeStateCopyWith<$Res> {
  _$WorkoutHomeStateCopyWithImpl(this._self, this._then);

  final WorkoutHomeState _self;
  final $Res Function(WorkoutHomeState) _then;

  /// Create a copy of WorkoutHomeState
  /// with the given fields replaced by the non-null parameter values.
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
    Object? lastWorkoutSummary = freezed,
    Object? isRestDay = null,
    Object? todayDayName = freezed,
    Object? todayExercises = null,
    Object? estimatedDuration = null,
    Object? nextDayId = freezed,
    Object? templateId = freezed,
    Object? manualDayId = freezed,
  }) {
    return _then(_self.copyWith(
      greeting: null == greeting
          ? _self.greeting
          : greeting // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      dateString: null == dateString
          ? _self.dateString
          : dateString // ignore: cast_nullable_to_non_nullable
              as String,
      currentStreak: null == currentStreak
          ? _self.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      dailyTip: null == dailyTip
          ? _self.dailyTip
          : dailyTip // ignore: cast_nullable_to_non_nullable
              as MotivationTip,
      lastWorkout: freezed == lastWorkout
          ? _self.lastWorkout
          : lastWorkout // ignore: cast_nullable_to_non_nullable
              as WorkoutSession?,
      activeDraft: freezed == activeDraft
          ? _self.activeDraft
          : activeDraft // ignore: cast_nullable_to_non_nullable
              as WorkoutSession?,
      weeklyVolume: null == weeklyVolume
          ? _self.weeklyVolume
          : weeklyVolume // ignore: cast_nullable_to_non_nullable
              as Map<int, double>,
      lastWeight: freezed == lastWeight
          ? _self.lastWeight
          : lastWeight // ignore: cast_nullable_to_non_nullable
              as BodyMeasurement?,
      lastWorkoutSummary: freezed == lastWorkoutSummary
          ? _self.lastWorkoutSummary
          : lastWorkoutSummary // ignore: cast_nullable_to_non_nullable
              as String?,
      isRestDay: null == isRestDay
          ? _self.isRestDay
          : isRestDay // ignore: cast_nullable_to_non_nullable
              as bool,
      todayDayName: freezed == todayDayName
          ? _self.todayDayName
          : todayDayName // ignore: cast_nullable_to_non_nullable
              as String?,
      todayExercises: null == todayExercises
          ? _self.todayExercises
          : todayExercises // ignore: cast_nullable_to_non_nullable
              as List<String>,
      estimatedDuration: null == estimatedDuration
          ? _self.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as int,
      nextDayId: freezed == nextDayId
          ? _self.nextDayId
          : nextDayId // ignore: cast_nullable_to_non_nullable
              as int?,
      templateId: freezed == templateId
          ? _self.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as int?,
      manualDayId: freezed == manualDayId
          ? _self.manualDayId
          : manualDayId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of WorkoutHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MotivationTipCopyWith<$Res> get dailyTip {
    return $MotivationTipCopyWith<$Res>(_self.dailyTip, (value) {
      return _then(_self.copyWith(dailyTip: value));
    });
  }

  /// Create a copy of WorkoutHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutSessionCopyWith<$Res>? get lastWorkout {
    if (_self.lastWorkout == null) {
      return null;
    }

    return $WorkoutSessionCopyWith<$Res>(_self.lastWorkout!, (value) {
      return _then(_self.copyWith(lastWorkout: value));
    });
  }

  /// Create a copy of WorkoutHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutSessionCopyWith<$Res>? get activeDraft {
    if (_self.activeDraft == null) {
      return null;
    }

    return $WorkoutSessionCopyWith<$Res>(_self.activeDraft!, (value) {
      return _then(_self.copyWith(activeDraft: value));
    });
  }

  /// Create a copy of WorkoutHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BodyMeasurementCopyWith<$Res>? get lastWeight {
    if (_self.lastWeight == null) {
      return null;
    }

    return $BodyMeasurementCopyWith<$Res>(_self.lastWeight!, (value) {
      return _then(_self.copyWith(lastWeight: value));
    });
  }
}

/// Adds pattern-matching-related methods to [WorkoutHomeState].
extension WorkoutHomeStatePatterns on WorkoutHomeState {
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
    TResult Function(_WorkoutHomeState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutHomeState() when $default != null:
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
    TResult Function(_WorkoutHomeState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutHomeState():
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
    TResult? Function(_WorkoutHomeState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutHomeState() when $default != null:
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
            String greeting,
            String userName,
            String dateString,
            int currentStreak,
            MotivationTip dailyTip,
            WorkoutSession? lastWorkout,
            WorkoutSession? activeDraft,
            Map<int, double> weeklyVolume,
            BodyMeasurement? lastWeight,
            String? lastWorkoutSummary,
            bool isRestDay,
            String? todayDayName,
            List<String> todayExercises,
            int estimatedDuration,
            int? nextDayId,
            int? templateId,
            int? manualDayId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutHomeState() when $default != null:
        return $default(
            _that.greeting,
            _that.userName,
            _that.dateString,
            _that.currentStreak,
            _that.dailyTip,
            _that.lastWorkout,
            _that.activeDraft,
            _that.weeklyVolume,
            _that.lastWeight,
            _that.lastWorkoutSummary,
            _that.isRestDay,
            _that.todayDayName,
            _that.todayExercises,
            _that.estimatedDuration,
            _that.nextDayId,
            _that.templateId,
            _that.manualDayId);
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
            String greeting,
            String userName,
            String dateString,
            int currentStreak,
            MotivationTip dailyTip,
            WorkoutSession? lastWorkout,
            WorkoutSession? activeDraft,
            Map<int, double> weeklyVolume,
            BodyMeasurement? lastWeight,
            String? lastWorkoutSummary,
            bool isRestDay,
            String? todayDayName,
            List<String> todayExercises,
            int estimatedDuration,
            int? nextDayId,
            int? templateId,
            int? manualDayId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutHomeState():
        return $default(
            _that.greeting,
            _that.userName,
            _that.dateString,
            _that.currentStreak,
            _that.dailyTip,
            _that.lastWorkout,
            _that.activeDraft,
            _that.weeklyVolume,
            _that.lastWeight,
            _that.lastWorkoutSummary,
            _that.isRestDay,
            _that.todayDayName,
            _that.todayExercises,
            _that.estimatedDuration,
            _that.nextDayId,
            _that.templateId,
            _that.manualDayId);
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
            String greeting,
            String userName,
            String dateString,
            int currentStreak,
            MotivationTip dailyTip,
            WorkoutSession? lastWorkout,
            WorkoutSession? activeDraft,
            Map<int, double> weeklyVolume,
            BodyMeasurement? lastWeight,
            String? lastWorkoutSummary,
            bool isRestDay,
            String? todayDayName,
            List<String> todayExercises,
            int estimatedDuration,
            int? nextDayId,
            int? templateId,
            int? manualDayId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutHomeState() when $default != null:
        return $default(
            _that.greeting,
            _that.userName,
            _that.dateString,
            _that.currentStreak,
            _that.dailyTip,
            _that.lastWorkout,
            _that.activeDraft,
            _that.weeklyVolume,
            _that.lastWeight,
            _that.lastWorkoutSummary,
            _that.isRestDay,
            _that.todayDayName,
            _that.todayExercises,
            _that.estimatedDuration,
            _that.nextDayId,
            _that.templateId,
            _that.manualDayId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _WorkoutHomeState extends WorkoutHomeState {
  const _WorkoutHomeState(
      {required this.greeting,
      required this.userName,
      required this.dateString,
      required this.currentStreak,
      required this.dailyTip,
      this.lastWorkout = null,
      this.activeDraft = null,
      final Map<int, double> weeklyVolume = const {},
      this.lastWeight = null,
      this.lastWorkoutSummary,
      this.isRestDay = false,
      this.todayDayName,
      final List<String> todayExercises = const [],
      this.estimatedDuration = 0,
      this.nextDayId,
      this.templateId,
      this.manualDayId})
      : _weeklyVolume = weeklyVolume,
        _todayExercises = todayExercises,
        super._();

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
  @JsonKey()
  final WorkoutSession? lastWorkout;
  @override
  @JsonKey()
  final WorkoutSession? activeDraft;
  final Map<int, double> _weeklyVolume;
  @override
  @JsonKey()
  Map<int, double> get weeklyVolume {
    if (_weeklyVolume is EqualUnmodifiableMapView) return _weeklyVolume;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_weeklyVolume);
  }

  @override
  @JsonKey()
  final BodyMeasurement? lastWeight;
  @override
  final String? lastWorkoutSummary;
  @override
  @JsonKey()
  final bool isRestDay;
  @override
  final String? todayDayName;
  final List<String> _todayExercises;
  @override
  @JsonKey()
  List<String> get todayExercises {
    if (_todayExercises is EqualUnmodifiableListView) return _todayExercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todayExercises);
  }

  @override
  @JsonKey()
  final int estimatedDuration;
  @override
  final int? nextDayId;
  @override
  final int? templateId;
  @override
  final int? manualDayId;

  /// Create a copy of WorkoutHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutHomeStateCopyWith<_WorkoutHomeState> get copyWith =>
      __$WorkoutHomeStateCopyWithImpl<_WorkoutHomeState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutHomeState &&
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
            (identical(other.lastWorkoutSummary, lastWorkoutSummary) ||
                other.lastWorkoutSummary == lastWorkoutSummary) &&
            (identical(other.isRestDay, isRestDay) ||
                other.isRestDay == isRestDay) &&
            (identical(other.todayDayName, todayDayName) ||
                other.todayDayName == todayDayName) &&
            const DeepCollectionEquality()
                .equals(other._todayExercises, _todayExercises) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            (identical(other.nextDayId, nextDayId) ||
                other.nextDayId == nextDayId) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.manualDayId, manualDayId) ||
                other.manualDayId == manualDayId));
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
      lastWorkoutSummary,
      isRestDay,
      todayDayName,
      const DeepCollectionEquality().hash(_todayExercises),
      estimatedDuration,
      nextDayId,
      templateId,
      manualDayId);

  @override
  String toString() {
    return 'WorkoutHomeState(greeting: $greeting, userName: $userName, dateString: $dateString, currentStreak: $currentStreak, dailyTip: $dailyTip, lastWorkout: $lastWorkout, activeDraft: $activeDraft, weeklyVolume: $weeklyVolume, lastWeight: $lastWeight, lastWorkoutSummary: $lastWorkoutSummary, isRestDay: $isRestDay, todayDayName: $todayDayName, todayExercises: $todayExercises, estimatedDuration: $estimatedDuration, nextDayId: $nextDayId, templateId: $templateId, manualDayId: $manualDayId)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutHomeStateCopyWith<$Res>
    implements $WorkoutHomeStateCopyWith<$Res> {
  factory _$WorkoutHomeStateCopyWith(
          _WorkoutHomeState value, $Res Function(_WorkoutHomeState) _then) =
      __$WorkoutHomeStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String greeting,
      String userName,
      String dateString,
      int currentStreak,
      MotivationTip dailyTip,
      WorkoutSession? lastWorkout,
      WorkoutSession? activeDraft,
      Map<int, double> weeklyVolume,
      BodyMeasurement? lastWeight,
      String? lastWorkoutSummary,
      bool isRestDay,
      String? todayDayName,
      List<String> todayExercises,
      int estimatedDuration,
      int? nextDayId,
      int? templateId,
      int? manualDayId});

  @override
  $MotivationTipCopyWith<$Res> get dailyTip;
  @override
  $WorkoutSessionCopyWith<$Res>? get lastWorkout;
  @override
  $WorkoutSessionCopyWith<$Res>? get activeDraft;
  @override
  $BodyMeasurementCopyWith<$Res>? get lastWeight;
}

/// @nodoc
class __$WorkoutHomeStateCopyWithImpl<$Res>
    implements _$WorkoutHomeStateCopyWith<$Res> {
  __$WorkoutHomeStateCopyWithImpl(this._self, this._then);

  final _WorkoutHomeState _self;
  final $Res Function(_WorkoutHomeState) _then;

  /// Create a copy of WorkoutHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    Object? lastWorkoutSummary = freezed,
    Object? isRestDay = null,
    Object? todayDayName = freezed,
    Object? todayExercises = null,
    Object? estimatedDuration = null,
    Object? nextDayId = freezed,
    Object? templateId = freezed,
    Object? manualDayId = freezed,
  }) {
    return _then(_WorkoutHomeState(
      greeting: null == greeting
          ? _self.greeting
          : greeting // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      dateString: null == dateString
          ? _self.dateString
          : dateString // ignore: cast_nullable_to_non_nullable
              as String,
      currentStreak: null == currentStreak
          ? _self.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      dailyTip: null == dailyTip
          ? _self.dailyTip
          : dailyTip // ignore: cast_nullable_to_non_nullable
              as MotivationTip,
      lastWorkout: freezed == lastWorkout
          ? _self.lastWorkout
          : lastWorkout // ignore: cast_nullable_to_non_nullable
              as WorkoutSession?,
      activeDraft: freezed == activeDraft
          ? _self.activeDraft
          : activeDraft // ignore: cast_nullable_to_non_nullable
              as WorkoutSession?,
      weeklyVolume: null == weeklyVolume
          ? _self._weeklyVolume
          : weeklyVolume // ignore: cast_nullable_to_non_nullable
              as Map<int, double>,
      lastWeight: freezed == lastWeight
          ? _self.lastWeight
          : lastWeight // ignore: cast_nullable_to_non_nullable
              as BodyMeasurement?,
      lastWorkoutSummary: freezed == lastWorkoutSummary
          ? _self.lastWorkoutSummary
          : lastWorkoutSummary // ignore: cast_nullable_to_non_nullable
              as String?,
      isRestDay: null == isRestDay
          ? _self.isRestDay
          : isRestDay // ignore: cast_nullable_to_non_nullable
              as bool,
      todayDayName: freezed == todayDayName
          ? _self.todayDayName
          : todayDayName // ignore: cast_nullable_to_non_nullable
              as String?,
      todayExercises: null == todayExercises
          ? _self._todayExercises
          : todayExercises // ignore: cast_nullable_to_non_nullable
              as List<String>,
      estimatedDuration: null == estimatedDuration
          ? _self.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as int,
      nextDayId: freezed == nextDayId
          ? _self.nextDayId
          : nextDayId // ignore: cast_nullable_to_non_nullable
              as int?,
      templateId: freezed == templateId
          ? _self.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as int?,
      manualDayId: freezed == manualDayId
          ? _self.manualDayId
          : manualDayId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of WorkoutHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MotivationTipCopyWith<$Res> get dailyTip {
    return $MotivationTipCopyWith<$Res>(_self.dailyTip, (value) {
      return _then(_self.copyWith(dailyTip: value));
    });
  }

  /// Create a copy of WorkoutHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutSessionCopyWith<$Res>? get lastWorkout {
    if (_self.lastWorkout == null) {
      return null;
    }

    return $WorkoutSessionCopyWith<$Res>(_self.lastWorkout!, (value) {
      return _then(_self.copyWith(lastWorkout: value));
    });
  }

  /// Create a copy of WorkoutHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutSessionCopyWith<$Res>? get activeDraft {
    if (_self.activeDraft == null) {
      return null;
    }

    return $WorkoutSessionCopyWith<$Res>(_self.activeDraft!, (value) {
      return _then(_self.copyWith(activeDraft: value));
    });
  }

  /// Create a copy of WorkoutHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BodyMeasurementCopyWith<$Res>? get lastWeight {
    if (_self.lastWeight == null) {
      return null;
    }

    return $BodyMeasurementCopyWith<$Res>(_self.lastWeight!, (value) {
      return _then(_self.copyWith(lastWeight: value));
    });
  }
}

// dart format on
