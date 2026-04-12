import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ai_gym_mentor/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> takeScreenshotAndLog(WidgetTester tester, String phaseName) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle(const Duration(seconds: 1));
    print('==== SCREENSHOT_READY: $phaseName ====');
    await Future.delayed(const Duration(seconds: 4)); // Allow PowerShell script to take adb screencap
  }

  testWidgets('QA 9-Phase Automation Flow', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // PHASE 1: APP LAUNCH
    print('Phase 1: App Launch');
    if (find.text('Let\'s Get to Know You').evaluate().isNotEmpty) {
      await tester.enterText(find.byType(TextField).first, 'Test User');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle(const Duration(seconds: 2));
    }
    await takeScreenshotAndLog(tester, 'phase1_initial_state');

    // PHASE 2: CREATE A NEW PLAN
    print('Phase 2: Navigate to Plans & Create');
    await tester.tap(find.text('Plans').last); // Assuming bottom nav
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(find.byType(FloatingActionButton).first);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final nameField = find.byType(TextField).first;
    await tester.enterText(nameField, '6 days demo');
    await tester.pumpAndSettle();

    // The form starts with 0 or 1 days. Let's tap 'Add Day' until we have 6.
    for (int i = 0; i < 6; i++) {
      await tester.tap(find.text('Add Day'));
      await tester.pumpAndSettle();
    }
    await takeScreenshotAndLog(tester, 'phase2_plan_created');

    // PHASE 3: ADD EXERCISES FOR EACH DAY
    print('Phase 3: Add Exercises');
    final commonExercises = ['Bench Press', 'Squat', 'Deadlift', 'Pull-Up', 'Overhead Press', 'Bicep Curl'];
    
    for (int i = 0; i < 6; i++) {
        // Expand the day
        await tester.tap(find.text('Day ${i + 1}'));
        await tester.pumpAndSettle();

        // Add 2 exercises
        for (int j = 0; j < 2; j++) {
            await tester.scrollUntilVisible(find.text('Add Exercise'), 50.0);
            await tester.tap(find.text('Add Exercise').last);
            await tester.pumpAndSettle();

            // Inside Exercise Picker Overlay
            final searchField = find.byType(TextField).last;
            await tester.enterText(searchField, commonExercises[(i + j) % commonExercises.length]);
            await tester.pumpAndSettle(const Duration(seconds: 1));
            
            // Tap the first list tile
            await tester.tap(find.byType(ListTile).first);
            await tester.pumpAndSettle();
        }
        
        // Collapse day
        await tester.tap(find.text('Day ${i + 1}'));
        await tester.pumpAndSettle();
    }
    await takeScreenshotAndLog(tester, 'phase3_exercises_added');

    // Save Program
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // PHASE 4: SET AS DEFAULT
    print('Phase 4: Set as Default');
    await tester.longPress(find.text('6 days demo'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Set as Default')); // Assuming this exists in context menu
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await takeScreenshotAndLog(tester, 'phase4_set_default');

    // PHASE 5: START TODAY'S WORKOUT
    print('Phase 5: Start Workout');
    await tester.tap(find.text('Active').last);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await takeScreenshotAndLog(tester, 'phase5_active_tab');

    await tester.tap(find.text('Start Today\'s Workout'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await takeScreenshotAndLog(tester, 'phase5_workout_started');

    // PHASE 6: LOG THE WORKOUT
    print('Phase 6: Log Sets');
    // Loop through 4 checkmarks (assuming 2 exercises x 2 sets)
    final checkmarks = find.byIcon(Icons.check); 
    for(int i=0; i<3; i++) { // Log 3 sets
        if(checkmarks.evaluate().isNotEmpty) {
            await tester.tap(checkmarks.first);
            await tester.pumpAndSettle(const Duration(seconds: 1));
            
            // Skip Rest
            if (find.text('Skip').evaluate().isNotEmpty) {
                await tester.tap(find.text('Skip'));
                await tester.pumpAndSettle();
            }
        }
    }
    await takeScreenshotAndLog(tester, 'phase6_logged_sets');

    // PHASE 7: END WORKOUT
    print('Phase 7: End Workout');
    await tester.tap(find.text('Finish')); // From top right of ActiveWorkoutScreen
    await tester.pumpAndSettle();
    
    // Summary overlay save
    if (find.text('Save Workout').evaluate().isNotEmpty) {
        await tester.tap(find.text('Save Workout'));
        await tester.pumpAndSettle(const Duration(seconds: 2));
    }
    await takeScreenshotAndLog(tester, 'phase7_workout_ended');

    // PHASE 8: VERIFY HISTORY
    print('Phase 8: History Verification');
    await tester.tap(find.text('History').last);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await takeScreenshotAndLog(tester, 'phase8_history_tab');
    
    await tester.tap(find.text('6 days demo').first);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await takeScreenshotAndLog(tester, 'phase8_history_detail');
    
    // Let me go back
    if (find.byIcon(Icons.chevron_left).evaluate().isNotEmpty) {
        await tester.tap(find.byIcon(Icons.chevron_left).first);
        await tester.pumpAndSettle();
    }

    // PHASE 9: VERIFY STATS
    print('Phase 9: Stats Verification');
    await tester.tap(find.text('Analytics').last); // Assuming it is called Analytics or Stats
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await takeScreenshotAndLog(tester, 'phase9_stats_tab');

    print('==== INTEGRATION TEST COMPLETE ====');
  });
}
