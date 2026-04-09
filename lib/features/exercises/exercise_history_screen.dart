import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/exercises/exercise_history_provider.dart';
import 'package:ai_gym_mentor/features/exercises/exercises_provider.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ExerciseHistoryScreen extends ConsumerStatefulWidget {
  final int exerciseId;
  const ExerciseHistoryScreen({super.key, required this.exerciseId});

  @override
  ConsumerState<ExerciseHistoryScreen> createState() =>
      _ExerciseHistoryScreenState();
}

class _ExerciseHistoryScreenState extends ConsumerState<ExerciseHistoryScreen> {
  Duration _range = const Duration(days: 180); // 6 months default

  @override
  Widget build(BuildContext context) {
    final exerciseAsync = ref.watch(allExercisesProvider);
    final statsAsync = ref.watch(exerciseStatsProvider(widget.exerciseId));
    final historyAsync = ref.watch(exerciseHistoryProvider(widget.exerciseId));
    final chartDataAsync =
        ref.watch(exerciseChartDataProvider(widget.exerciseId, _range));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: exerciseAsync.when(
          data: (exs) =>
              Text(exs.firstWhere((e) => e.id == widget.exerciseId).name),
          loading: () => const Text('History'),
          error: (_, __) => const Text('Error'),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: statsAsync.when(
              data: (stats) => _BestStatsCard(stats: stats),
              loading: () => const SizedBox(height: 100),
              error: (e, s) => Text('Error: $e'),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Progress Trend',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      _RangeSelector(
                        current: _range,
                        onChanged: (val) => setState(() => _range = val),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  historyAsync.when(
                    data: (sessions) {
                      if (sessions.length < 2) return const SizedBox.shrink();
                      final latest = sessions.first['sets'] as List<WorkoutSet>;
                      final oldest = sessions.last['sets'] as List<WorkoutSet>;
                      if (latest.isEmpty || oldest.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      final latest1RM = latest
                          .map((s) => s.weight * (1 + s.reps / 30))
                          .reduce((a, b) => a > b ? a : b);
                      final oldest1RM = oldest
                          .map((s) => s.weight * (1 + s.reps / 30))
                          .reduce((a, b) => a > b ? a : b);
                      final diff = latest1RM - oldest1RM;

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: diff > 0
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: diff > 0
                                  ? Colors.green.withValues(alpha: 0.3)
                                  : Colors.grey.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                                diff > 0
                                    ? LucideIcons.trendingUp
                                    : LucideIcons.minus,
                                size: 16,
                                color: diff > 0 ? Colors.green : Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                diff > 0
                                    ? "You've gained ~${diff.toStringAsFixed(1)}kg est. 1RM over this period"
                                    : "No significant 1RM gain detected in this range",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        diff > 0 ? Colors.green : Colors.grey),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 250,
                    child: chartDataAsync.when(
                      data: (data) => _ProgressLineChart(data: data),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, s) => Center(child: Text('Chart Error: $e')),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text('Session History',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          historyAsync.when(
            data: (sessions) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _SessionCard(
                  session: sessions[index],
                  previousSession:
                      index + 1 < sessions.length ? sessions[index + 1] : null,
                ),
                childCount: sessions.length,
              ),
            ),
            loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator())),
            error: (e, s) =>
                SliverFillRemaining(child: Center(child: Text('Error: $e'))),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 50)),
        ],
      ),
    );
  }
}

class _BestStatsCard extends StatelessWidget {
  final Map<String, dynamic> stats;
  const _BestStatsCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1)
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                  label: 'Max Weight', value: '${stats['maxWeight'] ?? 0}kg'),
              _StatItem(label: 'Max Reps', value: '${stats['maxReps'] ?? 0}'),
              _StatItem(
                  label: 'Best 1RM',
                  value: '${(stats['best1RM'] ?? 0).toStringAsFixed(1)}kg'),
            ],
          ),
          const Divider(height: 32),
          Text('Total Sets Logged: ${stats['totalSets'] ?? 0}',
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Text(label,
            style: TextStyle(
                fontSize: 10, color: Theme.of(context).colorScheme.outline)),
      ],
    );
  }
}

