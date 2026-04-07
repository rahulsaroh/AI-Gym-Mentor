import 'dart:async';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:gym_gemini_pro/core/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<bool> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  
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
    final prefs = await SharedPreferences.getInstance();
    final endTimeStr = prefs.getString('rest_timer_end_timestamp');
    if (endTimeStr != null) {
      final endTime = DateTime.parse(endTimeStr).add(const Duration(seconds: 30));
      await prefs.setString('rest_timer_end_timestamp', endTime.toIso8601String());
    }
  });

  // Timer logic
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        final prefs = await SharedPreferences.getInstance();
        final endTimeStr = prefs.getString('rest_timer_end_timestamp');
        final exName = prefs.getString('rest_timer_exercise_name');

        if (endTimeStr != null) {
          final endTime = DateTime.parse(endTimeStr);
          final now = DateTime.now();
          
          if (endTime.isAfter(now)) {
            final remaining = endTime.difference(now).inSeconds;
            // Fetch initial duration to calculate progress
            final initialDuration = prefs.getInt('rest_timer_initial_duration') ?? 60;

            // Update notification
            NotificationService().showTimerNotification(
              remainingSeconds: remaining,
              maxDuration: initialDuration,
              exerciseName: exName,
            );
            
            // Invoke callback for UI
            service.invoke('update', {
              "remaining": remaining,
            });
          } else {
            // Timer complete
            final nextEx = prefs.getString('rest_timer_next_exercise');
            NotificationService().showTimerCompleteNotification(nextExercise: nextEx);
            service.stopSelf();
            timer.cancel();
          }
        }
      }
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
