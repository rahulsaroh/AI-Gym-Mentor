import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/core/auth/auth_provider.dart';
import 'package:ai_gym_mentor/services/backup_service.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final container = ProviderContainer();
    try {
      if (task == 'weeklyBackup') {
        final googleSignIn = container.read(googleSignInProvider);

        // Ensure user is signed in
        final user = await googleSignIn.signInSilently();
        if (user == null) return false;

        final client = await googleSignIn.getAuthenticatedClient();
        if (client == null) return false;

        await container
            .read(backupServiceProvider.notifier)
            .uploadToDrive(client);
      }
      return true;
    } catch (e) {
      return false;
    }
  });
}

class BackgroundWorker {
  static const String weeklyBackupTask = 'weeklyBackup';

  static Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  }

  static Future<void> scheduleWeeklyBackup() async {
    await Workmanager().registerPeriodicTask(
      'gym_kilo_weekly_backup',
      weeklyBackupTask,
      frequency: const Duration(days: 7),
      initialDelay: _calculateDelayToSundayEightAM(),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
    );
  }

  static Future<void> cancelWeeklyBackup() async {
    await Workmanager().cancelByUniqueName('gym_kilo_weekly_backup');
  }

  static Duration _calculateDelayToSundayEightAM() {
    final now = DateTime.now();
    int daysUntilSunday = (DateTime.sunday - now.weekday) % 7;
    if (daysUntilSunday == 0 && now.hour >= 8) daysUntilSunday = 7;

    final nextSunday =
        DateTime(now.year, now.month, now.day + daysUntilSunday, 8);
    return nextSunday.difference(now);
  }
}
