import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:ai_gym_mentor/core/utils/timer_utils.dart';

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
  final service = FlutterBackgroundService();
  if (details.actionId == 'skip_rest') {
    service.invoke('skip');
  } else if (details.actionId == 'add_30s') {
    service.invoke('refresh_timer');
  }
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.actionId == 'skip_rest') {
          FlutterBackgroundService().invoke('skip');
        } else if (details.actionId == 'add_30s') {
          FlutterBackgroundService().invoke('refresh_timer');
        }
      },
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
  }

  Future<bool> requestPermission() async {
    if (await Permission.notification.isGranted) {
      return true;
    }
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  // --- Foreground Timer Notification ---

  static const int timerNotificationId = 999;

  Future<void> showTimerNotification({
    required int remainingSeconds,
    required int maxDuration,
    required String? exerciseName,
  }) async {
    final timeStr = TimerUtils.formatTime(remainingSeconds);

    final androidDetails = AndroidNotificationDetails(
      'rest_timer_service',
      'Rest Timer Service',
      channelDescription: 'Ongoing notification for rest timer',
      importance: Importance.low,
      priority: Priority.low,
      ongoing: true,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: maxDuration,
      progress: maxDuration - remainingSeconds,
      actions: <AndroidNotificationAction>[
        const AndroidNotificationAction('skip_rest', 'Skip Rest'),
        const AndroidNotificationAction('add_30s', '+30s'),
      ],
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: false, // Don't interrupt the user for ongoing updates
      presentSound: false,
    );

    await _notificationsPlugin.show(
      timerNotificationId,
      'Resting: $timeStr',
      exerciseName != null ? 'Previous: $exerciseName' : 'Take a breath',
      NotificationDetails(android: androidDetails, iOS: iosDetails),
    );
  }

  Future<void> showTimerCompleteNotification({String? nextExercise}) async {
    final androidDetails = AndroidNotificationDetails(
      'timer_complete',
      'Timer Complete',
      channelDescription: 'Alert when rest period is over',
      importance: Importance.max,
      priority: Priority.high,
      sound: const RawResourceAndroidNotificationSound('timer_end'),
      vibrationPattern: Int64List.fromList([0, 200, 100, 500]),
      enableVibration: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    await _notificationsPlugin.show(
      timerNotificationId + 1,
      'Rest Complete!',
      nextExercise != null ? 'Time for $nextExercise' : 'Get back to work!',
      NotificationDetails(android: androidDetails, iOS: iosDetails),
    );
  }

  Future<void> cancelTimerNotification() async {
    await _notificationsPlugin.cancel(timerNotificationId);
  }

  // --- Simple Scheduled Notifications ---

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'workout_timer',
          'Workout Timer',
          channelDescription: 'Notifications for workout rest timers',
          importance: Importance.high,
          priority: Priority.high,
          showWhen: false,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}
