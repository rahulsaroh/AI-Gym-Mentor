import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_gemini_pro/core/widgets/number_ticker.dart';
import 'package:gym_gemini_pro/core/widgets/skeleton_card.dart';
import 'package:gym_gemini_pro/features/analytics/analytics_providers.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnalyticsDashboardScreen extends ConsumerWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    final alertsAsync = ref.watch(plateauAlertsProvider);
    final prsAsync = ref.watch(recentPRsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.scale),
            onPressed: () => context.push('/analytics/measurements'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardStatsProvider);
          ref.invalidate(volumeTrendProvider);
          ref.invalidate(frequencyTrendProvider);
          ref.invalidate(muscleBalanceProvider);
          ref.invalidate(plateauAlertsProvider);
          ref.invalidate(recentPRsProvider);
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Overview Stats Row
              statsAsync.when(
                data: (stats) => _OverviewRow(stats: stats),
                loading: () => const _SkeletonRow(),
                error: (e, _) => const SizedBox.shrink(),
              ),

              // 2. Weekly Volume Trend
              _SectionHeader(title: 'Weekly Volume Trend', subtitle: 'Last 12 weeks'),
              _LazyChart(
                builder: (ref) => ref.watch(volumeTrendProvider).when(
                  data: (data) => _VolumeChart(data: data),
                  loading: () => const _SkeletonChart(),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),

              // 3. Workout Frequency
              _SectionHeader(title: 'Workout Frequency', subtitle: 'Target: 4 sessions/week'),
              _LazyChart(
                builder: (ref) => ref.watch(frequencyTrendProvider).when(
                  data: (data) => _FrequencyChart(data: data, target: 4),
                  loading: () => const _SkeletonChart(),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),

              // 4. Muscle Group Balance
              _SectionHeader(title: 'Muscle Balance', subtitle: 'This month vs Last month'),
              _LazyChart(
                height: 300,
                builder: (ref) => ref.watch(muscleBalanceProvider).when(
                  data: (data) => _MuscleRadarChart(data: data),
                  loading: () => const _SkeletonChart(height: 300),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),

              // 5. Plateau Alerts
              alertsAsync.when(
                data: (alerts) => alerts.isNotEmpty 
                  ? _PlateauSection(alerts: alerts)
                  : const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),

              // 6. Recent PRs
              _SectionHeader(
                title: 'Recent Records', 
                subtitle: 'Last 30 days',
                onTrailingTap: () => context.push('/analytics/prs'),
                trailingLabel: 'View All',
              ),
              prsAsync.when(
                data: (prs) => _RecentPRsCarousel(prs: prs),
                loading: () => const _SkeletonRow(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTrailingTap;
  final String? trailingLabel;

  const _SectionHeader({
    required this.title, 
    required this.subtitle, 
    this.onTrailingTap,
    this.trailingLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(subtitle, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline)),
            ],
          ),
          if (onTrailingTap != null)
            TextButton(
              onPressed: onTrailingTap,
              child: Text(trailingLabel ?? 'More'),
            ),
        ],
      ),
    );
  }
}

