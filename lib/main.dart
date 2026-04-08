import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:gym_gemini_pro/firebase_options.dart';

void main() async {
  // Ensure Flutter is initialized before any async code
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Firebase Initialization (Wrap in try/catch to maintain offline functionality)
  bool firebaseInitialized = false;
  try {
    if (kDebugMode) debugPrint('Step 1: Initializing Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).timeout(const Duration(seconds: 5));
    firebaseInitialized = true;
    if (kDebugMode) debugPrint('Firebase Initialized Successfully');
  } catch (e) {
    debugPrint('Firebase Initialization Failed (App will run in offline mode): $e');
  }

  // 2. Notification Service Initialization
  try {
    if (kDebugMode) debugPrint('Step 2: Initializing Notifications...');
    await NotificationService().init();
    if (kDebugMode) debugPrint('Notifications Initialized Successfully');
  } catch (e) {
    debugPrint('Notifications Initialization Failed: $e');
  }

  // 3. Timer Service Initialization
  try {
    if (kDebugMode) debugPrint('Step 3: Initializing Timer Service...');
    await TimerService.initialize();
    if (kDebugMode) debugPrint('Timer Service Initialized Successfully');
  } catch (e) {
    debugPrint('Timer Service Initialization Failed: $e');
  }

  // Background workers initialization
  try {
    if (kDebugMode) debugPrint('Step 4: Initializing Background Worker...');
    await BackgroundWorker.initialize();
    if (kDebugMode) debugPrint('Background Worker Initialized Successfully');
  } catch (e) {
    debugPrint('Background Worker Initialization Failed: $e');
  }

  // 4. Framework error catchers
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('FLUTTER ERROR: ${details.exception}');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('ASYNC ERROR: $error');
    return true;
  };

  ErrorWidget.builder = (details) {
    return GlobalErrorScreen(details: details);
  };

  if (kDebugMode) debugPrint('--- APP STARTUP COMPLETE ---');

  runApp(
    ProviderScope(
      child: ConnectivityInitializer(
        firebaseInitialized: firebaseInitialized,
        child: const GymGeminiApp(),
      ),
    ),
  );
}

class ConnectivityInitializer extends ConsumerWidget {
  final Widget child;
  final bool firebaseInitialized;
  
  const ConnectivityInitializer({
    super.key, 
    required this.child, 
    required this.firebaseInitialized,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Show a small warning if Firebase failed only after first frame
    if (!firebaseInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Firebase not connected. Some cloud features may be unavailable.'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 5),
          ),
        );
      });
    }

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
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, stack) => MaterialApp(
        home: GlobalErrorScreen(
          details: FlutterErrorDetails(exception: e, stack: stack),
        ),
      ),
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
      textTheme: baseTheme.textTheme.apply(
          bodyColor: isDark ? Colors.white : Colors.black87,
          displayColor: isDark ? Colors.white : Colors.black87,
          fontSizeFactor: fontSize == FontSize.large ? 1.2 : 1.0,
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
