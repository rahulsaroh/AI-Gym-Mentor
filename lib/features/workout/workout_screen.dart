import 'package:flutter/material.dart';
\nimport 'package:flutter_riverpod/flutter_riverpod.dart';
\nimport 'package:go_router/go_router.dart';
\nimport 'package:google_fonts/google_fonts.dart';
\nimport 'package:intl/intl.dart';
\nimport 'package:cached_network_image/cached_network_image.dart';
\nimport 'package:ai_gym_mentor/core/database/database.dart';
\nimport 'package:ai_gym_mentor/core/domain/entities/workout_session.dart';
\nimport 'package:lucide_icons_flutter/lucide_icons.dart';
\nimport 'package:drift/drift.dart' show OrderingTerm, OrderingMode;
\nimport 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';
\nimport 'package:ai_gym_mentor/features/workout/components/begin_session_sheet.dart';
\nimport 'package:ai_gym_mentor/services/plateau_service.dart';
\nimport 'package:shared_preferences/shared_preferences.dart';
\nimport 'package:ai_gym_mentor/features/workout/workout_repository.dart';
\nimport 'package:ai_gym_mentor/features/analytics/presentation/widgets/stats_trend_chart.dart';
\nimport 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
\nimport 'package:ai_gym_mentor/features/analytics/presentation/widgets/workout_heatmap.dart';
\nimport 'package:ai_gym_mentor/core/widgets/skeleton_card.dart';
\nimport 'package:ai_gym_mentor/features/bodymap/providers/bodymap_provider.dart';
\nimport 'package:ai_gym_mentor/features/bodymap/widgets/body_map_painter.dart';
\nimport 'package:ai_gym_mentor/features/bodymap/widgets/muscle_path_registry.dart';
\nimport 'package:ai_gym_mentor/core/services/heatmap_color_service.dart';
\n
\nclass WorkoutHomeScreen extends ConsumerWidget {
\n  const WorkoutHomeScreen({super.key});
\n
\n  @override
\n  Widget build(BuildContext context, WidgetRef ref) {
\n    final homeState = ref.watch(workoutHomeProvider);
\n
\n    return Scaffold(
\n      body: homeState.when(
\n        data: (state) => Stack(
\n          children: [
\n            RefreshIndicator(
\n              onRefresh: () => ref.read(workoutHomeProvider.notifier).refresh(),
\n              child: CustomScrollView(
\n                physics: const AlwaysScrollableScrollPhysics(),
\n                slivers: [
\n                  _HeaderSection(state: state),
\n                  _PlateauAlertSection(),
\n                  _TodayPlanSection(state: state),
\n                  _QuickActionSection(),
\n                  _MuscleRecoverySection(),
\n                  _LastWorkoutSection(state: state),
\n                  _ConsistencySection(),
\n                  _WeeklyVolumeSection(state: state),
\n                  _BodyweightSection(state: state),
\n                  _MotivationSection(state: state),
\n                  const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
\n                ],
\n              ),
\n            ),
\n            Consumer(
\n              builder: (context, ref, _) {
\n                final activeDraft = ref.watch(workoutHomeProvider
\n                    .select((s) => s.asData?.value.activeDraft));
\n                if (activeDraft != null) {
\n                  return _FloatingWorkoutBanner(workout: activeDraft);
\n                }
\n                return const SizedBox.shrink();
\n              },
\n            ),
\n          ],
\n        ),
\n        loading: () => RefreshIndicator(
\n          onRefresh: () => ref.read(workoutHomeProvider.notifier).refresh(),
\n          child: const SkeletonDashboard(),
\n        ),
\n        error: (err, stack) => RefreshIndicator(
\n          onRefresh: () => ref.read(workoutHomeProvider.notifier).refresh(),
\n          child: SingleChildScrollView(
\n            physics: const AlwaysScrollableScrollPhysics(),
\n            child: SizedBox(
\n              height: MediaQuery.of(context).size.height,
\n              child: Center(child: Text('Error: ')),
\n            ),
\n          ),
\n        ),
\n      ),
\n    );
\n  }
\n}
\n
\n
\nclass _HeaderSection extends StatelessWidget {
\n  final WorkoutHomeState state;
\n  const _HeaderSection({required this.state});
\n
\n  @override
\n  Widget build(BuildContext context) {
\n    final colorScheme = Theme.of(context).colorScheme;
\n    return SliverToBoxAdapter(
\n      child: RepaintBoundary(
\n        child: Padding(
\n          padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
\n          child: Column(
\n            crossAxisAlignment: CrossAxisAlignment.start,
\n            children: [
\n              Row(
\n                mainAxisAlignment: MainAxisAlignment.spaceBetween,
\n                children: [
\n                  Expanded(
\n                    child: Column(
\n                      crossAxisAlignment: CrossAxisAlignment.start,
\n                      children: [
\n                        Text(
\n                          '${state.greeting},',
\n                          style: GoogleFonts.outfit(
\n                            fontSize: 15,
\n                            fontWeight: FontWeight.w500,
\n                            color: colorScheme.outline,
\n                          ),
\n                        ),
\n                        const SizedBox(height: 4),
\n                        Text(
\n                          '${state.userName}!',
\n                          style: GoogleFonts.outfit(
\n                            fontSize: 32,
\n                            fontWeight: FontWeight.w900,
\n                            letterSpacing: -0.5,
\n                            height: 1.1,
\n                          ),
\n                          overflow: TextOverflow.ellipsis,
\n                        ),
\n                      ],
\n                    ),
\n                  ),
\n                  const SizedBox(width: 12),
\n                  _StreakBadge(streak: state.currentStreak),
\n                ],
\n              ),
\n              const SizedBox(height: 12),
\n              Text(
\n                state.dateString.toUpperCase(),
\n                style: GoogleFonts.outfit(
\n                  fontSize: 11,
\n                  fontWeight: FontWeight.w700,
\n                  letterSpacing: 1.5,
\n                  color: colorScheme.primary,
\n                ),
\n              ),
\n            ],
\n          ),
\n        ),
\n      ),
\n    );
\n  }
\n}
\n
\nclass _StreakBadge extends StatelessWidget {
\n  final int streak;
\n  const _StreakBadge({required this.streak});
\n
\n  @override
\n  Widget build(BuildContext context) {
\n    final hasStreak = streak > 0;
\n    final colorScheme = Theme.of(context).colorScheme;
\n    return Container(
\n      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
\n      decoration: BoxDecoration(
\n        color: hasStreak
\n            ? Colors.orange.withValues(alpha: 0.12)
\n            : colorScheme.primary.withValues(alpha: 0.12),
\n        borderRadius: BorderRadius.circular(12),
\n        border: Border.all(
\n          color: hasStreak
\n              ? Colors.orange.withValues(alpha: 0.3)
\n              : colorScheme.primary.withValues(alpha: 0.2),
\n          width: 1.5,
\n        ),
\n      ),
\n      child: Row(
\n        mainAxisSize: MainAxisSize.min,
\n        children: [
\n          if (hasStreak)
\n            Icon(
\n              LucideIcons.flame,
\n              size: 16,
\n              color: Colors.orange,
\n            )
\n          else
\n            Icon(LucideIcons.target, size: 16, color: colorScheme.primary),
\n          const SizedBox(width: 6),
\n          Text(
\n            hasStreak ? '$streak' : 'Start',
\n            style: GoogleFonts.outfit(
\n              fontSize: 13,
\n              fontWeight: FontWeight.w800,
\n              color: hasStreak ? Colors.orange : colorScheme.primary,
\n              height: 1,
\n            ),
\n          ),
\n          if (hasStreak)
\n            Text(
\n              'DAYS',
\n              style: GoogleFonts.outfit(
\n                fontSize: 9,
\n                fontWeight: FontWeight.w700,
\n                color: Colors.orange.withValues(alpha: 0.7),
\n                height: 1.5,
\n                letterSpacing: 0.5,
\n              ),
\n            ),
\n        ],
\n      ),
\n    );
\n  }
\n}
\n
\nclass _StatChip extends StatelessWidget {
\n  final IconData icon;
\n  final String label;
\n  const _StatChip({required this.icon, required this.label});
\n
\n  @override
\n  Widget build(BuildContext context) {
\n    return Row(
\n      children: [
\n        Icon(icon, size: 14, color: Theme.of(context).colorScheme.outline),
\n        const SizedBox(width: 4),
\n        Text(
\n          label,
\n          style: GoogleFonts.outfit(
\n              color: Theme.of(context).colorScheme.outline, fontSize: 13, fontWeight: FontWeight.w500),
\n        ),
\n      ],
\n    );
\n  }
\n}
\n
\nclass _ExerciseChip extends StatelessWidget {
\n  final String label;
\n  const _ExerciseChip({required this.label});
\n
\n  @override
\n  Widget build(BuildContext context) {
\n    return Container(
\n      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
\n      decoration: BoxDecoration(
\n        color: Colors.white.withValues(alpha: 0.15),
\n        borderRadius: BorderRadius.circular(8),
\n      ),
\n      child: Text(
\n        label,
\n        style: const TextStyle(color: Colors.orange, fontSize: 12),
\n      ),
\n    );
\n  }
\n}
\n
\nclass _QuickActionSection extends StatelessWidget {
\n  @override
\n  Widget build(BuildContext context) {
\n    return SliverToBoxAdapter(
\n      child: Padding(
\n        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
\n        child: Row(
\n          children: [
\n            _QuickActionItem(
\n              icon: LucideIcons.play,
\n              label: 'START',
\n              color: Colors.green.shade400,
\n              onTap: () {
\n                showModalBottomSheet(
\n                  context: context,
\n                  isScrollControlled: true,
\n                  backgroundColor: Colors.transparent,
\n                  builder: (context) => const BeginSessionSheet(),
\n                );
\n              },
\n            ),
\n            const SizedBox(width: 12),
\n            _QuickActionItem(
\n              icon: LucideIcons.clipboardList,
\n              label: 'PROGRAMS',
\n              color: Colors.purple.shade400,
\n              onTap: () => context.go('/programs'),
\n            ),
\n            const SizedBox(width: 12),
\n            _QuickActionItem(
\n              icon: LucideIcons.dumbbell,
\n              label: 'EXERCISES',
\n              color: Colors.blue.shade400,
\n              onTap: () => context.push('/exercises'),
\n            ),
\n          ],
\n        ),
\n      ),
\n    );
\n  }
\n}
\n
\nclass _QuickActionItem extends StatelessWidget {
\n  final IconData icon;
\n  final String label;
\n  final Color color;
\n  final VoidCallback onTap;
\n  final bool isAi;
\n
\n  const _QuickActionItem({
\n    required this.icon,
\n    required this.label,
\n    required this.color,
\n    required this.onTap,
\n    this.isAi = false,
\n  });
\n
\n  @override
\n  Widget build(BuildContext context) {
\n    final colorScheme = Theme.of(context).colorScheme;
\n    
\n    return Expanded(
\n      child: InkWell(
\n        onTap: onTap,
\n        borderRadius: BorderRadius.circular(16),
\n        child: Container(
\n          padding: const EdgeInsets.symmetric(vertical: 16),
\n          decoration: BoxDecoration(
\n            color: isAi 
\n                ? colorScheme.primary.withValues(alpha: 0.1)
\n                : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
\n            borderRadius: BorderRadius.circular(16),
\n            border: Border.all(
\n              color: isAi
\n                  ? colorScheme.primary.withValues(alpha: 0.3)
\n                  : Theme.of(context).dividerColor.withValues(alpha: 0.1),
\n              width: isAi ? 1.5 : 1,
\n            ),
\n          ),
\n          child: Column(
\n            children: [
\n              if (isAi)
\n                 ShaderMask(
\n                  shaderCallback: (Rect bounds) {
\n                    return LinearGradient(
\n                      colors: [Colors.orange.shade700, Colors.pink.shade500],
\n                    ).createShader(bounds);
\n                  },
\n                  child: Icon(icon, color: Colors.white),
\n                )
\n              else
\n                Icon(icon, color: color),
\n              const SizedBox(height: 8),
\n              Text(
\n                label,
\n                style: GoogleFonts.outfit(
\n                  fontSize: 12,
\n                  fontWeight: isAi ? FontWeight.w800 : FontWeight.w600,
\n                  color: isAi ? colorScheme.primary : null,
\n                  letterSpacing: isAi ? 0.5 : 0,
\n                ),
\n              ),
\n            ],
\n          ),
\n        ),
\n      ),
\n    );
\n  }
\n}
\n
\nclass _MuscleRecoverySection extends ConsumerWidget {
\n  @override
\n  Widget build(BuildContext context, WidgetRef ref) {
\n    final heatAsync = ref.watch(muscleHeatDataProvider);
\n    
\n    return SliverToBoxAdapter(
\n      child: Padding(
\n        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
\n        child: Container(
\n          padding: const EdgeInsets.all(20),
\n          decoration: BoxDecoration(
\n            color: Theme.of(context).colorScheme.surfaceContainerHighest,
\n            borderRadius: BorderRadius.circular(20),
\n            border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.08)),
\n          ),
\n          child: Column(
\n            crossAxisAlignment: CrossAxisAlignment.start,
\n            children: [
\n              Row(
\n                mainAxisAlignment: MainAxisAlignment.spaceBetween,
\n                children: [
\n                  Text(
\n                    'Recovery Status',
\n                    style: GoogleFonts.outfit(
\n                      fontSize: 18,
\n                      fontWeight: FontWeight.bold,
\n                    ),
\n                  ),
\n                  const Icon(LucideIcons.activity, size: 16, color: Colors.purple),
\n                ],
\n              ),
\n              const SizedBox(height: 16),
\n              SizedBox(
\n                height: 200,
\n                child: heatAsync.when(
\n                  data: (data) => Row(
\n                    children: [
\n                      Expanded(
\n                        child: CustomPaint(
\n                          painter: BodyMapPainter(
\n                            heatData: data,
\n                            musclePaths: MusclePathRegistry.getFrontPaths(),
\n                            mode: BodyMapMode.doms,
\n                            colorService: HeatmapColorService(),
\n                          ),
\n                        ),
\n                      ),
\n                      const SizedBox(width: 20),
\n                      Expanded(
\n                        child: Column(
\n                          mainAxisAlignment: MainAxisAlignment.center,
\n                          crossAxisAlignment: CrossAxisAlignment.start,
\n                          children: [
\n                            _RecoveryIndicator(label: 'Sore', color: const Color(0xFF7C4DFF)),
\n                            const SizedBox(height: 8),
\n                            _RecoveryIndicator(label: 'Recovered', color: const Color(0xFFBDBDBD)),
\n                            const SizedBox(height: 16),
\n                            Text(
\n                              'Muscles highlighted in purple are still recovering. Avoid heavy loading until recovered.',
\n                              style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline),
\n                            ),
\n                          ],
\n                        ),
\n                      ),
\n                    ],
\n                  ),
\n                  loading: () => const Center(child: CircularProgressIndicator()),
\n                  error: (e, _) => Text('Error: $e'),
\n                ),
\n              ),
\n            ],
\n          ),
\n        ),
\n      ),
\n    );
\n  }
\n}
\n
\nclass _RecoveryIndicator extends StatelessWidget {
\n  final String label;
\n  final Color color;
\n  const _RecoveryIndicator({required this.label, required this.color});
\n
\n  @override
\n  Widget build(BuildContext context) {
\n    return Row(
\n      children: [
\n        Container(
\n          width: 12,
\n          height: 12,
\n          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
\n        ),
\n        const SizedBox(width: 8),
\n        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
\n      ],
\n    );
\n  }
\n}
\n
\nclass _LastWorkoutSection extends StatelessWidget {
\n  final WorkoutHomeState state;
\n  const _LastWorkoutSection({required this.state});
\n
\n  @override
\n  Widget build(BuildContext context) {
\n    if (state.lastWorkout == null) {
\n      return const SliverToBoxAdapter(child: SizedBox());
\n    }
\n
\n    final timeAgo = DateFormat.yMMMd().format(state.lastWorkout!.date);
\n
\n    return SliverToBoxAdapter(
\n      child: Padding(
\n        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
\n        child: Container(
\n          padding: const EdgeInsets.all(16),
\n          decoration: BoxDecoration(
\n            color: Theme.of(context).colorScheme.surface,
\n            borderRadius: BorderRadius.circular(20),
\n            border: Border.all(
\n                color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
\n          ),
\n          child: Column(
\n            crossAxisAlignment: CrossAxisAlignment.start,
\n            children: [
\n              Row(
\n                mainAxisAlignment: MainAxisAlignment.spaceBetween,
\n                children: [
\n                  Text(
\n                    'Last workout: $timeAgo',
\n                    style: Theme.of(context).textTheme.bodySmall,
\n                  ),
\n                  const Icon(LucideIcons.history, size: 14, color: Colors.grey),
\n                ],
\n              ),
\n              const SizedBox(height: 8),
\n              Text(
\n                state.lastWorkout!.name,
\n                style: GoogleFonts.outfit(
\n                  fontSize: 18,
\n                  fontWeight: FontWeight.bold,
\n                ),
\n                overflow: TextOverflow.ellipsis,
\n                maxLines: 1,
\n              ),
\n              const SizedBox(height: 4),
\n              Text(
\n                'Duration: ${state.lastWorkout!.duration != null ? (state.lastWorkout!.duration! ~/ 60) : 0} mins',
\n                style: Theme.of(context).textTheme.bodySmall,
\n              ),
\n              const SizedBox(height: 12),
\n              Text(
\n                state.lastWorkoutSummary ?? 'No summary available',
\n                style: Theme.of(context)
\n                    .textTheme
\n                    .bodyMedium
\n                    ?.copyWith(fontStyle: FontStyle.italic),
\n              ),
\n              Align(
\n                alignment: Alignment.centerRight,
\n                child: TextButton(
\n                  onPressed: () =>
\n                      context.push('/history/workout/${state.lastWorkout!.id}'),
\n                  child: const Text('View Details →'),
\n                ),
\n              ),
\n            ],
\n          ),
\n        ),
\n      ),
\n    );
\n  }
\n}
\n
\nclass _WeeklyVolumeSection extends StatelessWidget {
\n  final WorkoutHomeState state;
\n  const _WeeklyVolumeSection({required this.state});
\n
\n  @override
\n  Widget build(BuildContext context) {
\n    // Convert weeklyVolume map to the format expected by StatsTrendChart
\n    final sortedKeys = state.weeklyVolume.keys.toList()..sort();
\n    final chartData = sortedKeys.map((k) => {
\n      'date': DateTime.fromMillisecondsSinceEpoch(k),
\n      'volume': state.weeklyVolume[k],
\n    }).toList();
\n
\n    return SliverToBoxAdapter(
\n      child: Padding(
\n        padding: const EdgeInsets.all(20),
\n        child: Column(
\n          crossAxisAlignment: CrossAxisAlignment.start,
\n          children: [
\n            Text(
\n              'Volume Progression',
\n              style: GoogleFonts.outfit(
\n                fontSize: 18,
\n                fontWeight: FontWeight.bold,
\n              ),
\n            ),
\n            const SizedBox(height: 16),
\n            StatsTrendChart(data: chartData, type: StatType.volume),
\n          ],
\n        ),
\n      ),
\n    );
\n  }
\n}
\n
\nclass _ConsistencySection extends ConsumerWidget {
\n  @override
\n  Widget build(BuildContext context, WidgetRef ref) {
\n    final activityAsync = ref.watch(dailyActivityProvider);
\n
\n    return SliverToBoxAdapter(
\n      child: Padding(
\n        padding: const EdgeInsets.symmetric(vertical: 20),
\n        child: activityAsync.when(
\n          data: (activity) {
\n            return Column(
\n              crossAxisAlignment: CrossAxisAlignment.start,
\n              children: [
\n                Padding(
\n                  padding: const EdgeInsets.symmetric(horizontal: 20),
\n                  child: Text(
\n                    'Consistency',
\n                    style: GoogleFonts.outfit(
\n                      fontSize: 18,
\n                      fontWeight: FontWeight.bold,
\n                    ),
\n                  ),
\n                ),
\n                const SizedBox(height: 16),
\n                WorkoutHeatmap(activity: activity),
\n              ],
\n            );
\n          },
\n          loading: () => const SizedBox(height: 150),
\n          error: (_, _) => const SizedBox.shrink(),
\n        ),
\n      ),
\n    );
\n  }
\n}
\n
\nclass _BodyweightSection extends StatelessWidget {
\n  final WorkoutHomeState state;
\n  const _BodyweightSection({required this.state});
\n
\n  @override
\n  Widget build(BuildContext context) {
\n    return SliverToBoxAdapter(
\n      child: Padding(
\n        padding: const EdgeInsets.symmetric(horizontal: 20),
\n        child: Card(
\n          color: Theme.of(context).colorScheme.surfaceContainerHighest,
\n          shape: RoundedRectangleBorder(
\n            borderRadius: BorderRadius.circular(16),
\n            side: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
\n          ),
\n          elevation: 0,
\n          child: ListTile(          color: Theme.of(context).colorScheme.surfaceContainerHighest,
\n          shape: RoundedRectangleBorder(
\n            borderRadius: BorderRadius.circular(16),
\n            side: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
\n          ),
\n          elevation: 0,
\n          child: ListTile(
\n            leading: const Icon(LucideIcons.scale, color: Colors.blue),
\n            title: const Text('Log today\'s weight'),
\n            subtitle: Text(state.lastWeight != null
\n                ? 'Last: ${state.lastWeight!.weight} kg'
\n                : 'No recorded weight yet'),
\n            trailing: const Icon(LucideIcons.chevronRight),
\n            onTap: () => _showWeightSheet(context),
\n          ),
\n        ),
\n      ),
\n    );
\n  }
\n
\n  void _showWeightSheet(BuildContext context) {
\n    final controller = TextEditingController();
\n    showModalBottomSheet(
\n      context: context,
\n      isScrollControlled: true,
\n      builder: (context) => Padding(
\n        padding: EdgeInsets.fromLTRB(
\n            20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
\n        child: Column(
\n          mainAxisSize: MainAxisSize.min,
\n          crossAxisAlignment: CrossAxisAlignment.start,
\n          children: [
\n            Text('Daily Bodyweight',
\n                style: GoogleFonts.outfit(
\n                    fontSize: 20, fontWeight: FontWeight.bold)),
\n            const SizedBox(height: 20),
\n            TextField(
\n              controller: controller,
\n              keyboardType: TextInputType.number,
\n              autofocus: true,
\n              decoration: const InputDecoration(
\n                labelText: 'Weight (kg)',
\n                border: OutlineInputBorder(),
\n              ),
\n            ),
\n            const SizedBox(height: 20),
\n            Consumer(
\n              builder: (context, ref, _) => SizedBox(
\n                width: double.infinity,
\n                child: ElevatedButton(
\n                  onPressed: () {
\n                    final weight = double.tryParse(controller.text);
\n                    if (weight != null) {
\n                      ref
\n                          .read(workoutHomeProvider.notifier)
\n                          .logWeight(weight);
\n                      Navigator.pop(context);
\n                    }
\n                  },
\n                  child: const Text('Save'),
\n                ),
\n              ),
\n            ),
\n          ],
\n        ),
\n      ),
\n    );
\n  }
\n}
\n
\nclass _PlateauAlertSection extends ConsumerStatefulWidget {
\n  @override
\n  ConsumerState<_PlateauAlertSection> createState() =>
\n      _PlateauAlertSectionState();
\n}
\n
\nclass _PlateauAlertSectionState extends ConsumerState<_PlateauAlertSection> {
\n  List<PlateauResult> _plateaus = [];
\n  bool _loading = true;
\n
\n  @override
\n  void initState() {
\n    super.initState();
\n    _checkPlateaus();
\n  }
\n
\n  Future<void> _checkPlateaus() async {
\n    final prefs = await SharedPreferences.getInstance();
\n    final db = ref.read(appDatabaseProvider);
\n    final service = ref.read(plateauServiceProvider.notifier);
\n
\n    // Get last 10 used exercises to check
\n    final recentExercises = await (db.select(db.exercises)
\n          ..where((t) => t.lastUsed.isNotNull())
\n          ..orderBy([
\n            (t) => OrderingTerm(expression: t.lastUsed, mode: OrderingMode.desc)
\n          ])
\n          ..limit(10))
\n        .get();
\n
\n    final results = <PlateauResult>[];
\n    for (var ex in recentExercises) {
\n      final dismissedKey = 'plateau_dismissed_${ex.id}';
\n      final dismissedUntil = prefs.getInt(dismissedKey) ?? 0;
\n      if (DateTime.now().millisecondsSinceEpoch < dismissedUntil) continue;
\n
\n      final result = await service.checkExercise(ex.id);
\n      if (result != null) results.add(result);
\n    }
\n
\n    if (mounted) {
\n      setState(() {
\n        _plateaus = results;
\n        _loading = false;
\n      });
\n    }
\n  }
\n
\n  @override
\n  Widget build(BuildContext context) {
\n    if (_loading || _plateaus.isEmpty) {
\n      return const SliverToBoxAdapter(child: SizedBox.shrink());
\n    }
\n
\n    return SliverToBoxAdapter(
\n      child: Column(
\n        children: _plateaus.map((p) => _buildDeloadCard(p)).toList(),
\n      ),
\n    );
\n  }
\n
\n  Widget _buildDeloadCard(PlateauResult plateau) {
\n    return Container(
\n      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
\n      padding: const EdgeInsets.all(16),
\n      decoration: BoxDecoration(
\n        color: Colors.orange.withValues(alpha: 0.08),
\n        borderRadius: BorderRadius.circular(16),
\n        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
\n      ),
\n      child: Column(
\n        crossAxisAlignment: CrossAxisAlignment.start,
\n        children: [
\n          Row(
\n            children: [
\n              Icon(LucideIcons.flame, color: Colors.orange, size: 20),
\n              const SizedBox(width: 8),
\n              const Expanded(
\n                child: Text(
\n                  'PLATEAU DETECTED',
\n                  style: TextStyle(
\n                      color: Colors.orange,
\n                      fontWeight: FontWeight.bold,
\n                      fontSize: 12,
\n                      letterSpacing: 1.2),
\n                  overflow: TextOverflow.ellipsis,
\n                ),
\n              ),
\n              const Spacer(),
\n              IconButton(
\n                icon:
\n                    const Icon(LucideIcons.x, color: Colors.orange, size: 16),
\n                onPressed: () => _dismiss(plateau),
\n                constraints: const BoxConstraints(),
\n                padding: EdgeInsets.zero,
\n              ),
\n            ],
\n          ),
\n          const SizedBox(height: 12),
\n          Text(
\n            '${plateau.exerciseName} hasn\'t improved in ${plateau.weeksStuck} sessions.',
\n            style: const TextStyle(
\n                color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 16),
\n            overflow: TextOverflow.ellipsis,
\n            maxLines: 1,
\n          ),
\n          const SizedBox(height: 4),
\n            Text(
\n              'Your CNS might need a break. Try a light session at \${plateau.deloadWeight}kg (70%) today.',
\n              style:
\n                  TextStyle(color: Colors.orange.withValues(alpha: 0.9), fontSize: 13),
\n            ),
\n          const SizedBox(height: 16),
\n          SizedBox(
\n            width: double.infinity,
\n            child: ElevatedButton(
\n              onPressed: () {}, // Handled by standard workout flow
\n              style: ElevatedButton.styleFrom(
\n                backgroundColor: Colors.white,
\n                foregroundColor: Colors.orange.shade900,
\n                elevation: 0,
\n                shape: RoundedRectangleBorder(
\n                    borderRadius: BorderRadius.circular(8)),
\n              ),
\n              child: const Text('Target Deload Next Session',
\n                  style: TextStyle(fontWeight: FontWeight.bold)),
\n            ),
\n          ),
\n        ],
\n      ),
\n    );
\n  }
\n
\n  Future<void> _dismiss(PlateauResult p) async {
\n    final prefs = await SharedPreferences.getInstance();
\n    // Dismiss for 2 weeks
\n    final until =
\n        DateTime.now().add(const Duration(days: 14)).millisecondsSinceEpoch;
\n    final dismissedKey = 'plateau_dismissed_${p.exerciseId}';
\n    await prefs.setInt(dismissedKey, until);
\n
\n    setState(() {
\n      _plateaus.remove(p);
\n    });
\n  }
\n}
\n
\nclass _MotivationSection extends StatelessWidget {
\n  final WorkoutHomeState state;
\n  const _MotivationSection({required this.state});
\n
\n  @override
\n  Widget build(BuildContext context) {
\n    return SliverToBoxAdapter(
\n      child: Padding(
\n        padding: const EdgeInsets.all(20),
\n        child: Container(
\n          padding: const EdgeInsets.all(20),
\n          decoration: BoxDecoration(
\n            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
\n            borderRadius: BorderRadius.circular(24),
\n            border: Border.all(
\n                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)),
\n          ),
\n          child: Column(
\n            crossAxisAlignment: CrossAxisAlignment.start,
\n            children: [
\n              Container(
\n                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
\n                decoration: BoxDecoration(
\n                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
\n                  borderRadius: BorderRadius.circular(8),
\n                ),
\n                child: Text(
\n                  state.dailyTip.category.toUpperCase(),
\n                  style: TextStyle(
\n                    fontSize: 10,
\n                    fontWeight: FontWeight.bold,
\n                    color: Theme.of(context).colorScheme.primary,
\n                  ),
\n                ),
\n              ),
\n              const SizedBox(height: 12),
\n              Text(
\n                state.dailyTip.text,
\n                style: GoogleFonts.outfit(
\n                  fontSize: 16,
\n                  height: 1.5,
\n                  fontWeight: FontWeight.w500,
\n                ),
\n              ),
\n            ],
\n          ),
\n        ),
\n      ),
\n    );
\n  }
\n}
\n
\nclass _FloatingWorkoutBanner extends StatefulWidget {
\n  final WorkoutSession workout;
\n  const _FloatingWorkoutBanner({required this.workout});
\n
\n  @override
\n  State<_FloatingWorkoutBanner> createState() => _FloatingWorkoutBannerState();
\n}
\n
\nclass _TodayExerciseItem extends StatelessWidget {
\n  final TodayExercise ex;
\n  const _TodayExerciseItem({required this.ex});
\n
\n  @override
\n  Widget build(BuildContext context) {
\n    return Padding(
\n      padding: const EdgeInsets.only(bottom: 12),
\n      child: InkWell(
\n        onTap: () => context.push('/exercises/${ex.id}'),
\n        borderRadius: BorderRadius.circular(12),
\n        child: Padding(
\n          padding: const EdgeInsets.all(4.0),
\n          child: Row(
\n            children: [
\n              Container(
\n                width: 40,
\n                height: 40,
\n                decoration: BoxDecoration(
\n                  color: Colors.white.withValues(alpha: 0.2),
\n                  shape: BoxShape.circle,
\n                  border: Border.all(
\n                      color: Colors.white.withValues(alpha: 0.3), width: 1),
\n                ),
\n                clipBehavior: Clip.antiAlias,
\n                child: ex.imageUrl != null && ex.imageUrl!.isNotEmpty
\n                    ? CachedNetworkImage(
\n                        imageUrl: ex.imageUrl!,
\n                        fit: BoxFit.cover,
\n                        placeholder: (context, url) => const Center(
\n                            child: SizedBox(
\n                                width: 15,
\n                                height: 15,
\n                                child: CircularProgressIndicator(
\n                                    strokeWidth: 2, color: Colors.white70))),
\n                        errorWidget: (context, url, error) => const Icon(
\n                            LucideIcons.dumbbell,
\n                            size: 16,
\n                            color: Colors.white70),
\n                      )
\n                    : const Icon(LucideIcons.dumbbell,
\n                        size: 16, color: Colors.white70),
\n              ),
\n              const SizedBox(width: 12),
\n              Expanded(
\n                child: Text(
\n                  ex.name,
\n                  style: GoogleFonts.outfit(
\n                    color: Colors.orange,
\n                    fontWeight: FontWeight.w700,
\n                    fontSize: 16,
\n                  ),
\n                  maxLines: 1,
\n                  overflow: TextOverflow.ellipsis,
\n                ),
\n              ),
\n              const Icon(LucideIcons.chevronRight, size: 14, color: Colors.white38),
\n            ],
\n          ),
\n        ),
\n      ),
\n    );
\n  }
\n}
