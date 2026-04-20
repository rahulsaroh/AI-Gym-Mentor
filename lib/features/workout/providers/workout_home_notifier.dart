import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart';
import 'package:ai_gym_mentor/core/domain/entities/workout_session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:ai_gym_mentor/features/analytics/measurements_repository.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';

part 'workout_home_notifier.freezed.dart';
part 'workout_home_notifier.g.dart';

@freezed
abstract class MotivationTip with _$MotivationTip {
  const MotivationTip._();

  const factory MotivationTip({
    required String text,
    required String category,
  }) = _MotivationTip;
}

@freezed
abstract class TodayExercise with _$TodayExercise {
  const factory TodayExercise({
    required int id,
    required String name,
    String? imageUrl,
  }) = _TodayExercise;
}

@freezed
abstract class WorkoutHomeState with _$WorkoutHomeState {
  const factory WorkoutHomeState({
    required String greeting,
    required String userName,
    required String dateString,
    required int currentStreak,
    required MotivationTip dailyTip,
    @Default(null) WorkoutSession? lastWorkout,
    @Default(null) WorkoutSession? activeDraft,
    @Default({})
    Map<int, double> weeklyVolume,
    @Default(null) BodyMeasurement? lastWeight,
    String? lastWorkoutSummary,
    @Default(false) bool isRestDay,
    String? todayDayName,
    @Default([]) List<TodayExercise> todayExercises,
    @Default(0) int estimatedDuration,
    int? nextDayId,
    int? templateId,
    int? manualDayId,
  }) = _WorkoutHomeState;

  const WorkoutHomeState._();

  bool get hasActiveWorkout => activeDraft != null;
  bool get hasLastWorkout => lastWorkout != null;
}

@riverpod
class WorkoutHomeNotifier extends _$WorkoutHomeNotifier {
  @override
  Future<WorkoutHomeState> build() async {
    return _fetchHomeData();
  }

  Future<WorkoutHomeState> _fetchHomeData({int? forcedDayId}) async {
    final workoutRepo = ref.read(workoutRepositoryProvider);
    
    // Performance: Cleanup stale draft workouts (older than 24h with no progress)
    await workoutRepo.cleanupStaleDrafts();

    final stats = await workoutRepo.getStats();
    final lastWorkout = await workoutRepo.getLastWorkout();
    final activeDraft = await workoutRepo.getActiveWorkoutDraft();
    bool isRestDay = false;

    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final weeklyVolume = await workoutRepo.getDailyVolumeRange(
      DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
      DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59),
    );

    // Get real summary for last workout
    String? lastWorkoutSummary;
    final lastWorkoutDate = lastWorkout?.date;
    if (lastWorkout != null) {
      final summaryData = await workoutRepo.getWorkoutSummary(lastWorkout.id);
      if (summaryData.isNotEmpty) {
        lastWorkoutSummary = summaryData.entries
            .take(2)
            .map((e) => '${e.key}: ${e.value.weight}kg x ${e.value.reps}')
            .join(' | ');
      }
    }

    final measurementsRepo = ref.read(measurementsRepositoryProvider);
    final measurements = await measurementsRepo.getAllMeasurements();

    final settings = ref.read(settingsProvider);
    final userName = settings.asData?.value.userName ?? 'Gym Kilo User';

    // Greeting logic
    final hour = now.hour;
    String greeting = 'Good morning';
    if (hour >= 12 && hour < 17) {
      greeting = 'Good afternoon';
    } else if (hour >= 17) {
      greeting = 'Good evening';
    }

    // Date string: 'Wednesday, 2 April 2025'
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    final dateString =
        '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}';

    // Motivation Tip
    final tips = _getMotivationTips();
    final tipIndex = (now.year * 365 + now.month * 31 + now.day) % tips.length;

    // Program logic: Determine today's workout day from active template
    String? todayDayName;
    List<TodayExercise> todayExercises = [];
    int estimatedDuration = 0;
    int? nextDayId;
    int? activeTemplateId;

