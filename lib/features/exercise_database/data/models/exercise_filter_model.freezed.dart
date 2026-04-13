// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseFilter {
  String? get bodyPart;
  String? get category;
  String? get equipment;
  String? get difficulty;
  String? get searchQuery;
  bool get favoritesOnly;

  /// Create a copy of ExerciseFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExerciseFilterCopyWith<ExerciseFilter> get copyWith =>
      _$ExerciseFilterCopyWithImpl<ExerciseFilter>(
          this as ExerciseFilter, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExerciseFilter &&
            (identical(other.bodyPart, bodyPart) ||
                other.bodyPart == bodyPart) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.favoritesOnly, favoritesOnly) ||
                other.favoritesOnly == favoritesOnly));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bodyPart, category, equipment,
      difficulty, searchQuery, favoritesOnly);

  @override
  String toString() {
    return 'ExerciseFilter(bodyPart: $bodyPart, category: $category, equipment: $equipment, difficulty: $difficulty, searchQuery: $searchQuery, favoritesOnly: $favoritesOnly)';
  }
}

/// @nodoc
abstract mixin class $ExerciseFilterCopyWith<$Res> {
  factory $ExerciseFilterCopyWith(
          ExerciseFilter value, $Res Function(ExerciseFilter) _then) =
      _$ExerciseFilterCopyWithImpl;
  @useResult
  $Res call(
      {String? bodyPart,
      String? category,
      String? equipment,
      String? difficulty,
      String? searchQuery,
      bool favoritesOnly});
}

/// @nodoc
class _$ExerciseFilterCopyWithImpl<$Res>
    implements $ExerciseFilterCopyWith<$Res> {
  _$ExerciseFilterCopyWithImpl(this._self, this._then);

  final ExerciseFilter _self;
  final $Res Function(ExerciseFilter) _then;

  /// Create a copy of ExerciseFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bodyPart = freezed,
    Object? category = freezed,
    Object? equipment = freezed,
    Object? difficulty = freezed,
    Object? searchQuery = freezed,
    Object? favoritesOnly = null,
  }) {
    return _then(_self.copyWith(
      bodyPart: freezed == bodyPart
          ? _self.bodyPart
          : bodyPart // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      equipment: freezed == equipment
          ? _self.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String?,
      difficulty: freezed == difficulty
          ? _self.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _self.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      favoritesOnly: null == favoritesOnly
          ? _self.favoritesOnly
          : favoritesOnly // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExerciseFilter].
extension ExerciseFilterPatterns on ExerciseFilter {
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
    TResult Function(_ExerciseFilter value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseFilter() when $default != null:
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
    TResult Function(_ExerciseFilter value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseFilter():
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
    TResult? Function(_ExerciseFilter value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseFilter() when $default != null:
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
    TResult Function(String? bodyPart, String? category, String? equipment,
            String? difficulty, String? searchQuery, bool favoritesOnly)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseFilter() when $default != null:
        return $default(_that.bodyPart, _that.category, _that.equipment,
            _that.difficulty, _that.searchQuery, _that.favoritesOnly);
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
    TResult Function(String? bodyPart, String? category, String? equipment,
            String? difficulty, String? searchQuery, bool favoritesOnly)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseFilter():
        return $default(_that.bodyPart, _that.category, _that.equipment,
            _that.difficulty, _that.searchQuery, _that.favoritesOnly);
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
    TResult? Function(String? bodyPart, String? category, String? equipment,
            String? difficulty, String? searchQuery, bool favoritesOnly)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseFilter() when $default != null:
        return $default(_that.bodyPart, _that.category, _that.equipment,
            _that.difficulty, _that.searchQuery, _that.favoritesOnly);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ExerciseFilter extends ExerciseFilter {
  const _ExerciseFilter(
      {this.bodyPart = null,
      this.category = null,
      this.equipment = null,
      this.difficulty = null,
      this.searchQuery = null,
      this.favoritesOnly = false})
      : super._();

  @override
  @JsonKey()
  final String? bodyPart;
  @override
  @JsonKey()
  final String? category;
  @override
  @JsonKey()
  final String? equipment;
  @override
  @JsonKey()
  final String? difficulty;
  @override
  @JsonKey()
  final String? searchQuery;
  @override
  @JsonKey()
  final bool favoritesOnly;

  /// Create a copy of ExerciseFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExerciseFilterCopyWith<_ExerciseFilter> get copyWith =>
      __$ExerciseFilterCopyWithImpl<_ExerciseFilter>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExerciseFilter &&
            (identical(other.bodyPart, bodyPart) ||
                other.bodyPart == bodyPart) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.favoritesOnly, favoritesOnly) ||
                other.favoritesOnly == favoritesOnly));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bodyPart, category, equipment,
      difficulty, searchQuery, favoritesOnly);

  @override
  String toString() {
    return 'ExerciseFilter(bodyPart: $bodyPart, category: $category, equipment: $equipment, difficulty: $difficulty, searchQuery: $searchQuery, favoritesOnly: $favoritesOnly)';
  }
}

/// @nodoc
abstract mixin class _$ExerciseFilterCopyWith<$Res>
    implements $ExerciseFilterCopyWith<$Res> {
  factory _$ExerciseFilterCopyWith(
          _ExerciseFilter value, $Res Function(_ExerciseFilter) _then) =
      __$ExerciseFilterCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? bodyPart,
      String? category,
      String? equipment,
      String? difficulty,
      String? searchQuery,
      bool favoritesOnly});
}

/// @nodoc
class __$ExerciseFilterCopyWithImpl<$Res>
    implements _$ExerciseFilterCopyWith<$Res> {
  __$ExerciseFilterCopyWithImpl(this._self, this._then);

  final _ExerciseFilter _self;
  final $Res Function(_ExerciseFilter) _then;

  /// Create a copy of ExerciseFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? bodyPart = freezed,
    Object? category = freezed,
    Object? equipment = freezed,
    Object? difficulty = freezed,
    Object? searchQuery = freezed,
    Object? favoritesOnly = null,
  }) {
    return _then(_ExerciseFilter(
      bodyPart: freezed == bodyPart
          ? _self.bodyPart
          : bodyPart // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      equipment: freezed == equipment
          ? _self.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String?,
      difficulty: freezed == difficulty
          ? _self.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _self.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      favoritesOnly: null == favoritesOnly
          ? _self.favoritesOnly
          : favoritesOnly // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
