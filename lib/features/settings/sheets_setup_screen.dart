import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:gym_gemini_pro/core/auth/auth_provider.dart';
import 'package:gym_gemini_pro/features/settings/settings_provider.dart';
import 'package:gym_gemini_pro/services/sheets_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SheetsSetupScreen extends ConsumerStatefulWidget {
  const SheetsSetupScreen({super.key});

  @override
  ConsumerState<SheetsSetupScreen> createState() => _SheetsSetupScreenState();
}

class _SheetsSetupScreenState extends ConsumerState<SheetsSetupScreen> {
  bool _isLoading = false;
  String? _error;

  Future<void> _handleConnect() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final googleSignIn = ref.read(googleSignInProvider);
      
      // Sign in
      final user = await googleSignIn.signIn();
      if (user == null) {
        setState(() => _isLoading = false);
        return;
      }

      // Get authenticated client
      final client = await googleSignIn.getAuthenticatedClient();
      if (client == null) {
        throw Exception('Failed to get authenticated client');
      }

      // Create spreadsheet
      final sheetsService = SheetsService(client);
      final spreadsheetId = await sheetsService.createSpreadsheet();
      
      if (spreadsheetId == null) {
        throw Exception('Failed to create spreadsheet');
      }

      // Update settings
      final settings = await ref.read(settingsProvider.future);
      await ref.read(settingsProvider.notifier).updateSettings(
        settings.copyWith(googleDriveEmail: user.email),
      );

      if (mounted) {
        context.pushReplacement('/settings/sheets-success', extra: spreadsheetId);
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sheets Sync'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            const Icon(LucideIcons.cloud, size: 80, color: Colors.blue),
            const SizedBox(height: 32),
            const Text(
              'Sync Your Workouts',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Connect your Google account to automatically back up every workout to a Google Spreadsheet. We\'ll create a "GYM Kilo" file in your Google Drive.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            _buildFeatureRow(LucideIcons.check, 'Auto-sync completed workouts'),
            const SizedBox(height: 12),
            _buildFeatureRow(LucideIcons.check, 'Detailed breakdown of every set'),
            const SizedBox(height: 12),
            _buildFeatureRow(LucideIcons.check, 'Track body measurements over time'),
            const Spacer(),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Error: $_error',
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton.icon(
                onPressed: _isLoading ? null : _handleConnect,
                icon: _isLoading 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(LucideIcons.logIn),
                label: Text(_isLoading ? 'Connecting...' : 'Connect with Google'),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'You can revoke access anytime in settings.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.green),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
      ],
    );
  }
}

class SheetsSuccessScreen extends StatelessWidget {
  final String spreadsheetId;
  const SheetsSuccessScreen({super.key, required this.spreadsheetId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.circleCheck, size: 80, color: Colors.green),
            const SizedBox(height: 32),
            const Text(
              'Connected Successfully!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Your workouts will now be automatically synced to your Google Spreadsheet.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: () => context.pop(),
                child: const Text('Back to Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
