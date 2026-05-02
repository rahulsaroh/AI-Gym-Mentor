import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';

part 'workout_program.freezed.dart';
part 'workout_program.g.dart';

@freezed
abstract class WorkoutProgram with _$WorkoutProgram {
  const WorkoutProgram._();

  const factory WorkoutProgram({
    required int id,
    required String name,
    String? description,
    DateTime? lastUsed,
    @Default(false) bool isSelected,
    @Default([]) List<ProgramDay> days,
  }) = _WorkoutProgram;

  factory WorkoutProgram.fromJson(Map<String, dynamic> json) => _$WorkoutProgramFromJson(json);
}

@freezed
abstract class ProgramDay with _$ProgramDay {
  const ProgramDay._();

  const factory ProgramDay({
    required int id,
    required int templateId,
    required String name,
    required int order,
    int? weekday,
    @Default([]) List<ProgramExercise> exercises,
  }) = _ProgramDay;

  factory ProgramDay.fromJson(Map<String, dynamic> json) => _$ProgramDayFromJson(json);
}

@freezed
abstract class ProgramExercise with _$ProgramExercise {
  const ProgramExercise._();

  const factory ProgramExercise({
    required int id,
    required int dayId,
    required ExerciseEntity exercise,
    required int order,
    @Default('Straight') String setType,
    @Default('[]') String setsJson, // Simplified for now, or use typed sets
    @Default(90) int restTime,
    String? notes,
    String? supersetGroupId,
  }) = _ProgramExercise;

  factory ProgramExercise.fromJson(Map<String, dynamic> json) => _$ProgramExerciseFromJson(json);
}
