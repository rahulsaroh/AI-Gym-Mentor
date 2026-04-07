import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

/// Detects device shake using the accelerometer.
/// Shake is defined as: magnitude > 2.7G for 3 consecutive
/// readings within 200ms.
class ShakeDetector {
  final double threshold;
  final int consecutiveCount;
  final Duration window;

  final StreamController<void> _shakeController =
      StreamController<void>.broadcast();

  Stream<void> get onShake => _shakeController.stream;

  StreamSubscription<AccelerometerEvent>? _subscription;
  final List<DateTime> _shakeTimestamps = [];

  ShakeDetector({
    this.threshold = 2.7,
    this.consecutiveCount = 3,
    this.window = const Duration(milliseconds: 200),
  });

  void start() {
    _subscription = accelerometerEvents.listen((event) {
      final magnitude = sqrt(
        event.x * event.x + event.y * event.y + event.z * event.z,
      ) / 9.81; // Convert to G

      if (magnitude > threshold) {
        final now = DateTime.now();
        _shakeTimestamps.add(now);

        // Remove timestamps outside the window
        _shakeTimestamps.removeWhere(
          (t) => now.difference(t) > window,
        );

        if (_shakeTimestamps.length >= consecutiveCount) {
          _shakeTimestamps.clear();
          if (!_shakeController.isClosed) {
            _shakeController.add(null);
          }
        }
      }
    });
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  void dispose() {
    stop();
    _shakeController.close();
  }
}
