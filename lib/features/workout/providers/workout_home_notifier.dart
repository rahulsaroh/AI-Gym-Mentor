import 'package:drift/drift.dart' hide JsonKey;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/core/domain/entities/body_measurement.dart' as ent;
import 'package:gym_gemini_pro/core/domain/entities/workout_program.dart' as ent;
import 'package:gym_gemini_pro/core/domain/entities/workout_session.dart' as ent;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gym_gemini_pro/features/workout/workout_repository.dart';
import 'package:gym_gemini_pro/features/analytics/measurements_repository.dart';
import 'package:gym_gemini_pro/features/settings/settings_provider.dart';

part 'workout_home_notifier.freezed.dart';
part 'workout_home_notifier.g.dart';

@freezed
class MotivationTip with _$MotivationTip {
  const factory MotivationTip({
    required String text,
    required String category,
  }) = _MotivationTip;
}

@freezed
class WorkoutHomeState with _$WorkoutHomeState {
  const factory WorkoutHomeState({
    required String greeting,
    required String userName,
    required String dateString,
    required int currentStreak,
    required MotivationTip dailyTip,
    ent.WorkoutSession? lastWorkout,
    ent.WorkoutSession? activeDraft,
    @Default({})
    Map<int, double> weeklyVolume, // millisecondsSinceEpoch -> volume
    ent.BodyMeasurement? lastWeight,
    String? lastWorkoutSummary,
    @Default(false) bool isRestDay,
    String? todayDayName,
    @Default([]) List<String> todayExercises,
    @Default(0) int estimatedDuration,
    int? nextDayId,
    int? templateId,
  }) = _WorkoutHomeState;
}

@riverpod
class WorkoutHomeNotifier extends _$WorkoutHomeNotifier {
  @override
  Future<WorkoutHomeState> build() async {
    return _fetchHomeData();
  }

  Future<WorkoutHomeState> _fetchHomeData() async {
    final workoutRepo = ref.read(workoutRepositoryProvider);
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
    final lastWeight = measurements.isNotEmpty ? measurements.first : null;

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
    List<String> todayExercises = [];
    int estimatedDuration = 0;
    int? nextDayId;
    int? activeTemplateId;

    final activeTemplate = await workoutRepo.getActiveTemplate();
    if (activeTemplate != null) {
      activeTemplateId = activeTemplate.id;
      final templateDays = await workoutRepo.getTemplateDays(activeTemplate.id);
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

        final nextDay = templateDays[nextDayIndex];
        todayDayName = nextDay.name;
        nextDayId = nextDay.id;

        final templateExercises =
            await workoutRepo.getTemplateExercises(nextDay.id);
        todayExercises =
            templateExercises.map((te) => te.exercise.name).toList();
        estimatedDuration =
            templateExercises.length * 12; // Estimate: 12 mins per exercise

        isRestDay = completedToday;
      }
    }

    // Fallback: If no workout completed today but no template, it's not a rest day yet
    if (activeTemplate == null && lastWorkout != null) {
      final workoutDate = lastWorkout.date;
      if (workoutDate.year == now.year &&
          workoutDate.month == now.month &&
          workoutDate.day == now.day) {
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
      lastWeight: lastWeight,
      lastWorkoutSummary: lastWorkoutSummary,
      isRestDay: isRestDay,
      todayDayName: todayDayName,
      todayExercises: todayExercises,
      estimatedDuration: estimatedDuration,
      nextDayId: nextDayId,
      templateId: activeTemplateId,
    );
  }

  Future<void> deleteWorkout(int id) async {
    final repo = ref.read(workoutRepositoryProvider);
    await repo.deleteWorkout(id);
    ref.invalidateSelf();
  }

  Future<int> startWorkout({int? templateId, int? dayId, String? name}) async {
    final repo = ref.read(workoutRepositoryProvider);
    final id = await repo.createWorkout(
      name: name ?? 'New Workout',
      templateId: templateId,
      dayId: dayId,
    );
    ref.invalidateSelf();
    return id;
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
