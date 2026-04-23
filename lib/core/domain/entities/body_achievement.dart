import 'package:ai_gym_mentor/core/domain/entities/body_target.dart';

class MetricAchievement {
  final int id;
  final String metric;
  final String label;
  final double targetValue;
  final double startValue;
  final double currentValue;
  /// Journey completion: (current-start)/(target-start). Used for the progress bar.
  /// Can be negative (regression) or >1 (overachieved).
  final double percentage;
  /// Absolute achievement: how close current is to target RIGHT NOW.
  /// = current/target for gain goals, target/current for loss goals.
  /// Always in [0.0, 1.0]. Used for the badge and overall score.
  final double achievementRatio;
  final DateTime? deadline;
  final DateTime? startDate;

  MetricAchievement({
    required this.id,
    required this.metric,
    required this.label,
    required this.targetValue,
    required this.startValue,
    required this.currentValue,
    required this.percentage,
    required this.achievementRatio,
    this.deadline,
    this.startDate,
  });
}

class PhysiqueAchievement {
  final double overallScore;      // clamped [0,1] for gauge fill
  final double rawOverallScore;   // actual avg, can be negative (regression)
  final List<MetricAchievement> achievements;

  PhysiqueAchievement({
    required this.overallScore,
    required this.achievements,
    this.rawOverallScore = 0,
  });
}
