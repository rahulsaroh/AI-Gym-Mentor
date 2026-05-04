import 'package:flutter/material.dart';
import '../../../core/domain/models/muscle_heat_data.dart';
import '../../../core/services/heatmap_color_service.dart';
import '../providers/bodymap_provider.dart';
import 'muscle_path_registry.dart';

class BodyMapPainter extends CustomPainter {
  final List<MuscleHeatData> heatData;
  final Map<String, Path> musclePaths;
  final BodyMapMode mode;
  final HeatmapColorService colorService;
  final String? selectedMuscle;

  BodyMapPainter({
    required this.heatData,
    required this.musclePaths,
    required this.mode,
    required this.colorService,
    this.selectedMuscle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Scale factor: our paths are in 200×400 space
    final scaleX = size.width / 200;
    final scaleY = size.height / 400;

    canvas.save();
    canvas.scale(scaleX, scaleY);

    // Build a lookup for fast access
    final dataMap = {for (var d in heatData) d.muscleName: d};

    // 1. Draw base silhouette (light grey outline)
    _drawSilhouette(canvas);

    // 2. Paint each muscle region
    for (final entry in musclePaths.entries) {
      final muscle = entry.key;
      final path = entry.value;
      final data = dataMap[muscle];

      Color fillColor;
      if (data == null || data.volumeKg == 0) {
        fillColor = const Color(0xFFDDDDDD); // untrained — neutral grey
      } else {
        fillColor = mode == BodyMapMode.volume
            ? colorService.colorForLoad(data.normalizedLoad)
            : colorService.colorForDoms(data.domsScore);
      }

      final paint = Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill;

      canvas.drawPath(path, paint);

      // Stroke outline
      final strokePaint = Paint()
        ..color = muscle == selectedMuscle
            ? Colors.white
            : Colors.black.withOpacity(0.15)
        ..style = muscle == selectedMuscle ? PaintingStyle.stroke : PaintingStyle.stroke
        ..strokeWidth = muscle == selectedMuscle ? 2.0 : 0.8;

      canvas.drawPath(path, strokePaint);

      _drawMuscleLabel(canvas, muscle, path);
    }

    canvas.restore();
  }

  void _drawSilhouette(Canvas canvas) {
    // Draw overall body outline shape in very light grey
    final silhouettePaint = Paint()
      ..color = Colors.grey.withOpacity(0.08)
      ..style = PaintingStyle.fill;
    // Use your full body outline path here
    canvas.drawPath(MusclePathRegistry.getFullBodyOutline(), silhouettePaint);
  }

  void _drawMuscleLabel(Canvas canvas, String muscleName, Path path) {
    final bounds = path.getBounds();
    if (bounds.isEmpty || bounds.width < 8) return;

    final displayName = _labelFor(muscleName);
    final fontSize = (bounds.width * 0.28).clamp(6.0, 11.0);

    final tp = TextPainter(
      text: TextSpan(
        text: displayName,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          shadows: const [
            Shadow(color: Colors.black, blurRadius: 3, offset: Offset(0.5, 0.5)),
            Shadow(color: Colors.black, blurRadius: 3, offset: Offset(-0.5, -0.5)),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: bounds.width);

    final offset = Offset(
      bounds.center.dx - tp.width / 2,
      bounds.center.dy - tp.height / 2,
    );
    tp.paint(canvas, offset);
  }

  String _labelFor(String muscle) {
    const labels = {
      'chest': 'Chest',
      'shoulders': 'Delt',
      'biceps': 'Biceps',
      'abs': 'Abs',
      'quads': 'Quads',
      'calves': 'Calves',
      'back': 'Back',
      'triceps': 'Triceps',
      'glutes': 'Glutes',
      'hamstrings': 'Hams',
      'forearms': 'Fore',
      'neck': 'Neck',
    };
    return labels[muscle] ?? muscle;
  }

  @override
  bool shouldRepaint(BodyMapPainter old) =>
      old.heatData != heatData ||
      old.mode != mode ||
      old.selectedMuscle != selectedMuscle;

  // Hit-test: which muscle did the user tap?
  String? muscleAtPoint(Offset localPosition, Size size) {
    final scaleX = 200 / size.width;
    final scaleY = 400 / size.height;
    final scaled = Offset(localPosition.dx * scaleX, localPosition.dy * scaleY);

    for (final entry in musclePaths.entries) {
      if (entry.value.contains(scaled)) return entry.key;
    }
    return null;
  }
}
