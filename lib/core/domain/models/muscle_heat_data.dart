class MuscleHeatData {
  final String muscleName; // "chest", "quads", etc.
  final double volumeKg; // total volume in 7 days
  final double normalizedLoad; // 0.0 → 1.0 (for color mapping)
  final double domsScore; // 0.0 → 1.0 (predicted soreness right now)

  const MuscleHeatData({
    required this.muscleName,
    required this.volumeKg,
    required this.normalizedLoad,
    required this.domsScore,
  });
}
