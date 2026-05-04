import 'package:drift/drift.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/analytics/domain/year_in_review_models.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';

part 'year_in_review_service.g.dart';

class YearInReviewService {
  final AppDatabase db;
  YearInReviewService(this.db);

  Future<YearInReviewData?> getYearMetadata(int year) async {
    // Check if any workouts exist for the year
    final start = DateTime(year, 1, 1);
    final end = DateTime(year, 12, 31, 23, 59, 59);
    
    final workoutCount = await (db.selectOnly(db.workouts)
      ..addColumns([db.workouts.id.count()])
      ..where(db.workouts.date.isBiggerOrEqualValue(start) & 
              db.workouts.date.isSmallerOrEqualValue(end) &
              db.workouts.status.equals('completed'))).getSingle();
              
    final count = workoutCount.read<int>(db.workouts.id.count()) ?? 0;
    if (count == 0) return null;
    return null; // Just a placeholder check
  }

  Future<YearInReviewData> computeYearInReview(int year, OneRmFormula formula) async {
    final start = DateTime(year, 1, 1);
    final end = DateTime(year, 12, 31, 23, 59, 59);

    // 1. Fetch All Workouts for the year
    final yearWorkouts = await (db.select(db.workouts)
      ..where((t) => t.date.isBiggerOrEqualValue(start) & 
                     t.date.isSmallerOrEqualValue(end) &
                     t.status.equals('completed'))
      ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)])).get();

    final workoutIds = yearWorkouts.map((w) => w.id).toList();

    // 2. Fetch All Sets for these workouts
    final yearSets = await (db.select(db.workoutSets).join([
      innerJoin(db.exercises, db.exercises.id.equalsExp(db.workoutSets.exerciseId)),
    ])..where(db.workoutSets.workoutId.isIn(workoutIds))).get();

    // 3. Fetch 1RM Snapshots for the year
    final yearSnapshots = await (db.select(db.exercise1RmSnapshots)
      ..where((t) => t.date.isBiggerOrEqualValue(start) & 
                     t.date.isSmallerOrEqualValue(end))).get();

    // --- AGGREGATION ---

    // Headline Stats
    final totalWorkouts = yearWorkouts.length;
    final trainingDays = yearWorkouts.map((w) => DateTime(w.date.year, w.date.month, w.date.day)).toSet().length;
    final totalDurationSecs = yearWorkouts.fold(0, (a, b) => a + (b.duration ?? 0));
    
    int totalSets = 0;
    int totalReps = 0;
    double totalVolume = 0;
    final Map<int, int> weekdayCounts = {};
    final Map<int, int> monthCounts = {};

    for (final w in yearWorkouts) {
      weekdayCounts[w.date.weekday] = (weekdayCounts[w.date.weekday] ?? 0) + 1;
      monthCounts[w.date.month] = (monthCounts[w.date.month] ?? 0) + 1;
    }

    final Map<String, double> volumeByMuscle = {};
    final Map<String, Set<int>> sessionsByMuscle = {};
    final Map<int, double> exerciseVolumes = {};
    final Map<int, String> exerciseNames = {};
    final Map<String, int> equipmentCounts = {};

    for (final row in yearSets) {
      final s = row.readTable(db.workoutSets);
      final ex = row.readTable(db.exercises);
      
      if (!s.completed) continue;

      totalSets++;
      totalReps += s.reps.toInt();
      final volume = s.weight * s.reps;
      totalVolume += volume;

      exerciseVolumes[ex.id] = (exerciseVolumes[ex.id] ?? 0) + volume;
      exerciseNames[ex.id] = ex.name;

      final muscle = _standardizeMuscle(ex.primaryMuscle);
      volumeByMuscle[muscle] = (volumeByMuscle[muscle] ?? 0) + volume;
      sessionsByMuscle.putIfAbsent(muscle, () => {}).add(s.workoutId);
      
      equipmentCounts[ex.equipment] = (equipmentCounts[ex.equipment] ?? 0) + 1;
    }

    // Consistency
    final dailyActivity = <DateTime, int>{};
    for (final w in yearWorkouts) {
      final d = DateTime(w.date.year, w.date.month, w.date.day);
      dailyActivity[d] = (dailyActivity[d] ?? 0) + 1;
    }

    int longestStreak = _calculateLongestStreak(yearWorkouts.map((w) => w.date).toList());

    final mostConsistentMonthInt = monthCounts.entries.isEmpty ? 1 : monthCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    final leastConsistentMonthInt = monthCounts.entries.isEmpty ? 1 : monthCounts.entries.reduce((a, b) => a.value < b.value ? a : b).key;

    // Strength
    final topExercises = exerciseVolumes.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    final prsInYear = yearSnapshots.where((s) => s.isPr).toList();
    
    // Heaviest lift
    final heaviestSet = yearSets.isEmpty ? null : yearSets.reduce((a, b) {
      final sa = a.readTable(db.workoutSets);
      final sb = b.readTable(db.workoutSets);
      return sa.weight > sb.weight ? a : b;
    });

    // Best 1RM
    final best1RmSnap = yearSnapshots.isEmpty ? null : yearSnapshots.reduce((a, b) => a.estimated1Rm > b.estimated1Rm ? a : b);

    // Muscle breakdowns
    final muscleList = volumeByMuscle.keys.toList();
    final mostTrainedMuscle = muscleList.isEmpty ? 'None' : volumeByMuscle.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    final leastTrainedMuscle = muscleList.isEmpty ? 'None' : volumeByMuscle.entries.reduce((a, b) => a.value < b.value ? a : b).key;

    // Equipment
    final uniqueExCount = exerciseVolumes.length;
    final mostUsedEx = topExercises.isEmpty ? 'None' : exerciseNames[topExercises.first.key] ?? 'None';
    final mostUsedEquip = equipmentCounts.entries.isEmpty ? 'None' : equipmentCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    // Insights
    final insights = _generateInsights(
      year: year,
      totalWorkouts: totalWorkouts,
      totalVolume: totalVolume,
      prCount: prsInYear.length,
      mostTrainedMuscle: mostTrainedMuscle,
      bestMonth: DateFormat('MMMM').format(DateTime(year, mostConsistentMonthInt)),
    );

    // Previous year comparison
    YearComparison? comparison;
    if (year > 2020) { // arbitrary limit
       comparison = await _getComparisonData(year - 1, totalWorkouts, totalVolume, exerciseVolumes, exerciseNames);
    }

    return YearInReviewData(
      year: year,
      headlineStats: HeadlineStats(
        totalWorkouts: totalWorkouts,
        totalTrainingDays: trainingDays,
        totalTrainingTime: Duration(seconds: totalDurationSecs),
        totalSets: totalSets,
        totalReps: totalReps,
        totalVolume: totalVolume,
        mostConsistentMonth: DateFormat('MMMM').format(DateTime(year, mostConsistentMonthInt)),
        mostTrainedWeekday: weekdayCounts.entries.isEmpty ? 1 : weekdayCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key,
      ),
      strengthHighlights: StrengthHighlights(
        topExercisesByVolume: topExercises.take(5).map((e) => ExerciseVolume(exerciseNames[e.key]!, e.value)).toList(),
        newPrsCount: prsInYear.length,
        biggestGains: await _getBiggestGains(year, yearSnapshots),
        heaviestLift: HeaviestLift(
          heaviestSet != null ? heaviestSet.readTable(db.exercises).name : 'None',
          heaviestSet != null ? heaviestSet.readTable(db.workoutSets).weight : 0,
        ),
        bestSingleSet: BestSet(
          best1RmSnap != null ? exerciseNames[best1RmSnap.exerciseId] ?? 'Unknown' : 'None',
          best1RmSnap?.weight ?? 0,
          best1RmSnap?.reps ?? 0,
          best1RmSnap?.estimated1Rm ?? 0,
        ),
      ),
      muscleBreakdown: MuscleBreakdown(
        volumeByMuscle: volumeByMuscle,
        sessionsByMuscle: sessionsByMuscle.map((k, v) => MapEntry(k, v.length)),
        mostTrainedMuscle: mostTrainedMuscle,
        leastTrainedMuscle: leastTrainedMuscle,
      ),
      consistencyData: ConsistencyData(
        dailyActivity: dailyActivity,
        monthlyWorkoutCounts: {for (int i = 1; i <= 12; i++) i: monthCounts[i] ?? 0},
        longestStreak: longestStreak,
        bestMonth: DateFormat('MMMM').format(DateTime(year, mostConsistentMonthInt)),
        worstMonth: DateFormat('MMMM').format(DateTime(year, leastConsistentMonthInt)),
      ),
      prAchievements: prsInYear.take(20).map((s) => PersonalRecordAchievement(
        exerciseName: exerciseNames[s.exerciseId] ?? 'Unknown',
        date: s.date,
        weight: s.weight,
        reps: s.reps,
        estimated1Rm: s.estimated1Rm,
      )).toList(),
      equipmentVariety: EquipmentVariety(
        uniqueExercisesCount: uniqueExCount,
        mostUsedExercise: mostUsedEx,
        mostUsedEquipment: mostUsedEquip,
        newExercisesTried: await _getNewExercises(year, exerciseNames.keys.toList()),
      ),
      motivationalInsights: insights,
      comparison: comparison,
    );
  }

  int _calculateLongestStreak(List<DateTime> dates) {
    if (dates.isEmpty) return 0;
    final sortedDates = dates.map((d) => DateTime(d.year, d.month, d.day)).toSet().toList()..sort();
    
    int maxStreak = 0;
    int currentStreak = 1;

    for (int i = 1; i < sortedDates.length; i++) {
        if (sortedDates[i].difference(sortedDates[i-1]).inDays == 1) {
            currentStreak++;
        } else {
            if (currentStreak > maxStreak) maxStreak = currentStreak;
            currentStreak = 1;
        }
    }
    return currentStreak > maxStreak ? currentStreak : maxStreak;
  }

  String _standardizeMuscle(String muscle) {
    final m = muscle.toLowerCase();
    if (m.contains('pector') || m.contains('chest')) return 'Chest';
    if (m.contains('back') || m.contains('lat') || m.contains('trape')) return 'Back';
    if (m.contains('deltoid') || m.contains('shoulder')) return 'Shoulders';
    if (m.contains('bicep')) return 'Biceps';
    if (m.contains('tricep')) return 'Triceps';
    if (m.contains('quad')) return 'Quads';
    if (m.contains('hamstr')) return 'Hamstrings';
    if (m.contains('glute')) return 'Glutes';
    if (m.contains('calf') || m.contains('calve')) return 'Calves';
    if (m.contains('abdom') || m.contains('core')) return 'Abs';
    return 'Other';
  }

  Future<List<StrengthGain>> _getBiggestGains(int year, List<Exercise1RmSnapshot> yearSnaps) async {
    final List<StrengthGain> gains = [];
    final Map<int, List<Exercise1RmSnapshot>> grouped = {};
    for (final s in yearSnaps) {
       grouped.putIfAbsent(s.exerciseId, () => []).add(s);
    }

    for (final entry in grouped.entries) {
      final history = entry.value..sort((a,b) => a.date.compareTo(b.date));
      if (history.length < 2) continue;
      
      final first = history.first;
      final last = history.last;
      final diff = ((last.estimated1Rm - first.estimated1Rm) / first.estimated1Rm) * 100;
      
      if (diff > 0) {
        final name = await _getExName(entry.key);
        gains.add(StrengthGain(name, diff));
      }
    }
    gains.sort((a, b) => b.percentageImprovement.compareTo(a.percentageImprovement));
    return gains.take(5).toList();
  }

  Future<List<String>> _getNewExercises(int year, List<int> yearExIds) async {
    final start = DateTime(year, 1, 1);
    final prevHistory = await (db.selectOnly(db.workoutSets)
      ..addColumns([db.workoutSets.exerciseId])
      ..join([innerJoin(db.workouts, db.workouts.id.equalsExp(db.workoutSets.workoutId))])
      ..where(db.workouts.date.isSmallerThanValue(start))
      ..groupBy([db.workoutSets.exerciseId])).get();
    
    final prevExIds = prevHistory.map((r) => r.read(db.workoutSets.exerciseId)).toSet();
    final List<String> newEx = [];
    for (final id in yearExIds) {
      if (!prevExIds.contains(id)) {
        newEx.add(await _getExName(id));
      }
    }
    return newEx;
  }

  Future<YearComparison?> _getComparisonData(int prevYear, int currentWorkouts, double currentVolume, Map<int, double> currentExVolumes, Map<int, String> currentExNames) async {
    final start = DateTime(prevYear, 1, 1);
    final end = DateTime(prevYear, 12, 31, 23, 59, 59);

    final stats = await (db.selectOnly(db.workouts)
      ..addColumns([db.workouts.id.count()])
      ..where(db.workouts.date.isBiggerOrEqualValue(start) & 
              db.workouts.date.isSmallerOrEqualValue(end) &
              db.workouts.status.equals('completed'))).getSingleOrNull();
    
    if (stats == null) return null;
    final prevCount = stats.read<int>(db.workouts.id.count()) ?? 0;
    if (prevCount == 0) return null;

    // Prev Volume (Estimate to save time)
    final volRows = await (db.selectOnly(db.workoutSets)
      ..addColumns([db.workoutSets.weight, db.workoutSets.reps])
      ..join([innerJoin(db.workouts, db.workouts.id.equalsExp(db.workoutSets.workoutId))])
      ..where(db.workouts.date.isBiggerOrEqualValue(start) & 
              db.workouts.date.isSmallerOrEqualValue(end) &
              db.workouts.status.equals('completed'))).get();
    
    double prevVolume = 0;
    for (final r in volRows) {
      prevVolume += (r.read(db.workoutSets.weight) ?? 0) * (r.read(db.workoutSets.reps) ?? 0);
    }

    return YearComparison(
      workoutDiff: currentWorkouts - prevCount,
      volumeDiffPercent: prevVolume > 0 ? ((currentVolume - prevVolume) / prevVolume) * 100 : 0,
      topLiftsDiff: [], // Placeholder
    );
  }

  List<String> _generateInsights({
    required int year,
    required int totalWorkouts,
    required double totalVolume,
    required int prCount,
    required String mostTrainedMuscle,
    required String bestMonth,
  }) {
    final List<String> insights = [];
    
    if (totalWorkouts > 150) {
      insights.add("You were in the top tier of consistency training $totalWorkouts days this year!");
    } else if (totalWorkouts > 50) {
      insights.add("Great work logging $totalWorkouts workouts in $year.");
    }

    if (prCount > 20) {
      insights.add("You crushed $prCount personal records — an absolute strength beast!");
    }

    insights.add("Your $mostTrainedMuscle group received the most love this year.");
    insights.add("$bestMonth was your most powerful month. Remember that energy!");

    return insights;
  }

  Future<String> _getExName(int? id) async {
     if (id == null) return 'Unknown';
     final ex = await (db.select(db.exercises)..where((t) => t.id.equals(id))).getSingleOrNull();
     return ex?.name ?? 'Unknown';
  }
}

@riverpod
YearInReviewService yearInReviewService(Ref ref) {
  return YearInReviewService(ref.watch(appDatabaseProvider));
}
