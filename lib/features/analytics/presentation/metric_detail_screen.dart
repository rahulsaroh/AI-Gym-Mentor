import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_achievement.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/body_measurements_log_screen.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/widgets/measurements_tab.dart';
import 'package:ai_gym_mentor/core/widgets/bouncing_card.dart';

/// Full-screen drill-down for a single measurement metric.
/// Works for both standard metrics and custom metrics.
class MetricDetailScreen extends ConsumerWidget {
  final String metricId;
  final String metricLabel;
  final String unit;
  final bool lowerIsBetter;

  const MetricDetailScreen({
    super.key,
    required this.metricId,
    required this.metricLabel,
    required this.unit,
    this.lowerIsBetter = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementAsync = ref.watch(physiqueAchievementProvider);
    final measurementsAsync = ref.watch(bodyMeasurementsListProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          metricLabel,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: MeasurementIntervalSelector(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BodyMeasurementsLogScreen()),
        ),
        icon: const Icon(LucideIcons.plus),
        label: Text('Log Entry', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
      ),
      body: measurementsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (allMeasurements) {
          // Extract all entries for this metric in chronological order (oldest first)
          final entries = <_LogEntry>[];
          for (final m in allMeasurements.reversed) {
            final val = extractMetricValue(m, metricId);
            if (val != null) {
              entries.add(_LogEntry(id: m.id, date: m.date, value: val));
            }
          }
          // Reverse so newest is first in display
          final displayEntries = entries.reversed.toList();

          // Find the achievement for this metric
          final MetricAchievement? achievement = achievementAsync.asData?.value
              .achievements
              .where((a) => a.metric == metricId)
              .firstOrNull;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: _MetricGaugeCard(
                    achievement: achievement,
                    metricLabel: metricLabel,
                    unit: unit,
                    lowerIsBetter: lowerIsBetter,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: _MetricHistoryChart(entries: entries),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'HISTORY LOG',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                      Text(
                        '${displayEntries.length} entries',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (displayEntries.isEmpty)
                SliverToBoxAdapter(
                  child: _EmptyLogState(metricLabel: metricLabel),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final entry = displayEntries[index];
                      // Previous entry is the one after in the displayEntries list (older)
                      final prevVal = index + 1 < displayEntries.length
                          ? displayEntries[index + 1].value
                          : null;
                      return _LogEntryCard(
                        entry: entry,
                        index: index,
                        prevValue: prevVal,
                        unit: unit,
                        lowerIsBetter: lowerIsBetter,
                        isFirst: index == 0,
                        onDelete: () async {
                          final confirmed = await _confirmDelete(context);
                          if (confirmed) {
                            await ref
                                .read(bodyMeasurementsListProvider.notifier)
                                .deleteMeasurement(entry.id);
                            ref.invalidate(physiqueAchievementProvider);
                          }
                        },
                      );
                    },
                    childCount: displayEntries.length,
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Delete Entry',
                style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
            content: Text(
              'Remove this log entry? This cannot be undone.',
              style: GoogleFonts.outfit(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }
}

// ─── Gauge Card ────────────────────────────────────────────────────────────────

class _MetricGaugeCard extends StatelessWidget {
  final MetricAchievement? achievement;
  final String metricLabel;
  final String unit;
  final bool lowerIsBetter;

  const _MetricGaugeCard({
    required this.achievement,
    required this.metricLabel,
    required this.unit,
    required this.lowerIsBetter,
  });

  @override
  Widget build(BuildContext context) {
    final a = achievement;
    final hasData = a != null && a.currentValue > 0;
    final hasTarget = a != null && a.targetValue > 0;

    // Compute start ratio and current ratio for gauge (relative to target)
    double startRatio = 0;
    double currentRatio = 0;
    bool isImproving = true;

    if (hasData && hasTarget && a != null) {
      final pct = a.percentage; // journey percentage
      isImproving = pct >= 0;
      startRatio = 0;
      currentRatio = pct.clamp(-1.0, 1.0).abs();
    }

    final pct = a != null ? (a.percentage.clamp(-1.0, 1.5) * 100) : 0.0;
    final pctDisplay = pct.toInt();
    final isPositive = pct >= 0;

    String subtitle = 'No data logged yet';
    if (hasData && hasTarget && a != null) {
      subtitle = isPositive ? '▲ Improving' : '▼ Regressing';
    } else if (hasData && !hasTarget && a != null) {
      subtitle = 'No target set';
    }

    final gaugeColor = !hasData
        ? Colors.grey
        : isImproving
            ? Colors.green
            : Colors.red;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
        ),
      ),
      child: Column(children: [
        Text(
          'OVERALL PROGRESS',
          style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        const SizedBox(height: 20),

        // Gauge
        SizedBox(
          height: 130,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            CustomPaint(
              size: const Size(230, 115),
              painter: _MetricGaugePainter(
                startProgress: startRatio,
                currentProgress: hasData && hasTarget ? a!.percentage.clamp(-1.0, 1.0) : 0.0,
                isImproving: isImproving,
                hasData: hasData && hasTarget,
                backgroundColor: Colors.grey.withValues(alpha: 0.15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                if (hasData && hasTarget)
                  Text(
                    '$pctDisplay%',
                    style: GoogleFonts.outfit(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: gaugeColor,
                    ),
                  )
                else
                  Text(
                    '--',
                    style: GoogleFonts.outfit(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                Text(
                  subtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: gaugeColor.withValues(alpha: 0.8),
                  ),
                ),
              ]),
            ),
          ]),
        ),

        const SizedBox(height: 16),

        // Stats row
        if (hasData && a != null)
          Row(children: [
            _StatChip(
              label: 'Start',
              value: '${a.startValue.toStringAsFixed(1)} $unit',
              color: const Color(0xFF3B82F6), // blue
            ),
            const SizedBox(width: 8),
            _StatChip(
              label: 'Current',
              value: '${a.currentValue.toStringAsFixed(1)} $unit',
              color: gaugeColor,
            ),
            const SizedBox(width: 8),
            if (hasTarget)
              _StatChip(
                label: 'Target',
                value: '${a.targetValue.toStringAsFixed(1)} $unit',
                color: Theme.of(context).colorScheme.primary,
              ),
          ]),
      ]),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withValues(alpha: 0.1),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(children: [
          Text(label,
              style: GoogleFonts.outfit(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(value,
              style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold, color: color),
              overflow: TextOverflow.ellipsis),
        ]),
      ),
    );
  }
}

class _MetricGaugePainter extends CustomPainter {
  final double startProgress;
  final double currentProgress;
  final bool isImproving;
  final bool hasData;
  final Color backgroundColor;

  _MetricGaugePainter({
    required this.startProgress,
    required this.currentProgress,
    required this.isImproving,
    required this.hasData,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi, math.pi, false,
      Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 16
        ..strokeCap = StrokeCap.round,
    );

    if (hasData && currentProgress.abs() > 0.001) {
      final abs = currentProgress.abs();
      final sweepAngle = math.pi * abs;
      final activeColor = isImproving ? Colors.green : Colors.red;

      if (isImproving) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          math.pi, sweepAngle, false,
          Paint()
            ..shader = SweepGradient(
              colors: [activeColor.withValues(alpha: 0.5), activeColor],
              startAngle: math.pi,
              endAngle: math.pi * 2,
            ).createShader(Rect.fromCircle(center: center, radius: radius))
            ..style = PaintingStyle.stroke
            ..strokeWidth = 16
            ..strokeCap = StrokeCap.round,
        );
      } else {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          math.pi, sweepAngle, false,
          Paint()
            ..color = activeColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = 16
            ..strokeCap = StrokeCap.round,
        );
      }
    }

    final blueMarkerPaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final startAngle = math.pi;
    final innerR = radius - 12.0;
    final outerR = radius + 4.0;
    canvas.drawLine(
      Offset(center.dx + innerR * math.cos(startAngle),
          center.dy + innerR * math.sin(startAngle)),
      Offset(center.dx + outerR * math.cos(startAngle),
          center.dy + outerR * math.sin(startAngle)),
      blueMarkerPaint,
    );

    final tickPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (double i = math.pi; i <= math.pi * 2; i += 0.18) {
      final outerTick = radius + 20;
      canvas.drawLine(
        Offset(center.dx + outerTick * math.cos(i), center.dy + outerTick * math.sin(i)),
        Offset(center.dx + (outerTick + 5) * math.cos(i), center.dy + (outerTick + 5) * math.sin(i)),
        tickPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MetricGaugePainter old) =>
      old.currentProgress != currentProgress || old.isImproving != isImproving;
}

class _MetricHistoryChart extends StatelessWidget {
  final List<_LogEntry> entries;
  const _MetricHistoryChart({required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.length < 2) return const SizedBox.shrink();

    final spots = entries.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value)).toList();
    final values = entries.map((e) => e.value).toList();
    final minVal = values.reduce((a, b) => a < b ? a : b);
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    final padding = (maxVal - minVal) * 0.15;
    final minY = (minVal - padding).clamp(0.0, double.infinity);
    final maxY = maxVal + padding;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HISTORY TREND',
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 220,
          padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
          ),
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 44,
                    getTitlesWidget: (val, meta) => Text(
                      val.toStringAsFixed(1),
                      style: GoogleFonts.robotoMono(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (val, meta) {
                      final idx = val.toInt();
                      if (idx < 0 || idx >= entries.length) return const SizedBox.shrink();
                      if (entries.length > 6 && idx % (entries.length ~/ 3) != 0) {
                        return const SizedBox.shrink();
                      }
                      final date = entries[idx].date;
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          DateFormat('MMM d').format(date),
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      );
                    },
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
                  color: Theme.of(context).colorScheme.primary,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                      radius: 4,
                      color: Colors.white,
                      strokeWidth: 2,
                      strokeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                        Theme.of(context).colorScheme.primary.withValues(alpha: 0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => Theme.of(context).colorScheme.surfaceContainerHighest,
                  getTooltipItems: (touchedSpots) => touchedSpots.map((spot) {
                    final entry = entries[spot.x.toInt()];
                    return LineTooltipItem(
                      '${entry.value.toStringAsFixed(1)}\n${DateFormat('MMM d, yyyy').format(entry.date)}',
                      TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LogEntry {
  final int id;
  final DateTime date;
  final double value;
  const _LogEntry({required this.id, required this.date, required this.value});
}

class _LogEntryCard extends StatelessWidget {
  final _LogEntry entry;
  final int index;
  final double? prevValue;
  final String unit;
  final bool lowerIsBetter;
  final bool isFirst;
  final VoidCallback onDelete;

  const _LogEntryCard({
    required this.entry,
    required this.index,
    required this.prevValue,
    required this.unit,
    required this.lowerIsBetter,
    required this.isFirst,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    double? changePct;
    bool? isImproving;
    if (prevValue != null && prevValue! > 0) {
      changePct = ((entry.value - prevValue!) / prevValue!) * 100;
      if (lowerIsBetter) {
        isImproving = changePct <= 0;
      } else {
        isImproving = changePct >= 0;
      }
    }

    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return BouncingCard(
      onTap: () {}, 
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: theme.dividerColor.withValues(alpha: 0.05),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  isFirst 
                    ? LucideIcons.medal 
                    : (index % 2 == 0 ? LucideIcons.notebookPen : LucideIcons.chartBar),
                  color: isFirst 
                    ? const Color(0xFFD4AF37) 
                    : onSurface.withValues(alpha: 0.4),
                  size: 26,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${entry.value.toStringAsFixed(1)} $unit',
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: onSurface,
                          ),
                        ),
                        if (isFirst) ...[
                          const SizedBox(width: 8),
                          _BadgePill(
                            label: 'Latest',
                            color: theme.colorScheme.primary.withValues(alpha: 0.2),
                            textColor: theme.colorScheme.primary,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${DateFormat('EEE, d MMM yyyy').format(entry.date)} · ${DateFormat('h:mm a').format(entry.date)}',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: onSurface.withValues(alpha: 0.5),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (changePct != null)
                    _ChangePill(
                      changePct: changePct,
                      isImproving: isImproving ?? false,
                    ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        LucideIcons.trash2,
                        color: Colors.red[400]?.withValues(alpha: 0.8),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BadgePill extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  const _BadgePill({required this.label, required this.color, required this.textColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.bold, color: textColor)),
    );
  }
}

class _ChangePill extends StatelessWidget {
  final double changePct;
  final bool isImproving;
  const _ChangePill({required this.changePct, required this.isImproving});
  @override
  Widget build(BuildContext context) {
    final color = isImproving ? Colors.green : Colors.red;
    final sign = changePct >= 0 ? '+' : '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withValues(alpha: 0.3))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isImproving ? LucideIcons.trendingUp : LucideIcons.trendingDown, size: 12, color: color),
          const SizedBox(width: 4),
          Text('$sign${changePct.toStringAsFixed(1)}%', style: GoogleFonts.robotoMono(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

class _EmptyLogState extends StatelessWidget {
  final String metricLabel;
  const _EmptyLogState({required this.metricLabel});
  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 48), child: Column(children: [Icon(LucideIcons.notebookText, size: 48, color: Colors.grey.withValues(alpha: 0.3)), const SizedBox(height: 16), Text('No $metricLabel logs yet', style: GoogleFonts.outfit(fontSize: 16, color: Colors.grey))])));
  }
}

double? extractMetricValue(dynamic m, String id) {
  if (id == 'weight') return m.weight;
  if (id == 'bodyFat') return m.bodyFat;
  if (id == 'chest') return m.chest;
  if (id == 'shoulders') return m.shoulders;
  if (id == 'armLeft') return m.armLeft;
  if (id == 'armRight') return m.armRight;
  if (id == 'forearmLeft') return m.forearmLeft;
  if (id == 'forearmRight') return m.forearmRight;
  if (id == 'waist') return m.waist;
  if (id == 'waistNaval') return m.waistNaval;
  if (id == 'hips') return m.hips;
  if (id == 'thighLeft') return m.thighLeft;
  if (id == 'thighRight') return m.thighRight;
  if (id == 'calfLeft') return m.calfLeft;
  if (id == 'calfRight') return m.calfRight;
  if (id == 'neck') return m.neck;
  if (id == 'subcutaneousFat') return m.subcutaneousFat;
  if (id == 'visceralFat') return m.visceralFat;
  return null;
}

// ─── Mini Trendline ──────────────────────────────────────────────────────────
// Kept from remote for potential future use

class _MiniTrendline extends ConsumerWidget {
  final String metricId;
  const _MiniTrendline({required this.metricId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendAsync = ref.watch(metricAchievementTrendProvider(metricId: metricId));

    return trendAsync.when(
      data: (spots) {
        if (spots.length < 2) return const SizedBox.shrink();

        return LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            minX: spots.first.x,
            maxX: spots.last.x,
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
