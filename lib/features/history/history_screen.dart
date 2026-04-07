import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/core/widgets/skeleton_card.dart';
import 'package:gym_gemini_pro/core/widgets/number_ticker.dart';
import 'package:gym_gemini_pro/features/history/history_providers.dart';
import 'package:gym_gemini_pro/features/settings/settings_provider.dart';
import 'package:gym_gemini_pro/core/utils/weight_converter.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:gym_gemini_pro/features/settings/models/settings_state.dart';
import 'package:go_router/go_router.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(historyListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(historyStatsProvider);
    final historyAsync = ref.watch(historyListProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar.large(
            title: const Text('History'),
            floating: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: statsAsync.when(
              data: (stats) => _HistoryHeaderStats(stats: stats),
              loading: () => const _StatsLoadingPlaceholder(),
              error: (e, s) => const SizedBox.shrink(),
            ),
          ),
          const SliverToBoxAdapter(child: _HeatmapHeader()),
          const SliverToBoxAdapter(child: _HeatmapCalendar()),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'Recent Workouts',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          historyAsync.when(
            data: (workouts) {
              if (workouts.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text('No workouts logged yet.')),
                );
              }
              return _WorkoutSliverList(workouts: workouts);
            },
            loading: () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, __) => const SkeletonCard(height: 100, margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6)),
                childCount: 6,
              ),
            ),
            error: (e, s) => SliverFillRemaining(
              child: Center(child: Text('Error: $e')),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
}

