import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/widgets/pr_banner_widget.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/widgets/stats_trend_chart.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/widgets/muscle_balance_chart.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/widgets/workout_heatmap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AnalyticsDashboardScreen extends ConsumerWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prsAsync = ref.watch(recentPRsProvider);
    final volumeAsync = ref.watch(volumeTrendProvider);
    final durationAsync = ref.watch(durationTrendProvider);
    final weightAsync = ref.watch(weightTrendProvider);
    final muscleAsync = ref.watch(muscleBalanceProvider);
    final activityAsync = ref.watch(dailyActivityProvider);
    final dashboardAsync = ref.watch(dashboardStatsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Training Insights'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.info),
            onPressed: () => _showInfo(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(recentPRsProvider);
          ref.invalidate(volumeTrendProvider);
          ref.invalidate(durationTrendProvider);
          ref.invalidate(weightTrendProvider);
          ref.invalidate(muscleBalanceProvider);
          ref.invalidate(dailyActivityProvider);
          ref.invalidate(dashboardStatsProvider);
        },
        child: CustomScrollView(
          slivers: [
            // 1. Overview Cards
            SliverToBoxAdapter(
              child: _buildOverviewSection(dashboardAsync),
            ),

            // 2. Personal Records
            SliverToBoxAdapter(
              child: prsAsync.when(
                data: (prs) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: PRBannerWidget(recentPRs: prs),
                ),
                loading: () => const SizedBox(height: 100),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ),

            // 3. Trends Section (Tabbed or List)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Performance Trends',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildTrendSection(
                      context, 
                      'Volume Moved', 
                      volumeAsync.when(
                        data: (d) => StatsTrendChart(data: d, type: StatType.volume),
                        loading: () => const SizedBox(height: 220),
                        error: (e, _) => Text('Error: $e'),
                      ),
                      LucideIcons.activity,
                    ),
                    const SizedBox(height: 24),
                    _buildTrendSection(
                      context, 
                      'Avg. Workout Duration', 
                      durationAsync.when(
                        data: (d) => StatsTrendChart(data: d, type: StatType.duration),
                        loading: () => const SizedBox(height: 220),
                        error: (e, _) => Text('Error: $e'),
                      ),
                      LucideIcons.timer,
                    ),
                    const SizedBox(height: 24),
                    _buildTrendSection(
                      context, 
                      'Body Weight', 
                      weightAsync.when(
                        data: (d) => StatsTrendChart(data: d, type: StatType.weight, valueSuffix: ' kg'),
                        loading: () => const SizedBox(height: 220),
                        error: (e, _) => Text('Error: $e'),
                      ),
                      LucideIcons.scale,
                    ),
                  ],
                ),
              ),
            ),

            // 4. Heatmap
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: activityAsync.when(
                  data: (activity) {
                    // Convert list of maps to Map<DateTime, int> for the Heatmap widget
                    final activityMap = {
                      for (var item in activity) 
                        item['date'] as DateTime : item['count'] as int
                    };
                    return WorkoutHeatmap(activity: activityMap);
                  },
                  loading: () => const SizedBox(height: 150),
                  error: (e, _) => const SizedBox.shrink(),
                ),
              ),
            ),

            // 5. Muscle Balance
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Muscle Work Distribution',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    muscleAsync.when(
                      data: (balance) => Card(
                        elevation: 0,
                        color: Theme.of(context).colorScheme.surfaceContainerLow,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: MuscleBalanceChart(balanceData: balance),
                        ),
                      ),
                      loading: () => const SizedBox(height: 250),
                      error: (e, _) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendSection(BuildContext context, String title, Widget chart, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Theme.of(context).colorScheme.outline),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        chart,
      ],
    );
  }

  Widget _buildOverviewSection(AsyncValue<Map<String, dynamic>> dashboardAsync) {
    return dashboardAsync.when(
      data: (data) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            _StatCard(
              label: 'Workouts',
              value: data['workoutCount'].toString(),
              subtitle: 'this month',
              icon: LucideIcons.calendarCheck,
              color: Colors.blue,
            ),
            const SizedBox(width: 12),
            _StatCard(
              label: 'Streak',
              value: '${data['activeStreak']}d',
              subtitle: 'current',
              icon: LucideIcons.flame,
              color: Colors.orange,
            ),
          ],
        ),
      ),
      loading: () => const SizedBox(height: 120),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  void _showInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('About Your Insights', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const BulletPoint(text: 'Volume Moved: Total weight lifted across all exercises (scaled in Tons).'),
            const BulletPoint(text: 'Avg Duration: Average training session length over time.'),
            const BulletPoint(text: 'Body Weight: Tracking your physical progress alongside training.'),
            const BulletPoint(text: 'PRs: Detected when your estimated 1RM beats your all-time best.'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Got it'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
