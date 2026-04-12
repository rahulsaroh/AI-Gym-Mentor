import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // No online background tasks remain
    return true;
  });
}

class BackgroundWorker {
  static Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
  }

  static Future<void> scheduleWeeklyBackup() async {
    // Placeholder for future offline periodic tasks
  }

  static Future<void> cancelWeeklyBackup() async {
    await Workmanager().cancelByUniqueName('gym_kilo_weekly_backup');
  }
}

