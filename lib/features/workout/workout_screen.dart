import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/domain/entities/workout_session.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:drift/drift.dart' show OrderingTerm, OrderingMode;
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';
import 'package:ai_gym_mentor/features/workout/components/begin_session_sheet.dart';
import 'package:ai_gym_mentor/services/plateau_service.dart';
import 'package:ai_gym_mentor/services/sync_worker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/core/widgets/skeleton_card.dart';

class WorkoutHomeScreen extends ConsumerWidget {
  const WorkoutHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(workoutHomeNotifierProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(workoutHomeNotifierProvider.notifier).refresh(),
        child: homeState.when(
          data: (state) => Stack(
            children: [
              CustomScrollView(
                slivers: [
                  _HeaderSection(state: state),
                  _PlateauAlertSection(),
                  _TodayPlanSection(state: state),
                  _QuickActionSection(),
                  _LastWorkoutSection(state: state),
                  _WeeklyVolumeSection(state: state),
                  _BodyweightSection(state: state),
                  _MotivationSection(state: state),
                  const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
                ],
              ),
              Consumer(
                builder: (context, ref, _) {
                  final activeDraft = ref.watch(workoutHomeNotifierProvider
                      .select((s) => s.asData?.value.activeDraft));
                  if (activeDraft != null) {
                    return _FloatingWorkoutBanner(workout: activeDraft);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          loading: () => const SkeletonDashboard(),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final WorkoutHomeState state;
  const _HeaderSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RepaintBoundary(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${state.greeting},',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        Text(
                          '${state.userName}!',
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const _SyncIndicator(),
                      const SizedBox(width: 8),
                      _StreakBadge(streak: state.currentStreak),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                state.dateString.toUpperCase(),
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SyncIndicator extends ConsumerWidget {
  const _SyncIndicator();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncStatus = ref.watch(syncWorkerProvider);

    switch (syncStatus) {
      case SyncStatus.syncing:
        return _buildChip(
          context,
          icon: const SizedBox(
            width: 12,
            height: 12,
            child:
                CircularProgressIndicator(strokeWidth: 2, color: Colors.blue),
          ),
          label: 'Syncing...',
          color: Colors.blue,
        );
      case SyncStatus.failed:
        return GestureDetector(
          onTap: () => ref.read(syncWorkerProvider.notifier).processQueue(),
          child: _buildChip(
            context,
            icon: const Icon(LucideIcons.cloudAlert,
                size: 14, color: Colors.orange),
            label: 'Retry Sync',
            color: Colors.orange,
          ),
        );
      case SyncStatus.authenticationRequired:
        return GestureDetector(
          onTap: () => context.push('/settings/sheets-setup'),
          child: _buildChip(
            context,
            icon: const Icon(LucideIcons.cloudAlert,
                size: 14, color: Colors.orange),
            label: 'Fix Connection',
            color: Colors.orange,
          ),
        );
      case SyncStatus.success:
        return _buildChip(
          context,
          icon: const Icon(LucideIcons.check, size: 14, color: Colors.green),
          label: 'Synced',
          color: Colors.green,
        );
      case SyncStatus.idle:
        return const SizedBox.shrink();
    }
  }

  Widget _buildChip(BuildContext context,
      {required Widget icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  final int streak;
  const _StreakBadge({required this.streak});

  @override
  Widget build(BuildContext context) {
    final hasStreak = streak > 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: hasStreak
              ? [Colors.orange.shade700, Colors.orange.shade500]
              : [Colors.blue.shade700, Colors.blue.shade500],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (hasStreak ? Colors.orange : Colors.blue).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasStreak)
            const _AnimatedFlame()
          else
            const Icon(LucideIcons.zap, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            hasStreak ? '$streak Days' : 'Start',
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedFlame extends StatefulWidget {
  const _AnimatedFlame();

  @override
  State<_AnimatedFlame> createState() => _AnimatedFlameState();
}

class _AnimatedFlameState extends State<_AnimatedFlame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.9 + (_controller.value * 0.2),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Colors.yellow.shade400,
                Colors.orange.shade600,
                Colors.red.shade700
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.0, 0.5 + (_controller.value * 0.5), 1.0],
            ).createShader(bounds),
            child: const Icon(LucideIcons.flame, size: 18, color: Colors.white),
          ),
        );
      },
    );
  }
}

class _TodayPlanSection extends ConsumerWidget {
  final WorkoutHomeState state;
  const _TodayPlanSection({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Hero(
          tag: 'today_plan_card',
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF1E3A8A), // Deep Blue
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                  blurRadius: 25,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.isRestDay ? 'REST DAY' : 'TODAY\'S PLAN',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          Text(
                            state.isRestDay
                                ? 'Time to Recover'
                                : (state.todayDayName ?? "Push Day A"),
                            style: GoogleFonts.outfit(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(LucideIcons.calendar,
                          color: Colors.white, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (!state.isRestDay) ...[
                  Row(
                    children: [
                      _StatChip(
                          icon: LucideIcons.dumbbell,
                          label: '${state.todayExercises.length} Exercises'),
                      const SizedBox(width: 12),
                      _StatChip(
                          icon: LucideIcons.clock,
                          label: '${state.estimatedDuration} mins'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: state.todayExercises
                            .take(3)
                            .map((e) => _ExerciseChip(label: e))
                            .toList() +
                        (state.todayExercises.length > 3
                            ? [
                                _ExerciseChip(
                                    label:
                                        '+${state.todayExercises.length - 3} more')
                              ]
                            : []),
                  ),
                ] else
                  Text(
                    '💪 Recharge and let your muscles grow. You\'ve earned it!',
                    style: GoogleFonts.outfit(
                        color: Colors.white.withValues(alpha: 0.9), fontSize: 15),
                  ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const BeginSessionSheet(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1E3A8A),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      state.activeDraft != null
                          ? 'RESUME WORKOUT'
                          : (state.isRestDay
                              ? 'START QUICK WORKOUT'
                              : 'START TODAY\'S WORKOUT'),
                      style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w900, letterSpacing: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.white70),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.outfit(
              color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _ExerciseChip extends StatelessWidget {
  final String label;
  const _ExerciseChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

class _QuickActionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Row(
          children: [
            _QuickActionItem(
              icon: LucideIcons.play,
              label: 'START',
              color: Colors.green.shade400,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const BeginSessionSheet(),
                );
              },
            ),
            const SizedBox(width: 12),
            _QuickActionItem(
              icon: LucideIcons.clipboardList,
              label: 'PROGRAMS',
              color: Colors.purple.shade400,
              onTap: () => context.go('/programs'),
            ),
            const SizedBox(width: 12),
            _QuickActionItem(
              icon: LucideIcons.dumbbell,
              label: 'EXERCISES',
              color: Colors.blue.shade400,
              onTap: () => context.go('/exercises'),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LastWorkoutSection extends StatelessWidget {
  final WorkoutHomeState state;
  const _LastWorkoutSection({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.lastWorkout == null)
      return const SliverToBoxAdapter(child: SizedBox());

    final timeAgo = DateFormat.yMMMd().format(state.lastWorkout!.date);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last workout: $timeAgo',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Icon(LucideIcons.history, size: 14, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                state.lastWorkout!.name,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 4),
              Text(
                'Duration: ${state.lastWorkout!.duration != null ? (state.lastWorkout!.duration! ~/ 60) : 0} mins',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Text(
                state.lastWorkoutSummary ?? 'No summary available',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontStyle: FontStyle.italic),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      context.push('/history/workout/${state.lastWorkout!.id}'),
                  child: const Text('View Details →'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeeklyVolumeSection extends StatelessWidget {
  final WorkoutHomeState state;
  const _WeeklyVolumeSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RepaintBoundary(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This Week\'s Volume',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 120,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 5000, // Adjust based on data
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(days[value.toInt()]),
                            );
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(7, (i) {
                      final day = DateTime.now().subtract(
                          Duration(days: DateTime.now().weekday - 1 - i));
                      final dayKey = DateTime(day.year, day.month, day.day)
                          .millisecondsSinceEpoch;
                      final volume = state.weeklyVolume[dayKey] ?? 0;

                      return BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: volume,
                            color: (i == DateTime.now().weekday - 1
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest)
                        .withValues(alpha: 0.8),
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Total this week: ${state.weeklyVolume.values.fold(0.0, (a, b) => a + b).toStringAsFixed(0)} kg',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BodyweightSection extends StatelessWidget {
  final WorkoutHomeState state;
  const _BodyweightSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          child: ListTile(
            leading: const Icon(LucideIcons.scale, color: Colors.blue),
            title: const Text('Log today\'s weight'),
            subtitle: Text(state.lastWeight != null
                ? 'Last: ${state.lastWeight!.weight} kg'
                : 'No recorded weight yet'),
            trailing: const Icon(LucideIcons.chevronRight),
            onTap: () => _showWeightSheet(context),
          ),
        ),
      ),
    );
  }

  void _showWeightSheet(BuildContext context) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daily Bodyweight',
                style: GoogleFonts.outfit(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Consumer(
              builder: (context, ref, _) => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final weight = double.tryParse(controller.text);
                    if (weight != null) {
                      ref
                          .read(workoutHomeNotifierProvider.notifier)
                          .logWeight(weight);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlateauAlertSection extends ConsumerStatefulWidget {
  @override
  ConsumerState<_PlateauAlertSection> createState() =>
      _PlateauAlertSectionState();
}

class _PlateauAlertSectionState extends ConsumerState<_PlateauAlertSection> {
  List<PlateauResult> _plateaus = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _checkPlateaus();
  }

  Future<void> _checkPlateaus() async {
    final prefs = await SharedPreferences.getInstance();
    final db = ref.read(appDatabaseProvider);
    final service = ref.read(plateauServiceProvider.notifier);

    // Get last 10 used exercises to check
    final recentExercises = await (db.select(db.exercises)
          ..where((t) => t.lastUsed.isNotNull())
          ..orderBy([
            (t) => OrderingTerm(expression: t.lastUsed, mode: OrderingMode.desc)
          ])
          ..limit(10))
        .get();

    final results = <PlateauResult>[];
    for (var ex in recentExercises) {
      final dismissedKey = 'plateau_dismissed_${ex.id}';
      final dismissedUntil = prefs.getInt(dismissedKey) ?? 0;
      if (DateTime.now().millisecondsSinceEpoch < dismissedUntil) continue;

      final result = await service.checkExercise(ex.id);
      if (result != null) results.add(result);
    }

    if (mounted) {
      setState(() {
        _plateaus = results;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _plateaus.isEmpty)
      return const SliverToBoxAdapter(child: SizedBox.shrink());

    return SliverToBoxAdapter(
      child: Column(
        children: _plateaus.map((p) => _buildDeloadCard(p)).toList(),
      ),
    );
  }

  Widget _buildDeloadCard(PlateauResult plateau) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade800, Colors.orange.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.orange.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.flame, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'PLATEAU DETECTED',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1.2),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              IconButton(
                icon:
                    const Icon(LucideIcons.x, color: Colors.white70, size: 16),
                onPressed: () => _dismiss(plateau),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${plateau.exerciseName} hasn\'t improved in ${plateau.weeksStuck} sessions.',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 4),
          Text(
            'Your CNS might need a break. Try a light session at ${plateau.deloadWeight}kg (70%) today.',
            style:
                TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {}, // Handled by standard workout flow
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange.shade900,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Target Deload Next Session',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dismiss(PlateauResult p) async {
    final prefs = await SharedPreferences.getInstance();
    // Dismiss for 2 weeks
    final until =
        DateTime.now().add(const Duration(days: 14)).millisecondsSinceEpoch;
    final dismissedKey = 'plateau_dismissed_${p.exerciseId}';
    await prefs.setInt(dismissedKey, until);

    setState(() {
      _plateaus.remove(p);
    });
  }
}

class _MotivationSection extends StatelessWidget {
  final WorkoutHomeState state;
  const _MotivationSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  state.dailyTip.category.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                state.dailyTip.text,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingWorkoutBanner extends StatefulWidget {
  final WorkoutSession workout;
  const _FloatingWorkoutBanner({required this.workout});

  @override
  State<_FloatingWorkoutBanner> createState() => _FloatingWorkoutBannerState();
}

class _FloatingWorkoutBannerState extends State<_FloatingWorkoutBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.2 * _controller.value),
                  blurRadius: 15 * _controller.value,
                  spreadRadius: 2 * _controller.value,
                ),
              ],
            ),
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .secondaryContainer
                .withOpacity(0.95),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => context
                      .push('/app/workout/active?id=${widget.workout.id}'),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      const Icon(LucideIcons.activity, color: Colors.green),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Workout in progress — tap to resume',
                          style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w800, fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
                child: VerticalDivider(width: 24, thickness: 1),
              ),
              Consumer(
                builder: (context, ref, _) {
                  return IconButton(
                    icon: const Icon(LucideIcons.trash2,
                        size: 18, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Discard Workout?'),
                          content: const Text(
                              'All progress in the current active session will be lost.'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Keep')),
                            TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Discard',
                                    style: TextStyle(color: Colors.red))),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        ref
                            .read(workoutHomeNotifierProvider.notifier)
                            .deleteWorkout(widget.workout.id);
                      }
                    },
                    tooltip: 'Discard workout',
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
