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
            Builder(
              builder: (context) => SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _OverallProgressCard(physique: physique),
                  const SizedBox(height: 20),
                  _MeasurementsSectionHeader(
                    onManage: () => _openManageMeasurementsScreen(context),
                    onLog: () => _openLogScreen(context),
                  ),
                  const SizedBox(height: 12),
                  ...physique.achievements
                      .where((a) => standardMetrics.any((m) => m.id == a.metric))
                      .map((a) => _MeasurementItem(
                            achievement: a,
                            onTap: () => _openDetailScreen(context, a),
                          )),
                  if (physique.achievements.any((a) => !standardMetrics.any((m) => m.id == a.metric))) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8, left: 4),
                      child: Text(
                        'CUSTOM MEASUREMENTS',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
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

// ─── Section Header ──────────────────────────────────────────────────────────

class _MeasurementsSectionHeader extends StatelessWidget {
  final VoidCallback onManage;
  final VoidCallback onLog;

  const _MeasurementsSectionHeader({
    required this.onManage,
    required this.onLog,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'MY MEASUREMENTS',
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              color: const Color(0xFF1A1A2E),
            ),
          ),
          Row(
            children: [
              _IconActionButton(
                icon: LucideIcons.notebookText,
                tooltip: 'Manage Logs',
                onTap: onManage,
              ),
              const SizedBox(width: 4),
              _IconActionButton(
                icon: LucideIcons.pencil,
                tooltip: 'Log Measurement',
                onTap: onLog,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _IconActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: primary),
        ),
      ),
    );
  }
}

// ─── Overall Progress Card ────────────────────────────────────────────────────

class _OverallProgressCard extends StatelessWidget {
  final PhysiqueAchievement physique;
  const _OverallProgressCard({required this.physique});

  @override
  Widget build(BuildContext context) {
    final pct = (physique.overallScore.clamp(0.0, 1.0) * 100).toInt();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Period selector
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: const MeasurementIntervalSelector(),
          ),

          const SizedBox(height: 8),

          // Gauge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _GaugeWidget(
              score: physique.overallScore.clamp(0.0, 1.0) * 100,
              pct: pct,
            ),
          ),

          const SizedBox(height: 16),

          // Legend row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _LegendDot(color: Color(0xFF3D6FE8), label: 'Start'),
              SizedBox(width: 20),
              _LegendDot(color: Color(0xFF2ECC71), label: 'Growth'),
              SizedBox(width: 20),
              _LegendDot(color: Color(0xFFE74C3C), label: 'Decline'),
            ],
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              'BODY ACHIEVEMENT SCORE',
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.8,
                color: const Color(0xFF1A1A2E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Gauge Widget ─────────────────────────────────────────────────────────────

class _GaugeWidget extends StatelessWidget {
  final double score;
  final int pct;

  const _GaugeWidget({required this.score, required this.pct});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Gauge painter
          Center(
            child: CustomPaint(
              size: const Size(280, 145),
              painter: _GaugePainter(score: score),
            ),
          ),

          // Content inside gauge
          Positioned(
            bottom: 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$pct%',
                  style: GoogleFonts.outfit(
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1A1A2E),
                    height: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Log to view score!',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF9098A3),
                  ),
                ),
                const SizedBox(height: 14),
                _StadiumButton(
                  label: 'Set your target',
                  onTap: () => context.push('/analytics/manage-measurements'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stadium Button ───────────────────────────────────────────────────────────

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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFDDE1EA), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 13, color: const Color(0xFF9098A3)),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF9098A3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Interval Selector ───────────────────────────────────────────────────────

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
    return BouncingCard(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: const BoxConstraints(minWidth: 52),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3D6FE8) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFFE0E3EB),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF3D6FE8).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF9098A3),
          ),
        ),
      ),
    );
  }
}

// ─── Legend Dot ──────────────────────────────────────────────────────────────

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF6B7280),
        ),
      ),
    ]);
  }
}

// ─── Gauge Painter ───────────────────────────────────────────────────────────

class _GaugePainter extends CustomPainter {
  final double score;

