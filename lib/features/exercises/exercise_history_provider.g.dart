// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$exerciseStatsHash() => r'27a7115f46d38e6f240afcd79cea0421a879c57e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [exerciseStats].
@ProviderFor(exerciseStats)
const exerciseStatsProvider = ExerciseStatsFamily();

/// See also [exerciseStats].
class ExerciseStatsFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [exerciseStats].
  const ExerciseStatsFamily();

  /// See also [exerciseStats].
  ExerciseStatsProvider call(
    int exerciseId,
  ) {
    return ExerciseStatsProvider(
      exerciseId,
    );
  }

  @override
  ExerciseStatsProvider getProviderOverride(
    covariant ExerciseStatsProvider provider,
  ) {
    return call(
      provider.exerciseId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'exerciseStatsProvider';
}

/// See also [exerciseStats].
class ExerciseStatsProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [exerciseStats].
  ExerciseStatsProvider(
    int exerciseId,
  ) : this._internal(
          (ref) => exerciseStats(
            ref as ExerciseStatsRef,
            exerciseId,
          ),
          from: exerciseStatsProvider,
          name: r'exerciseStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$exerciseStatsHash,
          dependencies: ExerciseStatsFamily._dependencies,
          allTransitiveDependencies:
              ExerciseStatsFamily._allTransitiveDependencies,
          exerciseId: exerciseId,
        );

  ExerciseStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.exerciseId,
  }) : super.internal();

  final int exerciseId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(ExerciseStatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExerciseStatsProvider._internal(
        (ref) => create(ref as ExerciseStatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        exerciseId: exerciseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _ExerciseStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExerciseStatsProvider && other.exerciseId == exerciseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, exerciseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExerciseStatsRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `exerciseId` of this provider.
  int get exerciseId;
}

class _ExerciseStatsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with ExerciseStatsRef {
  _ExerciseStatsProviderElement(super.provider);

  @override
  int get exerciseId => (origin as ExerciseStatsProvider).exerciseId;
}

String _$exerciseHistoryHash() => r'ae272edab031e7ed3606538ca2da824f580b2115';

/// See also [exerciseHistory].
@ProviderFor(exerciseHistory)
const exerciseHistoryProvider = ExerciseHistoryFamily();

/// See also [exerciseHistory].
class ExerciseHistoryFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [exerciseHistory].
  const ExerciseHistoryFamily();

  /// See also [exerciseHistory].
  ExerciseHistoryProvider call(
    int exerciseId,
  ) {
    return ExerciseHistoryProvider(
      exerciseId,
    );
  }

  @override
  ExerciseHistoryProvider getProviderOverride(
    covariant ExerciseHistoryProvider provider,
  ) {
    return call(
      provider.exerciseId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'exerciseHistoryProvider';
}

/// See also [exerciseHistory].
class ExerciseHistoryProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [exerciseHistory].
  ExerciseHistoryProvider(
    int exerciseId,
  ) : this._internal(
          (ref) => exerciseHistory(
            ref as ExerciseHistoryRef,
            exerciseId,
          ),
          from: exerciseHistoryProvider,
          name: r'exerciseHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$exerciseHistoryHash,
          dependencies: ExerciseHistoryFamily._dependencies,
          allTransitiveDependencies:
              ExerciseHistoryFamily._allTransitiveDependencies,
          exerciseId: exerciseId,
        );

  ExerciseHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.exerciseId,
  }) : super.internal();

  final int exerciseId;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(ExerciseHistoryRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExerciseHistoryProvider._internal(
        (ref) => create(ref as ExerciseHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        exerciseId: exerciseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _ExerciseHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExerciseHistoryProvider && other.exerciseId == exerciseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, exerciseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExerciseHistoryRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `exerciseId` of this provider.
  int get exerciseId;
}

class _ExerciseHistoryProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with ExerciseHistoryRef {
  _ExerciseHistoryProviderElement(super.provider);

  @override
  int get exerciseId => (origin as ExerciseHistoryProvider).exerciseId;
}

String _$exerciseChartDataHash() => r'c0288cfda5906bc0f24a4f4df54bc83969ef5c0f';

/// See also [exerciseChartData].
@ProviderFor(exerciseChartData)
const exerciseChartDataProvider = ExerciseChartDataFamily();

/// See also [exerciseChartData].
class ExerciseChartDataFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [exerciseChartData].
  const ExerciseChartDataFamily();

  /// See also [exerciseChartData].
  ExerciseChartDataProvider call(
    int exerciseId,
    Duration range,
  ) {
    return ExerciseChartDataProvider(
      exerciseId,
      range,
    );
  }

  @override
  ExerciseChartDataProvider getProviderOverride(
    covariant ExerciseChartDataProvider provider,
  ) {
    return call(
      provider.exerciseId,
      provider.range,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'exerciseChartDataProvider';
}

/// See also [exerciseChartData].
class ExerciseChartDataProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [exerciseChartData].
  ExerciseChartDataProvider(
    int exerciseId,
    Duration range,
  ) : this._internal(
          (ref) => exerciseChartData(
            ref as ExerciseChartDataRef,
            exerciseId,
            range,
          ),
          from: exerciseChartDataProvider,
          name: r'exerciseChartDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$exerciseChartDataHash,
          dependencies: ExerciseChartDataFamily._dependencies,
          allTransitiveDependencies:
              ExerciseChartDataFamily._allTransitiveDependencies,
          exerciseId: exerciseId,
          range: range,
        );

  ExerciseChartDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.exerciseId,
    required this.range,
  }) : super.internal();

  final int exerciseId;
  final Duration range;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(ExerciseChartDataRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExerciseChartDataProvider._internal(
        (ref) => create(ref as ExerciseChartDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        exerciseId: exerciseId,
        range: range,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _ExerciseChartDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExerciseChartDataProvider &&
        other.exerciseId == exerciseId &&
        other.range == range;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, exerciseId.hashCode);
    hash = _SystemHash.combine(hash, range.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExerciseChartDataRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `exerciseId` of this provider.
  int get exerciseId;

  /// The parameter `range` of this provider.
  Duration get range;
}

class _ExerciseChartDataProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with ExerciseChartDataRef {
  _ExerciseChartDataProviderElement(super.provider);

  @override
  int get exerciseId => (origin as ExerciseChartDataProvider).exerciseId;
  @override
  Duration get range => (origin as ExerciseChartDataProvider).range;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
