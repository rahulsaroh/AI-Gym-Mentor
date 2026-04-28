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
    return _MetricDetailView(
      metricId: metricId,
      metricLabel: metricLabel,
      unit: unit,
      lowerIsBetter: lowerIsBetter,
    );
  }
}

class _MetricDetailView extends ConsumerWidget {
  final String metricId;
  final String metricLabel;
  final String unit;
  final bool lowerIsBetter;

  const _MetricDetailView({
    required this.metricId,
    required this.metricLabel,
    required this.unit,
    required this.lowerIsBetter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementAsync = ref.watch(physiqueAchievementProvider);
    final measurementsAsync = ref.watch(bodyMeasurementsListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          metricLabel,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w900),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      bottomNavigationBar: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: MeasurementIntervalSelector(),
        ),
      ),
      // FAB removed as per user request
      body: measurementsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (allMeasurements) {
          final entries = <_LogEntry>[];
          for (final m in allMeasurements.reversed) {
            final val = extractMetricValue(m, metricId);
            if (val != null) {
              entries.add(_LogEntry(id: m.id, date: m.date, value: val));
            }
          }
          final displayEntries = entries.reversed.toList();

          final MetricAchievement? achievement = achievementAsync.asData?.value
              .achievements
              .where((a) => a.metric == metricId)
              .firstOrNull;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
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
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                  child: _MetricHistoryChart(
                    entries: entries,
                    targetValue: achievement?.targetValue,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'HISTORY LOG',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                      Text(
                        '${displayEntries.length} entries',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.primary.withValues(alpha: 0.6),
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
                          }
                        },
                      );
                    },
                    childCount: displayEntries.length,
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
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
    final theme = Theme.of(context);

    double startRatio = 0;
    double currentRatio = 0;
    bool isImproving = true;

    if (hasData && hasTarget && a != null) {
      final pct = a.percentage; 
      isImproving = pct >= 0;
      startRatio = 0;
      currentRatio = pct.clamp(-1.0, 1.0).abs();
    }

    final pct = a != null ? (a.percentage.clamp(-1.0, 1.5) * 100) : 0.0;
    final pctDisplay = pct.toInt();

    final gaugeColor = !hasData
        ? Colors.grey
        : isImproving
            ? const Color(0xFF2ECC71)
            : const Color(0xFFE74C3C);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(10, 10),
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 20,
            offset: const Offset(-10, -10),
          ),
        ],
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Column(children: [
        Text(
          'OVERALL PROGRESS',
          style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1.2),
        ),
        const SizedBox(height: 32),

        SizedBox(
          height: 180,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            CustomPaint(
              size: const Size(280, 140),
              painter: _MetallicGaugePainter(
                startProgress: startRatio,
                currentProgress: hasData && hasTarget ? a!.percentage.clamp(-1.0, 1.0) : 0.0,
                isImproving: isImproving,
                hasData: hasData && hasTarget,
                backgroundColor: const Color(0xFFF1F4F8),
              ),
            ),
            Positioned(
              bottom: 12,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                if (hasData && hasTarget)
                  Text(
                    '$pctDisplay%',
                    style: GoogleFonts.outfit(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  )
                else
                  Text(
                    '0%',
                    style: GoogleFonts.outfit(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey.withValues(alpha: 0.3),
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                   !hasData 
                    ? 'Log to view score!'
                    : hasTarget 
                      ? (isImproving ? 'Improving' : 'Regressing')
                      : 'No target set',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
                if (!hasTarget && hasData)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: _PillAction(
                      label: 'Set your target',
                      onTap: () {}, 
                    ),
                  ),
              ]),
            ),
          ]),
        ),

        const SizedBox(height: 32),

        if (hasData && a != null)
          Row(children: [
            _StatChip(
              label: 'Start',
              value: '${a.startValue.toStringAsFixed(1)} $unit',
              color: const Color(0xFF3B82F6),
            ),
            const SizedBox(width: 12),
            _StatChip(
              label: 'Current',
              value: '${a.currentValue.toStringAsFixed(1)} $unit',
              color: gaugeColor,
            ),
            if (hasTarget) ...[
              const SizedBox(width: 12),
              _StatChip(
                label: 'Target',
                value: '${a.targetValue.toStringAsFixed(1)} $unit',
                color: theme.colorScheme.primary,
              ),
            ],
          ]),
      ]),
    );
  }
}

class _PillAction extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PillAction({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
          color: const Color(0xFFF1F5F9),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black.withValues(alpha: 0.7)),
        ),
      ),
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
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color.withValues(alpha: 0.05),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Column(children: [
          Text(label,
              style: GoogleFonts.outfit(fontSize: 11, color: color, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
          const SizedBox(height: 4),
          Text(value,
              style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.bold, color: color),
              overflow: TextOverflow.ellipsis),
        ]),
      ),
    );
  }
}

class _MetallicGaugePainter extends CustomPainter {
  final double startProgress;
  final double currentProgress;
  final bool isImproving;
  final bool hasData;
  final Color backgroundColor;

  _MetallicGaugePainter({
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

    // Tick Marks
    final tickPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (double i = math.pi; i <= math.pi * 2; i += (math.pi / 12)) {
      final innerR = radius + 20;
      final outerR = radius + 30;
      canvas.drawLine(
        Offset(center.dx + innerR * math.cos(i), center.dy + innerR * math.sin(i)),
        Offset(center.dx + outerR * math.cos(i), center.dy + outerR * math.sin(i)),
        tickPaint,
      );
    }

    // Outer Track
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi, math.pi, false,
      Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 24
        ..strokeCap = StrokeCap.round,
    );

    // Metallic Inner Background
    final metallicRect = Rect.fromCircle(center: center, radius: radius - 15);
    final metallicPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFF1F5F9),
          const Color(0xFFE2E8F0),
          const Color(0xFFCBD5E1),
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(metallicRect)
      ..style = PaintingStyle.fill;
    
