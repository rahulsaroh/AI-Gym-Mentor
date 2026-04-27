import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/domain/entities/workout_session.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:drift/drift.dart' show OrderingTerm, OrderingMode;
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';
import 'package:ai_gym_mentor/features/workout/components/begin_session_sheet.dart';
import 'package:ai_gym_mentor/services/plateau_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/widgets/stats_trend_chart.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/widgets/workout_heatmap.dart';
import 'package:ai_gym_mentor/core/widgets/skeleton_card.dart';
import 'package:ai_gym_mentor/features/bodymap/providers/bodymap_provider.dart';
import 'package:ai_gym_mentor/features/bodymap/widgets/body_map_painter.dart';
import 'package:ai_gym_mentor/features/bodymap/widgets/muscle_path_registry.dart';
import 'package:ai_gym_mentor/core/services/heatmap_color_service.dart';

class WorkoutHomeScreen extends ConsumerWidget {
  const WorkoutHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(workoutHomeProvider);

    return Scaffold(
      body: homeState.when(
        data: (state) => Stack(
          children: [
            RefreshIndicator(
              onRefresh: () => ref.read(workoutHomeProvider.notifier).refresh(),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  _HeaderSection(state: state),
                  _PlateauAlertSection(),
                  _TodayPlanSection(state: state),
                  _QuickActionSection(),
                  _MuscleRecoveryHeatmap(),
                  _LastWorkoutSection(state: state),
                  _ConsistencySection(),
                  _WeeklyVolumeSection(state: state),
                  _BodyweightSection(state: state),
                  _MotivationSection(state: state),
                  const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, _) {
                final activeDraft = ref.watch(workoutHomeProvider
                    .select((s) => s.asData?.value.activeDraft));
                if (activeDraft != null) {
                  return _FloatingWorkoutBanner(workout: activeDraft);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        loading: () => RefreshIndicator(
          onRefresh: () => ref.read(workoutHomeProvider.notifier).refresh(),
          child: const SkeletonDashboard(),
        ),
        error: (err, stack) => RefreshIndicator(
          onRefresh: () => ref.read(workoutHomeProvider.notifier).refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(child: Text('Error: $err')),
            ),
          ),
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
                  _StreakBadge(streak: state.currentStreak),
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
                          Row(
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
                              if (!state.isRestDay && state.templateId != null) ...[
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () => _showDayOverridePicker(context, ref, state),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                  const Icon(LucideIcons.repeat, size: 10, color: Colors.white),
                                  const SizedBox(width: 4),
                                  Text(
                                    'CHANGE',
                                          style: GoogleFonts.outfit(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              if (state.templateId != null && state.nextDayId != null) {
                                context.push('/programs/details/${state.templateId}?dayId=${state.nextDayId}');
                              }
                            },
                            child: Text(
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
                  Column(
                    children: [
                      ...state.todayExercises.take(3).map((ex) => _TodayExerciseItem(ex: ex)),
                      if (state.todayExercises.length > 3)
                        InkWell(
                          onTap: () {
                            if (state.templateId != null && state.nextDayId != null) {
                              context.push('/programs/details/${state.templateId}?dayId=${state.nextDayId}');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              children: [
                                Icon(LucideIcons.plus, size: 14, color: Colors.white.withValues(alpha: 0.7)),
                                const SizedBox(width: 8),
                                Text(
                                  '${state.todayExercises.length - 3} more exercises',
                                  style: GoogleFonts.outfit(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
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
                    onPressed: () async {
                      if (state.activeDraft != null) {
                        // Navigate directly to the active workout — no need to ask anything
                        context.push('/app/workout/active?id=${state.activeDraft!.id}');
                      } else if (state.templateId != null && state.nextDayId != null && !state.isRestDay) {
                        // Auto-start today's workout
                        final workoutId = await ref.read(workoutHomeProvider.notifier).startWorkout(
                          templateId: state.templateId,
                          dayId: state.nextDayId,
                          name: state.todayDayName ?? 'Today\'s Workout',
                        );
                        if (context.mounted) {
                          context.push('/app/workout/active?id=$workoutId&dayId=${state.nextDayId}');
                        }
                      } else {
                        // Show selection sheet if no plan is set or it's a rest day and user wants a quick workout
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const BeginSessionSheet(),
                        );
                      }
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

  Future<void> _showDayOverridePicker(

      BuildContext context, WidgetRef ref, WorkoutHomeState state) async {
    final templateId = state.templateId;
    if (templateId == null) return;

    final repo = ref.read(workoutRepositoryProvider);
    final days = await repo.getTemplateDays(templateId);

    if (context.mounted) {
      final selectedDayId = await showDialog<int>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Switch Workout Day',
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = days[index];
                final isCurrent = day.id == state.nextDayId;
                return ListTile(
                  title: Text(day.name,
                      style: GoogleFonts.outfit(
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                        color: isCurrent ? Theme.of(context).colorScheme.primary : null,
                      )),
                  trailing: isCurrent ? const Icon(LucideIcons.check, size: 16) : null,
                  onTap: () => Navigator.pop(context, day.id),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(workoutHomeProvider.notifier).resetManualDay();
                Navigator.pop(context);
              },
              child: const Text('RESET TO SCHEDULE'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );

      if (selectedDayId != null && context.mounted) {
        await ref
            .read(workoutHomeProvider.notifier)
            .setManualDay(selectedDayId);
      }
    }
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
              onTap: () => context.push('/exercises'),
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
  final bool isAi;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.isAi = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isAi 
                ? colorScheme.primary.withValues(alpha: 0.1)
                : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isAi
                  ? colorScheme.primary.withValues(alpha: 0.3)
                  : Theme.of(context).dividerColor.withValues(alpha: 0.1),
              width: isAi ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              if (isAi)
                 ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Colors.orange.shade700, Colors.pink.shade500],
                    ).createShader(bounds);
                  },
                  child: Icon(icon, color: Colors.white),
                )
              else
                Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: isAi ? FontWeight.w800 : FontWeight.w600,
                  color: isAi ? colorScheme.primary : null,
                  letterSpacing: isAi ? 0.5 : 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MuscleRecoveryHeatmap extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heatAsync = ref.watch(muscleHeatDataProvider);
    
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recovery Status',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(LucideIcons.activity, size: 16, color: Colors.purple),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: heatAsync.when(
                  data: (data) => Row(
                    children: [
                      Expanded(
                        child: CustomPaint(
                          painter: BodyMapPainter(
                            heatData: data,
                            musclePaths: MusclePathRegistry.getFrontPaths(),
                            mode: BodyMapMode.doms,
                            colorService: HeatmapColorService(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _RecoveryIndicator(label: 'Sore', color: const Color(0xFF7C4DFF)),
                            const SizedBox(height: 8),
                            _RecoveryIndicator(label: 'Recovered', color: const Color(0xFFBDBDBD)),
                            const SizedBox(height: 16),
                            Text(
                              'Muscles highlighted in purple are still recovering. Avoid heavy loading until recovered.',
                              style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Error: $e'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecoveryIndicator extends StatelessWidget {
  final String label;
  final Color color;
  const _RecoveryIndicator({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _LastWorkoutSection extends StatelessWidget {
  final WorkoutHomeState state;
  const _LastWorkoutSection({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.lastWorkout == null) {
      return const SliverToBoxAdapter(child: SizedBox());
    }

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
    // Convert weeklyVolume map to the format expected by StatsTrendChart
    final sortedKeys = state.weeklyVolume.keys.toList()..sort();
    final chartData = sortedKeys.map((k) => {
      'date': DateTime.fromMillisecondsSinceEpoch(k),
      'volume': state.weeklyVolume[k],
    }).toList();

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Volume Progression',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            StatsTrendChart(data: chartData, type: StatType.volume),
          ],
        ),
      ),
    );
  }
}

class _ConsistencySection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityAsync = ref.watch(dailyActivityProvider);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: activityAsync.when(
          data: (activity) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Consistency',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                WorkoutHeatmap(activity: activity),
              ],
            );
          },
          loading: () => const SizedBox(height: 150),
          error: (_, _) => const SizedBox.shrink(),
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
                          .read(workoutHomeProvider.notifier)
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
    if (_loading || _plateaus.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

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
      bottom: 100,
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
                        await ref
                            .read(workoutHomeProvider.notifier)
                            .deleteWorkout(widget.workout.id);
                        // Refresh home state so banner disappears
                        ref.invalidate(workoutHomeProvider);
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

class _TodayExerciseItem extends StatelessWidget {
  final TodayExercise ex;
  const _TodayExerciseItem({required this.ex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/exercises/${ex.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3), width: 1),
                ),
                clipBehavior: Clip.antiAlias,
                child: ex.imageUrl != null && ex.imageUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: ex.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                            child: SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white70))),
                        errorWidget: (context, url, error) => const Icon(
                            LucideIcons.dumbbell,
                            size: 16,
                            color: Colors.white70),
                      )
                    : const Icon(LucideIcons.dumbbell,
                        size: 16, color: Colors.white70),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  ex.name,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(LucideIcons.chevronRight, size: 14, color: Colors.white38),
            ],
          ),
        ),
      ),
    );
  }
}
