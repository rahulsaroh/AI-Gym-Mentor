import 'package:ai_gym_mentor/core/database/database.dart' as db;

class ExerciseBlock {
  final int exerciseOrder;
  final int exerciseId;
  final String? supersetGroupId;
  final List<db.WorkoutSet> sets;

  ExerciseBlock({
    required this.exerciseOrder,
    required this.exerciseId,
    required this.sets,
    this.supersetGroupId,
  });
}
