import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/analytics/measurements_repository.dart';
import 'package:ai_gym_mentor/core/services/golden_ratio_service.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart' as ent;

/// Animated donut ring showing how close each body measurement is to
/// the Steve-Reeves Golden Ratio ideal, derived from height + sex.
class GoldenRatioRingCard extends ConsumerStatefulWidget {
  const GoldenRatioRingCard({super.key});
  @override
  ConsumerState<GoldenRatioRingCard> createState() => _GoldenRatioRingCardState();
}

class _GoldenRatioRingCardState extends ConsumerState<GoldenRatioRingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  int _lastSegCount = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  static const _defs = [
    ('chest', 'Chest'), ('shoulders', 'Shoulders'), ('waist', 'Waist'),
    ('hips', 'Hips'), ('armLeft', 'Bicep L'), ('armRight', 'Bicep R'),
    ('thighLeft', 'Thigh L'), ('thighRight', 'Thigh R'),
    ('calfLeft', 'Calf L'), ('calfRight', 'Calf R'),
  ];

  double? _extract(ent.BodyMeasurement? m, String key) {
    if (m == null) return null;
    switch (key) {
      case 'chest':      return m.chest;
      case 'shoulders':  return m.shoulders;
      case 'waist':      return m.waist;
      case 'hips':       return m.hips;
      case 'armLeft':    return m.armLeft;
      case 'armRight':   return m.armRight;
      case 'thighLeft':  return m.thighLeft;
      case 'thighRight': return m.thighRight;
      case 'calfLeft':   return m.calfLeft;
      case 'calfRight':  return m.calfRight;
      default: return null;
    }
  }

  List<_Seg> _buildSegs(Map<String, double> targets, ent.BodyMeasurement? latest) {
    return _defs.map(((key, label)) {
      final tgt = targets[key];
      if (tgt == null || tgt <= 0) return null;
      final cur = _extract(latest, key);
      final hasData = cur != null && cur > 0;
      final ratio = hasData ? (cur! <= tgt ? cur / tgt : tgt / cur).clamp(0.0, 1.0) : 0.0;
      return _Seg(key: key, label: label, ratio: ratio, hasData: hasData, target: tgt, current: cur);
    }).whereType<_Seg>().toList();
  }

  static Color _segColor(double r) => r >= 0.9
      ? const Color(0xFF2ECC71)
      : r >= 0.7 ? const Color(0xFFF39C12) : const Color(0xFFE74C3C);

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider).value;
    if (settings == null || settings.height <= 0) return const SizedBox.shrink();

    final targets = GoldenRatioService.calculateTargets(heightCm: settings.height, sex: settings.sex);
    final measAsync = ref.watch(bodyMeasurementsListProvider);

    return measAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (measurements) {
        final sorted = [...measurements]..sort((a, b) => b.date.compareTo(a.date));
        final latest = sorted.firstOrNull;
        final segs = _buildSegs(targets, latest);

        if (segs.length != _lastSegCount) {
          _lastSegCount = segs.length;
          _ctrl.forward(from: 0);
        }

        final withData = segs.where((s) => s.hasData).toList();
        final avgRatio = withData.isEmpty
            ? 0.0
            : withData.fold(0.0, (acc, s) => acc + s.ratio) / withData.length;
        final scorePct = (avgRatio * 100).round();

        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFFBEE), Color(0xFFFFF3C4)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFFFE07A).withValues(alpha: 0.6), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withValues(alpha: 0.10),
                blurRadius: 24, offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(LucideIcons.sparkles, color: Color(0xFFD4A017), size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Golden Ratio Progress',
                            style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w800, color: const Color(0xFF1A1A2E))),
                        Text(
                          'Steve Reeves ideal · ${settings.height.toInt()}cm ${settings.sex.name}',
                          style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF9098A3)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _anim,
                builder: (_, __) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 136, height: 136,
                      child: CustomPaint(
                        painter: _RingPainter(segs: segs, animVal: _anim.value),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('$scorePct%',
                                  style: GoogleFonts.outfit(fontSize: 26, fontWeight: FontWeight.w900, color: const Color(0xFF1A1A2E), height: 1)),
                              Text('ideal',
                                  style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF9098A3), fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: segs.take(6).map((s) {
                          final pct = (s.ratio * 100).round();
                          final c = s.hasData ? _segColor(s.ratio) : const Color(0xFFDDDDDD);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                SizedBox(width: 62,
                                  child: Text(s.label,
                                      style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E)))),
                                Expanded(
                                  child: Stack(children: [
                                    Container(height: 6, decoration: BoxDecoration(color: const Color(0xFFEEEEEE), borderRadius: BorderRadius.circular(3))),
                                    FractionallySizedBox(
                                      widthFactor: (s.ratio * _anim.value).clamp(0.0, 1.0),
                                      child: Container(height: 6, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(3))),
                                    ),
                                  ]),
                                ),
                                const SizedBox(width: 6),
                                SizedBox(width: 28,
                                  child: Text(
                                    s.hasData ? '$pct%' : '--',
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w700,
                                        color: s.hasData ? const Color(0xFF1A1A2E) : const Color(0xFFCCCCCC)),
                                  )),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              if (withData.isEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700).withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('Log body measurements to see your golden ratio progress',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF9098A3))),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Dot(color: const Color(0xFF2ECC71), label: '≥90%'),
                  const SizedBox(width: 16),
                  _Dot(color: const Color(0xFFF39C12), label: '70–90%'),
                  const SizedBox(width: 16),
                  _Dot(color: const Color(0xFFE74C3C), label: '<70%'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Seg {
  final String key, label;
  final double ratio, target;
  final double? current;
  final bool hasData;
  const _Seg({required this.key, required this.label, required this.ratio,
      required this.target, required this.current, required this.hasData});
}

class _RingPainter extends CustomPainter {
  final List<_Seg> segs;
  final double animVal;
  const _RingPainter({required this.segs, required this.animVal});

  static Color _color(double r) => r >= 0.9
      ? const Color(0xFF2ECC71)
      : r >= 0.7 ? const Color(0xFFF39C12) : const Color(0xFFE74C3C);

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width * 0.43;
    const sw = 13.0, gap = 0.045;
    final n = segs.length;
    if (n == 0) return;
    final seg = (2 * math.pi - n * gap) / n;
    for (int i = 0; i < n; i++) {
      final s = segs[i];
      final start = -math.pi / 2 + i * (seg + gap);
      final rect = Rect.fromCircle(center: c, radius: r);
      canvas.drawArc(rect, start, seg, false, Paint()
        ..color = const Color(0xFFEEEEEE)
        ..style = PaintingStyle.stroke
        ..strokeWidth = sw
        ..strokeCap = StrokeCap.round);
      if (!s.hasData || s.ratio <= 0) continue;
      final fill = seg * s.ratio * animVal;
      canvas.drawArc(rect, start, fill, false, Paint()
        ..color = _color(s.ratio)
        ..style = PaintingStyle.stroke
        ..strokeWidth = sw
        ..strokeCap = StrokeCap.round);
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.animVal != animVal || old.segs.length != segs.length;
}

class _Dot extends StatelessWidget {
  final Color color;
  final String label;
  const _Dot({required this.color, required this.label});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 5),
      Text(label, style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF9098A3), fontWeight: FontWeight.w600)),
    ],
  );
}
