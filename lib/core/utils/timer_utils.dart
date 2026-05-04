class TimerUtils {
  /// Calculates remaining seconds from an end time.
  /// Returns 0 if end time is reached or null.
  static int calculateRemainingSeconds(DateTime? endTime) {
    if (endTime == null) return 0;
    final now = DateTime.now();
    if (endTime.isBefore(now)) return 0;
    return endTime.difference(now).inSeconds;
  }

  /// Validates a timer transition (e.g., adding seconds)
  /// and returns the new consistent end time.
  static DateTime extendEndTime(DateTime currentEndTime, int additionalSeconds) {
    return currentEndTime.add(Duration(seconds: additionalSeconds));
  }

  /// Format seconds into M:SS
  static String formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
