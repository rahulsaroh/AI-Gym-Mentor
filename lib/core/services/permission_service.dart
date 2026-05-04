
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionService {
  Future<void> requestAllPermissions() async {
    // 1. Notifications
    await Permission.notification.request();

    // 2. Storage / Media
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        // Android 13+
        await [
          Permission.photos,
          Permission.videos,
          Permission.audio,
        ].request();
      } else {
        // Older Android
        await Permission.storage.request();
      }
    } else if (Platform.isIOS) {
      await Permission.photos.request();
    }
    
    // 3. Exact Alarm (for timers on Android 12+)
    if (Platform.isAndroid) {
       final androidInfo = await DeviceInfoPlugin().androidInfo;
       if (androidInfo.version.sdkInt >= 31) {
         await Permission.scheduleExactAlarm.request();
       }
    }
  }

  Future<bool> hasStoragePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        return await Permission.photos.isGranted || await Permission.manageExternalStorage.isGranted;
      }
    }
    return await Permission.storage.isGranted;
  }

  Future<void> openSettings() async {
    await openAppSettings();
  }
}

final permissionServiceProvider = Provider((ref) => PermissionService());
