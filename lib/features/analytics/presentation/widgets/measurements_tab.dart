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
import 'package:go_router/go_router.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _OverallProgressCard(physique: physique),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('MY MEASUREMENTS',
                            style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2)),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(LucideIcons.notebookText, 
                                size: 22, 
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
                                    size: 22,
                                    color: Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...physique.achievements
                      .where((a) => standardMetrics.any((m) => m.id == a.metric))
                      .map((a) => _MeasurementItem(
                            achievement: a,
                            onTap: () => _openDetailScreen(context, a),
                          )),
                  if (physique.achievements.any((a) => !standardMetrics.any((m) => m.id == a.metric))) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8, left: 8),
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
                  const SizedBox(height: 100),
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

class _OverallProgressCard extends ConsumerWidget {
  final PhysiqueAchievement physique;
  const _OverallProgressCard({required this.physique});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateRange = ref.watch(measurementDateRangeProvider);
    final pct = (physique.overallScore.clamp(0.0, 1.0) * 100).toInt();
    final isImproving = physique.rawOverallScore >= 0;
    final theme = Theme.of(context);

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
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(children: [
        const MeasurementIntervalSelector(),
        const SizedBox(height: 32),

        SizedBox(
          height: 180,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            CustomPaint(
              size: const Size(280, 140),
              painter: _GaugePainter(
                score: physique.overallScore.clamp(0.0, 1.0) * 100,
              ),
            ),
            Positioned(
              bottom: 40,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('$pct%',
                    style: GoogleFonts.outfit(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF1A1A2E))),
                const SizedBox(height: 4),
                Text(
                  'Log to view score!',
                  style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF9098A3)),
                ),
                const SizedBox(height: 12),
                _StadiumButton(
                  label: 'Set your target',
                  onTap: () => context.push('/analytics/manage-measurements'),
                ),
              ]),
            ),
          ]),
        ),

        const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _LegendDot(color: const Color(0xFF3D6FE8), label: 'Start'),
          const SizedBox(width: 20),
          _LegendDot(color: const Color(0xFF2ECC71), label: 'Growth'),
          const SizedBox(width: 20),
          _LegendDot(color: const Color(0xFFE74C3C), label: 'Decline'),
        ]),

        const SizedBox(height: 24),
        Text(
          'BODY ACHIEVEMENT SCORE',
          style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              color: const Color(0xFF1A1A2E)),
        ),
        const SizedBox(height: 20),
        _StadiumButton(
          label: 'Clear period',
          icon: LucideIcons.x,
          onTap: () => ref.read(measurementDateRangeProvider.notifier).clear(),
        ),

          _StadiumButton(
            label: 'Clear period',
            icon: LucideIcons.x,
            onTap: () => ref.read(measurementDateRangeProvider.notifier).clear(),
          ),
      ]),
    );
  }
}

class _StadiumButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  const _StadiumButton({
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE0E3EB)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: const Color(0xFF9098A3)),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF9098A3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeasurementIntervalSelector extends ConsumerWidget {
  const MeasurementIntervalSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedMeasurementIntervalProvider);
    return SizedBox(
      height: 52,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: MeasurementInterval.values.map((interval) {
              final isSelected = selected == interval;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
    
    return BouncingCard(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        constraints: const BoxConstraints(minWidth: 60),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3D6FE8) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFFE0E3EB),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF9098A3),
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
        width: 10, height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 8),
      Text(label,
          style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black.withValues(alpha: 0.6))),
    ]);
  }
}

class _GaugePainter extends CustomPainter {
  final double score;

  _GaugePainter({required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    const strokeWidth = 20.0;

    // 1. Ticks outside the arc
    final tickPaint = Paint()
      ..color = const Color(0xFF9098A3).withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = 0; i <= 20; i++) {
      final angle = math.pi + (i * math.pi / 20);
      final innerR = radius + 4;
      final outerR = radius + 14;
      canvas.drawLine(
        Offset(center.dx + innerR * math.cos(angle), center.dy + innerR * math.sin(angle)),
        Offset(center.dx + outerR * math.cos(angle), center.dy + outerR * math.sin(angle)),
        tickPaint,
      );
    }

    // 2. Main Metallic Arc
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);
    
    // Background arc with 3D inset effect
    final bgPaint = Paint()
      ..color = const Color(0xFFE0E3EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, math.pi, math.pi, false, bgPaint);

    // Metallic gradient arc
    final metallicPaint = Paint()
      ..shader = SweepGradient(
        colors: const [
          Color(0xFFC8CDD6),
          Color(0xFFE8EAF0),
          Color(0xFFB0B5C0),
          Color(0xFFE8EAF0),
          Color(0xFFC8CDD6),
        ],
        stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
        startAngle: math.pi,
        endAngle: math.pi * 2,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth - 2 // Slightly thinner for inset look
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, math.pi, math.pi, false, metallicPaint);

    // 3. Progress Fill (if needed, though prompt implies 0% initially)
    if (score > 0) {
      final progressPaint = Paint()
        ..color = const Color(0xFF3D6FE8).withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(rect, math.pi, math.pi * (score / 100), false, progressPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter old) => old.score != score;
}

class _MeasurementItem extends StatelessWidget {
  final MetricAchievement achievement;
  final VoidCallback onTap;
  const _MeasurementItem({required this.achievement, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final achRatio = achievement.achievementRatio;
    final unit = _unitFor(achievement.metric);
    final hasData = achievement.currentValue > 0;
    final theme = Theme.of(context);

    return BouncingCard(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Icon placeholder (48x48)
                  Builder(builder: (context) {
                    final cfg = standardMetrics.where((m) => m.id == achievement.metric).firstOrNull;
                    return Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F3F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: (cfg?.assetPath != null)
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(cfg!.assetPath!, fit: BoxFit.contain),
                              )
                            : Icon(cfg?.icon ?? LucideIcons.activity,
                                color: const Color(0xFF3D6FE8), size: 24),
                      ),
                    );
                  }),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement.label,
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          !hasData
                              ? 'No records logged. Tap to add.'
                              : 'Current: ${achievement.currentValue.toStringAsFixed(1)} $unit',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: const Color(0xFF9098A3),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Circular + button
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D6FE8).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      LucideIcons.plus,
                      size: 20,
                      color: Color(0xFF3D6FE8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    LucideIcons.chevronRight,
                    size: 20,
                    color: Color(0xFF9098A3),
                  ),
                ],
              ),
            ),

            // Progress bar at the very bottom edge
            Container(
              height: 4,
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xFFE0E3EB)),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: hasData && achievement.targetValue > 0 
                    ? achRatio.clamp(0.0, 1.0) 
                    : 0.05, // Subtle fill for "no data" look
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF3D6FE8),
                  ),
                ),
              ),
            ),
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
      default: return LucideIcons.activity;
    }
  }
}

// ─── Extracted Widgets ──────────────────────────────────────────────────

class _OverallMiniTrendline extends ConsumerWidget {
  const _OverallMiniTrendline();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendAsync = ref.watch(overallAchievementTrendProvider);
    return trendAsync.when(
      data: (spots) {
        if (spots.length < 2) return const SizedBox.shrink();
        return LineChart(LineChartData(gridData: const FlGridData(show: false), titlesData: const FlTitlesData(show: false), borderData: FlBorderData(show: false), minX: spots.first.x, maxX: spots.last.x, minY: -0.1, maxY: 1.1, lineBarsData: [LineChartBarData(spots: spots, isCurved: true, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5), barWidth: 2, isStrokeCapRound: true, dotData: const FlDotData(show: false), belowBarData: BarAreaData(show: true, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05)))]));
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
