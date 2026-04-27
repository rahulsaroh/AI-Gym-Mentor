import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_achievement.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/metric_detail_screen.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/body_measurements_log_screen.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/manage_measurements_screen.dart';
import 'package:ai_gym_mentor/core/widgets/bouncing_card.dart';

class MeasurementsTab extends ConsumerWidget {
  const MeasurementsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementAsync = ref.watch(physiqueAchievementProvider);

    return achievementAsync.when(
      data: (physique) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            Builder(builder: (context) => SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            )),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _OverallProgressCard(physique: physique),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('MY MEASUREMENTS',
                          style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2)),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(LucideIcons.notebookText, 
                              size: 20, 
                              color: Theme.of(context).colorScheme.primary),
                            onPressed: () => _openManageMeasurementsScreen(context),
                            tooltip: 'Manage Logs',
                          ),
                          InkWell(
                            onTap: () => _openLogScreen(context),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Icon(LucideIcons.pencil,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Always show all standard metrics
                  ...physique.achievements
                      .where((a) => standardMetrics.any((m) => m.id == a.metric))
                      .map((a) => _MeasurementItem(
                            achievement: a,
                            onTap: () => _openDetailScreen(context, a),
                          )),
                  // Custom metric cards
                  if (physique.achievements.any((a) => !standardMetrics.any((m) => m.id == a.metric))) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text('CUSTOM MEASUREMENTS',
                          style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Theme.of(context).colorScheme.outline)),
                    ),
                    ...physique.achievements
                        .where((a) => !standardMetrics.any((m) => m.id == a.metric))
                        .map((a) => _MeasurementItem(
                              achievement: a,
                              onTap: () => _openDetailScreen(context, a),
                            )),
                  ],
                  const SizedBox(height: 80),
                ]),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  void _openLogScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const BodyMeasurementsLogScreen()));
  }

  void _openDetailScreen(BuildContext context, MetricAchievement a) {
    // Find config for icon/unit
    final cfg = standardMetrics.where((m) => m.id == a.metric).firstOrNull;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MetricDetailScreen(
          metricId: a.metric,
          metricLabel: a.label,
          unit: cfg?.unit ?? _unitFor(a.metric),
          lowerIsBetter: cfg?.lowerIsBetter ?? false,
        ),
      ),
    );
  }

  String _unitFor(String m) {
    final cfg = standardMetrics.where((cfg) => cfg.id == m).firstOrNull;
    if (cfg != null) return cfg.unit;
    if (m == 'bodyFat' || m == 'subcutaneousFat' || m == 'visceralFat') return '%';
    return 'cm';
  }

  void _openManageMeasurementsScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const ManageMeasurementsScreen()));
  }
}

// ─── Overall Progress Card ─────────────────────────────────────────────────

class _OverallProgressCard extends ConsumerWidget {
  final PhysiqueAchievement physique;
  const _OverallProgressCard({required this.physique});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateRange = ref.watch(measurementDateRangeProvider);
    final pct = (physique.overallScore.clamp(0.0, 1.0) * 100).toInt();
    final isImproving = physique.rawOverallScore >= 0;
    final progressColor = isImproving ? Colors.green : Colors.red;

    final withTarget = physique.achievements.where((a) => a.targetValue > 0).toList();
    double startRatio = 0;
    if (withTarget.isNotEmpty) {
      double totalStart = 0;
      for (final a in withTarget) {
        if (a.targetValue > 0 && a.startValue > 0) {
          final r = (a.startValue <= a.targetValue)
              ? a.startValue / a.targetValue
              : a.targetValue / a.startValue;
          totalStart += r.clamp(0.0, 1.0);
        }
      }
      startRatio = (totalStart / withTarget.length).clamp(0.0, 1.0);
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 20, offset: const Offset(0, 8)),
        ],
        border: Border.all(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
      ),
      child: Column(children: [
        const MeasurementIntervalSelector(),
        const SizedBox(height: 24),

        SizedBox(
          height: 120,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            CustomPaint(
              size: const Size(220, 110),
              painter: _GaugePainter(
                startRatio: startRatio,
                currentRatio: physique.overallScore.clamp(0.0, 1.0),
                isImproving: isImproving,
                hasTarget: withTarget.isNotEmpty,
                backgroundColor: Colors.grey.withValues(alpha: 0.15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('$pct%',
                    style: GoogleFonts.outfit(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: withTarget.isEmpty ? Colors.grey : progressColor)),
                Text(
                  withTarget.isEmpty
                      ? 'Set targets to track'
                      : isImproving ? '▲ Improving' : '▼ Regressing',
                  style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: (withTarget.isEmpty ? Colors.grey : progressColor)
                          .withValues(alpha: 0.8)),
                ),
              ]),
            ),
          ]),
        ),

        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _LegendDot(color: const Color(0xFF3B82F6), label: 'Start'),
          const SizedBox(width: 12),
          _LegendDot(color: Colors.green, label: 'Growth'),
          const SizedBox(width: 12),
          _LegendDot(color: Colors.red, label: 'Decline'),
        ]),

        const SizedBox(height: 8),
        Text('BODY ACHIEVEMENT SCORE',
            style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                letterSpacing: 1.1)),

        if (dateRange != null) ...[
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () =>
                ref.read(measurementDateRangeProvider.notifier).clear(),
            icon: const Icon(LucideIcons.x, size: 14),
            label: Text('Clear period',
                style: GoogleFonts.outfit(fontSize: 12)),
            style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 8)),
          ),
        ],
      ]),
    );
  }
}

