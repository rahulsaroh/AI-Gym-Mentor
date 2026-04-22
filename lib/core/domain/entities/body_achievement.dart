import 'package:ai_gym_mentor/core/domain/entities/body_target.dart';

class MetricAchievement {
  final int id;
  final String metric;
  final String label;
  final double targetValue;
  final double startValue;
  final double currentValue;
  final double percentage;
  final DateTime? deadline;

  MetricAchievement({
    required this.id,
    required this.metric,
    required this.label,
    required this.targetValue,
    required this.startValue,
    required this.currentValue,
    required this.percentage,
    this.deadline,
  });
}

class PhysiqueAchievement {
  final double overallScore;
  final List<MetricAchievement> achievements;

  PhysiqueAchievement({
    required this.overallScore,
    required this.achievements,
  });
}
