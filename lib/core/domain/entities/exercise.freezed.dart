// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Exercise {
  int get id;
  String get name;
  String? get description;
  String get category;
  String get difficulty;
  String get primaryMuscle;
  String? get secondaryMuscle;
  String get equipment;
  String get setType;
  int get restTime;
  List<String>? get instructions;
  String? get gifUrl;
  String? get imageUrl;
  String? get videoUrl;
  String? get mechanic;
  String? get force;
  String get source;
  bool get isCustom;
  DateTime? get lastUsed;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExerciseCopyWith<Exercise> get copyWith =>
      _$ExerciseCopyWithImpl<Exercise>(this as Exercise, _$identity);

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Exercise &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.primaryMuscle, primaryMuscle) ||
                other.primaryMuscle == primaryMuscle) &&
            (identical(other.secondaryMuscle, secondaryMuscle) ||
                other.secondaryMuscle == secondaryMuscle) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.setType, setType) || other.setType == setType) &&
            (identical(other.restTime, restTime) ||
                other.restTime == restTime) &&
            const DeepCollectionEquality()
                .equals(other.instructions, instructions) &&
            (identical(other.gifUrl, gifUrl) || other.gifUrl == gifUrl) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.mechanic, mechanic) ||
                other.mechanic == mechanic) &&
            (identical(other.force, force) || other.force == force) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom) &&
            (identical(other.lastUsed, lastUsed) ||
                other.lastUsed == lastUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        description,
        category,
        difficulty,
        primaryMuscle,
        secondaryMuscle,
        equipment,
        setType,
        restTime,
        const DeepCollectionEquality().hash(instructions),
        gifUrl,
        imageUrl,
        videoUrl,
        mechanic,
        force,
        source,
        isCustom,
        lastUsed
      ]);

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, description: $description, category: $category, difficulty: $difficulty, primaryMuscle: $primaryMuscle, secondaryMuscle: $secondaryMuscle, equipment: $equipment, setType: $setType, restTime: $restTime, instructions: $instructions, gifUrl: $gifUrl, imageUrl: $imageUrl, videoUrl: $videoUrl, mechanic: $mechanic, force: $force, source: $source, isCustom: $isCustom, lastUsed: $lastUsed)';
  }
}

/// @nodoc
abstract mixin class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) _then) =
      _$ExerciseCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      String category,
      String difficulty,
      String primaryMuscle,
      String? secondaryMuscle,
      String equipment,
      String setType,
      int restTime,
      List<String>? instructions,
      String? gifUrl,
      String? imageUrl,
      String? videoUrl,
      String? mechanic,
      String? force,
      String source,
      bool isCustom,
      DateTime? lastUsed});
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res> implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._self, this._then);

  final Exercise _self;
  final $Res Function(Exercise) _then;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = null,
    Object? difficulty = null,
    Object? primaryMuscle = null,
    Object? secondaryMuscle = freezed,
    Object? equipment = null,
    Object? setType = null,
    Object? restTime = null,
    Object? instructions = freezed,
    Object? gifUrl = freezed,
    Object? imageUrl = freezed,
    Object? videoUrl = freezed,
    Object? mechanic = freezed,
    Object? force = freezed,
    Object? source = null,
    Object? isCustom = null,
    Object? lastUsed = freezed,
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
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _self.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      primaryMuscle: null == primaryMuscle
          ? _self.primaryMuscle
          : primaryMuscle // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryMuscle: freezed == secondaryMuscle
          ? _self.secondaryMuscle
          : secondaryMuscle // ignore: cast_nullable_to_non_nullable
              as String?,
      equipment: null == equipment
          ? _self.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String,
      setType: null == setType
          ? _self.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as String,
      restTime: null == restTime
          ? _self.restTime
          : restTime // ignore: cast_nullable_to_non_nullable
              as int,
      instructions: freezed == instructions
          ? _self.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      gifUrl: freezed == gifUrl
          ? _self.gifUrl
          : gifUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _self.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mechanic: freezed == mechanic
          ? _self.mechanic
          : mechanic // ignore: cast_nullable_to_non_nullable
              as String?,
      force: freezed == force
          ? _self.force
          : force // ignore: cast_nullable_to_non_nullable
              as String?,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      isCustom: null == isCustom
          ? _self.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUsed: freezed == lastUsed
          ? _self.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Exercise].
