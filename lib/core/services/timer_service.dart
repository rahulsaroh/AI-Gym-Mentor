import 'dart:async';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:ai_gym_mentor/core/services/notification_service.dart';
import 'package:ai_gym_mentor/core/utils/timer_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<bool> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  DateTime? endTime;
  String? exName;
  String? nextEx;
  int initialDuration = 60;

  void loadMetadata() {
    final endTimeStr = prefs.getString('rest_timer_end_timestamp');
    exName = prefs.getString('rest_timer_exercise_name');
    nextEx = prefs.getString('rest_timer_next_exercise');
    initialDuration = prefs.getInt('rest_timer_initial_duration') ?? 60;
    if (endTimeStr != null) {
      endTime = DateTime.tryParse(endTimeStr);
    }
  }

  loadMetadata();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  service.on('skip').listen((event) {
    service.stopSelf();
  });

  service.on('add_30s').listen((event) async {
    if (endTime != null) {
      endTime = endTime!.add(const Duration(seconds: 30));
      await prefs.setString('rest_timer_end_timestamp', endTime!.toIso8601String());
    }
  });

  service.on('refresh_timer').listen((event) async {
    // Reload metadata to get the new endTime set by UI or previous action
    loadMetadata();
  });

  // Timer logic for updates
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    final remaining = TimerUtils.calculateRemainingSeconds(endTime);

    if (remaining > 0) {
      // Update notification text (Cheap)
      NotificationService().showTimerNotification(
        remainingSeconds: remaining,
        maxDuration: initialDuration,
        exerciseName: exName,
      );

      // Invoke callback for UI (Cheap)
      service.invoke('update', {
        "remaining": remaining,
      });
    } else {
      // Timer complete
      NotificationService()
          .showTimerCompleteNotification(nextExercise: nextEx);
      service.stopSelf();
      timer.cancel();
    }
  });

  return true;
}

class TimerService {
  static Future<void> initialize() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        notificationChannelId: 'rest_timer_service',
        initialNotificationTitle: 'Rest Timer',
        initialNotificationContent: 'Preparing...',
        foregroundServiceTypes: [AndroidForegroundType.health],
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onStart,
      ),
    );
  }
}
