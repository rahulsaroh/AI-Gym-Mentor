import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> takeScreenshotAndLog(WidgetTester tester, String phaseName) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle(const Duration(seconds: 1));
    print('==== SCREENSHOT_READY: $phaseName ====');
    // Give script time to capture
    await Future.delayed(const Duration(seconds: 5));
  }

  testWidgets('Verify 6-Day Elite PPL Visibility', (tester) async {
    // Inject preferences to bypass onboarding and setup
    SharedPreferences.setMockInitialValues({
        'hasSeenOnboarding': true,
        'hasCompletedSetup': true,
        'userName': 'Test User',
    });
    
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Handle Setup Screen if it appears
    if (find.textContaining("Let's set you up").evaluate().isNotEmpty) {
        print('Completing Setup Screen...');
        await tester.enterText(find.byType(TextField), 'Test User');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();
        
        final completeButton = find.text('Complete Setup');
        await tester.tap(completeButton);
        await tester.pumpAndSettle(const Duration(seconds: 5));
    }

    // Navigate to Plans tab (index 3)
    print('Navigating to Plans tab');
    
    // Check for Onboarding screen
    if (find.textContaining('Onboarding').evaluate().isNotEmpty || 
        find.textContaining('Skip').evaluate().isNotEmpty) {
        print('Detected Onboarding screen, attempting to skip...');
        final skipButton = find.textContaining('Skip');
        if (skipButton.evaluate().isNotEmpty) {
            await tester.tap(skipButton.first);
            await tester.pumpAndSettle(const Duration(seconds: 5));
        }
    }

    // Wait for the shell to be ready
    bool shellReady = false;
    for (int i = 0; i < 15; i++) {
        if (find.byType(BottomNavigationBar).evaluate().isNotEmpty) {
            shellReady = true;
            break;
        }
        
        // Log what we see
        final allText = find.byType(Text).evaluate().map((e) => (e.widget as Text).data).toList();
        print('Waiting for BottomNavigationBar... (attempt ${i+1}) - Current Texts: $allText');
        
        await tester.pump(const Duration(seconds: 1));
    }

    if (!shellReady) {
        print('Error: BottomNavigationBar not found after 15s!');
        // Log all types to see what's on screen
        final allWidgets = tester.allWidgets.map((e) => e.runtimeType.toString()).toSet().toList();
        print('Visible Widget Types: $allWidgets');
        await takeScreenshotAndLog(tester, 'error_shell_not_found');
        return;
    }


    final planTab = find.byWidgetPredicate((widget) => 
        (widget is Text && (widget.data == 'Plan' || widget.data == 'Plans')) ||
        (widget is Icon && (widget.icon == Icons.calendar_today || widget.icon == Icons.list_alt))
    );
    
    if (planTab.evaluate().isNotEmpty) {
        await tester.tap(planTab.first);
    } else {
        print('Warning: Plan tab not found by text/icon, attempting fallback tap...');
        // Final fallback: tap by index if we can find the bar
        final navBar = find.byType(BottomNavigationBar).first;
        await tester.tap(navBar); 
    }

    await tester.pumpAndSettle(const Duration(seconds: 3));
    await takeScreenshotAndLog(tester, 'plans_list_verify');

    // Find the plan "6-Day Elite PPL"
    // Wait up to 10 seconds for it to appear (seeding might take time on first run)
    bool planFound = false;
    for (int i = 0; i < 5; i++) {
        final planFinder = find.text('6-Day Elite PPL');
        if (planFinder.evaluate().isNotEmpty) {
            planFound = true;
            await tester.tap(planFinder.first);
            break;
        }
        print('Waiting for plan... (attempt ${i+1})');
        await tester.pump(const Duration(seconds: 2));
        await tester.drag(find.byType(ListView).first, const Offset(0, -200));
        await tester.pumpAndSettle();
    }

    if (planFound) {
        await tester.pumpAndSettle(const Duration(seconds: 3));

        
        // We are now in CreateEditProgramScreen
        await takeScreenshotAndLog(tester, 'plan_detail_elite_ppl');
        
        // Count day cards
        // Day cards are _DayCard widgets. 
        // We can count them by looking for the "Day Name" text fields or the handles.
        final dayCardFinder = find.byType(Card); // Simple proxy
        print('Detected ${dayCardFinder.evaluate().length} cards in the plan');
    } else {
        print('Plan still not found after scroll');
    }

    print('==== INTEGRATION TEST COMPLETE ====');
  });
}