class _RangeSelector extends StatelessWidget {
  final Duration current;
  final ValueChanged<Duration> onChanged;

  const _RangeSelector({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _RangeBtn(
            label: '1M',
            active: current.inDays == 30,
            onTap: () => onChanged(const Duration(days: 30))),
        _RangeBtn(
            label: '3M',
            active: current.inDays == 90,
            onTap: () => onChanged(const Duration(days: 90))),
        _RangeBtn(
            label: '6M',
            active: current.inDays == 180,
            onTap: () => onChanged(const Duration(days: 180))),
        _RangeBtn(
            label: 'All',
            active: current.inDays > 1000,
            onTap: () => onChanged(const Duration(days: 365 * 10))),
      ],
    );
  }
}

class _RangeBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _RangeBtn(
      {required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: const EdgeInsets.only(left: 4),
        decoration: BoxDecoration(
          color: active
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: active ? Colors.white : null)),
      ),
    );
  }
}

class _ProgressLineChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const _ProgressLineChart({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const Center(child: Text('Not enough data yet.'));

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (val, meta) {
                if (data.length < 2) return const SizedBox.shrink();
                if (val.toInt() % (data.length ~/ 3 + 1) == 0) {
                  final d = data[val.toInt()]['date'] as DateTime;
                  return Text(DateFormat('MM/dd').format(d),
                      style: const TextStyle(fontSize: 10));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: data
                .asMap()
                .entries
                .map((e) => FlSpot(e.key.toDouble(), e.value['rm']))
                .toList(),
            isCurved: true,
            color: Theme.of(context).colorScheme.primary,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final Map<String, dynamic> session;
  final Map<String, dynamic>? previousSession;
  const _SessionCard({required this.session, this.previousSession});

  @override
  Widget build(BuildContext context) {
    final rawSets = session['sets'] as List<dynamic>;
    final sets = rawSets.cast<WorkoutSet>();
    if (sets.isEmpty) return const SizedBox.shrink();

    final topSet =
        sets.reduce((curr, next) => curr.weight > next.weight ? curr : next);
    final volume = sets.fold(0.0, (a, b) => a + (b.weight * b.reps));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            DateFormat('MMM d, yyyy')
                                .format(session['date'] as DateTime),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          session['workoutName'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.outline),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${volume.toStringAsFixed(0)}kg total',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
              const Divider(height: 20),
              Row(
                children: [
                  const Icon(LucideIcons.trendingUp,
                      size: 14, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    'Best: ${topSet.weight}kg x ${topSet.reps.toInt()} reps',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  _buildTrendIndicator(topSet),
                  const SizedBox(width: 8),
                  Text(
                      '1RM: ${(topSet.weight * (1 + topSet.reps / 30)).toStringAsFixed(1)}kg',
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendIndicator(WorkoutSet currentTop) {
    if (previousSession == null) return const SizedBox.shrink();

    final prevSets = previousSession!['sets'] as List<WorkoutSet>;
    if (prevSets.isEmpty) return const SizedBox.shrink();

    final current1RM = currentTop.weight * (1 + currentTop.reps / 30);
    final prevTop = prevSets.reduce((a, b) =>
        (a.weight * (1 + a.reps / 30)) > (b.weight * (1 + b.reps / 30))
            ? a
            : b);
    final prev1RM = prevTop.weight * (1 + prevTop.reps / 30);

    if (current1RM > prev1RM * 1.01) {
      return const Icon(LucideIcons.arrowUp, size: 14, color: Colors.green);
    } else if (current1RM < prev1RM * 0.99) {
      return const Icon(LucideIcons.arrowDown, size: 14, color: Colors.red);
    }
    return const Icon(LucideIcons.minus, size: 14, color: Colors.grey);
  }
}
