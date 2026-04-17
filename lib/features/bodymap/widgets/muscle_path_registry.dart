import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class MusclePathRegistry {
  static Map<String, Path> getFrontPaths() {
    return {
      'chest': _path('M70 75 Q100 85 130 75 L130 100 Q100 110 70 100 Z'),
      'shoulders': _combine([
        _oval(60, 75, 15, 12), // left deltoid
        _oval(140, 75, 15, 12), // right deltoid
      ]),
      'biceps': _combine([
        _oval(50, 110, 10, 25),
        _oval(150, 110, 10, 25),
      ]),
      'abs': _combine([
        _path('M85 105 L115 105 L115 160 L85 160 Z'), // rectus
        _path('M70 105 L85 105 L85 160 L70 150 Z'), // left oblique
        _path('M115 105 L130 105 L130 150 L115 160 Z'), // right oblique
      ]),
      'quads': _combine([
        _oval(75, 230, 18, 45),
        _oval(125, 230, 18, 45),
      ]),
      'calves': _combine([
        _oval(75, 320, 12, 35),
        _oval(125, 320, 12, 35),
      ]),
    };
  }

  static Map<String, Path> getBackPaths() {
    return {
      'back': _combine([
        _path('M70 60 Q100 70 130 60 L130 85 Q100 95 70 85 Z'), // trapezius
        _path(
            'M65 85 Q100 95 135 85 L130 150 Q100 160 70 150 Z'), // latissimus
        _path('M85 150 L115 150 L115 190 L85 190 Z'), // erector spinae
      ]),
      'shoulders': _combine([
        _oval(60, 75, 15, 12), // posterior deltoid
        _oval(140, 75, 15, 12),
      ]),
      'triceps': _combine([
        _oval(50, 110, 10, 25),
        _oval(150, 110, 10, 25),
      ]),
      'glutes': _combine([
        _oval(75, 200, 20, 25),
        _oval(125, 200, 20, 25),
      ]),
      'hamstrings': _combine([
        _oval(75, 250, 15, 40),
        _oval(125, 250, 15, 40),
      ]),
      'calves': _combine([
        _oval(75, 320, 12, 35),
        _oval(125, 320, 12, 35),
      ]),
    };
  }

  static Path getFullBodyOutline() {
    final path = Path();
    // Simplified silhouette roughly enclosing all parts
    path.addOval(Rect.fromLTWH(80, 5, 40, 50)); // head
    path.addRect(Rect.fromLTWH(60, 60, 80, 130)); // torso
    path.addRect(Rect.fromLTWH(40, 75, 30, 100)); // left arm
    path.addRect(Rect.fromLTWH(130, 75, 30, 100)); // right arm
    path.addRect(Rect.fromLTWH(60, 190, 35, 180)); // left leg
    path.addRect(Rect.fromLTWH(105, 190, 35, 180)); // right leg
    return path;
  }

  static Path _path(String data) {
    return parseSvgPathData(data);
  }

  static Path _oval(double cx, double cy, double rx, double ry) {
    return Path()..addOval(Rect.fromLTRB(cx - rx, cy - ry, cx + rx, cy + ry));
  }

  static Path _combine(List<Path> paths) {
    final combined = Path();
    for (final p in paths) {
      combined.addPath(p, Offset.zero);
    }
    return combined;
  }
}
