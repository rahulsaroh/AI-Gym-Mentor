// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeWorkoutHash() => r'17fa1e36cb1fa4746040d38ab36cfef7807bd491';

/// See also [activeWorkout].
@ProviderFor(activeWorkout)
final activeWorkoutProvider = AutoDisposeFutureProvider<Workout?>.internal(
  activeWorkout,
  name: r'activeWorkoutProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeWorkoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveWorkoutRef = AutoDisposeFutureProviderRef<Workout?>;
String _$workoutTemplatesHash() => r'd62598744ca7c737193ed697ba983dcb6bf359cb';

/// See also [workoutTemplates].
@ProviderFor(workoutTemplates)
final workoutTemplatesProvider =
    AutoDisposeFutureProvider<List<WorkoutTemplate>>.internal(
  workoutTemplates,
  name: r'workoutTemplatesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$workoutTemplatesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorkoutTemplatesRef
    = AutoDisposeFutureProviderRef<List<WorkoutTemplate>>;
String _$templateDaysHash() => r'63e24068ca9260cfd5ec6d8d60ba6cf4253bb396';

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

/// See also [templateDays].
@ProviderFor(templateDays)
const templateDaysProvider = TemplateDaysFamily();

/// See also [templateDays].
class TemplateDaysFamily extends Family<AsyncValue<List<TemplateDay>>> {
  /// See also [templateDays].
  const TemplateDaysFamily();

  /// See also [templateDays].
  TemplateDaysProvider call(
    int templateId,
  ) {
    return TemplateDaysProvider(
      templateId,
    );
  }

  @override
  TemplateDaysProvider getProviderOverride(
    covariant TemplateDaysProvider provider,
  ) {
    return call(
      provider.templateId,
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
  String? get name => r'templateDaysProvider';
}

/// See also [templateDays].
class TemplateDaysProvider
    extends AutoDisposeFutureProvider<List<TemplateDay>> {
  /// See also [templateDays].
  TemplateDaysProvider(
    int templateId,
  ) : this._internal(
          (ref) => templateDays(
            ref as TemplateDaysRef,
            templateId,
          ),
          from: templateDaysProvider,
          name: r'templateDaysProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$templateDaysHash,
          dependencies: TemplateDaysFamily._dependencies,
          allTransitiveDependencies:
              TemplateDaysFamily._allTransitiveDependencies,
          templateId: templateId,
        );

  TemplateDaysProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.templateId,
  }) : super.internal();

  final int templateId;

  @override
  Override overrideWith(
    FutureOr<List<TemplateDay>> Function(TemplateDaysRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TemplateDaysProvider._internal(
        (ref) => create(ref as TemplateDaysRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        templateId: templateId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TemplateDay>> createElement() {
    return _TemplateDaysProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TemplateDaysProvider && other.templateId == templateId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, templateId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TemplateDaysRef on AutoDisposeFutureProviderRef<List<TemplateDay>> {
  /// The parameter `templateId` of this provider.
  int get templateId;
}

class _TemplateDaysProviderElement
    extends AutoDisposeFutureProviderElement<List<TemplateDay>>
    with TemplateDaysRef {
  _TemplateDaysProviderElement(super.provider);

  @override
  int get templateId => (origin as TemplateDaysProvider).templateId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
