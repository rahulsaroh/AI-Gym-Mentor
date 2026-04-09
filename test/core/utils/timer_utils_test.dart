import 'package:flutter_test/flutter_test.dart';
import 'package:ai_gym_mentor/core/utils/timer_utils.dart';

void main() {
  group('TimerUtils', () {
    test('calculateRemainingSeconds returns 0 for null endTime', () {
      expect(TimerUtils.calculateRemainingSeconds(null), 0);
    });

    test('calculateRemainingSeconds returns 0 for past endTime', () {
      final pastTime = DateTime.now().subtract(const Duration(seconds: 10));
      expect(TimerUtils.calculateRemainingSeconds(pastTime), 0);
    });

    test('calculateRemainingSeconds returns correct seconds for future endTime', () {
      final futureTime = DateTime.now().add(const Duration(seconds: 60));
      // Allow for a small delay in execution
      final remaining = TimerUtils.calculateRemainingSeconds(futureTime);
      expect(remaining, closeTo(60, 2));
    });

    test('extendEndTime adds seconds correctly', () {
      final now = DateTime.now();
      final extended = TimerUtils.extendEndTime(now, 30);
      expect(extended.difference(now).inSeconds, 30);
    });

    test('formatTime formats seconds into M:SS correctly', () {
      expect(TimerUtils.formatTime(65), '1:05');
      expect(TimerUtils.formatTime(9), '0:09');
      expect(TimerUtils.formatTime(0), '0:00');
      expect(TimerUtils.formatTime(3600), '60:00');
    });
  });
}
