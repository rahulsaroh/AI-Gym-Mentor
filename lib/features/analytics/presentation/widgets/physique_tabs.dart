import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart' as ent;
import 'package:ai_gym_mentor/core/domain/entities/body_target.dart' as target;
import 'package:ai_gym_mentor/core/domain/entities/body_achievement.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/body_stats_log_screen.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/body_targets_log_screen.dart';

class PhysiqueHistoryTab extends StatefulWidget {
  final AsyncValue<List<ent.BodyMeasurement>> measurementsAsync;
  const PhysiqueHistoryTab({super.key, required this.measurementsAsync});

  @override
  State<PhysiqueHistoryTab> createState() => _PhysiqueHistoryTabState();
}

class _PhysiqueHistoryTabState extends State<PhysiqueHistoryTab> {
  String _selectedMetric = 'weight';
  final Map<String, ({String label, IconData icon, Color color})> _metrics = {
    'overall': (label: 'Overall', icon: LucideIcons.award, color: Colors.amber),
    'weight': (label: 'Weight', icon: LucideIcons.scale, color: Colors.blue),
    'bodyFat': (label: 'Body Fat', icon: LucideIcons.percent, color: Colors.orange),
    'chest': (label: 'Chest', icon: LucideIcons.ruler, color: Colors.teal),
    'waist': (label: 'Waist', icon: LucideIcons.ruler, color: Colors.red),
    'hips': (label: 'Hips', icon: LucideIcons.ruler, color: Colors.purple),
    'armLeft': (label: 'L-Arm', icon: LucideIcons.armchair, color: Colors.indigo),
    'armRight': (label: 'R-Arm', icon: LucideIcons.armchair, color: Colors.indigo),
    'thighLeft': (label: 'L-Thigh', icon: LucideIcons.footprints, color: Colors.green),
    'thighRight': (label: 'R-Thigh', icon: LucideIcons.footprints, color: Colors.green),
    'calfLeft': (label: 'L-Calf', icon: LucideIcons.footprints, color: Colors.brown),
  };

  @override
  Widget build(BuildContext context) {
    return widget.measurementsAsync.when(
      data: (data) {
        if (data.isEmpty) {
          return const CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyHistoryPlaceholder(),
              ),
            ],
          );
        }

        final grouped = _groupDataByMonth(data, _selectedMetric);
        
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                child: _MetricSelector(
                  selected: _selectedMetric,
                  metrics: {
                    'overall': _metrics['overall']!,
                    'weight': _metrics['weight']!,
                    'bodyFat': _metrics['bodyFat']!,
                  },
                  onChanged: (v) => setState(() => _selectedMetric = v),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      key: ValueKey(_selectedMetric),
                      height: 220,
                      child: _MetricChart(
                        data: data,
                        metric: _selectedMetric,
                        label: _metrics[_selectedMetric]!.label,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                    child: Row(
                      children: [
                        Text(
                          'Log History',
                          style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (grouped.isEmpty)
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: Text('No history for this metric', style: TextStyle(color: Colors.grey)),
                  ),
                ),
              )
            else
              ...grouped.entries.expand((entry) => [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _MonthHeaderDelegate(entry.key),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _MeasurementTile(
                            measurement: entry.value[index],
                            all: data,
                            selectedMetric: _selectedMetric,
                          ),
                          childCount: entry.value.length,
                        ),
                      ),
                    ),
                  ]),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, stack) => Center(child: Text('Error: $e')),
    );
  }

  Map<String, List<ent.BodyMeasurement>> _groupDataByMonth(List<ent.BodyMeasurement> data, String metric) {
    final Map<String, List<ent.BodyMeasurement>> groups = {};
    for (final m in data) {
      if (metric != 'overall' && extractMetricValue(m, metric) == null) continue;
      final dateStr = DateFormat('MMMM yyyy').format(m.date);
      if (!groups.containsKey(dateStr)) groups[dateStr] = [];
      groups[dateStr]!.add(m);
    }
    return groups;
  }
}

