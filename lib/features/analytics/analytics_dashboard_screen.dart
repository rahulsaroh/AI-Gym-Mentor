import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/core/utils/weight_converter.dart';
import 'package:ai_gym_mentor/core/widgets/number_ticker.dart';
import 'package:ai_gym_mentor/core/widgets/skeleton_card.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ai_gym_mentor/features/analytics/components/fitness_wrapped_card.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/widgets/stats_trend_chart.dart';
import 'package:ai_gym_mentor/features/analytics/components/training_heatmap.dart';
import 'package:ai_gym_mentor/features/analytics/components/volume_vs_weight_chart.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/strength_analytics_dashboard.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/strength_analytics_notifier.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/providers/year_in_review_providers.dart';

class AnalyticsDashboardScreen extends ConsumerWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();
    final unit = settings.weightUnit;
    final alertsAsync = ref.watch(plateauAlertsProvider);
    final prsAsync = ref.watch(recentPRsProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Analytics'),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.scale),
              onPressed: () => context.push('/analytics/measurements'),
            ),
          ],
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Strength'),
            ],
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          children: [
            // Overview Tab
            RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(dashboardStatsProvider);
                ref.invalidate(volumeTrendProvider);
                ref.invalidate(frequencyTrendProvider);
                ref.invalidate(muscleBalanceProvider);
                ref.invalidate(plateauAlertsProvider);
                ref.invalidate(recentPRsProvider);
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FitnessWrappedCard(),
                    _buildYearInReviewPromo(context, ref),
                    // 1. Overview Stats Row
                    statsAsync.when(
                      data: (stats) {
                        if (stats['totalWorkouts'] == 0) {
                          return const _EmptyAnalyticsState();
                        }
                        return _OverviewRow(stats: stats, unit: unit);
                      },
                      loading: () => const _SkeletonRow(),
                      error: (e, _) => const SizedBox.shrink(),
                    ),
  
                    const SizedBox(height: 16),
                    const TrainingHeatmap(),
  
                    // 2. Weekly Volume vs Body Weight (Dual Axis) - Beat Hevy Feature
                    _SectionHeader(
                        title: 'Volume vs Body Weight', subtitle: 'Strength vs mass trend'),
                    VolumeVsWeightChart(unit: unit),
  
                    // 3. Weekly Volume Trend (Detailed Bar)
                    _SectionHeader(
                        title: 'Weekly Volume Trend', subtitle: 'Last 12 weeks'),
                    _LazyChart(
                      builder: (ref) => ref.watch(volumeTrendProvider).when(
                            data: (data) => _VolumeChart(data: data, unit: unit),
                            loading: () => const _SkeletonChart(),
                            error: (e, _) => Center(child: Text('Error: $e')),
                          ),
                    ),
  
                    // 3. Workout Frequency
                    _SectionHeader(
                        title: 'Workout Frequency',
                        subtitle: 'Target: 4 sessions/week'),
                    _LazyChart(
                      builder: (ref) => ref.watch(frequencyTrendProvider).when(
                            data: (data) => _FrequencyChart(data: data, target: 4),
                            loading: () => const _SkeletonChart(),
                            error: (e, _) => Center(child: Text('Error: $e')),
                          ),
                    ),
  
                    // 3.1 Body Weight Trend
                    _SectionHeader(
                        title: 'Body Weight Trend', subtitle: 'Progress over time'),
                    _LazyChart(
                      builder: (ref) => ref.watch(weightTrendProvider).when(
                            data: (data) => StatsTrendChart(data: data, type: StatType.weight),
                            loading: () => const _SkeletonChart(),
                            error: (e, _) => Center(child: Text('Error: $e')),
                          ),
                    ),
  
                    // 3.2 Workout Duration Trend
                    _SectionHeader(
                        title: 'Duration Trend', subtitle: 'Average workout length'),
                    _LazyChart(
                      builder: (ref) => ref.watch(durationTrendProvider).when(
                            data: (data) => StatsTrendChart(data: data, type: StatType.duration),
                            loading: () => const _SkeletonChart(),
                            error: (e, _) => Center(child: Text('Error: $e')),
                          ),
                    ),
  
                    // 4. Muscle Group Balance
                    _SectionHeader(
                        title: 'Muscle Balance',
                        subtitle: 'This month vs Last month'),
                    _LazyChart(
                      height: 350,
                      builder: (ref) => ref.watch(muscleBalanceProvider).when(
                            data: (data) => _MuscleBarChart(data: data),
                            loading: () => const _SkeletonChart(height: 350),
                            error: (e, _) => Center(child: Text('Error: $e')),
                          ),
                    ),
  
                    // 4.1 BodyMap Heatmap Entry
                    _SectionHeader(
                      title: 'Muscle Heatmap',
                      subtitle: 'Visualize your training & recovery',
                      onTrailingTap: () => context.push('/analytics/bodymap'),
                      trailingLabel: 'View Full Map',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () => context.push('/analytics/bodymap'),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                                Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(LucideIcons.accessibility, size: 40),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'interactive Body Map',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Track volume distribution and predict soreness across all muscle groups.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                LucideIcons.chevronRight,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ],
                          ),
                        ),
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
            
            // Strength Tab
            RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(strengthAnalyticsProvider);
              },
              child: const StrengthAnalyticsDashboard(),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildYearInReviewPromo(BuildContext context, WidgetRef ref) {
    final availableYears = ref.watch(availableReviewYearsProvider);
    
    return availableYears.when(
      data: (years) {
        if (years.isEmpty) return const SizedBox.shrink();
        final currentYear = DateTime.now().year;
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: InkWell(
            onTap: () => context.push('/analytics/year-in-review/$currentYear'),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo[900]!, Colors.indigo[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.indigo.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(LucideIcons.sparkles, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Training Year',
                          style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          'Discover your $currentYear highlights, PRs, and massive gains.',
                          style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const Icon(LucideIcons.chevronRight, color: Colors.white),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis),
                Text(subtitle,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.outline),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
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
  final WeightUnit unit;
  const _OverviewRow({required this.stats, required this.unit});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _StatCard(
            label: 'This Month',
            numericValue: unit == WeightUnit.kg
                ? (stats['monthlyVolume'] as num).toDouble() / 1000
                : WeightConverter.toDisplay(
                        (stats['monthlyVolume'] as num).toDouble(), unit) /
                    1000,
            suffix: unit == WeightUnit.kg ? 'T' : 'k lbs',
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
            numericValue: (stats['activeStreak'] as num?)?.toDouble() ?? 0,
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

  const _StatCard(
      {required this.label,
      required this.numericValue,
      required this.icon,
      required this.color,
      this.suffix = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.1)),
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
  final WeightUnit unit;
  const _VolumeChart({required this.data, required this.unit});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty)
      return const _EmptyChartTip(
          message: 'Log some workouts to see volume trends.');

    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: data
                  .asMap()
                  .entries
                  .map((e) => FlSpot(
                      e.key.toDouble(),
                      unit == WeightUnit.kg
                          ? e.value['volume'] / 1000
                          : WeightConverter.toDisplay(e.value['volume'], unit) /
                              1000))
                  .toList(),
              isCurved: true,
              color: Theme.of(context).colorScheme.primary,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                  show: true,
                  color:
                      Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)),
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
                  if (val.toInt() >= data.length)
                    return const SizedBox.shrink();
                  final date = data[val.toInt()]['date'] as DateTime;
                  return Text(DateFormat('MM/dd').format(date),
                      style: const TextStyle(fontSize: 10));
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
    if (data.isEmpty)
      return const _EmptyChartTip(
          message: 'Complete workouts regularly to see your frequency.');

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
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(4)),
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
                  if (val.toInt() >= data.length || val.toInt() % 4 != 0)
                    return const SizedBox.shrink();
                  final date = data[val.toInt()]['date'] as DateTime;
                  return Text(DateFormat('MM/dd').format(date),
                      style: const TextStyle(fontSize: 10));
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

class _MuscleBarChart extends StatelessWidget {
  final Map<String, dynamic> data;
  const _MuscleBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final labels = (data['labels'] as List? ?? []).cast<String>();
    final thisMonth = (data['thisMonth'] as List? ?? []).cast<double>();
    final lastMonth = (data['lastMonth'] as List? ?? []).cast<double>();

    if (labels.isEmpty)
      return const _EmptyChartTip(
          message: 'No muscle data available for comparisons.');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: List.generate(labels.length, (index) {
              final label = labels[index];
              final current = thisMonth[index];
              final previous = lastMonth[index];
              final maxVal = ([...thisMonth, ...lastMonth])
                  .reduce((a, b) => a > b ? a : b);

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(label,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                        Text(
                          '${current.toInt()} vs ${previous.toInt()} kg',
                          style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).colorScheme.outline),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _HorizontalProgressBar(
                      value: current,
                      backgroundValue: previous,
                      maxValue: maxVal == 0 ? 1 : maxVal,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LegendItem(
                label: 'Last Month', color: Colors.blue.withValues(alpha: 0.3)),
            const SizedBox(width: 24),
            _LegendItem(
                label: 'This Month',
                color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ],
    );
  }
}

class _HorizontalProgressBar extends StatelessWidget {
  final double value;
  final double backgroundValue;
  final double maxValue;

  const _HorizontalProgressBar({
    required this.value,
    required this.backgroundValue,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background bar (Previous Month)
        Container(
          height: 12,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        // Previous month indicator
        FractionallySizedBox(
          widthFactor: (backgroundValue / maxValue).clamp(0.0, 1.0),
          child: Container(
            height: 12,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        // Current month bar
        FractionallySizedBox(
          widthFactor: (value / maxValue).clamp(0.0, 1.0),
          child: Container(
            height: 12,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                  Theme.of(context).colorScheme.primary,
                ],
              ),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
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
        Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
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
              Text('Progression Alerts',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  color: Colors.amber.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alert['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(alert['suggestion'],
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black87)),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Consumer(
                          builder: (context, ref, _) => TextButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final until = DateTime.now()
                                  .add(const Duration(days: 14))
                                  .millisecondsSinceEpoch;
                              await prefs.setInt(
                                  'plateau_dismissed_${alert['exerciseId']}',
                                  until);
                              ref.invalidate(plateauAlertsProvider);
                            },
                            child: const Text('Dismiss',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ),
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
    if (prs.isEmpty)
      return const _EmptyChartTip(
          message: 'New Personal Records will appear here!');

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
              gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.blue.shade600]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(pr['name'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                const SizedBox(height: 4),
                Text(pr['value'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                Text(DateFormat('MMM d').format(pr['date']),
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7), fontSize: 10)),
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
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      child: Row(
        children: [
          SkeletonCard(
              height: 100,
              width: 120,
              margin: EdgeInsets.only(left: 16, right: 8)),
          SkeletonCard(
              height: 100, width: 120, margin: EdgeInsets.only(right: 8)),
          SkeletonCard(
              height: 100, width: 120, margin: EdgeInsets.only(right: 8)),
          SkeletonCard(height: 100, width: 120, margin: EdgeInsets.zero),
        ],
      ),
    );
  }
}

class _EmptyAnalyticsState extends StatelessWidget {
  const _EmptyAnalyticsState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(LucideIcons.layoutDashboard,
                size: 64,
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.1)),
            const SizedBox(height: 16),
            Text(
              'No Analytics Data Yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete your first workout to start tracking your volume and progress trends over time.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(LucideIcons.play),
              label: const Text('Log First Workout'),
            ),
          ],
        ),
      ),
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
        child: Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.outline, fontSize: 12)),
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
      child: _isVisible
          ? widget.builder(ref)
          : _SkeletonChart(height: widget.height),
    );
  }
}
