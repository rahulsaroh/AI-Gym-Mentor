
class YearInReviewData {
  final int year;
  final HeadlineStats headlineStats;
  final StrengthHighlights strengthHighlights;
  final MuscleBreakdown muscleBreakdown;
  final ConsistencyData consistencyData;
  final List<PersonalRecordAchievement> prAchievements;
  final EquipmentVariety equipmentVariety;
  final List<String> motivationalInsights;
  final YearComparison? comparison;

  YearInReviewData({
    required this.year,
    required this.headlineStats,
    required this.strengthHighlights,
    required this.muscleBreakdown,
    required this.consistencyData,
    required this.prAchievements,
    required this.equipmentVariety,
    required this.motivationalInsights,
    this.comparison,
  });
}

class HeadlineStats {
  final int totalWorkouts;
  final int totalTrainingDays;
  final Duration totalTrainingTime;
  final int totalSets;
  final int totalReps;
  final double totalVolume;
  final String mostConsistentMonth;
  final int mostTrainedWeekday; // 1-7

  HeadlineStats({
    required this.totalWorkouts,
    required this.totalTrainingDays,
    required this.totalTrainingTime,
    required this.totalSets,
    required this.totalReps,
    required this.totalVolume,
    required this.mostConsistentMonth,
    required this.mostTrainedWeekday,
  });
}

class StrengthHighlights {
  final List<ExerciseVolume> topExercisesByVolume;
  final int newPrsCount;
  final List<StrengthGain> biggestGains;
  final HeaviestLift heaviestLift;
  final BestSet bestSingleSet;

  StrengthHighlights({
    required this.topExercisesByVolume,
    required this.newPrsCount,
    required this.biggestGains,
    required this.heaviestLift,
    required this.bestSingleSet,
  });
}

class ExerciseVolume {
  final String exerciseName;
  final double volume;

  ExerciseVolume(this.exerciseName, this.volume);
}

class StrengthGain {
  final String exerciseName;
  final double percentageImprovement;

  StrengthGain(this.exerciseName, this.percentageImprovement);
}

class HeaviestLift {
  final String exerciseName;
  final double weight;

  HeaviestLift(this.exerciseName, this.weight);
}

class BestSet {
  final String exerciseName;
  final double weight;
  final double reps;
  final double estimated1Rm;

  BestSet(this.exerciseName, this.weight, this.reps, this.estimated1Rm);
}

class MuscleBreakdown {
  final Map<String, double> volumeByMuscle;
  final Map<String, int> sessionsByMuscle;
  final String mostTrainedMuscle;
  final String leastTrainedMuscle;

  MuscleBreakdown({
    required this.volumeByMuscle,
    required this.sessionsByMuscle,
    required this.mostTrainedMuscle,
    required this.leastTrainedMuscle,
  });
}

class ConsistencyData {
  final Map<DateTime, int> dailyActivity; // Heatmap data
  final Map<int, int> monthlyWorkoutCounts; // Month (1-12) -> count
  final int longestStreak;
  final String bestMonth;
  final String worstMonth;

  ConsistencyData({
    required this.dailyActivity,
    required this.monthlyWorkoutCounts,
    required this.longestStreak,
    required this.bestMonth,
    required this.worstMonth,
  });
}

class PersonalRecordAchievement {
  final String exerciseName;
  final DateTime date;
  final double weight;
  final double reps;
  final double estimated1Rm;

  PersonalRecordAchievement({
    required this.exerciseName,
    required this.date,
    required this.weight,
    required this.reps,
    required this.estimated1Rm,
  });
}

class EquipmentVariety {
  final int uniqueExercisesCount;
  final String mostUsedExercise;
  final String mostUsedEquipment;
  final List<String> newExercisesTried;

  EquipmentVariety({
    required this.uniqueExercisesCount,
    required this.mostUsedExercise,
    required this.mostUsedEquipment,
    required this.newExercisesTried,
  });
}

class YearComparison {
  final int workoutDiff;
  final double volumeDiffPercent;
  final List<StrengthDiff> topLiftsDiff;

  YearComparison({
    required this.workoutDiff,
    required this.volumeDiffPercent,
    required this.topLiftsDiff,
  });
}

class StrengthDiff {
  final String exerciseName;
  final double changePercent;

  StrengthDiff(this.exerciseName, this.changePercent);
}