extension ExercisePatterns on Exercise {
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
    TResult Function(_Exercise value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Exercise() when $default != null:
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
    TResult Function(_Exercise value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Exercise():
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
    TResult? Function(_Exercise value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Exercise() when $default != null:
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
            String? description,
            String category,
            String difficulty,
            String primaryMuscle,
            String? secondaryMuscle,
            String equipment,
            String setType,
            int restTime,
            List<String>? instructions,
            String? gifUrl,
            String? imageUrl,
            String? videoUrl,
            String? mechanic,
            String? force,
            String source,
            bool isCustom,
            DateTime? lastUsed)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Exercise() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.category,
            _that.difficulty,
            _that.primaryMuscle,
            _that.secondaryMuscle,
            _that.equipment,
            _that.setType,
            _that.restTime,
            _that.instructions,
            _that.gifUrl,
            _that.imageUrl,
            _that.videoUrl,
            _that.mechanic,
            _that.force,
            _that.source,
            _that.isCustom,
            _that.lastUsed);
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
            String? description,
            String category,
            String difficulty,
            String primaryMuscle,
            String? secondaryMuscle,
            String equipment,
            String setType,
            int restTime,
            List<String>? instructions,
            String? gifUrl,
            String? imageUrl,
            String? videoUrl,
            String? mechanic,
            String? force,
            String source,
            bool isCustom,
            DateTime? lastUsed)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Exercise():
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.category,
            _that.difficulty,
            _that.primaryMuscle,
            _that.secondaryMuscle,
            _that.equipment,
            _that.setType,
            _that.restTime,
            _that.instructions,
            _that.gifUrl,
            _that.imageUrl,
            _that.videoUrl,
            _that.mechanic,
            _that.force,
            _that.source,
            _that.isCustom,
            _that.lastUsed);
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
            String? description,
            String category,
            String difficulty,
            String primaryMuscle,
            String? secondaryMuscle,
            String equipment,
            String setType,
            int restTime,
            List<String>? instructions,
            String? gifUrl,
            String? imageUrl,
            String? videoUrl,
            String? mechanic,
            String? force,
            String source,
            bool isCustom,
            DateTime? lastUsed)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Exercise() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.category,
            _that.difficulty,
            _that.primaryMuscle,
            _that.secondaryMuscle,
            _that.equipment,
            _that.setType,
            _that.restTime,
            _that.instructions,
            _that.gifUrl,
            _that.imageUrl,
            _that.videoUrl,
            _that.mechanic,
            _that.force,
            _that.source,
            _that.isCustom,
            _that.lastUsed);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Exercise extends Exercise {
  const _Exercise(
      {required this.id,
      required this.name,
      this.description,
      this.category = 'Strength',
      this.difficulty = 'Beginner',
      this.primaryMuscle = '',
      this.secondaryMuscle,
      this.equipment = 'Barbell',
      this.setType = 'Straight',
      this.restTime = 90,
      final List<String>? instructions,
      this.gifUrl,
      this.imageUrl,
      this.videoUrl,
      this.mechanic,
      this.force,
      this.source = 'local',
      this.isCustom = false,
      this.lastUsed})
      : _instructions = instructions,
        super._();
  factory _Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final String difficulty;
  @override
  @JsonKey()
  final String primaryMuscle;
  @override
  final String? secondaryMuscle;
  @override
  @JsonKey()
  final String equipment;
  @override
  @JsonKey()
  final String setType;
  @override
  @JsonKey()
  final int restTime;
  final List<String>? _instructions;
  @override
  List<String>? get instructions {
    final value = _instructions;
    if (value == null) return null;
    if (_instructions is EqualUnmodifiableListView) return _instructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? gifUrl;
  @override
  final String? imageUrl;
  @override
  final String? videoUrl;
  @override
  final String? mechanic;
  @override
  final String? force;
  @override
  @JsonKey()
  final String source;
  @override
  @JsonKey()
  final bool isCustom;
  @override
  final DateTime? lastUsed;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExerciseCopyWith<_Exercise> get copyWith =>
      __$ExerciseCopyWithImpl<_Exercise>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExerciseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Exercise &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.primaryMuscle, primaryMuscle) ||
                other.primaryMuscle == primaryMuscle) &&
            (identical(other.secondaryMuscle, secondaryMuscle) ||
                other.secondaryMuscle == secondaryMuscle) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.setType, setType) || other.setType == setType) &&
            (identical(other.restTime, restTime) ||
                other.restTime == restTime) &&
            const DeepCollectionEquality()
                .equals(other._instructions, _instructions) &&
            (identical(other.gifUrl, gifUrl) || other.gifUrl == gifUrl) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.mechanic, mechanic) ||
                other.mechanic == mechanic) &&
            (identical(other.force, force) || other.force == force) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom) &&
            (identical(other.lastUsed, lastUsed) ||
                other.lastUsed == lastUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        description,
        category,
        difficulty,
        primaryMuscle,
        secondaryMuscle,
        equipment,
        setType,
        restTime,
        const DeepCollectionEquality().hash(_instructions),
        gifUrl,
        imageUrl,
        videoUrl,
        mechanic,
        force,
        source,
        isCustom,
        lastUsed
      ]);

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, description: $description, category: $category, difficulty: $difficulty, primaryMuscle: $primaryMuscle, secondaryMuscle: $secondaryMuscle, equipment: $equipment, setType: $setType, restTime: $restTime, instructions: $instructions, gifUrl: $gifUrl, imageUrl: $imageUrl, videoUrl: $videoUrl, mechanic: $mechanic, force: $force, source: $source, isCustom: $isCustom, lastUsed: $lastUsed)';
  }
}