    canvas.drawArc(
      metallicRect,
      math.pi, math.pi, true,
      metallicPaint,
    );

    if (hasData && currentProgress.abs() > 0.001) {
      final abs = currentProgress.abs();
      final sweepAngle = math.pi * abs;
      final activeColor = isImproving ? const Color(0xFF2ECC71) : const Color(0xFFE74C3C);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        math.pi, sweepAngle, false,
        Paint()
          ..shader = SweepGradient(
            colors: [activeColor.withValues(alpha: 0.4), activeColor],
            startAngle: math.pi,
            endAngle: math.pi * 2,
          ).createShader(Rect.fromCircle(center: center, radius: radius))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 26
          ..strokeCap = StrokeCap.round
          ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MetallicGaugePainter old) =>
      old.currentProgress != currentProgress || old.isImproving != isImproving;
}

class _MetricHistoryChart extends StatelessWidget {
  final List<_LogEntry> entries;
  final double? targetValue;
  const _MetricHistoryChart({required this.entries, this.targetValue});

  @override
  Widget build(BuildContext context) {
    if (entries.length < 2) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final spots = entries.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value)).toList();
    final values = entries.map((e) => e.value).toList();
    final minVal = values.reduce((a, b) => a < b ? a : b);
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    final padding = (maxVal - minVal) * 0.15;
    final minY = (math.min(minVal, targetValue ?? minVal) - padding).clamp(0.0, double.infinity);
    final maxY = math.max(maxVal, targetValue ?? maxVal) + padding;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(6, 6),
          ),
          const BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            offset: Offset(-6, -6),
          ),
        ],
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HISTORY TREND',
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (val, meta) => Text(
                        val.toStringAsFixed(1),
                        style: GoogleFonts.robotoMono(fontSize: 10, color: theme.colorScheme.outline),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (val, meta) {
                        final idx = val.toInt();
                        if (idx < 0 || idx >= entries.length) return const SizedBox.shrink();
                        if (entries.length > 6 && idx % (entries.length ~/ 3) != 0) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(DateFormat('MMM d').format(entries[idx].date), style: TextStyle(fontSize: 9, color: theme.colorScheme.outline)),
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
                    color: theme.colorScheme.primary,
                    barWidth: 5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: true, getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(radius: 5, color: Colors.white, strokeWidth: 2.5, strokeColor: theme.colorScheme.primary)),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [theme.colorScheme.primary.withValues(alpha: 0.2), theme.colorScheme.primary.withValues(alpha: 0.0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    if (targetValue != null && targetValue! > 0)
                      HorizontalLine(
                        y: targetValue!,
                        color: theme.colorScheme.primary.withValues(alpha: 0.5),
                        strokeWidth: 2,
                        dashArray: [5, 5],
                        label: HorizontalLineLabel(
                          show: true,
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.only(right: 5, bottom: 5),
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                          labelResolver: (line) => 'Target: ${line.y.toStringAsFixed(1)}',
                        ),
                      ),
                  ],
                ),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => theme.colorScheme.surfaceContainerHighest,
                    getTooltipItems: (touchedSpots) => touchedSpots.map((spot) {
                      final entry = entries[spot.x.toInt()];
                      return LineTooltipItem(
                        '${entry.value.toStringAsFixed(1)}\n${DateFormat('MMM d').format(entry.date)}',
                        TextStyle(color: theme.colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 11),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
      isImproving = lowerIsBetter ? changePct <= 0 : changePct >= 0;
    }

    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return BouncingCard(
      onTap: () {}, 
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(5, 5),
            ),
            const BoxShadow(
              color: Colors.white,
              blurRadius: 10,
              offset: Offset(-5, -5),
            ),
          ],
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      blurRadius: 5,
                      offset: Offset(-1, -1),
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
                  size: 28,
                ),
              ),
              const SizedBox(width: 20),
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
                          const SizedBox(width: 10),
                          _BadgePill(
                            label: 'Latest',
                            color: theme.colorScheme.primary.withValues(alpha: 0.1),
                            textColor: theme.colorScheme.primary,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${DateFormat('EEE, d MMM yyyy').format(entry.date)}',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: onSurface.withValues(alpha: 0.4),
                        fontWeight: FontWeight.w600,
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
                  const SizedBox(height: 10),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(LucideIcons.trash2, color: Colors.red[400]?.withValues(alpha: 0.7), size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Text(label, style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w900, color: textColor)),
    );
  }
}

class _ChangePill extends StatelessWidget {
  final double changePct;
  final bool isImproving;
  const _ChangePill({required this.changePct, required this.isImproving});
  @override
  Widget build(BuildContext context) {
    final color = isImproving ? const Color(0xFF2ECC71) : const Color(0xFFE74C3C);
    final sign = changePct >= 0 ? '+' : '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withValues(alpha: 0.2))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isImproving ? LucideIcons.trendingUp : LucideIcons.trendingDown, size: 14, color: color),
          const SizedBox(width: 6),
          Text('$sign${changePct.toStringAsFixed(1)}%', style: GoogleFonts.robotoMono(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
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
    return Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 80), child: Column(children: [Icon(LucideIcons.notebookText, size: 60, color: Colors.grey.withValues(alpha: 0.2)), const SizedBox(height: 20), Text('No $metricLabel logs yet', style: GoogleFonts.outfit(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w600))])));
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