class _HistoryHeaderStats extends StatelessWidget {
  final Map<String, dynamic> stats;
  const _HistoryHeaderStats({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.2,
        children: [
          _StatChip(
            label: 'Current Streak',
            value: (stats['currentStreak'] as num).toDouble(),
            icon: LucideIcons.flame,
            color: Colors.orange,
          ),
          _StatChip(
            label: 'Longest Streak',
            value: (stats['longestStreak'] as num).toDouble(),
            icon: LucideIcons.award,
            color: Colors.purple,
          ),
          _StatChip(
            label: 'Total Workouts',
            value: (stats['totalWorkouts'] as num).toDouble(),
            icon: LucideIcons.dumbbell,
            color: Colors.blue,
          ),
          _StatChip(
            label: 'Total Volume',
            value: (stats['totalVolume'] as num).toDouble(),
            icon: LucideIcons.trendingUp,
            color: const Color(0xFF10B981),
            isVolume: true,
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final double value;
  final IconData icon;
  final Color color;
  final bool isVolume;

  const _StatChip({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.isVolume = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberTicker(
                  value: value,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  decimalPlaces: 0,
                  suffix: isVolume && value >= 1000 ? 'kg' : (isVolume ? ' kg' : ''),
                ),
                Text(label, style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.outline)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeatmapHeader extends StatelessWidget {
  const _HeatmapHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _IntensityKey(label: 'Less', color: Colors.transparent),
                _IntensityKey(color: Color(0xFFBBDEFB)), // Lightest Blue
                _IntensityKey(color: Color(0xFF64B5F6)), // Light Blue
                _IntensityKey(color: Color(0xFF1E88E5)), // Blue
                _IntensityKey(color: Color(0xFF0D47A1)), // Dark Blue
                _IntensityKey(label: 'More', color: Colors.transparent),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IntensityKey extends StatelessWidget {
  final String? label;
  final Color color;
  const _IntensityKey({this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(label!, style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.outline)),
      );
    }
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
    );
  }
}

class _HeatmapCalendar extends ConsumerWidget {
  const _HeatmapCalendar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setsAsync = ref.watch(heatmapSetsProvider);

    return setsAsync.when(
      data: (sets) {
        final activityMap = _processHeatmapData(sets);
        return SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            reverse: true, // Show current month first
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 13, // 12 months + extra buffer
            itemBuilder: (context, index) {
              final monthDate = DateTime.now().subtract(Duration(days: 30 * index));
              return _MonthGrid(
                year: monthDate.year,
                month: monthDate.month,
                activityMap: activityMap,
              );
            },
          ),
        );
      },
      loading: () => const SizedBox(height: 140),
      error: (e, s) => const SizedBox.shrink(),
    );
  }

  Map<DateTime, double> _processHeatmapData(List<WorkoutSet> sets) {
    final Map<DateTime, double> map = {};
    for (var s in sets) {
      if (s.completedAt == null) continue;
      final day = DateTime(s.completedAt!.year, s.completedAt!.month, s.completedAt!.day);
      map[day] = (map[day] ?? 0) + (s.weight * s.reps);
    }
    return map;
  }
}

class _MonthGrid extends StatelessWidget {
  final int year;
  final int month;
  final Map<DateTime, double> activityMap;

  const _MonthGrid({required this.year, required this.month, required this.activityMap});

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(year, month);
    final firstDay = DateTime(year, month, 1);
    final monthLabel = DateFormat.MMMM().format(firstDay);
    final today = DateTime.now();
    final isCurrentMonth = today.year == year && today.month == month;

    return Container(
      width: 130, // Approximate width for 7 columns
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$monthLabel $year', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isCurrentMonth ? Colors.orange : null)),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
              ),
              itemCount: daysInMonth,
              itemBuilder: (context, index) {
                final date = DateTime(year, month, index + 1);
                final volume = activityMap[date] ?? 0;
                final isToday = today.year == date.year && today.month == date.month && today.day == date.day;

                return Container(
                  decoration: BoxDecoration(
                    color: _getColorForVolume(volume),
                    borderRadius: BorderRadius.circular(2),
                    border: isToday ? Border.all(color: Colors.orange, width: 1.5) : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForVolume(double volume) {
    if (volume == 0) return Colors.grey.withOpacity(0.1);
    if (volume < 1000) return const Color(0xFFBBDEFB);
    if (volume < 5000) return const Color(0xFF64B5F6);
    if (volume < 10000) return const Color(0xFF1E88E5);
    return const Color(0xFF0D47A1);
  }
}

class _WorkoutSliverList extends ConsumerWidget {
  final List<HistoryItem> workouts;
  const _WorkoutSliverList({required this.workouts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = workouts[index];
          final workout = item.workout;
          // Simple grouping by inserting headers (ideally pre-computed)
          bool showHeader = false;
          String headerText = '';
          
          final date = workout.date;
          if (index == 0) {
            showHeader = true;
            headerText = _getGroupLabel(date);
          } else {
            final prevDate = workouts[index - 1].workout.date;
            if (date.month != prevDate.month || date.year != prevDate.year) {
              showHeader = true;
              headerText = _getGroupLabel(date);
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showHeader)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(headerText, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              _WorkoutCard(item: item),
            ],
          );
        },
        childCount: workouts.length,
      ),
    );
  }

  String _getGroupLabel(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month) {
      if (DateUtils.isSameDay(date, now)) return 'Today';
      return 'This Month';
    }
    return DateFormat.yMMMM().format(date);
  }
}

class _WorkoutCard extends ConsumerWidget {
  final HistoryItem item;
  const _WorkoutCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workout = item.workout;
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();
    final unit = settings.weightUnit;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Slidable(
        key: ValueKey('history_slide_${workout.id}'),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (_) async {
                final confirm = await _showDeleteConfirmation(context);
                if (confirm == true) {
                  ref.read(historyListProvider.notifier).deleteWorkout(workout.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Workout deleted')),
                    );
                  }
                }
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: LucideIcons.trash2,
              label: 'Delete',
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
            ),
          ],
        ),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Session duplicated')),
                );
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: LucideIcons.copy,
              label: 'Duplicate',
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            ),
          ],
        ),
        child: Card(
          child: InkWell(
            onTap: () => context.push('/history/workout/${workout.id}'),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                              DateFormat('EEE, MMM d').format(workout.date),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Hero(
                              tag: 'workout_${workout.id}',
                              child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  workout.name,
                                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(LucideIcons.chevronRight, size: 16),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      Expanded(child: _CompactStat(icon: LucideIcons.clock, label: _formatDuration(workout.duration ?? 0))),
                      const SizedBox(width: 8),
                      Expanded(child: _CompactStat(icon: LucideIcons.trendingUp, label: WeightConverter.format(item.volume, unit, decimals: 0))),
                      const SizedBox(width: 8),
                      Expanded(child: _CompactStat(icon: LucideIcons.layers, label: '${item.setCount} sets')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    if (seconds < 60) return '${seconds}s';
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (remainingSeconds == 0) return '${minutes}m';
    return '${minutes}m ${remainingSeconds}s';
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Workout?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}

class _CompactStat extends StatelessWidget {
  final IconData icon;
  final String label;
  const _CompactStat({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Theme.of(context).colorScheme.outline),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline)),
      ],
    );
  }
}

class _StatsLoadingPlaceholder extends StatelessWidget {
  const _StatsLoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.2,
        children: const [
          SkeletonCard(height: 60, margin: EdgeInsets.zero),
          SkeletonCard(height: 60, margin: EdgeInsets.zero),
          SkeletonCard(height: 60, margin: EdgeInsets.zero),
          SkeletonCard(height: 60, margin: EdgeInsets.zero),
        ],
      ),
    );
  }
}
