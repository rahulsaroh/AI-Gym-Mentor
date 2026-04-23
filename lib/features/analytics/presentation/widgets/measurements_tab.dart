import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_achievement.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/body_measurements_log_screen.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class MeasurementsTab extends ConsumerWidget {
  const MeasurementsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementAsync = ref.watch(physiqueAchievementProvider);

    return achievementAsync.when(
      data: (physique) {
        if (physique.achievements.isEmpty) {
          return _EmptyState(onTap: () => _openLogScreen(context));
        }
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
                  const SizedBox(height: 16),
                  ...physique.achievements.map((a) => _MeasurementItem(achievement: a)),
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
    final gaugeColor = isImproving ? Colors.green : Colors.red;

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
        // Header row
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('OVERALL PROGRESS',
              style: GoogleFonts.outfit(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          // Calendar icon → date range picker
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => _pickDateRange(context, ref, dateRange),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(LucideIcons.calendar, size: 16,
                    color: Theme.of(context).colorScheme.primary),
                if (dateRange != null) ...[
                  const SizedBox(width: 6),
                  Text(
                    '${DateFormat('d MMM').format(dateRange.start)} – ${DateFormat('d MMM').format(dateRange.end)}',
                    style: GoogleFonts.outfit(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ]),
            ),
          ),
        ]),

        if (dateRange == null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('Tap 📅 to set a tracking period',
                style: GoogleFonts.outfit(fontSize: 11, color: Colors.grey)),
          ),

        const SizedBox(height: 24),

        // Gauge
        SizedBox(
          height: 120,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            CustomPaint(
              size: const Size(220, 110),
              painter: _GaugePainter(
                progress: physique.overallScore.clamp(0.0, 1.0),
                activeColor: gaugeColor,
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
                        color: gaugeColor)),
                Text(
                  isImproving ? '▲ Improving' : '▼ Regressing',
                  style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: gaugeColor.withValues(alpha: 0.8)),
                ),
              ]),
            ),
          ]),
        ),

        const SizedBox(height: 12),
        Text('BODY ACHIEVEMENT SCORE',
            style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                letterSpacing: 1.1)),

        if (dateRange != null) ...[
          const SizedBox(height: 8),
          // Clear button
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

  Future<void> _pickDateRange(
      BuildContext context, WidgetRef ref, DateTimeRange? current) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: current ??
          DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 30)),
            end: DateTime.now(),
          ),
      builder: (context, child) => Theme(
        data: Theme.of(context),
        child: child!,
      ),
    );
    if (picked != null) {
      ref.read(measurementDateRangeProvider.notifier).set(picked);
    }
  }
}

// ─── Gauge Painter ─────────────────────────────────────────────────────────

class _GaugePainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color backgroundColor;

  _GaugePainter(
      {required this.progress,
      required this.activeColor,
      required this.backgroundColor});

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

    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        math.pi, math.pi * progress, false,
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
    }

    // Tick marks
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
      old.progress != progress || old.activeColor != activeColor;
}

// ─── Measurement Item Card ─────────────────────────────────────────────────

class _MeasurementItem extends StatelessWidget {
  final MetricAchievement achievement;
  const _MeasurementItem({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final pct = achievement.percentage;        // used for progress bar (journey)
    final achRatio = achievement.achievementRatio; // used for badge (absolute)
    final badgePct = (achRatio * 100).toInt();
    final unit = _unitFor(achievement.metric);
    final fmt = DateFormat('d MMM yy');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10, offset: const Offset(0, 4)),
        ],
        border: Border.all(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.05)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          // Icon
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            ),
            child: Icon(_iconFor(achievement.metric),
                color: Theme.of(context).colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 14),

          // Label + values
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(achievement.label,
                  style: GoogleFonts.outfit(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(
                achievement.targetValue > 0
                    ? '${achievement.startValue.toStringAsFixed(1)} → '
                      '${achievement.currentValue.toStringAsFixed(1)} $unit'
                      '  ·  Goal: ${achievement.targetValue.toStringAsFixed(1)} $unit'
                    : achievement.currentValue > 0
                        ? 'Current: ${achievement.currentValue.toStringAsFixed(1)} $unit  ·  No target set'
                        : 'No data logged yet',
                style: GoogleFonts.outfit(fontSize: 11, color: Colors.grey),
              ),
              if (achievement.startDate != null && achievement.deadline != null)
                Text(
                  '${fmt.format(achievement.startDate!)} – ${fmt.format(achievement.deadline!)}',
                  style: GoogleFonts.outfit(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.primary
                          .withValues(alpha: 0.7)),
                ),
            ],
          )),

          // % badge  — achievementRatio: how close to target right now
          Builder(builder: (context) {
            if (achievement.targetValue <= 0) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.withValues(alpha: 0.1),
                  border: Border.all(color: Colors.grey, width: 1.5),
                ),
                child: Text('--',
                    style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              );
            }
            // Badge is always themed green (achieved %) — no red here
            // Red/green logic lives in the progress bar below
            final color = badgePct >= 100
                ? Colors.green
                : Theme.of(context).colorScheme.primary;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: color.withValues(alpha: 0.1),
                border: Border.all(color: color, width: 1.5),
              ),
              child: Text('$badgePct%',
                  style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color)),
            );
          }),
        ]),

        const SizedBox(height: 14),
        _SegmentedBar(
            percentage: pct,
            hasTarget: achievement.targetValue > 0),
      ]),
    );
  }

  String _unitFor(String m) {
    if (m == 'weight') return 'kg';
    if (m == 'bodyFat' || m == 'subcutaneousFat' || m == 'visceralFat') return '%';
    return 'cm';
  }

  IconData _iconFor(String m) {
    switch (m) {
      case 'weight': return LucideIcons.scale;
      case 'bodyFat': return LucideIcons.percent;
      case 'chest': return LucideIcons.square;
      case 'shoulders': return LucideIcons.moveHorizontal;
      case 'armLeft': case 'armRight': return LucideIcons.armchair;
      case 'waist': return LucideIcons.minimize2;
      case 'hips': return LucideIcons.circle;
      case 'neck': return LucideIcons.user;
      default: return LucideIcons.activity;
    }
  }
}

// ─── 3-segment progress bar ────────────────────────────────────────────────
// [BLUE thin marker = start] [GREEN = progress] [BLANK = remaining]
// Regression: [RED] [BLUE] [BLANK]

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
    final primary = Theme.of(context).colorScheme.primary;

    return LayoutBuilder(builder: (context, constraints) {
      final total = constraints.maxWidth;

      // No target: show fully grey bar
      if (!hasTarget) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(h / 2),
          child: SizedBox(
            height: h,
            child: Container(color: Colors.grey.withValues(alpha: 0.2)),
          ),
        );
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

// ─── Empty State ───────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final VoidCallback onTap;
  const _EmptyState({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(LucideIcons.target, size: 64,
            color: Colors.grey.withValues(alpha: 0.4)),
        const SizedBox(height: 16),
        Text('No Measurements Yet',
            style: GoogleFonts.outfit(
                fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Tap below to log measurements\nand set your targets.',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(color: Colors.grey)),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: onTap,
          icon: const Icon(LucideIcons.plus),
          label: Text('Log Measurements',
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        ),
      ],
    ));
  }
}