class _EmptyHistoryPlaceholder extends ConsumerWidget {
  const _EmptyHistoryPlaceholder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2), style: BorderStyle.none), // dashed concept
        ),
        child: Column(
          children: [
            Icon(LucideIcons.scale, size: 48, color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            const Text('No logs yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Your progress log is currently empty.', style: TextStyle(color: Theme.of(context).colorScheme.outline), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                // Relies on FAB for actual insertion.
              },
              icon: const Icon(LucideIcons.plus, size: 18),
              label: const Text('Log your first entry'),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () async {
                await ref.read(bodyMeasurementsListProvider.notifier).seedSampleData();
                if (context.mounted) {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sample measurement data seeded!')));
                }
              },
              icon: const Icon(LucideIcons.database, size: 16),
              label: const Text('Seed Sample Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 90.0;
  @override
  double get maxExtent => 90.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) => true;
}

class _MonthHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  _MonthHeaderDelegate(this.title);

  @override
  double get minExtent => 40.0;
  @override
  double get maxExtent => 40.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.centerLeft,
      child: Text(
        title.toUpperCase(),
        style: TextStyle(color: Theme.of(context).colorScheme.outline, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.2),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _MonthHeaderDelegate oldDelegate) => oldDelegate.title != title;
}


class PhysiqueStatsTab extends StatelessWidget {
  final AsyncValue<List<ent.BodyMeasurement>> measurementsAsync;
  const PhysiqueStatsTab({super.key, required this.measurementsAsync});

  @override
  Widget build(BuildContext context) {
    return measurementsAsync.when(
      data: (measurements) {
        if (measurements.isEmpty) return const _EmptyTabState(type: 'measurements');
        final latest = measurements.first;
        final previous = measurements.length > 1 ? measurements[1] : null;

        return ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            _LatestReadingCard(latest: latest),
            const SizedBox(height: 24),
            Text('Part Statistics', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...standardMetrics.map((config) {
              final val = extractMetricValue(latest, config.id);
              if (val == null) return const SizedBox.shrink();
              final prevVal = previous != null ? extractMetricValue(previous, config.id) : null;
              return _StatRow(config: config, value: val, prevValue: prevVal);
            }),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class PhysiqueTargetsTab extends StatelessWidget {
  const PhysiqueTargetsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final achievementAsync = ref.watch(physiqueAchievementProvider);
        return achievementAsync.when(
          data: (physique) {
            if (physique.achievements.isEmpty) return const _EmptyTabState(type: 'targets');
            return ListView(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              children: [
                _PhysiqueScoreCard(achievement: physique),
                const SizedBox(height: 24),
                Text('Active Goals', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ...physique.achievements.map((a) => _AchievementTile(achievement: a)),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        );
      },
    );
  }
}

// --- Helper Widgets migrated from BodyMeasurementsScreen ---

class _MetricSelector extends StatelessWidget {
  final String selected;
  final Map<String, ({String label, IconData icon, Color color})> metrics;
  final ValueChanged<String> onChanged;
  const _MetricSelector({required this.selected, required this.metrics, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: metrics.entries.map((e) {
          final isSelected = selected == e.key;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () => onChanged(e.key),
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                constraints: const BoxConstraints(minWidth: 120),
                decoration: BoxDecoration(
                  color: isSelected ? e.value.color : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isSelected
                      ? [BoxShadow(color: e.value.color.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))]
                      : [],
                  border: Border.all(color: isSelected ? e.value.color : Theme.of(context).dividerColor, width: 1.5),
                ),
                child: Row(
                  children: [
                    Icon(e.value.icon, size: 18, color: isSelected ? Colors.white : e.value.color),
                    const SizedBox(width: 8),
                    Text(
                      e.value.label,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MetricChart extends StatelessWidget {
  final List<ent.BodyMeasurement> data;
  final String metric;
  final String label;

  const _MetricChart({required this.data, required this.metric, required this.label});

  @override
  Widget build(BuildContext context) {
    final sortedData = List<ent.BodyMeasurement>.from(data)..sort((a, b) => a.date.compareTo(b.date));

    return Consumer(
      builder: (context, ref, _) {
        final targetsAsync = ref.watch(bodyTargetsListProvider);
        final targets = targetsAsync.maybeWhen(data: (t) => t, orElse: () => <target.BodyTarget>[]);
        final targetValue = targets.where((t) => t.metric == metric).firstOrNull?.targetValue;

        final List<FlSpot> spots;
        if (metric == 'overall') {
          spots = sortedData.asMap().entries.map((e) {
            final score = calculatePhysiqueScore(e.value, targets, sortedData).overallScore;
            return FlSpot(e.key.toDouble(), score * 100);
          }).toList();
        } else {
          spots = sortedData.asMap().entries
              .where((e) => extractMetricValue(e.value, metric) != null)
              .map((e) => FlSpot(e.key.toDouble(), extractMetricValue(e.value, metric)!))
              .toList();
        }

        if (spots.isEmpty) return const Center(child: Text('No history entries', style: TextStyle(color: Colors.grey)));

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E56A0), Color(0xFF163172)],
            ),
            boxShadow: [
              BoxShadow(color: const Color(0xFF1E56A0).withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.1,
                    child: CustomPaint(painter: _GridPainter()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 28, 12),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          color: const Color(0xFF4FC3F7),
                          barWidth: 4,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [const Color(0xFF4FC3F7).withValues(alpha: 0.3), const Color(0xFF4FC3F7).withValues(alpha: 0)],
                            ),
                          ),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (val, meta) => Text(
                              val.toStringAsFixed(0),
                              style: GoogleFonts.robotoMono(color: Colors.white60, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: false),
                      extraLinesData: ExtraLinesData(
                        horizontalLines: [
                          if (targetValue != null)
                            HorizontalLine(
                              y: targetValue,
                              color: Colors.white.withValues(alpha: 0.4),
                              strokeWidth: 1,
                              dashArray: [10, 5],
                              label: HorizontalLineLabel(
                                show: true,
                                alignment: Alignment.topRight,
                                padding: const EdgeInsets.only(right: 8, bottom: 8),
                                style: GoogleFonts.outfit(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                labelResolver: (_) => 'GOAL',
                              ),
                            ),
                        ],
                      ),
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (_) => const Color(0xFF1E56A0),
                          getTooltipItems: (touchedSpots) => touchedSpots.map((s) => LineTooltipItem(
                                '${s.y.toStringAsFixed(1)}${metric == 'overall' ? '%' : ''}',
                                GoogleFonts.robotoMono(color: Colors.white, fontWeight: FontWeight.bold),
                              )).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MeasurementTile extends StatelessWidget {
  final ent.BodyMeasurement measurement;
  final List<ent.BodyMeasurement> all;
  final String selectedMetric;
  const _MeasurementTile({required this.measurement, required this.all, required this.selectedMetric});

  @override
  Widget build(BuildContext context) {
    final val = extractMetricValue(measurement, selectedMetric);
    if (val == null) return const SizedBox.shrink();

    final index = all.indexOf(measurement);
    final prev = (index + 1 < all.length) ? all[index + 1] : null;
    final prevVal = prev != null ? extractMetricValue(prev, selectedMetric) : null;

    // Weight-loss = orange (down arrow is good here for weight metric)
    // For other metrics: green up = good
    Color trendColor = Colors.grey.shade600;
    IconData trendIcon = LucideIcons.minus;
    String deltaText = '';

    if (prevVal != null && (val - prevVal).abs() > 0.01) {
      final delta = val - prevVal;
      final isUp = delta > 0;
      // For weight and body fat, down is green; for measurements, up is green
      final isGood = (selectedMetric == 'weight' || selectedMetric == 'bodyFat') ? !isUp : isUp;
      trendColor = isGood ? const Color(0xFF4CAF50) : const Color(0xFFE53935);
      trendIcon = isUp ? LucideIcons.trendingUp : LucideIcons.trendingDown;
      deltaText = '${isUp ? '+' : ''}${delta.toStringAsFixed(1)}';
    }

    final unit = (selectedMetric == 'weight') ? 'kg'
        : (selectedMetric == 'bodyFat') ? '%'
        : 'cm';

    return Dismissible(
      key: ValueKey(measurement.date.toIso8601String() + selectedMetric),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red.shade700,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(LucideIcons.trash2, color: Colors.white),
      ),
      onDismissed: (_) {
        // TODO: wire to repository delete
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            // Trend circle icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: trendColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(trendIcon, size: 18, color: trendColor),
            ),
            const SizedBox(width: 14),
            // Date + delta
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMM d, yyyy').format(measurement.date),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  if (deltaText.isNotEmpty)
                    Text(
                      '$deltaText $unit from previous',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: trendColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  else
                    Text(
                      'First entry',
                      style: GoogleFonts.outfit(fontSize: 12, color: Theme.of(context).colorScheme.outline),
                    ),
                ],
              ),
            ),
            // Value + unit
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  val.toStringAsFixed(1),
                  style: GoogleFonts.robotoMono(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(unit, style: const TextStyle(fontSize: 12, color: Colors.white54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LatestReadingCard extends StatelessWidget {
  final ent.BodyMeasurement latest;
  const _LatestReadingCard({required this.latest});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Latest Entry', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 16)),
              const Icon(LucideIcons.calendar, color: Colors.white70, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(DateFormat('MMMM d, yyyy').format(latest.date),
              style: GoogleFonts.outfit(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final MetricConfig config;
  final double value;
  final double? prevValue;
  const _StatRow({required this.config, required this.value, this.prevValue});

  @override
  Widget build(BuildContext context) {
    final delta = prevValue != null ? value - prevValue! : null;
    Color deltaColor = Colors.grey;
    if (delta != null && delta.abs() > 0.01) {
      final isImprovement = config.lowerIsBetter ? delta < 0 : delta > 0;
      deltaColor = isImprovement ? Colors.green : Colors.red;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: config.assetPath != null
                ? Image.asset(config.assetPath!,
                    width: 32, height: 32, errorBuilder: (ctx, err, st) => const Icon(LucideIcons.activity))
                : const Icon(LucideIcons.activity, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(config.label, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(config.unit, style: GoogleFonts.outfit(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$value', style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold, fontSize: 20)),
              if (delta != null && delta.abs() > 0.01)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(delta > 0 ? LucideIcons.trendingUp : LucideIcons.trendingDown, size: 14, color: deltaColor),
                    const SizedBox(width: 4),
                    Text('${delta > 0 ? '+' : ''}${delta.toStringAsFixed(1)}',
                        style: GoogleFonts.robotoMono(fontSize: 12, fontWeight: FontWeight.bold, color: deltaColor)),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PhysiqueScoreCard extends StatelessWidget {
  final PhysiqueAchievement achievement;
  const _PhysiqueScoreCard({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final score = (achievement.overallScore * 100).toInt();
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade400, Colors.orange.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.3),
            blurRadius: 25,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  value: achievement.overallScore,
                  strokeWidth: 8,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              Text('$score%', style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Physique Score',
                    style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  score >= 90 ? 'Legendary Progress! 👑' : (score > 70 ? 'Amazing Gaps! 🔥' : 'Keep Pushing! 💪'),
                  style: GoogleFonts.outfit(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  final MetricAchievement achievement;
  const _AchievementTile({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final progress = achievement.percentage.clamp(0.0, 1.0);
    // Determine color based on progress - using a soft green like the image
    final Color accentColor = const Color(0xFF2E7D32); // Darker green for text
    final Color barColor = const Color(0xFF66BB6A); // Lighter green for bar

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Grid Pattern
          Positioned(
            right: 20,
            top: 10,
            child: Opacity(
              opacity: 0.08,
              child: _DotGrid(rows: 3, cols: 6),
            ),
          ),
          Positioned(
            left: 60,
            bottom: 40,
            child: Opacity(
              opacity: 0.08,
              child: _DotGrid(rows: 2, cols: 4),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // Top Row: Icon, Label, Percentage
                Row(
                  children: [
                    // Glassy Icon Container
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.green.withValues(alpha: 0.15),
                            Colors.green.withValues(alpha: 0.05),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withValues(alpha: 0.08),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(LucideIcons.target, size: 22, color: accentColor),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        achievement.label,
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      '${(achievement.percentage * 100).toInt()}%',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Metrics Row with Dividers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _MetricMiniLabel(label: 'Start', value: '${achievement.startValue}')),
                    _VerticalDivider(),
                    Expanded(child: _MetricMiniLabel(label: 'Current', value: '${achievement.currentValue}', isCentered: true)),
                    _VerticalDivider(),
                    Expanded(child: _MetricMiniLabel(label: 'Goal', value: '${achievement.targetValue}', isGoal: true)),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Custom Gradient Progress Bar
                Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [barColor.withValues(alpha: 0.6), barColor],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: barColor.withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DotGrid extends StatelessWidget {
  final int rows;
  final int cols;
  const _DotGrid({required this.rows, required this.cols});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(rows, (r) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(cols, (c) => Container(
          width: 3,
          height: 3,
          margin: const EdgeInsets.all(2),
          decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
        )),
      )),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 1,
      color: Colors.grey.shade200,
    );
  }
}

class _MetricMiniLabel extends StatelessWidget {
  final String label;
  final String value;
  final bool isGoal;
  final bool isCentered;
  const _MetricMiniLabel({
    required this.label,
    required this.value,
    this.isGoal = false,
    this.isCentered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 11,
            color: Colors.blueGrey.shade300,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isGoal ? const Color(0xFF0D47A1) : const Color(0xFF2D3142),
          ),
        ),
      ],
    );
  }
}

class _EmptyTabState extends ConsumerWidget {
  final String type;
  const _EmptyTabState({required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTargets = type == 'targets';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isTargets ? LucideIcons.target : LucideIcons.listTodo, size: 80, color: Colors.grey.shade200),
          const SizedBox(height: 24),
          Text(isTargets ? 'No active goals set' : 'Your journal is empty',
              style: GoogleFonts.outfit(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(isTargets ? 'Start by setting a physique target' : 'Log your first measurements to see progress',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(color: Colors.grey.shade400, fontSize: 14)),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => isTargets ? const BodyTargetsLogScreen() : const BodyStatsLogScreen())),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: Text(isTargets ? 'Set Your First Goal' : 'Start Logging'),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () async {
              if (isTargets) {
                await ref.read(bodyTargetsListProvider.notifier).seedSampleTargets();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sample targets seeded!')));
                }
              } else {
                await ref.read(bodyMeasurementsListProvider.notifier).seedSampleData();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sample measurement data seeded!')));
                }
              }
            },
            icon: Icon(isTargets ? LucideIcons.target : LucideIcons.database, size: 16),
            label: Text(isTargets ? 'Seed Sample Targets' : 'Seed Sample Measurements'),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..strokeWidth = 1;

    const spacing = 40.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