    final activeTemplate = await workoutRepo.getActiveTemplate();
    if (activeTemplate != null) {
      activeTemplateId = activeTemplate.id;
      // Fix #16: getActiveTemplate() already fetches days, reuse them.
      final templateDays = activeTemplate.days;
      if (templateDays.isNotEmpty) {
        final lastTemplateWorkout =
            await workoutRepo.getLastWorkoutOfTemplate(activeTemplate.id);

        int nextDayIndex = 0;
        bool completedToday = false;

        if (lastTemplateWorkout != null) {
          final workoutDate = lastTemplateWorkout.date;
          if (workoutDate.year == now.year &&
              workoutDate.month == now.month &&
              workoutDate.day == now.day) {
            completedToday = true;
          }

          if (lastTemplateWorkout.dayId != null) {
            final lastDayIndex = templateDays
                .indexWhere((d) => d.id == lastTemplateWorkout.dayId);
            if (lastDayIndex != -1) {
              nextDayIndex = (lastDayIndex + 1) % templateDays.length;
            }
          }
        }

        // Weekday Priority Logic:
        // Try to find a day that specifically matches today's weekday
        final todayWeekday = now.weekday; // 1 = Mon, 7 = Sun
        final weekdayMatchIndex = templateDays.indexWhere((d) => d.weekday == todayWeekday);
        
        final nextDay = (forcedDayId != null) 
            ? templateDays.firstWhere((d) => d.id == forcedDayId, orElse: () => templateDays[nextDayIndex])
            : (weekdayMatchIndex != -1 ? templateDays[weekdayMatchIndex] : templateDays[nextDayIndex]);
            
        todayDayName = nextDay.name;
        nextDayId = nextDay.id;

        final templateExercises =
            await workoutRepo.getTemplateExercises(nextDay.id);
        todayExercises = templateExercises.map((te) => TodayExercise(
              id: te.exercise.id,
              name: te.exercise.name,
              imageUrl: te.exercise.imageUrls.isNotEmpty
                  ? te.exercise.imageUrls.first
                  : (te.exercise.gifUrl ?? ''),
            )).toList();
        // Estimate duration based on historical averages
        final avgDurationPerExercise = (stats['avgDuration'] ?? 45) / (stats['avgExercises'] ?? 5);
        estimatedDuration = (templateExercises.length * avgDurationPerExercise).round();

        isRestDay = completedToday && forcedDayId == null;
      }
    }

    // Fallback: If no workout completed today but no template, it's not a rest day yet
    if (activeTemplate == null && lastWorkoutDate != null) {
      if (lastWorkoutDate.year == now.year &&
          lastWorkoutDate.month == now.month &&
          lastWorkoutDate.day == now.day) {
        isRestDay = true;
      }
    }

