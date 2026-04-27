import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ai_gym_mentor/core/domain/entities/logged_set.dart' as ent;
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:ai_gym_mentor/core/widgets/skeleton_card.dart';
import 'package:ai_gym_mentor/core/widgets/number_ticker.dart';
import 'package:ai_gym_mentor/features/history/history_providers.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/core/utils/weight_converter.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/services/export_service.dart';
import 'package:ai_gym_mentor/core/widgets/bouncing_card.dart';
import 'package:google_fonts/google_fonts.dart';

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
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
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
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar.large(
            title: const Text('History'),
            floating: true,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(LucideIcons.share2),
                onPressed: () => _showExportMenu(context),
              ),
              const SizedBox(width: 8),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextField(
                  onChanged: (val) {
                    ref.read(historyFilterStateProvider.notifier).updateFilter(
                          (s) => s.copyWith(searchQuery: val),
                        );
                  },
                  decoration: InputDecoration(
                    hintText: 'Search workouts...',
                    prefixIcon: const Icon(LucideIcons.search, size: 20),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _FilterSection(),
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
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.history,
                              size: 64,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.2)),
                          const SizedBox(height: 16),
                          Text(
                            'Your fitness journey starts here!',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Log your first workout to see your progress history and volume trends.',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.outline),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          FilledButton.icon(
                            onPressed: () => context.go('/'),
                            icon: const Icon(LucideIcons.play),
                            label: const Text('Start Workout'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return _WorkoutSliverList(workouts: workouts);
            },
            loading: () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, _) => const SkeletonCard(
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6)),
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

  void _showExportMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  const Icon(LucideIcons.download, size: 20),
                  const SizedBox(width: 12),
                  Text('Export History',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading:
                  const Icon(LucideIcons.fileSpreadsheet, color: Colors.green),
              title: const Text('Export as CSV'),
              subtitle: const Text('Best for Excel or Google Sheets'),
              onTap: () {
                Navigator.pop(context);
                ref.read(exportServiceProvider).exportToCsv();
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.fileText, color: Colors.red),
              title: const Text('Export as PDF'),
              subtitle: const Text('Professional training report'),
              onTap: () {
                Navigator.pop(context);
                ref.read(exportServiceProvider).exportToPdf();
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _FilterSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(historyFilterStateProvider);
    final muscles = [
      'Chest',
      'Back',
      'Shoulders',
      'Biceps',
      'Triceps',
      'Legs',
      'Abs',
      'Full Body'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              FilterChip(
                label: const Text('All'),
                selected: (filter.muscleGroups?.isEmpty ?? true) &&
                    filter.templateId == null,
                onSelected: (_) {
                  ref.read(historyFilterStateProvider.notifier).updateFilter(
                        (s) => const HistoryFilter(),
                      );
                },
              ),
              const SizedBox(width: 8),
              ...muscles.map((m) {
                final isSelected = filter.muscleGroups?.contains(m) ?? false;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(m),
                    selected: isSelected,
                    onSelected: (selected) {
                      final current =
                          List<String>.from(filter.muscleGroups ?? []);
                      if (selected) {
                        current.add(m);
                      } else {
                        current.remove(m);
                      }
                      ref
                          .read(historyFilterStateProvider.notifier)
                          .updateFilter(
                            (s) => s.copyWith(muscleGroups: current),
                          );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ],
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  decimalPlaces: 0,
                  suffix: isVolume && value >= 1000
                      ? 'kg'
                      : (isVolume ? ' kg' : ''),
                ),
                Text(label,
                    style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.outline)),
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
          Text('Activity',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
        child: Text(label!,
            style: TextStyle(
                fontSize: 10, color: Theme.of(context).colorScheme.outline)),
      );
    }
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
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
        // Cast to dynamic to resolve analyzer error until build_runner is executed
        final activityMap = _processHeatmapData(sets as dynamic);
        return SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            reverse: true, // Show current month first
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 13, // 12 months + extra buffer
            itemBuilder: (context, index) {
              final monthDate =
                  DateTime.now().subtract(Duration(days: 30 * index));
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

  Map<DateTime, double> _processHeatmapData(List<ent.LoggedSet> sets) {
    final Map<DateTime, double> map = {};
    for (var s in sets) {
      if (s.completedAt == null) continue;
      final day = DateTime(
          s.completedAt!.year, s.completedAt!.month, s.completedAt!.day);
      map[day] = (map[day] ?? 0) + (s.weight * s.reps);
    }
    return map;
  }
}

class _MonthGrid extends StatelessWidget {
  final int year;
  final int month;
  final Map<DateTime, double> activityMap;

  const _MonthGrid(
      {required this.year, required this.month, required this.activityMap});

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
          Text('$monthLabel $year',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isCurrentMonth ? Colors.orange : null)),
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
                final isToday = today.year == date.year &&
                    today.month == date.month &&
                    today.day == date.day;

                return Container(
                  decoration: BoxDecoration(
                    color: _getColorForVolume(volume),
                    borderRadius: BorderRadius.circular(2),
                    border: isToday
                        ? Border.all(color: Colors.orange, width: 1.5)
                        : null,
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
                  child: Text(headerText,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
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
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          extentRatio: 0.5,
          children: [
            SlidableAction(
              onPressed: (_) async {
                final nameController = TextEditingController(text: workout.name);
                final name = await showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Save as Template'),
                    content: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Template Name'),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                      TextButton(onPressed: () => Navigator.pop(context, nameController.text), child: const Text('Save')),
                    ],
                  ),
                );
                if (name != null && context.mounted) {
                  await ref.read(workoutRepositoryProvider).saveWorkoutAsTemplate(workout.id, name);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saved as reusable template')),
                  );
                }
              },
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              icon: LucideIcons.layoutTemplate,
              label: 'As Template',
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            ),
            SlidableAction(
              onPressed: (_) async {
                await ref.read(workoutRepositoryProvider).repeatWorkout(workout.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Session duplicated to draft')),
                  );
                  context.go('/'); 
                }
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: LucideIcons.copy,
              label: 'Repeat',
            ),
          ],
        ),
        child: BouncingCard(
          onTap: () => context.push('/history/workout/${workout.id}'),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.05),
              ),
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
                            DateFormat('EEEE, MMM d').format(workout.date),
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Hero(
                            tag: 'workout_${workout.id}',
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                workout.name,
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      LucideIcons.chevronRight, 
                      size: 16, 
                      color: theme.colorScheme.outline.withValues(alpha: 0.5)
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: _CompactStat(
                              icon: LucideIcons.clock,
                              label: _formatDuration(workout.duration ?? 0))),
                      Container(width: 1, height: 16, color: theme.dividerColor.withValues(alpha: 0.1)),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _CompactStat(
                              icon: LucideIcons.trendingUp,
                              label: WeightConverter.format(item.volume, unit,
                                  decimals: 0))),
                      Container(width: 1, height: 16, color: theme.dividerColor.withValues(alpha: 0.1)),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _CompactStat(
                              icon: LucideIcons.layers,
                              label: '${item.setCount} sets')),
                    ],
                  ),
                ),
              ],
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
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete', style: TextStyle(color: Colors.red))),
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
        Expanded(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12, color: Theme.of(context).colorScheme.outline),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
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
