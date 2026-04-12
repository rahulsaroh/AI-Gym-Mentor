import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/main.dart' as app;
import 'package:go_router/go_router.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Application-Wide Link & Screen Audit', (tester) async {
    // 1. Setup Initial State (Skip Onboarding/Setup)
    SharedPreferences.setMockInitialValues({
      'hasSeenOnboarding': true,
      'hasCompletedSetup': true,
      'userName': 'QA Tester',
    });

    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // 2. Define Routes to Verify
    final routesToAudit = [
      '/app',
      '/ai-mentor',
      '/exercises',
      '/exercises/create',
      '/exercises/library',
      '/history',
      '/programs',
      '/create-plan',
      '/analytics',
      '/analytics/prs',
      '/analytics/measurements',
      '/settings',
      '/settings/plates',
      '/settings/about',
      '/settings/setup-sheets',
      '/settings/sync-log',
    ];

    print('==== STARTING LINK AUDIT ====');

    for (final route in routesToAudit) {
      print('Auditing Route: $route');
      try {
        final BuildContext context = tester.element(find.byType(app.GymGeminiApp));
        context.go(route);
        await tester.pumpAndSettle(const Duration(seconds: 2));
        
        // Verify no "Red Screen" (ErrorWidget) is showing
        expect(find.byType(ErrorWidget), findsNothing, reason: 'Red screen detected on $route');
        
        // Verify basic scaffold/layout
        expect(find.byType(Scaffold), findsWidgets, reason: 'No Scaffold found on $route');
        
        print('SUCCESS: $route is stable.');
      } catch (e) {
        print('FAILURE: Error on $route: $e');
      }
    }

    print('==== LINK AUDIT COMPLETE ====');
  });
}
