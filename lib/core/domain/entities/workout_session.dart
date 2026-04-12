import 'package:freezed_annotation/freezed_annotation.dart';
import 'logged_set.dart';
import 'exercise.dart';

part 'workout_session.freezed.dart';
part 'workout_session.g.dart';

@freezed
abstract class WorkoutSession with _$WorkoutSession {
  const WorkoutSession._();

  const factory WorkoutSession({
    required int id,
    required String name,
    required DateTime date,
    DateTime? startTime,
    DateTime? endTime,
    int? duration,
    int? templateId,
    int? dayId,
    String? notes,
    @Default('draft') String status,
    @Default([]) List<LoggedExercise> exercises,
  }) = _WorkoutSession;

  factory WorkoutSession.fromJson(Map<String, dynamic> json) => _$WorkoutSessionFromJson(json);
}

@freezed
abstract class LoggedExercise with _$LoggedExercise {
  const LoggedExercise._();

  const factory LoggedExercise({
    required int exerciseId,
    required String exerciseName,
    required int order,
    @Default([]) List<LoggedSet> sets,
  }) = _LoggedExercise;

  factory LoggedExercise.fromJson(Map<String, dynamic> json) => _$LoggedExerciseFromJson(json);
}
