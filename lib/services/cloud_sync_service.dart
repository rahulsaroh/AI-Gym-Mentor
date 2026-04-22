import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icloud_storage/icloud_storage.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';

class CloudSyncService {
  final Ref ref;
  
  CloudSyncService(this.ref);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [drive.DriveApi.driveFileScope],
  );

  /// Syncs the local Excel file to Google Drive.
  Future<void> syncToGoogleDrive(String localPath) async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signInSilently() ?? await _googleSignIn.signIn();
      if (account == null) return;

      final authHeaders = await account.authHeaders;
      final authenticateClient = _GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(authenticateClient);

      final file = File(localPath);
      if (!await file.exists()) return;

      // Check if file already exists in Drive
      final query = "name = 'GymLog_Backup.xlsx' and trashed = false";
      final fileList = await driveApi.files.list(q: query);
      
      final drive.File driveFile = drive.File();
      driveFile.name = 'GymLog_Backup.xlsx';

      final media = drive.Media(file.openRead(), await file.length());

      if (fileList.files != null && fileList.files!.isNotEmpty) {
        // Update existing
        final existingId = fileList.files!.first.id!;
        await driveApi.files.update(driveFile, existingId, uploadMedia: media);
        debugPrint('Google Drive: File updated.');
      } else {
        // Create new
        await driveApi.files.create(driveFile, uploadMedia: media);
        debugPrint('Google Drive: File created.');
      }
      
      // Update last synced date in settings
      final settings = await ref.read(settingsProvider.future);
      ref.read(settingsProvider.notifier).updateSettings(settings.copyWith(lastDriveBackup: DateTime.now()));

    } catch (e) {
      debugPrint('Google Drive Sync Error: $e');
    }
  }

  /// iOS specific iCloud sync
  Future<void> syncToICloud(String localPath) async {
    if (!Platform.isIOS) return;
    try {
      // The icloud_storage package requires an iCloud container ID
      // This is usually defined in Xcode entitlements
      const containerId = 'iCloud.com.yourcompany.gymlog'; 
      
      final file = File(localPath);
      if (!await file.exists()) return;

      await ICloudStorage.upload(
        containerId: containerId,
        filePath: localPath,
        destinationFileName: 'gym_log.xlsx',
        onProgress: (stream) {
          stream.listen((progress) {
            debugPrint('iCloud Upload Progress: $progress');
          });
        },
      );
      debugPrint('iCloud: File uploaded.');
    } catch (e) {
      debugPrint('iCloud Sync Error: $e');
    }
  }
}

class _GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  _GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}

final cloudSyncServiceProvider = Provider((ref) => CloudSyncService(ref));
