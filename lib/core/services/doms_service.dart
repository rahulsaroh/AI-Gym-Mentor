class DomsService {
  /// Returns a 0.0–1.0 soreness score for a muscle right now,
  /// given the last time it was trained.
  double calculateDomsScore(DateTime lastTrained) {
    final hoursAgo = DateTime.now().difference(lastTrained).inHours.toDouble();

    if (hoursAgo < 0) return 0.0;
    if (hoursAgo > 96) return 0.0; // fully recovered after 4 days

    // Ramp up: 0h → 36h peak
    if (hoursAgo <= 36) {
      return hoursAgo / 36.0;
    }
    // Ramp down: 36h → 96h decay
    return 1.0 - ((hoursAgo - 36) / 60.0).clamp(0.0, 1.0);
  }
}
