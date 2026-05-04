import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';

class OneRmService {
  /// Calculates estimated 1RM using the specified formula.
  static double calculate({
    required double weight,
    required double reps,
    required OneRmFormula formula,
  }) {
    if (weight <= 0 || reps <= 0) return 0;
    if (reps == 1) return weight;

    switch (formula) {
      case OneRmFormula.epley:
        // 1RM = weight * (1 + reps/30)
        return weight * (1 + (reps / 30));
      case OneRmFormula.brzycki:
        // 1RM = weight * (36 / (37 - reps))
        if (reps >= 37) return weight * reps; // Safeguard for extreme rep ranges
        return weight * (36 / (37 - reps));
    }
  }

  /// Determines if a set is eligible for 1RM calculation.
  /// Suggested rules:
  /// - Exclude bodyweight (unless weighted)
  /// - Exclude reps > 10 (as accuracy drops)
  /// - Exclude cardio/timed sets
  static bool isEligible({
    required double weight,
    required double reps,
    required String exerciseSetType,
    required String exerciseCategory,
  }) {
    // Basic numeric checks
    if (weight <= 0 || reps <= 0) return false;
    
    // rep threshold check (e.g. > 12 reps are less reliable)
    if (reps > 12) return false;

    // Category checks
    final category = exerciseCategory.toLowerCase();
    if (category.contains('cardio') || 
        category.contains('stretch') || 
        category.contains('timed') ||
        category.contains('yoga')) {
      return false;
    }

    // Bodyweight check
    final type = exerciseSetType.toLowerCase();
    if (type.contains('bodyweight') && weight <= 0) {
      return false;
    }

    return true;
  }
}
