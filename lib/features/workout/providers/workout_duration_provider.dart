import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_duration_provider.g.dart';

@riverpod
class WorkoutDuration extends _$WorkoutDuration {
  Timer? _ticker;
  DateTime? _startTime;

  @override
  int build() {
    ref.onDispose(() => _ticker?.cancel());
    return 0;
  }

  void start(DateTime startTime) {
    _startTime = startTime;
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startTime != null) {
        state = DateTime.now().difference(_startTime!).inSeconds;
      }
    });
  }

  void stop() {
    _ticker?.cancel();
    state = 0;
  }
}
