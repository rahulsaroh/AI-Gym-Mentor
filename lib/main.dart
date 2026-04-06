import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gym_gemini_pro/core/router/router.dart';
import 'package:gym_gemini_pro/core/widgets/global_error_handler.dart';
import 'dart:ui';
import 'package:gym_gemini_pro/core/services/notification_service.dart';
import 'package:gym_gemini_pro/core/services/timer_service.dart';
import 'package:gym_gemini_pro/features/settings/models/settings_state.dart';
import 'package:gym_gemini_pro/features/settings/settings_provider.dart';
import 'package:gym_gemini_pro/services/connectivity_service.dart';
import 'package:gym_gemini_pro/services/sync_worker.dart';
import 'package:gym_gemini_pro/services/background_worker.dart';

/*
  PHASE 8 SETUP INSTRUCTIONS:
  1. Go to Google Cloud Console: https://console.cloud.google.com/
  2. Create Project: 'my-gym-mentor-ai'
  3. Enable APIs: 'Google Sheets API' & 'Google Drive API'
  4. OAuth Consent Screen: Set up User Type as External.
  5. Credentials: Create OAuth 2.0 Client IDs for:
     - Android: Use Package Name 'com.gymgemini.pro.gym_gemini_pro' and your SHA-1.
     - iOS: Use Bundle ID 'com.gymgemini.pro.gym_gemini_pro'.
  6. Firebase: Go to Firebase Console, add Android/iOS apps, and download google-services.json.
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Framework errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('FLUTTER ERROR: ${details.exception}');
  };

  // 2. Async errors
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('ASYNC ERROR: $error');
    return true;
  };

  // 3. UI Error Widget
  ErrorWidget.builder = (details) {
    return GlobalErrorScreen(details: details);
  };

  debugPrint('--- APP STARTUP ---');
  
  try {
    debugPrint('Step 1: Initializing Notifications...');
    await NotificationService().init();
    debugPrint('Notifications Initialized Successfully');
  } catch (e) {
    debugPrint('Notifications Initialization Failed: $e');
  }

  // Firebase initialization is disabled for now as the plugin/config is missing.
  // This allows the app to reach the dashboard without native hangs or crashes.
  /*
  try {
    debugPrint('Step 2: Checking Firebase configuration...');
    await Firebase.initializeApp().timeout(const Duration(seconds: 2));
    debugPrint('Firebase Initialized Successfully');
  } catch (e) {
    debugPrint('Firebase Initialization Skipped or Failed: $e');
  }
  */

  // Services that might start foreground services are disabled for this debug run.
  /*
  try {
    debugPrint('Initializing Sync Worker...');
    await ref.read(syncWorkerProvider.notifier).init();
    debugPrint('Sync Worker Initialized');
  } catch (e) {
    debugPrint('Sync Worker Initialization Failed: $e');
  }

  try {
    debugPrint('Initializing Background Worker...');
    await BackgroundWorker.initialize();
    debugPrint('Background Worker Initialized');
  } catch (e) {
    debugPrint('Background Worker Initialization Failed: $e');
  }
  */

  debugPrint('Running App...');
  runApp(
    const ProviderScope(
      child: ConnectivityInitializer(child: GymGeminiApp()),
    ),
  );
}

class ConnectivityInitializer extends ConsumerWidget {
  final Widget child;
  const ConnectivityInitializer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize connectivity listener
    ref.listen(connectivityServiceProvider, (prev, next) {
      final status = next.value;
      if (status != null && status != ConnectivityResult.none) {
        ref.read(syncWorkerProvider.notifier).processQueue();
      }
    });

    // Schedule weekly backup if enabled
    ref.listen(settingsProvider, (prev, next) {
      final settings = next.value;
      if (settings != null && settings.autoBackup) {
        BackgroundWorker.scheduleWeeklyBackup();
      }
    });
    
    return child;
  }
}

class GymGeminiApp extends ConsumerWidget {
  const GymGeminiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);

    return settingsAsync.when(
      data: (settings) => MaterialApp.router(
        title: 'Gym Gemini Pro',
        debugShowCheckedModeBanner: false,
        themeMode: settings.themeMode,
        theme: _buildTheme(Brightness.light, settings.accentColor, settings.fontSize),
        darkTheme: _buildTheme(Brightness.dark, settings.accentColor, settings.fontSize),
        routerConfig: router,
        builder: (context, child) {
          return AnimatedTheme(
            data: Theme.of(context),
            duration: const Duration(milliseconds: 400),
            child: child!,
          );
        },
      ),
      loading: () => const MaterialApp(home: Scaffold(body: Center(child: CircularProgressIndicator()))),
      error: (e, _) => MaterialApp(home: Scaffold(body: Center(child: Text('Error: $e')))),
    );
  }

  ThemeData _buildTheme(Brightness brightness, Color accentColor, FontSize fontSize) {
    final isDark = brightness == Brightness.dark;
    final baseColor = isDark ? const Color(0xFF0F172A) : Colors.white;
    final surfaceColor = isDark ? const Color(0xFF1E293B) : Colors.grey[50]!;
    
    final baseTheme = isDark ? ThemeData.dark() : ThemeData.light();
    
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: accentColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentColor,
        brightness: brightness,
        surface: baseColor,
        error: Colors.red,
        onSurface: isDark ? Colors.white : Colors.black87,
        primary: accentColor,
      ),
      scaffoldBackgroundColor: baseColor,
      textTheme: GoogleFonts.interTextTheme(
        baseTheme.textTheme.apply(
          bodyColor: isDark ? Colors.white : Colors.black87,
          displayColor: isDark ? Colors.white : Colors.black87,
          fontSizeFactor: fontSize == FontSize.large ? 1.2 : 1.0,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: baseColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
