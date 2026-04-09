// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return _Exercise.fromJson(json);
}

/// @nodoc
mixin _$Exercise {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  String get primaryMuscle => throw _privateConstructorUsedError;
  String? get secondaryMuscle => throw _privateConstructorUsedError;
  String get equipment => throw _privateConstructorUsedError;
  String get setType => throw _privateConstructorUsedError;
  int get restTime => throw _privateConstructorUsedError;
  List<String>? get instructions => throw _privateConstructorUsedError;
  String? get gifUrl => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  String? get mechanic => throw _privateConstructorUsedError;
  String? get force => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  bool get isCustom => throw _privateConstructorUsedError;
  DateTime? get lastUsed => throw _privateConstructorUsedError;

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res, Exercise>;
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
class _$ExerciseCopyWithImpl<$Res, $Val extends Exercise>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      primaryMuscle: null == primaryMuscle
          ? _value.primaryMuscle
          : primaryMuscle // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryMuscle: freezed == secondaryMuscle
          ? _value.secondaryMuscle
          : secondaryMuscle // ignore: cast_nullable_to_non_nullable
              as String?,
      equipment: null == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String,
      setType: null == setType
          ? _value.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as String,
      restTime: null == restTime
          ? _value.restTime
          : restTime // ignore: cast_nullable_to_non_nullable
              as int,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      gifUrl: freezed == gifUrl
          ? _value.gifUrl
          : gifUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mechanic: freezed == mechanic
          ? _value.mechanic
          : mechanic // ignore: cast_nullable_to_non_nullable
              as String?,
      force: freezed == force
          ? _value.force
          : force // ignore: cast_nullable_to_non_nullable
              as String?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUsed: freezed == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseImplCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$$ExerciseImplCopyWith(
          _$ExerciseImpl value, $Res Function(_$ExerciseImpl) then) =
      __$$ExerciseImplCopyWithImpl<$Res>;
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
class __$$ExerciseImplCopyWithImpl<$Res>
    extends _$ExerciseCopyWithImpl<$Res, _$ExerciseImpl>
    implements _$$ExerciseImplCopyWith<$Res> {
  __$$ExerciseImplCopyWithImpl(
      _$ExerciseImpl _value, $Res Function(_$ExerciseImpl) _then)
      : super(_value, _then);

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
    return _then(_$ExerciseImpl(
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      primaryMuscle: null == primaryMuscle
          ? _value.primaryMuscle
          : primaryMuscle // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryMuscle: freezed == secondaryMuscle
          ? _value.secondaryMuscle
          : secondaryMuscle // ignore: cast_nullable_to_non_nullable
              as String?,
      equipment: null == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String,
      setType: null == setType
          ? _value.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as String,
      restTime: null == restTime
          ? _value.restTime
          : restTime // ignore: cast_nullable_to_non_nullable
              as int,
      instructions: freezed == instructions
          ? _value._instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      gifUrl: freezed == gifUrl
          ? _value.gifUrl
          : gifUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      mechanic: freezed == mechanic
          ? _value.mechanic
          : mechanic // ignore: cast_nullable_to_non_nullable
              as String?,
      force: freezed == force
          ? _value.force
          : force // ignore: cast_nullable_to_non_nullable
              as String?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUsed: freezed == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseImpl implements _Exercise {
  const _$ExerciseImpl(
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
      : _instructions = instructions;

  factory _$ExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseImplFromJson(json);

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

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, description: $description, category: $category, difficulty: $difficulty, primaryMuscle: $primaryMuscle, secondaryMuscle: $secondaryMuscle, equipment: $equipment, setType: $setType, restTime: $restTime, instructions: $instructions, gifUrl: $gifUrl, imageUrl: $imageUrl, videoUrl: $videoUrl, mechanic: $mechanic, force: $force, source: $source, isCustom: $isCustom, lastUsed: $lastUsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseImpl &&
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

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      __$$ExerciseImplCopyWithImpl<_$ExerciseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseImplToJson(
      this,
    );
  }
}

abstract class _Exercise implements Exercise {
  const factory _Exercise(
      {required final int id,
      required final String name,
      final String? description,
      final String category,
      final String difficulty,
      final String primaryMuscle,
      final String? secondaryMuscle,
      final String equipment,
      final String setType,
      final int restTime,
      final List<String>? instructions,
      final String? gifUrl,
      final String? imageUrl,
      final String? videoUrl,
      final String? mechanic,
      final String? force,
      final String source,
      final bool isCustom,
      final DateTime? lastUsed}) = _$ExerciseImpl;

  factory _Exercise.fromJson(Map<String, dynamic> json) =
      _$ExerciseImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get category;
  @override
  String get difficulty;
  @override
  String get primaryMuscle;
  @override
  String? get secondaryMuscle;
  @override
  String get equipment;
  @override
  String get setType;
  @override
  int get restTime;
  @override
  List<String>? get instructions;
  @override
  String? get gifUrl;
  @override
  String? get imageUrl;
  @override
  String? get videoUrl;
  @override
  String? get mechanic;
  @override
  String? get force;
  @override
  String get source;
  @override
  bool get isCustom;
  @override
  DateTime? get lastUsed;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