/// @nodoc
abstract mixin class _$ExerciseCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$ExerciseCopyWith(_Exercise value, $Res Function(_Exercise) _then) =
      __$ExerciseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      String category,
      String difficulty,
      String primaryMuscle,
      String? secondaryMuscle,
      String equipment,
      String setType,
      int restTime,
      List<String>? instructions,
      String? gifUrl,
      String? imageUrl,
      String? videoUrl,
      String? mechanic,
      String? force,
      String source,
      bool isCustom,
      DateTime? lastUsed});
}

/// @nodoc
class __$ExerciseCopyWithImpl<$Res> implements _$ExerciseCopyWith<$Res> {
  __$ExerciseCopyWithImpl(this._self, this._then);

  final _Exercise _self;
  final $Res Function(_Exercise) _then;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = null,
    Object? difficulty = null,
    Object? primaryMuscle = null,
    Object? secondaryMuscle = freezed,
    Object? equipment = null,
    Object? setType = null,
    Object? restTime = null,
    Object? instructions = freezed,
    Object? gifUrl = freezed,
    Object? imageUrl = freezed,
    Object? videoUrl = freezed,
    Object? mechanic = freezed,
    Object? force = freezed,
    Object? source = null,
    Object? isCustom = null,
    Object? lastUsed = freezed,
  }) {
    return _then(_Exercise(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _self.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      primaryMuscle: null == primaryMuscle
          ? _self.primaryMuscle
          : primaryMuscle // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryMuscle: freezed == secondaryMuscle
          ? _self.secondaryMuscle
          : secondaryMuscle // ignore: cast_nullable_to_non_nullable
              as String?,
      equipment: null == equipment
          ? _self.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String,
      setType: null == setType
          ? _self.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as String,
      restTime: null == restTime
          ? _self.restTime
          : restTime // ignore: cast_nullable_to_non_nullable
              as int,
      instructions: freezed == instructions
          ? _self._instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      gifUrl: freezed == gifUrl
          ? _self.gifUrl
          : gifUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _self.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mechanic: freezed == mechanic
          ? _self.mechanic
          : mechanic // ignore: cast_nullable_to_non_nullable
              as String?,
      force: freezed == force
          ? _self.force
          : force // ignore: cast_nullable_to_non_nullable
              as String?,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      isCustom: null == isCustom
          ? _self.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUsed: freezed == lastUsed
          ? _self.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
