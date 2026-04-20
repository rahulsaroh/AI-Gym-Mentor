import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/main.dart' as app;
import 'package:go_router/go_router.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Comprehensive System-Wide Audit', (tester) async {
    // 1. Setup Initial State (Skip Onboarding/Setup for initial route check)
    SharedPreferences.setMockInitialValues({
      'hasSeenOnboarding': true,
      'hasCompletedSetup': true,
      'userName': 'QA Audit User',
      'weightUnit': 'kg',
    });

    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 4));

    final routesToAudit = [
      '/app',
      '/ai-mentor',
      '/exercises',
      '/exercises/1',
      '/exercises/library',
      '/history',
      '/programs',
      '/programs/create',
      '/analytics',
      '/analytics/prs',
      '/analytics/measurements',
      '/settings',
      '/settings/plates',
      '/settings/about',
      '/settings/setup-sheets',
      '/settings/sync-log',
    ];

    print('==== STARTING COMPREHENSIVE ROUTE AUDIT ====');

    for (final route in routesToAudit) {
      print('Auditing Route: $route');
      try {
        // Find the root app widget to get context
        final Finder appFinder = find.byType(MaterialApp).first;
        if (appFinder.evaluate().isEmpty) {
          print('Error: Could not find MaterialApp to initiate navigation.');
          continue;
        }
        
        final BuildContext context = tester.element(appFinder);
        context.go(route);
        
        // Allow time for the screen to build and possible animations to finish
        await tester.pumpAndSettle(const Duration(seconds: 2));
        
        // --- VALIDATION 1: No ErrorWidget ---
        final errorFinder = find.byType(ErrorWidget);
        expect(errorFinder, findsNothing, 
          reason: 'CRITICAL: Red Error Card detected on route $route');

        // --- VALIDATION 2: Basic UI Elements ---
        expect(find.byType(Scaffold), findsWidgets, 
          reason: 'FAIL: No Scaffold found on route $route');

        // --- CAPTURE: Screenshot ---
        // Sanitizing route name for filename
        final safeName = route.replaceAll('/', '_').replaceAll(':', '').replaceAll('?', '_');
        await binding.takeScreenshot('screenshot$safeName');
        
        print('SUCCESS: $route is stable and rendered.');
      } catch (e) {
        print('FAILURE: Error during audit of $route: $e');
      }
    }

    print('==== AUDIT COMPLETE ====');
  });
}
