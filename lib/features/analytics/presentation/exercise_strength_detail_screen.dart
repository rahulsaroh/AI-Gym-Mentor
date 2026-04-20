import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:ai_gym_mentor/features/analytics/data/strength_repository.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/core/database/database.dart';

class ExerciseStrengthDetailScreen extends ConsumerWidget {
  final int exerciseId;
  final String exerciseName;
  const ExerciseStrengthDetailScreen({super.key, required this.exerciseId, required this.exerciseName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(strengthRepositoryProvider);
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(exerciseName, style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: repo.getExerciseStrengthMetrics(exerciseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No strength history available.', style: GoogleFonts.outfit()));
          }

          final metrics = snapshot.data!;
          final latest = metrics['latest'] as Exercise1RmSnapshot;
          final best = metrics['allTimeBest'] as Exercise1RmSnapshot;

          return FutureBuilder<List<Exercise1RmSnapshot>>(
            future: repo.getExerciseHistory(exerciseId),
            builder: (context, historySnapshot) {
              if (!historySnapshot.hasData) return const SizedBox.shrink();
              final history = historySnapshot.data!;

              return FutureBuilder<int>(
                future: repo.getStrengthSessionsCount(exerciseId),
                builder: (context, sessionSnapshot) {
                  if (!sessionSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final sessionCount = sessionSnapshot.data!;
                  
                  return ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                       _buildHeader(context, latest, best, sessionCount, settings.weightUnit),
                       const SizedBox(height: 32),
                       _buildChart(context, history, settings.weightUnit),
                       const SizedBox(height: 32),
                       _buildBenchmarkGrid(context, metrics, settings.weightUnit),
                       const SizedBox(height: 32),
                       _buildInsightCard(context, metrics),
                       const SizedBox(height: 32),
                       _buildMilestones(context, history, settings.weightUnit),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Exercise1RmSnapshot latest, Exercise1RmSnapshot best, int sessionCount, WeightUnit unit) {
    final unitLabel = unit == WeightUnit.kg ? 'kg' : 'lbs';
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStatBox('Current e1RM', '${latest.estimated1Rm.toInt()}$unitLabel', Colors.blue)),
            const SizedBox(width: 16),
            Expanded(child: _buildStatBox('All-Time PR', '${best.estimated1Rm.toInt()}$unitLabel', Colors.orange)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSmallIconStat(LucideIcons.calendarDays, '${sessionCount} sessions'),
              _buildSmallIconStat(LucideIcons.history, 'Last: ${DateFormat.MMMd().format(latest.date)}'),
              _buildSmallIconStat(LucideIcons.calculator, 'Formula: ${latest.formula}'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallIconStat(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Text(label, style: GoogleFonts.outfit(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildStatBox(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Text(label, style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildBenchmarkGrid(BuildContext context, Map<String, dynamic> metrics, WeightUnit unit) {
    final latest = (metrics['latest'] as Exercise1RmSnapshot).estimated1Rm;
    final unitLabel = unit == WeightUnit.kg ? 'kg' : 'lbs';
    
    // Inferred benchmarks based on standard percentages
    final threeRM = latest * 0.93;
    final fiveRM = latest * 0.87;
    final tenRM = latest * 0.75;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Inferred Benchmarks', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildBenchmarkItem('3RM', '${threeRM.toInt()}$unitLabel', '93%')),
            const SizedBox(width: 12),
            Expanded(child: _buildBenchmarkItem('5RM', '${fiveRM.toInt()}$unitLabel', '87%')),
            const SizedBox(width: 12),
            Expanded(child: _buildBenchmarkItem('10RM', '${tenRM.toInt()}$unitLabel', '75%')),
          ],
        ),
      ],
    );
  }

  Widget _buildBenchmarkItem(String label, String value, String percent) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        children: [
          Text(label, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
          Text(percent, style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildInsightCard(BuildContext context, Map<String, dynamic> metrics) {
    final trend = metrics['trend'] as String;
    final change = metrics['changePercent'] as double;
    final isPositive = change > 0;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[900]!, Colors.grey[800]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.sparkles, color: isPositive ? Colors.yellow : Colors.blue, size: 20),
              const SizedBox(width: 12),
              Text('Smart Insight', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            trend == 'improving' 
              ? 'exceptional progress! You have increased your strength by ${change.toStringAsFixed(1)}% recently. Maintain this intensity to keep the momentum.'
              : (trend == 'stable' ? 'Your strength is holding steady. This is a great baseline. Try increasing your weight by 2.5% in your next session to force adaptation.' : 'We detected a slight dip in estimated strength. This is normal during high-volume phases or if recovery is sub-optimal.'),
            style: GoogleFonts.outfit(color: Colors.white.withOpacity(0.8), fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(BuildContext context, List<Exercise1RmSnapshot> history, WeightUnit unit) {
    if (history.length < 2) {
      return Container(
        height: 200,
        decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(24)),
        child: Center(child: Text('Log more sessions to unlock trend charts.', style: GoogleFonts.outfit(color: Colors.grey, fontSize: 13))),
      );
    }

    final spots = history.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.estimated1Rm)).toList();
    final minY = history.map((e) => e.estimated1Rm).reduce((a, b) => a < b ? a : b) * 0.95;
    final maxY = history.map((e) => e.estimated1Rm).reduce((a, b) => a > b ? a : b) * 1.05;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Strength Progression', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          height: 220,
          padding: const EdgeInsets.only(right: 16, top: 16),
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (val, meta) {
                      if (val.toInt() % (history.length > 5 ? history.length ~/ 3 : 1) != 0) return const SizedBox.shrink();
                      if (val.toInt() >= history.length) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(DateFormat('MMM d').format(history[val.toInt()].date), style: const TextStyle(fontSize: 10, color: Colors.grey)),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (val, meta) => Text('${val.toInt()}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              minY: minY,
              maxY: maxY,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Colors.blue[600],
                  barWidth: 4,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                      radius: 4,
                      color: Colors.white,
                      strokeWidth: 2,
                      strokeColor: Colors.blue[600]!,
                    ),
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [Colors.blue.withOpacity(0.2), Colors.blue.withOpacity(0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMilestones(BuildContext context, List<Exercise1RmSnapshot> history, WeightUnit unit) {
    final prs = history.where((s) => s.isPr).toList().reversed.toList();
    final unitLabel = unit == WeightUnit.kg ? 'kg' : 'lbs';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Progression Milestones', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        if (prs.isEmpty)
           Center(child: Text('No PRs recorded yet.', style: GoogleFonts.outfit(color: Colors.grey, fontSize: 13)))
        else
          ...prs.map((pr) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[100]!),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.orange[50], shape: BoxShape.circle),
                  child: const Icon(LucideIcons.award, color: Colors.orange, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Personal Record', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(DateFormat.yMMMd().format(pr.date), style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                Text('${pr.estimated1Rm.toInt()}$unitLabel', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.orange[700], fontSize: 18)),
              ],
            ),
          )),
      ],
    );
  }
}


