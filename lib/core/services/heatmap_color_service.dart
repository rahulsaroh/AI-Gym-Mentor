import 'package:flutter/material.dart';

class HeatmapColorService {
  // Volume thresholds per muscle group (in kg) — tune these
  static const Map<String, double> _maxVolume = {
    'chest': 6000,
    'back': 8000,
    'quads': 9000,
    'hamstrings': 5000,
    'shoulders': 4000,
    'biceps': 3000,
    'triceps': 3000,
    'calves': 4000,
    'abs': 2000,
    'glutes': 7000,
  };

  double normalize(String muscle, double volume) {
    final max = _maxVolume[muscle.toLowerCase()] ?? 5000;
    return (volume / max).clamp(0.0, 1.0);
  }

  Color colorForLoad(double normalized) {
    if (normalized == 0) return const Color(0xFFBDBDBD); // grey — untrained

    if (normalized < 0.5) {
      // grey → yellow (0 to 0.5)
      return Color.lerp(
        const Color(0xFFBDBDBD),
        const Color(0xFFFFEB3B),
        normalized * 2,
      )!;
    } else {
      // yellow → orange → red (0.5 to 1.0)
      final t = (normalized - 0.5) * 2;
      return Color.lerp(
        const Color(0xFFFFEB3B),
        const Color(0xFFE53935),
        t,
      )!;
    }
  }

  Color colorForDoms(double domsScore) {
    // Purple tint for soreness overlay — distinct from volume
    return Color.lerp(
      Colors.transparent,
      const Color(0xFF7C4DFF),
      domsScore,
    )!;
  }
}
