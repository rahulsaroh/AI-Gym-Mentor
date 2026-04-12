// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cloud_integration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CloudIntegrationState {
  bool get isFirebaseInitialized;
  ConnectivityResult get connectivity;
  bool get isGoogleSignedIn;
  int get pendingSyncCount;
  String? get lastSyncError;
  DateTime? get lastSyncedAt;
  bool get isSyncEnabled;

  /// Create a copy of CloudIntegrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CloudIntegrationStateCopyWith<CloudIntegrationState> get copyWith =>
      _$CloudIntegrationStateCopyWithImpl<CloudIntegrationState>(
          this as CloudIntegrationState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CloudIntegrationState &&
            (identical(other.isFirebaseInitialized, isFirebaseInitialized) ||
                other.isFirebaseInitialized == isFirebaseInitialized) &&
            (identical(other.connectivity, connectivity) ||
                other.connectivity == connectivity) &&
            (identical(other.isGoogleSignedIn, isGoogleSignedIn) ||
                other.isGoogleSignedIn == isGoogleSignedIn) &&
            (identical(other.pendingSyncCount, pendingSyncCount) ||
                other.pendingSyncCount == pendingSyncCount) &&
            (identical(other.lastSyncError, lastSyncError) ||
                other.lastSyncError == lastSyncError) &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt) &&
            (identical(other.isSyncEnabled, isSyncEnabled) ||
                other.isSyncEnabled == isSyncEnabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isFirebaseInitialized,
      connectivity,
      isGoogleSignedIn,
      pendingSyncCount,
      lastSyncError,
      lastSyncedAt,
      isSyncEnabled);

  @override
  String toString() {
    return 'CloudIntegrationState(isFirebaseInitialized: $isFirebaseInitialized, connectivity: $connectivity, isGoogleSignedIn: $isGoogleSignedIn, pendingSyncCount: $pendingSyncCount, lastSyncError: $lastSyncError, lastSyncedAt: $lastSyncedAt, isSyncEnabled: $isSyncEnabled)';
  }
}

/// @nodoc
abstract mixin class $CloudIntegrationStateCopyWith<$Res> {
  factory $CloudIntegrationStateCopyWith(CloudIntegrationState value,
          $Res Function(CloudIntegrationState) _then) =
      _$CloudIntegrationStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isFirebaseInitialized,
      ConnectivityResult connectivity,
      bool isGoogleSignedIn,
      int pendingSyncCount,
      String? lastSyncError,
      DateTime? lastSyncedAt,
      bool isSyncEnabled});
}

