import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

part 'timer_notifier.g.dart';

class TimerState {
  final bool isRunning;
  final int remainingSeconds;
  final String? exerciseName;
  final int initialDuration;

  TimerState({
    this.isRunning = false,
    this.remainingSeconds = 0,
    this.exerciseName,
    this.initialDuration = 0,
  });

  TimerState copyWith({
    bool? isRunning,
    int? remainingSeconds,
    String? exerciseName,
    int? initialDuration,
  }) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      exerciseName: exerciseName ?? this.exerciseName,
      initialDuration: initialDuration ?? this.initialDuration,
    );
  }
}

@riverpod
class TimerNotifier extends _$TimerNotifier {
  Timer? _ticker;
  static const String _endTimeKey = 'rest_timer_end_timestamp';
  static const String _exerciseNameKey = 'rest_timer_exercise_name';

  @override
  TimerState build() {
    _restoreState();
    _setupServiceListener();
    return TimerState();
  }

  void _setupServiceListener() {
    FlutterBackgroundService().on('update').listen((event) {
      if (event != null && event['remaining'] != null) {
        final remaining = event['remaining'] as int;
        if (state.isRunning) {
          state = state.copyWith(remainingSeconds: remaining);
        }
      }
    });
  }

  Future<void> _restoreState() async {
    final prefs = await SharedPreferences.getInstance();
    final endTimeStr = prefs.getString(_endTimeKey);
    final exName = prefs.getString(_exerciseNameKey);

    if (endTimeStr != null) {
      final endTime = DateTime.parse(endTimeStr);
      final now = DateTime.now();
      if (endTime.isAfter(now)) {
        final remaining = endTime.difference(now).inSeconds;
        state = state.copyWith(
          isRunning: true,
          remainingSeconds: remaining,
          exerciseName: exName,
          initialDuration: remaining, // Best effort for restoration
        );
        _startTicker();
      } else {
        _clearState();
      }
    }
  }

  Future<void> start(int duration, String? exerciseName) async {
    final endTime = DateTime.now().add(Duration(seconds: duration));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_endTimeKey, endTime.toIso8601String());
    await prefs.setInt('rest_timer_initial_duration', duration);
    if (exerciseName != null) {
      await prefs.setString(_exerciseNameKey, exerciseName);
    }

    state = TimerState(
      isRunning: true,
      remainingSeconds: duration,
      exerciseName: exerciseName,
      initialDuration: duration,
    );

    _startTicker();

    // Start Foreground Service
    final service = FlutterBackgroundService();
    final isRunning = await service.isRunning();
    if (!isRunning) {
      await service.startService();
    }
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      } else {
        stop();
      }
    });
  }

  Future<void> stop() async {
    _ticker?.cancel();
    state = TimerState();
    _clearState();
    
    final service = FlutterBackgroundService();
    service.invoke('stopService');
  }

  Future<void> _clearState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_endTimeKey);
    await prefs.remove(_exerciseNameKey);
  }

  void pause() {
    _ticker?.cancel();
    state = state.copyWith(isRunning: false);
  }

  void resume() {
    if (state.remainingSeconds > 0) {
      state = state.copyWith(isRunning: true);
      _startTicker();
    }
  }

  void extend(int seconds) async {
    final newRemaining = state.remainingSeconds + seconds;
    final newEndTime = DateTime.now().add(Duration(seconds: newRemaining));
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_endTimeKey, newEndTime.toIso8601String());
    
    state = state.copyWith(remainingSeconds: newRemaining);
    
    // Notify service if running
    FlutterBackgroundService().invoke('add_30s'); // Service also updates its internal endTime
  }

  Future<bool> checkPermissions() async {
    final notificationStatus = await Permission.notification.status;
    if (!notificationStatus.isGranted) {
      final result = await Permission.notification.request();
      if (!result.isGranted) return false;
    }

    // Exact alarm for Android 13+
    if (await Permission.scheduleExactAlarm.isDenied) {
      final result = await Permission.scheduleExactAlarm.request();
      if (!result.isGranted) return false;
    }

    return true;
  }
}