  _GaugePainter({required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    const strokeWidth = 22.0;

    // 1. Tick marks outside arc
    final tickPaint = Paint()
      ..color = const Color(0xFF9098A3).withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = 0; i <= 20; i++) {
      final angle = math.pi + (i * math.pi / 20);
      final innerR = radius + 5;
      final outerR = radius + 16;
      canvas.drawLine(
        Offset(center.dx + innerR * math.cos(angle), center.dy + innerR * math.sin(angle)),
        Offset(center.dx + outerR * math.cos(angle), center.dy + outerR * math.sin(angle)),
        tickPaint,
      );
    }

    final arcRect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    // 2. Background arc — light grey groove
    final bgPaint = Paint()
      ..color = const Color(0xFFE2E5ED)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, math.pi, math.pi, false, bgPaint);

    // 3. Metallic sheen overlay
    final metallicPaint = Paint()
      ..shader = SweepGradient(
        colors: const [
          Color(0xFFCAD0DC),
          Color(0xFFECEFF6),
          Color(0xFFB8BEC9),
          Color(0xFFECEFF6),
          Color(0xFFCAD0DC),
        ],
        stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
        startAngle: math.pi,
        endAngle: math.pi * 2,
      ).createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth - 4
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, math.pi, math.pi, false, metallicPaint);

    // 4. Progress fill
    if (score > 0) {
      final progressPaint = Paint()
        ..color = const Color(0xFF3D6FE8).withValues(alpha: 0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(arcRect, math.pi, math.pi * (score / 100), false, progressPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter old) => old.score != score;
}

// ─── Measurement Item Card ────────────────────────────────────────────────────

class _MeasurementItem extends StatelessWidget {
  final MetricAchievement achievement;
  final VoidCallback onTap;
  const _MeasurementItem({required this.achievement, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final unit = _unitFor(achievement.metric);
    final hasData = achievement.currentValue > 0;

    return BouncingCard(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
              child: Row(
                children: [
                  // Icon container
                  Builder(builder: (context) {
                    final cfg = standardMetrics.where((m) => m.id == achievement.metric).firstOrNull;
                    return Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4F8),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: (cfg?.assetPath != null)
                            ? Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Image.asset(cfg!.assetPath!, fit: BoxFit.contain),
                              )
                            : Icon(
                                cfg?.icon ?? LucideIcons.activity,
                                color: const Color(0xFF3D6FE8),
                                size: 22,
                              ),
                      ),
                    );
                  }),
                  const SizedBox(width: 14),

                  // Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement.label,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          !hasData
                              ? 'No records logged. Tap to add.'
                              : 'Current: ${achievement.currentValue.toStringAsFixed(1)} $unit',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: const Color(0xFF9098A3),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Achievement percentage or Change percentage
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D6FE8).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: achievement.targetValue > 0
                          ? Text(
                              '${(achievement.achievementRatio.clamp(0.0, 1.0) * 100).toInt()}%',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF3D6FE8),
                              ),
                            )
                          : Text(
                              _getChangeLabel(achievement),
                              style: GoogleFonts.outfit(
                                fontSize: achievement.startValue == 0 ? 11 : 10,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF3D6FE8),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    LucideIcons.chevronRight,
                    size: 18,
                    color: Color(0xFFBCC1CC),
                  ),
                ],
              ),
            ),

            // Progress bar at bottom
            Container(
              height: 4,
              width: double.infinity,
              color: const Color(0xFFEDF0F7),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: hasData && achievement.targetValue > 0
                    ? achievement.percentage.clamp(0.0, 1.0)
                    : 0.04,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF5B87F0), Color(0xFF3D6FE8)],
                    ),
                    borderRadius: BorderRadius.circular(2),
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

  String _getChangeLabel(MetricAchievement a) {
    if (a.startValue == 0 || a.currentValue == 0) return 'NEW';
    final change = ((a.currentValue - a.startValue) / a.startValue) * 100;
    if (change.abs() < 0.1) return '0%';
    final sign = change > 0 ? '+' : '';
    return '$sign${change.toStringAsFixed(1)}%';
  }
}

// ─── Extracted Trendline Widget ──────────────────────────────────────────────

class _OverallMiniTrendline extends ConsumerWidget {
  const _OverallMiniTrendline();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendAsync = ref.watch(overallAchievementTrendProvider);
    return trendAsync.when(
      data: (spots) {
        if (spots.length < 2) return const SizedBox.shrink();
        return LineChart(LineChartData(
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
        ));
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
