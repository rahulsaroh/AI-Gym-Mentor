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
            // Update notification
            NotificationService().showTimerNotification(
              remainingSeconds: remaining,
              maxDuration: 60, // Simplified; normally track this too
              exerciseName: exName,
            );
            
            // Invoke callback for UI
            service.invoke('update', {
              "remaining": remaining,
            });
          } else {
            // Timer complete
            NotificationService().showTimerCompleteNotification(nextExercise: null);
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
