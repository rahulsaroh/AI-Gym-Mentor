// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeWorkout)
final activeWorkoutProvider = ActiveWorkoutProvider._();

final class ActiveWorkoutProvider extends $FunctionalProvider<
        AsyncValue<WorkoutSession?>, WorkoutSession?, FutureOr<WorkoutSession?>>
    with $FutureModifier<WorkoutSession?>, $FutureProvider<WorkoutSession?> {
  ActiveWorkoutProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'activeWorkoutProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activeWorkoutHash();

  @$internal
  @override
  $FutureProviderElement<WorkoutSession?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<WorkoutSession?> create(Ref ref) {
    return activeWorkout(ref);
  }
}

String _$activeWorkoutHash() => r'54bfd337b7b877eed606682712eb12666703e9ad';

@ProviderFor(workoutTemplates)
final workoutTemplatesProvider = WorkoutTemplatesProvider._();

final class WorkoutTemplatesProvider extends $FunctionalProvider<
        AsyncValue<List<WorkoutProgram>>,
        List<WorkoutProgram>,
        FutureOr<List<WorkoutProgram>>>
    with
        $FutureModifier<List<WorkoutProgram>>,
        $FutureProvider<List<WorkoutProgram>> {
  WorkoutTemplatesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'workoutTemplatesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$workoutTemplatesHash();

  @$internal
  @override
  $FutureProviderElement<List<WorkoutProgram>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<WorkoutProgram>> create(Ref ref) {
    return workoutTemplates(ref);
  }
}

String _$workoutTemplatesHash() => r'9d0f0d5d0cfe48521a923d0a672c396681bed72a';

@ProviderFor(templateDays)
final templateDaysProvider = TemplateDaysFamily._();

final class TemplateDaysProvider extends $FunctionalProvider<
        AsyncValue<List<ProgramDay>>,
        List<ProgramDay>,
        FutureOr<List<ProgramDay>>>
    with $FutureModifier<List<ProgramDay>>, $FutureProvider<List<ProgramDay>> {
  TemplateDaysProvider._(
      {required TemplateDaysFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'templateDaysProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$templateDaysHash();

  @override
  String toString() {
    return r'templateDaysProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ProgramDay>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProgramDay>> create(Ref ref) {
    final argument = this.argument as int;
    return templateDays(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TemplateDaysProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$templateDaysHash() => r'05495a10cfa8159fe1f876db84d3ff93fb4c5f0d';

final class TemplateDaysFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ProgramDay>>, int> {
  TemplateDaysFamily._()
      : super(
          retry: null,
          name: r'templateDaysProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  TemplateDaysProvider call(
    int templateId,
  ) =>
      TemplateDaysProvider._(argument: templateId, from: this);

  @override
  String toString() => r'templateDaysProvider';
}
