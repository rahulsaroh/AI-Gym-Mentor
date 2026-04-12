import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';

final aiContextBuilderProvider = Provider<AiContextBuilder>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final settingsState = ref.watch(settingsProvider);
  // Default to a safe fallback if settings aren't loaded yet
  final settings = settingsState.asData?.value ?? const SettingsState();
  return AiContextBuilder(db, settings);
});

class AiContextBuilder {
  final AppDatabase _db;
  final SettingsState _settings;

  AiContextBuilder(this._db, this._settings);

  Future<String> buildGeneralContext() async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    // Get last 7 days workouts
    final workoutsQuery = _db.select(_db.workouts)
      ..where((w) => w.date.isBiggerOrEqualValue(sevenDaysAgo))
      ..orderBy([(w) => OrderingTerm(expression: w.date, mode: OrderingMode.desc)]);
    final workouts = await workoutsQuery.get();

    // Calculate consecutive days
    int consecutiveDays = 0;
    DateTime checkDate = DateTime(now.year, now.month, now.day);
    while (true) {
      final startOfDay = checkDate;
      final endOfDay = checkDate.add(const Duration(days: 1));
      
      final hasWorkoutOnDate = await (_db.select(_db.workouts)
            ..where((w) => w.date.isBiggerOrEqualValue(startOfDay) & w.date.isSmallerThanValue(endOfDay)))
          .getSingleOrNull() != null;
      
      if (hasWorkoutOnDate) {
        consecutiveDays++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    // Attempt to calculate weekly volume (rough estimate of total sets * reps * weight)
    double weeklyVolume = 0.0;
    int prsLogged = 0;
    
    for (var w in workouts) {
      final sets = await (_db.select(_db.workoutSets)
            ..where((s) => s.workoutId.equals(w.id)))
          .get();
      
      for (var s in sets) {
        if (s.completed) {
          weeklyVolume += (s.reps * s.weight);
          if (s.isPr) prsLogged++;
        }
      }
    }

    final buffer = StringBuffer();
    buffer.writeln('### User Profile');
    buffer.writeln('- Name: ${_settings.userName}');
    buffer.writeln('- Age: ${_settings.age}');
    buffer.writeln('- Goals: ${_settings.goals}');
    buffer.writeln('- Experience Level: ${_settings.experienceLevel.name}');
    buffer.writeln('- Preferred Unit: ${_settings.weightUnit.name}');
    buffer.writeln('');
    
    buffer.writeln('### Recent Activity (Last 7 Days)');
    buffer.writeln('- Workouts Completed: ${workouts.length}');
    buffer.writeln('- Consecutive Training Days: $consecutiveDays');
    buffer.writeln('- Estimated Weekly Volume: ${weeklyVolume.toStringAsFixed(1)} ${_settings.weightUnit.name}');
    buffer.writeln('- PRs Logged this week: $prsLogged');
    
    if (workouts.isNotEmpty) {
      buffer.writeln('\n### Workout History Details');
      for (var w in workouts) {
        buffer.writeln('- ${w.date.toIso8601String().split('T')[0]}: ${w.name}');
      }
    }

    return buffer.toString();
  }

  String buildExerciseContext(String exerciseName, String muscleGroup) {
    return 'User is asking about the exercise "$exerciseName" which targets the "$muscleGroup" muscle group.\nProvide concise, actionable form tips and common mistakes to avoid.';
  }
}