class _OverviewRow extends StatelessWidget {
  final Map<String, dynamic> stats;
  const _OverviewRow({required this.stats});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _StatCard(
            label: 'This Month',
            numericValue: (stats['monthlyVolume'] as num).toDouble() / 1000,
            suffix: 'T',
            icon: LucideIcons.trendingUp,
            color: Colors.blue,
          ),
          _StatCard(
            label: 'Workouts',
            numericValue: (stats['workoutCount'] as num).toDouble(),
            icon: LucideIcons.calendarDays,
            color: Colors.orange,
          ),
          _StatCard(
            label: 'Avg Duration',
            numericValue: (stats['avgDuration'] as num).toDouble(),
            suffix: 'm',
            icon: LucideIcons.clock,
            color: Colors.purple,
          ),
          _StatCard(
            label: 'Active Streak',
            numericValue: 5,
            suffix: '🔥',
            icon: LucideIcons.flame,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final double numericValue;
  final String suffix;
  final IconData icon;
  final Color color;

  const _StatCard({required this.label, required this.numericValue, required this.icon, required this.color, this.suffix = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 12),
          NumberTicker(
            value: numericValue,
            suffix: suffix,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _VolumeChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const _VolumeChart({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const _EmptyChartTip(message: 'Log some workouts to see volume trends.');

    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value['volume'] / 1000)).toList(),
              isCurved: true,
              color: Theme.of(context).colorScheme.primary,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: true, color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 3, // Shows every 3 weeks
                getTitlesWidget: (val, meta) {
                  if (val.toInt() >= data.length) return const SizedBox.shrink();
                  final date = data[val.toInt()]['date'] as DateTime;
                  return Text(DateFormat('MM/dd').format(date), style: const TextStyle(fontSize: 10));
                },
              ),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

class _FrequencyChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final int target;
  const _FrequencyChart({required this.data, required this.target});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BarChart(
        BarChartData(
          barGroups: data.asMap().entries.map((e) {
            final count = (e.value['count'] as num).toDouble();
            return BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: count,
                  color: count >= target ? Colors.green : Colors.orange,
                  width: 16,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (val, meta) {
                   if (val.toInt() >= data.length || val.toInt() % 4 != 0) return const SizedBox.shrink();
                   final date = data[val.toInt()]['date'] as DateTime;
                   return Text(DateFormat('MM/dd').format(date), style: const TextStyle(fontSize: 10));
                },
              ),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

class _MuscleRadarChart extends StatelessWidget {
  final Map<String, dynamic> data;
  const _MuscleRadarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final labels = data['labels'] as List<String>;
    final thisMonth = data['thisMonth'] as List<double>;
    final lastMonth = data['lastMonth'] as List<double>;

    // Find max value for normalization
    double maxVal = ([...thisMonth, ...lastMonth]).reduce((a, b) => a > b ? a : b);
    if (maxVal == 0) maxVal = 1;

    return Column(
      children: [
        SizedBox(
          height: 300,
          child: RadarChart(
            RadarChartData(
              dataSets: [
                RadarDataSet(
                  dataEntries: lastMonth.map((v) => RadarEntry(value: v / maxVal)).toList(),
                  borderColor: Colors.blue.withOpacity(0.5),
                  fillColor: Colors.blue.withOpacity(0.1),
                ),
                RadarDataSet(
                  dataEntries: thisMonth.map((v) => RadarEntry(value: v / maxVal)).toList(),
                  borderColor: Theme.of(context).colorScheme.primary,
                  fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  entryRadius: 3,
                ),
              ],
              getTitle: (index, angle) => RadarChartTitle(text: labels[index], angle: angle),
              tickCount: 3,
              ticksTextStyle: const TextStyle(color: Colors.transparent),
              gridBorderData: BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 1),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LegendItem(label: 'Last Month', color: Colors.blue.withOpacity(0.5)),
            const SizedBox(width: 24),
            _LegendItem(label: 'This Month', color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  const _LegendItem({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _PlateauSection extends StatelessWidget {
  final List<Map<String, dynamic>> alerts;
  const _PlateauSection({required this.alerts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 18),
              SizedBox(width: 8),
              Text('Progression Alerts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alert['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(alert['suggestion'], style: const TextStyle(fontSize: 13, color: Colors.black87)),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {}, // TODO: Dismiss logic
                          child: const Text('Dismiss', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RecentPRsCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> prs;
  const _RecentPRsCarousel({required this.prs});

  @override
  Widget build(BuildContext context) {
    if (prs.isEmpty) return const _EmptyChartTip(message: 'New Personal Records will appear here!');

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: prs.length,
        itemBuilder: (context, index) {
          final pr = prs[index];
          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue.shade800, Colors.blue.shade600]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(pr['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(pr['value'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(DateFormat('MMM d').format(pr['date']), style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SkeletonRow extends StatelessWidget {
  const _SkeletonRow();
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SkeletonCard(height: 100, width: 120, margin: EdgeInsets.only(left: 16, right: 8)),
        SkeletonCard(height: 100, width: 120, margin: EdgeInsets.only(right: 8)),
        SkeletonCard(height: 100, width: 120, margin: EdgeInsets.only(right: 8)),
        SkeletonCard(height: 100, width: 120, margin: EdgeInsets.zero),
      ],
    );
  }
}

class _SkeletonChart extends StatelessWidget {
  final double height;
  const _SkeletonChart({this.height = 200});
  @override
  Widget build(BuildContext context) {
    return SkeletonCard(height: height, margin: const EdgeInsets.all(16));
  }
}

class _EmptyChartTip extends StatelessWidget {
  final String message;
  const _EmptyChartTip({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(message, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 12)),
      ),
    );
  }
}
class _LazyChart extends ConsumerStatefulWidget {
  final Widget Function(WidgetRef ref) builder;
  final double height;

  const _LazyChart({required this.builder, this.height = 200});

  @override
  ConsumerState<_LazyChart> createState() => _LazyChartState();
}

class _LazyChartState extends ConsumerState<_LazyChart> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(widget.builder.hashCode),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05 && !_isVisible) {
          if (mounted) setState(() => _isVisible = true);
        }
      },
      child: _isVisible ? widget.builder(ref) : _SkeletonChart(height: widget.height),
    );
  }
}
