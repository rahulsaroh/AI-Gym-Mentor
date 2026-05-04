import 'package:ai_gym_mentor/core/database/database.dart';

class WorkoutLogicService {
  /// Calculates 1RM using the Epley formula: weight * (1 + reps/30)
  static double calculateOneRM(double weight, double reps) {
    if (weight <= 0 || reps <= 0) return 0;
    return weight * (1 + (reps / 30));
  }

  /// Calculates total volume for a list of sets.
  /// Standardizes exclusion of certain set types if needed.
  static double calculateVolume(List<WorkoutSet> sets, {bool excludeTimed = true}) {
    double total = 0;
    for (final s in sets) {
      if (s.completed && s.weight > 0 && s.reps > 0) {
        // Here we could add logic to check if the exercise is 'Timed' 
        // but that requires joining with the exercises table.
        // For now, this helper takes sets that are already filtered or assumed to be valid.
        total += s.weight * s.reps;
      }
    }
    return total;
  }

  /// Calculates current and longest streaks from a list of workout dates.
  static Map<String, int> calculateStreaks(List<DateTime> workoutDates) {
    if (workoutDates.isEmpty) {
      return {'currentStreak': 0, 'longestStreak': 0};
    }

    final sortedDates = workoutDates
        .map((d) => DateTime(d.year, d.month, d.day))
        .toSet()
        .toList()
      ..sort();

    int longestStreak = 0;
    int tempStreak = 1;
    
    for (int i = 1; i < sortedDates.length; i++) {
      if (sortedDates[i].difference(sortedDates[i - 1]).inDays == 1) {
        tempStreak++;
      } else {
        if (tempStreak > longestStreak) longestStreak = tempStreak;
        tempStreak = 1;
      }
    }
    if (tempStreak > longestStreak) longestStreak = tempStreak;

    // Current streak check
    int currentStreak = 0;
    final today = DateTime.now();
    final todayTruncated = DateTime(today.year, today.month, today.day);
    final lastWorkoutDay = sortedDates.last;
    final diff = todayTruncated.difference(lastWorkoutDay).inDays;

    if (diff <= 1) {
      currentStreak = 1;
      for (int i = sortedDates.length - 1; i > 0; i--) {
        if (sortedDates[i].difference(sortedDates[i - 1]).inDays == 1) {
          currentStreak++;
        } else {
          break;
        }
      }
    }

    return {
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
    };
  }
}