    return WorkoutHomeState(
      greeting: greeting,
      userName: userName,
      dateString: dateString,
      currentStreak: stats['currentStreak'] as int,
      dailyTip: tips[tipIndex],
      lastWorkout: lastWorkout,
      activeDraft: activeDraft,
      weeklyVolume: weeklyVolume,
      lastWeight: measurements.isNotEmpty ? measurements.first : null,
      lastWorkoutSummary: lastWorkoutSummary,
      isRestDay: isRestDay,
      todayDayName: todayDayName,
      todayExercises: todayExercises,
      estimatedDuration: estimatedDuration,
      nextDayId: nextDayId,
      templateId: activeTemplateId,
      manualDayId: null, // This gets overridden by state in the actual notifier behavior if we use state.value
    );
  }

  // Helper to get manualDayId from current state
  int? get _currentManualDayId => state.asData?.value.manualDayId;

  Future<void> setManualDay(int dayId) async {
    final currentState = state.asData?.value;
    if (currentState == null) return;
    
    state = AsyncValue.data(currentState.copyWith(manualDayId: dayId));
    // Re-fetch to update exercises and name based on this new day
    state = await AsyncValue.guard(() async {
      final fresh = await _fetchHomeData(forcedDayId: dayId);
      return fresh.copyWith(manualDayId: dayId);
    });
  }

  Future<void> resetManualDay() async {
    final currentState = state.asData?.value;
    if (currentState == null) return;
    state = AsyncValue.data(currentState.copyWith(manualDayId: null));
    refresh();
  }

  Future<void> deleteWorkout(int id) async {
    final repo = ref.read(workoutRepositoryProvider);
    await repo.deleteWorkout(id);
    ref.invalidateSelf();
  }

  Future<int> startWorkout({int? templateId, int? dayId, String? name}) async {
    final repo = ref.read(workoutRepositoryProvider);
    debugPrint('WorkoutHomeNotifier.startWorkout: templateId=$templateId, dayId=$dayId, name=$name');

    // 1. Check if we already have a RECENT draft (within 12h) for this specific day/template
    // This prevents "Stacking" drafts if the user starts a session, leaves, and starts same again.
    final existingId = await repo.findExistingRecentDraft(
      templateId: templateId,
      dayId: dayId,
    );

    if (existingId != null) {
      debugPrint('WorkoutHomeNotifier.startWorkout: Reusing existing draft id=$existingId');
      return existingId;
    }

    // 2. Otherwise create a new one
    final id = await repo.createWorkout(
      name: name ?? 'New Workout',
      templateId: templateId,
      dayId: dayId,
    );
    debugPrint('WorkoutHomeNotifier.startWorkout: created workout id=$id');
    ref.invalidateSelf();
    return id;
  }

  Future<void> discardActiveDraft() async {
    final activeDraft = state.asData?.value.activeDraft;
    if (activeDraft == null) return;

    final repo = ref.read(workoutRepositoryProvider);
    await repo.deleteWorkout(activeDraft.id);
    ref.invalidateSelf();
  }

  Future<void> logWeight(double weight) async {
    final repo = ref.read(measurementsRepositoryProvider);
    await repo.addWeight(weight, DateTime.now());
    ref.invalidateSelf();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchHomeData());
  }

  List<MotivationTip> _getMotivationTips() {
    return const [
      MotivationTip(
          text:
              "Progressive overload is the key to muscle growth. Always aim to do more than last time.",
          category: "Progress"),
      MotivationTip(
          text:
              "Don't skip leg day. Squats build more than just legs; they boost overall testosterone.",
          category: "Technique"),
      MotivationTip(
          text:
              "Rest is just as important as the workout. Your muscles grow while you sleep.",
          category: "Recovery"),
      MotivationTip(
          text:
              "Consistency over intensity. Showing up every day is better than one perfect workout.",
          category: "Mindset"),
      MotivationTip(
          text:
              "Drink at least 3 liters of water daily to stay hydrated and keep your muscles full.",
          category: "Nutrition"),
      MotivationTip(
          text:
              "Mind-muscle connection: focus on the muscle you're working, don't just move the weight.",
          category: "Technique"),
      MotivationTip(
          text:
              "Form first, weight later. Ego lifting is the fastest way to get an injury.",
          category: "Safety"),
      MotivationTip(
          text:
              "Track your lifts. If you don't measure it, you can't improve it.",
          category: "Tracking"),
      MotivationTip(
          text: "A 10-minute workout is better than no workout at all.",
          category: "Mindset"),
      MotivationTip(
          text:
              "Eat enough protein. Aim for 1.6g to 2.2g per kg of body weight.",
          category: "Nutrition"),
      MotivationTip(
          text:
              "Compound movements like deadlifts and presses should be the core of your routine.",
          category: "Technique"),
      MotivationTip(
          text:
              "Listen to your body. If something hurts (not just burn), stop and check your form.",
          category: "Safety"),
      MotivationTip(
          text:
              "Deload weeks are necessary to prevent burnout and central nervous system fatigue.",
          category: "Recovery"),
      MotivationTip(
          text: "Your only competition is the person you were yesterday.",
          category: "Mindset"),
      MotivationTip(
          text: "Pre-workout caffeine can increase focus and power output.",
          category: "Supplements"),
      MotivationTip(
          text:
              "Stretching after a workout can improve flexibility and blood flow to muscles.",
          category: "Recovery"),
      MotivationTip(
          text: "A strong core provides stability for all your other lifts.",
          category: "Technique"),
      MotivationTip(
          text:
              "Don't fear carbs; they are the primary fuel for high-intensity training.",
          category: "Nutrition"),
      MotivationTip(
          text:
              "Visualize your set before you start. Mental preparation increases performance.",
          category: "Mindset"),
      MotivationTip(
          text: "Keep your rest periods consistent to properly track progress.",
          category: "Tracking"),
      MotivationTip(
          text: "Full range of motion beats partial reps 90% of the time.",
          category: "Technique"),
      MotivationTip(
          text:
              "Creatine is one of the most researched and effective safe supplements.",
          category: "Supplements"),
      MotivationTip(
          text: "Vary your rep ranges to target different muscle fiber types.",
          category: "Progress"),
      MotivationTip(
          text:
              "Sleep 7-9 hours per night for optimal recovery and hormone balance.",
          category: "Recovery"),
      MotivationTip(
          text: "The last 2 reps are where the growth happens.",
          category: "Mindset"),
      MotivationTip(
          text: "Proper breathing: exhale on exertion, inhale on the release.",
          category: "Technique"),
      MotivationTip(
          text: "Unilateral training helps correct muscle imbalances.",
          category: "Technique"),
      MotivationTip(
          text:
              "Healthy fats are essential for hormone production and joint health.",
          category: "Nutrition"),
      MotivationTip(
          text: "Celebrate the small wins. A 1kg increase is still progress.",
          category: "Mindset"),
      MotivationTip(
          text:
              "Keep your gym bag packed the night before to eliminate excuses.",
          category: "Mindset"),
    ];
  }
}
