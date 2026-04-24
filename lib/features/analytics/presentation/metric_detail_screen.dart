import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_achievement.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/body_measurements_log_screen.dart';

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
          child: _IntervalSelector(),
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
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: SizedBox(
                      height: 40,
                      width: 250,
                      child: _MetricMiniTrendline(metricId: metricId),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'HISTORY LOG',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                      Text(
                        '${displayEntries.length} entries',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.outline,
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
      // startRatio = 0 (start of arc)
      // We split the arc: blue = startRatio, green/red = progress portion
      // Use achievementRatio for overall fill: start = 0 by definition since percentage is relative
      // For the 3-color gauge on this screen, startRatio stays 0 and current = journey pct
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

// ─── 3-color Gauge Painter ─────────────────────────────────────────────────────
// Blue = start marker at 0% (thin vertical line)
// Green = progress from start to current (if improving)
// Red = regress from start to current (if declining)
// Grey = remaining

class _MetricGaugePainter extends CustomPainter {
  final double startProgress; // always 0.0 in journey terms
  final double currentProgress; // clamped journey percentage [-1, 1]
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

    // Background arc
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
        // Green from 0 → current
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
        // Red from 0 → abs(current) — regression shown from start going right
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

    // Blue start marker: a short perpendicular tick at the 0% position (left)
    // The 0% position is at angle math.pi (left side of arc)
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

    // Tick marks
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

// ─── Log Entry Card ─────────────────────────────────────────────────────────

class _LogEntry {
  final int id;
  final DateTime date;
  final double value;
  const _LogEntry({required this.id, required this.date, required this.value});
}

class _LogEntryCard extends StatelessWidget {
  final _LogEntry entry;
  final double? prevValue;
  final String unit;
  final bool lowerIsBetter;
  final bool isFirst;
  final VoidCallback onDelete;

  const _LogEntryCard({
    required this.entry,
    required this.prevValue,
    required this.unit,
    required this.lowerIsBetter,
    required this.isFirst,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('EEE, d MMM yyyy');
    final timeFmt = DateFormat('h:mm a');

    // Calculate change vs previous
    double? changePct;
    bool? isImproving;
    if (prevValue != null && prevValue! > 0) {
      changePct = ((entry.value - prevValue!) / prevValue!) * 100;
      // isImproving: for lowerIsBetter metrics, decrease is good
      if (lowerIsBetter) {
        isImproving = changePct <= 0;
      } else {
        isImproving = changePct >= 0;
      }
    }

    Color changeColor = Colors.grey;
    String changeText = '--';
    IconData changeIcon = LucideIcons.minus;

    if (changePct != null && isImproving != null) {
      changeColor = isImproving ? Colors.green : Colors.red;
      final sign = changePct > 0 ? '+' : '';
      changeText = '$sign${changePct.toStringAsFixed(1)}%';
      changeIcon = changePct > 0 ? LucideIcons.trendingUp : LucideIcons.trendingDown;
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: isFirst
            ? Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4), width: 1.5)
            : Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFirst
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.15)
                : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          ),
          child: Icon(
            isFirst ? LucideIcons.star : LucideIcons.calendar,
            size: 18,
            color: isFirst
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
        ),
        title: Row(children: [
          Text(
            '${entry.value.toStringAsFixed(1)} $unit',
            style: GoogleFonts.robotoMono(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isFirst) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              ),
              child: Text(
                'Latest',
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ]),
        subtitle: Text(
          '${fmt.format(entry.date)}  ·  ${timeFmt.format(entry.date)}',
          style: GoogleFonts.outfit(fontSize: 12, color: Theme.of(context).colorScheme.outline),
        ),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          // Change badge
          if (changePct != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: changeColor.withValues(alpha: 0.1),
                border: Border.all(color: changeColor.withValues(alpha: 0.3)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(changeIcon, size: 12, color: changeColor),
                const SizedBox(width: 3),
                Text(
                  changeText,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: changeColor,
                  ),
                ),
              ]),
            ),
          const SizedBox(width: 4),
          // Delete
          IconButton(
            icon: Icon(LucideIcons.trash2, size: 17, color: Colors.red.withValues(alpha: 0.7)),
            onPressed: onDelete,
            tooltip: 'Delete entry',
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            padding: const EdgeInsets.all(6),
          ),
        ]),
      ),
    );
  }
}

// ─── Empty State ─────────────────────────────────────────────────────────────

class _EmptyLogState extends StatelessWidget {
  final String metricLabel;
  const _EmptyLogState({required this.metricLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Column(children: [
        Icon(LucideIcons.clipboardList, size: 56, color: Colors.grey.withValues(alpha: 0.3)),
        const SizedBox(height: 16),
        Text(
          'No $metricLabel logs yet',
          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Tap the button below to log your first $metricLabel measurement.',
          style: GoogleFonts.outfit(color: Colors.grey, fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