class MeasurementIntervalSelector extends ConsumerWidget {
  const MeasurementIntervalSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedMeasurementIntervalProvider);
    return SizedBox(
      height: 44,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: MeasurementInterval.values.map((interval) {
              final isSelected = selected == interval;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _IntervalPill(
                  label: interval.label,
                  isSelected: isSelected,
                  onTap: () {
                    ref.read(selectedMeasurementIntervalProvider.notifier).set(interval);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _IntervalPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _IntervalPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: const BoxConstraints(minWidth: 50),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? primary : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primary : theme.dividerColor.withValues(alpha: 0.15),
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 8, height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 4),
      Text(label,
          style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey)),
    ]);
  }
}

class _GaugePainter extends CustomPainter {
  final double startRatio;
  final double currentRatio;
  final bool isImproving;
  final bool hasTarget;
  final Color backgroundColor;

  _GaugePainter({
    required this.startRatio,
    required this.currentRatio,
    required this.isImproving,
    required this.hasTarget,
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

    if (hasTarget) {
      final blueEnd = startRatio.clamp(0.0, 1.0);
      final greenEnd = currentRatio.clamp(0.0, 1.0);
      final activeColor = isImproving ? Colors.green : Colors.red;

      if (blueEnd > 0.001) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          math.pi,
          math.pi * blueEnd,
          false,
          Paint()
            ..color = const Color(0xFF3B82F6)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 16
            ..strokeCap = StrokeCap.round,
        );
      }

      if (greenEnd > blueEnd + 0.001) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          math.pi + math.pi * blueEnd,
          math.pi * (greenEnd - blueEnd),
          false,
          Paint()
            ..shader = SweepGradient(
              colors: [activeColor.withValues(alpha: 0.6), activeColor],
              startAngle: math.pi,
              endAngle: math.pi * 2,
            ).createShader(Rect.fromCircle(center: center, radius: radius))
            ..style = PaintingStyle.stroke
            ..strokeWidth = 16
            ..strokeCap = StrokeCap.round,
        );
      } else if (greenEnd < blueEnd - 0.001) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          math.pi + math.pi * greenEnd,
          math.pi * (blueEnd - greenEnd),
          false,
          Paint()
            ..color = Colors.red
            ..style = PaintingStyle.stroke
            ..strokeWidth = 16
            ..strokeCap = StrokeCap.round,
        );
      }
    }

    final outerR = radius + 20;
    final tickPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (double i = math.pi; i <= math.pi * 2; i += 0.18) {
      canvas.drawLine(
        Offset(center.dx + outerR * math.cos(i),
            center.dy + outerR * math.sin(i)),
        Offset(center.dx + (outerR + 5) * math.cos(i),
            center.dy + (outerR + 5) * math.sin(i)),
        tickPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter old) =>
      old.startRatio != startRatio ||
      old.currentRatio != currentRatio ||
      old.isImproving != isImproving;
}

class _MeasurementItem extends StatelessWidget {
  final MetricAchievement achievement;
  final VoidCallback onTap;
  const _MeasurementItem({required this.achievement, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final pct = achievement.percentage;
    final achRatio = achievement.achievementRatio;
    final badgePct = (achRatio * 100).toInt();
    final unit = _unitFor(achievement.metric);
    final fmt = DateFormat('d MMM yy');
    final hasData = achievement.currentValue > 0;
    final theme = Theme.of(context);

    return BouncingCard(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 15,
              offset: const Offset(0, 8),
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
              children: [
                Builder(builder: (context) {
                  final cfg = standardMetrics.where((m) => m.id == achievement.metric).firstOrNull;
                  return Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: (cfg?.assetPath != null)
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(cfg!.assetPath!, fit: BoxFit.contain),
                            )
                          : Icon(cfg?.icon ?? _iconFor(achievement.metric),
                              color: theme.colorScheme.primary, size: 22),
                    ),
                  );
                }),
                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        achievement.label,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        !hasData
                            ? 'No data logged yet — tap to log'
                            : achievement.targetValue > 0
                                ? '${achievement.currentValue.toStringAsFixed(1)} $unit  (Start: ${achievement.startValue.toStringAsFixed(1)})'
                                : 'Current: ${achievement.currentValue.toStringAsFixed(1)} $unit  ·  No target set',
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: !hasData 
                              ? theme.colorScheme.primary.withValues(alpha: 0.7) 
                              : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),