/// @nodoc
class _$CloudIntegrationStateCopyWithImpl<$Res>
    implements $CloudIntegrationStateCopyWith<$Res> {
  _$CloudIntegrationStateCopyWithImpl(this._self, this._then);

  final CloudIntegrationState _self;
  final $Res Function(CloudIntegrationState) _then;

  /// Create a copy of CloudIntegrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFirebaseInitialized = null,
    Object? connectivity = null,
    Object? isGoogleSignedIn = null,
    Object? pendingSyncCount = null,
    Object? lastSyncError = freezed,
    Object? lastSyncedAt = freezed,
    Object? isSyncEnabled = null,
  }) {
    return _then(_self.copyWith(
      isFirebaseInitialized: null == isFirebaseInitialized
          ? _self.isFirebaseInitialized
          : isFirebaseInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      connectivity: null == connectivity
          ? _self.connectivity
          : connectivity // ignore: cast_nullable_to_non_nullable
              as ConnectivityResult,
      isGoogleSignedIn: null == isGoogleSignedIn
          ? _self.isGoogleSignedIn
          : isGoogleSignedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingSyncCount: null == pendingSyncCount
          ? _self.pendingSyncCount
          : pendingSyncCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastSyncError: freezed == lastSyncError
          ? _self.lastSyncError
          : lastSyncError // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSyncedAt: freezed == lastSyncedAt
          ? _self.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isSyncEnabled: null == isSyncEnabled
          ? _self.isSyncEnabled
          : isSyncEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [CloudIntegrationState].
extension CloudIntegrationStatePatterns on CloudIntegrationState {
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
    TResult Function(_CloudIntegrationState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CloudIntegrationState() when $default != null:
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
    TResult Function(_CloudIntegrationState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CloudIntegrationState():
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
    TResult? Function(_CloudIntegrationState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CloudIntegrationState() when $default != null:
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
            bool isFirebaseInitialized,
            ConnectivityResult connectivity,
            bool isGoogleSignedIn,
            int pendingSyncCount,
            String? lastSyncError,
            DateTime? lastSyncedAt,
            bool isSyncEnabled)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CloudIntegrationState() when $default != null:
        return $default(
            _that.isFirebaseInitialized,
            _that.connectivity,
            _that.isGoogleSignedIn,
            _that.pendingSyncCount,
            _that.lastSyncError,
            _that.lastSyncedAt,
            _that.isSyncEnabled);
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
            bool isFirebaseInitialized,
            ConnectivityResult connectivity,
            bool isGoogleSignedIn,
            int pendingSyncCount,
            String? lastSyncError,
            DateTime? lastSyncedAt,
            bool isSyncEnabled)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CloudIntegrationState():
        return $default(
            _that.isFirebaseInitialized,
            _that.connectivity,
            _that.isGoogleSignedIn,
            _that.pendingSyncCount,
            _that.lastSyncError,
            _that.lastSyncedAt,
            _that.isSyncEnabled);
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
            bool isFirebaseInitialized,
            ConnectivityResult connectivity,
            bool isGoogleSignedIn,
            int pendingSyncCount,
            String? lastSyncError,
            DateTime? lastSyncedAt,
            bool isSyncEnabled)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CloudIntegrationState() when $default != null:
        return $default(
            _that.isFirebaseInitialized,
            _that.connectivity,
            _that.isGoogleSignedIn,
            _that.pendingSyncCount,
            _that.lastSyncError,
            _that.lastSyncedAt,
            _that.isSyncEnabled);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CloudIntegrationState extends CloudIntegrationState {
  const _CloudIntegrationState(
      {this.isFirebaseInitialized = false,
      this.connectivity = ConnectivityResult.none,
      this.isGoogleSignedIn = false,
      this.pendingSyncCount = 0,
      this.lastSyncError,
      this.lastSyncedAt,
      this.isSyncEnabled = false})
      : super._();

  @override
  @JsonKey()
  final bool isFirebaseInitialized;
  @override
  @JsonKey()
  final ConnectivityResult connectivity;
  @override
  @JsonKey()
  final bool isGoogleSignedIn;
  @override
  @JsonKey()
  final int pendingSyncCount;
  @override
  final String? lastSyncError;
  @override
  final DateTime? lastSyncedAt;
  @override
  @JsonKey()
  final bool isSyncEnabled;

  /// Create a copy of CloudIntegrationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CloudIntegrationStateCopyWith<_CloudIntegrationState> get copyWith =>
      __$CloudIntegrationStateCopyWithImpl<_CloudIntegrationState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CloudIntegrationState &&
            (identical(other.isFirebaseInitialized, isFirebaseInitialized) ||
                other.isFirebaseInitialized == isFirebaseInitialized) &&
            (identical(other.connectivity, connectivity) ||
                other.connectivity == connectivity) &&
            (identical(other.isGoogleSignedIn, isGoogleSignedIn) ||
                other.isGoogleSignedIn == isGoogleSignedIn) &&
            (identical(other.pendingSyncCount, pendingSyncCount) ||
                other.pendingSyncCount == pendingSyncCount) &&
            (identical(other.lastSyncError, lastSyncError) ||
                other.lastSyncError == lastSyncError) &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt) &&
            (identical(other.isSyncEnabled, isSyncEnabled) ||
                other.isSyncEnabled == isSyncEnabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isFirebaseInitialized,
      connectivity,
      isGoogleSignedIn,
      pendingSyncCount,
      lastSyncError,
      lastSyncedAt,
      isSyncEnabled);

  @override
  String toString() {
    return 'CloudIntegrationState(isFirebaseInitialized: $isFirebaseInitialized, connectivity: $connectivity, isGoogleSignedIn: $isGoogleSignedIn, pendingSyncCount: $pendingSyncCount, lastSyncError: $lastSyncError, lastSyncedAt: $lastSyncedAt, isSyncEnabled: $isSyncEnabled)';
  }
}

/// @nodoc
abstract mixin class _$CloudIntegrationStateCopyWith<$Res>
    implements $CloudIntegrationStateCopyWith<$Res> {
  factory _$CloudIntegrationStateCopyWith(_CloudIntegrationState value,
          $Res Function(_CloudIntegrationState) _then) =
      __$CloudIntegrationStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isFirebaseInitialized,
      ConnectivityResult connectivity,
      bool isGoogleSignedIn,
      int pendingSyncCount,
      String? lastSyncError,
      DateTime? lastSyncedAt,
      bool isSyncEnabled});
}

/// @nodoc
class __$CloudIntegrationStateCopyWithImpl<$Res>
    implements _$CloudIntegrationStateCopyWith<$Res> {
  __$CloudIntegrationStateCopyWithImpl(this._self, this._then);

  final _CloudIntegrationState _self;
  final $Res Function(_CloudIntegrationState) _then;

  /// Create a copy of CloudIntegrationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isFirebaseInitialized = null,
    Object? connectivity = null,
    Object? isGoogleSignedIn = null,
    Object? pendingSyncCount = null,
    Object? lastSyncError = freezed,
    Object? lastSyncedAt = freezed,
    Object? isSyncEnabled = null,
  }) {
    return _then(_CloudIntegrationState(
      isFirebaseInitialized: null == isFirebaseInitialized
          ? _self.isFirebaseInitialized
          : isFirebaseInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      connectivity: null == connectivity
          ? _self.connectivity
          : connectivity // ignore: cast_nullable_to_non_nullable
              as ConnectivityResult,
      isGoogleSignedIn: null == isGoogleSignedIn
          ? _self.isGoogleSignedIn
          : isGoogleSignedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingSyncCount: null == pendingSyncCount
          ? _self.pendingSyncCount
          : pendingSyncCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastSyncError: freezed == lastSyncError
          ? _self.lastSyncError
          : lastSyncError // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSyncedAt: freezed == lastSyncedAt
          ? _self.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isSyncEnabled: null == isSyncEnabled
          ? _self.isSyncEnabled
          : isSyncEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
