import 'package:freezed_annotation/freezed_annotation.dart';
import 'exercise.dart';

part 'workout_program.freezed.dart';
part 'workout_program.g.dart';

@freezed
class WorkoutProgram with _$WorkoutProgram {
  const factory WorkoutProgram({
    required int id,
    required String name,
    String? description,
    DateTime? lastUsed,
    @Default([]) List<ProgramDay> days,
  }) = _WorkoutProgram;

  factory WorkoutProgram.fromJson(Map<String, dynamic> json) => _$WorkoutProgramFromJson(json);
}

@freezed
class ProgramDay with _$ProgramDay {
  const factory ProgramDay({
    required int id,
    required int templateId,
    required String name,
    required int order,
    @Default([]) List<ProgramExercise> exercises,
  }) = _ProgramDay;

  factory ProgramDay.fromJson(Map<String, dynamic> json) => _$ProgramDayFromJson(json);
}

@freezed
class ProgramExercise with _$ProgramExercise {
  const factory ProgramExercise({
    required int id,
    required int dayId,
    required Exercise exercise,
    required int order,
    @Default('Straight') String setType,
    @Default('[]') String setsJson, // Simplified for now, or use typed sets
    @Default(90) int restTime,
    String? notes,
    String? supersetGroupId,
  }) = _ProgramExercise;

  factory ProgramExercise.fromJson(Map<String, dynamic> json) => _$ProgramExerciseFromJson(json);
}