                _AchievementBadge(
                  hasData: hasData,
                  hasTarget: achievement.targetValue > 0,
                  badgePct: badgePct,
                ),
                
                const SizedBox(width: 4),
                Icon(LucideIcons.chevronRight, 
                  size: 16, 
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3)
                ),
              ],
            ),

            if (hasData && achievement.targetValue > 0) ...[
              const SizedBox(height: 16),
              _SegmentedBar(
                percentage: pct,
                hasTarget: true,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Goal: ${achievement.targetValue.toStringAsFixed(1)} $unit',
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      color: theme.colorScheme.primary.withValues(alpha: 0.6),
                    ),
                  ),
                  if (achievement.deadline != null)
                    Text(
                      'Deadline: ${fmt.format(achievement.deadline!)}',
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _unitFor(String m) {
    final cfg = standardMetrics.where((cfg) => cfg.id == m).firstOrNull;
    if (cfg != null) return cfg.unit;
    if (m == 'bodyFat' || m == 'subcutaneousFat' || m == 'visceralFat') return '%';
    return 'cm';
  }

  IconData _iconFor(String m) {
    final cfg = standardMetrics.where((cfg) => cfg.id == m).firstOrNull;
    if (cfg != null) return cfg.icon;
    switch (m) {
      case 'weight': return LucideIcons.scale;
      case 'bodyFat': return LucideIcons.percent;
      case 'chest': return LucideIcons.square;
      case 'shoulders': return LucideIcons.moveHorizontal;
      case 'armLeft': case 'armRight': return LucideIcons.armchair;
      case 'waist': case 'waistNaval': return LucideIcons.minimize2;
      case 'hips': return LucideIcons.circle;
      case 'neck': return LucideIcons.user;
      default: return LucideIcons.activity;
    }
  }
}

class _AchievementBadge extends StatelessWidget {
  final bool hasData;
  final bool hasTarget;
  final int badgePct;
  const _AchievementBadge({required this.hasData, required this.hasTarget, required this.badgePct});
  @override
  Widget build(BuildContext context) {
    if (!hasData || !hasTarget) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey.withValues(alpha: 0.1)),
        child: Text('--', style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
      );
    }
    final color = badgePct >= 100 ? Colors.green : Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: color.withValues(alpha: 0.1)),
      child: Text('$badgePct%', style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
    );
  }
}

class _SegmentedBar extends StatelessWidget {
  final double percentage;
  final bool hasTarget;
  const _SegmentedBar({required this.percentage, this.hasTarget = true});
  @override
  Widget build(BuildContext context) {
    const markerW = 4.0;
    const h = 10.0;
    final clamped = percentage.clamp(-1.0, 1.0);
    final isRegression = clamped < 0;
    final abs = clamped.abs();
    final primary = const Color(0xFF3B82F6);
    return LayoutBuilder(builder: (context, constraints) {
      final total = constraints.maxWidth;
      if (!hasTarget) {
        return ClipRRect(borderRadius: BorderRadius.circular(h / 2), child: SizedBox(height: h, child: Container(color: Colors.grey.withValues(alpha: 0.2))));
      }
      final progressW = (abs * (total - markerW)).clamp(0.0, total - markerW);
      final blankW = (total - markerW - progressW).clamp(0.0, double.infinity);
      return ClipRRect(
        borderRadius: BorderRadius.circular(h / 2),
        child: SizedBox(height: h, child: Row(children: [
          if (isRegression) ...[
            Container(width: progressW, color: Colors.red),
            Container(width: markerW, color: primary),
            Container(width: blankW, color: Colors.grey.withValues(alpha: 0.2)),
          ] else ...[
            Container(width: markerW, color: primary),
            Container(width: progressW, color: Colors.green),
            Container(width: blankW, color: Colors.grey.withValues(alpha: 0.2)),
          ],
        ])),
      );
    });
  }
}

// ─── Mini Trendlines (Kept from remote for potential future use) ──────────

class _OverallMiniTrendline extends ConsumerWidget {
  const _OverallMiniTrendline();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendAsync = ref.watch(overallAchievementTrendProvider);

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
            minY: -0.1, 
            maxY: 1.1,  
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

class _MetricMiniTrendline extends ConsumerWidget {
  final String metricId;
  const _MetricMiniTrendline({required this.metricId});

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
