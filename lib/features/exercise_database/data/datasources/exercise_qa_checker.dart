import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_qa_checker.g.dart';

@riverpod
class ExerciseQaChecker extends _$ExerciseQaChecker {
  @override
  void build() {}

  List<String> validateExercise(ExerciseEntity exercise) {
    final issues = <String>[];

    if (exercise.instructions.isEmpty) {
      issues.add('Missing instructions.');
    }
    if (exercise.imageUrls.isEmpty && exercise.gifUrl == null) {
      issues.add('Missing visual media (Image/GIF).');
    }
    if (!exercise.isEnriched) {
      issues.add('Not AI enriched (Missing safety tips/mistakes).');
    }
    if (exercise.primaryMuscles.isEmpty) {
      issues.add('No primary muscles assigned.');
    }
    if (exercise.equipment == null || exercise.equipment!.isEmpty) {
      issues.add('Equipment type not specified.');
    }

    return issues;
  }

  bool isReadyForProduction(ExerciseEntity exercise) {
    return validateExercise(exercise).isEmpty;
  }
}
