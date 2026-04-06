// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'programs_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProgramsState {
  List<WorkoutTemplate> get templates => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramsStateCopyWith<ProgramsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramsStateCopyWith<$Res> {
  factory $ProgramsStateCopyWith(
          ProgramsState value, $Res Function(ProgramsState) then) =
      _$ProgramsStateCopyWithImpl<$Res, ProgramsState>;
  @useResult
  $Res call(
      {List<WorkoutTemplate> templates, bool isLoading, String? errorMessage});
}

/// @nodoc
class _$ProgramsStateCopyWithImpl<$Res, $Val extends ProgramsState>
    implements $ProgramsStateCopyWith<$Res> {
  _$ProgramsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templates = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      templates: null == templates
          ? _value.templates
          : templates // ignore: cast_nullable_to_non_nullable
              as List<WorkoutTemplate>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgramsStateImplCopyWith<$Res>
    implements $ProgramsStateCopyWith<$Res> {
  factory _$$ProgramsStateImplCopyWith(
          _$ProgramsStateImpl value, $Res Function(_$ProgramsStateImpl) then) =
      __$$ProgramsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<WorkoutTemplate> templates, bool isLoading, String? errorMessage});
}

/// @nodoc
class __$$ProgramsStateImplCopyWithImpl<$Res>
    extends _$ProgramsStateCopyWithImpl<$Res, _$ProgramsStateImpl>
    implements _$$ProgramsStateImplCopyWith<$Res> {
  __$$ProgramsStateImplCopyWithImpl(
      _$ProgramsStateImpl _value, $Res Function(_$ProgramsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templates = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ProgramsStateImpl(
      templates: null == templates
          ? _value._templates
          : templates // ignore: cast_nullable_to_non_nullable
              as List<WorkoutTemplate>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ProgramsStateImpl implements _ProgramsState {
  const _$ProgramsStateImpl(
      {final List<WorkoutTemplate> templates = const [],
      this.isLoading = false,
      this.errorMessage})
      : _templates = templates;

  final List<WorkoutTemplate> _templates;
  @override
  @JsonKey()
  List<WorkoutTemplate> get templates {
    if (_templates is EqualUnmodifiableListView) return _templates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_templates);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ProgramsState(templates: $templates, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramsStateImpl &&
            const DeepCollectionEquality()
                .equals(other._templates, _templates) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_templates), isLoading, errorMessage);

  /// Create a copy of ProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramsStateImplCopyWith<_$ProgramsStateImpl> get copyWith =>
      __$$ProgramsStateImplCopyWithImpl<_$ProgramsStateImpl>(this, _$identity);
}

abstract class _ProgramsState implements ProgramsState {
  const factory _ProgramsState(
      {final List<WorkoutTemplate> templates,
      final bool isLoading,
      final String? errorMessage}) = _$ProgramsStateImpl;

  @override
  List<WorkoutTemplate> get templates;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of ProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramsStateImplCopyWith<_$ProgramsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
