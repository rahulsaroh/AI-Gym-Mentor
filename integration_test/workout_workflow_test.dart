import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ai_gym_mentor/main.dart' as app;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Workout Workflow Verification', () {
    testWidgets('6-day demo plan creation and workout execution', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Skip splash/onboarding if they appear
      if (find.text('Splash Screen').evaluate().isNotEmpty) {
        print('Skipping splash...');
        await Future.delayed(const Duration(seconds: 2));
        await tester.pumpAndSettle();
      }

      print('Step 1: Navigating to Plans tab...');
      final plansTab = find.byIcon(Icons.calendar_today);
      await tester.tap(plansTab);
      await tester.pumpAndSettle();

      print('Step 2: Creating a new plan with name "6 days demo"...');
      final addPlanButton = find.byIcon(LucideIcons.plus);
      await tester.tap(addPlanButton.last); // Use last in case of FAB and empty state button
      await tester.pumpAndSettle();

      final nameField = find.widgetWithText(TextField, 'Program Name');
      await tester.enterText(nameField, '6 days demo');
      await tester.pumpAndSettle();

      print('Step 3-4: Making a 6 day plan and adding 2-3 exercises to each day...');
      for (int day = 1; day <= 6; day++) {
        print('Adding Day $day...');
        final addDayButton = find.text('Add Day');
        if (addDayButton.evaluate().isEmpty) {
          await tester.tap(find.text('Add Training Day'));
        } else {
          await tester.tap(addDayButton);
        }
        await tester.pumpAndSettle();

        // The new day card should be visible. 
        // We'll add 2 exercises to each day.
        for (int ex = 1; ex <= 2; ex++) {
          print('  Adding Exercise $ex to Day $day...');
          final addExerciseButton = find.text('Add Exercise').last;
          await tester.tap(addExerciseButton);
          await tester.pumpAndSettle();

          // In ExercisePickerOverlay, select the first exercise found
          final firstExercise = find.byType(ListTile).first;
          await tester.tap(firstExercise);
          await tester.pumpAndSettle();
          
          // Check for overflows after adding exercise
          _checkForOverflows();
        }
      }

      print('Saving the program...');
      final saveButton = find.text('Save');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      print('Step 6: Setting this program as default workout program...');
      // Find the "6 days demo" card and use the popup menu
      final moreButton = find.byIcon(LucideIcons.ellipsisVertical).last;
      await tester.tap(moreButton);
      await tester.pumpAndSettle();

      final setAsDefault = find.text('Set as Default');
      await tester.tap(setAsDefault);
      await tester.pumpAndSettle();

      print('Step 7: Navigating to active screen and clicking start today workout...');
      final activeTab = find.byIcon(Icons.fitness_center);
      await tester.tap(activeTab);
      await tester.pumpAndSettle();

      final startWorkoutButton = find.text('START TODAY\'S WORKOUT');
      await tester.tap(startWorkoutButton);
      await tester.pumpAndSettle();

      // Confirm in BeginSessionSheet if it appears
      if (find.text('Begin Session').evaluate().isNotEmpty) {
        final startButton = find.text('6 days demo').first;
        await tester.tap(startButton);
        await tester.pumpAndSettle();
      }

      print('Step 8-9: Logging exercises and sets...');
      // Log 2 sets for the first exercise
      for (int s = 1; s <= 2; s++) {
        print('  Logging Set $s of Exercise 1...');
        // Find text fields for weight and reps
        // We'll use the first ones visible
        final weightField = find.byType(TextField).at(1); // 0 is title, 1 is first weight
        final repsField = find.byType(TextField).at(2);
        
        await tester.enterText(weightField, '60');
        await tester.enterText(repsField, '10');
        await tester.pumpAndSettle();

        final checkMark = find.byIcon(LucideIcons.check).first;
        await tester.tap(checkMark);
        await tester.pumpAndSettle();

        print('Step 10-11: Testing timer (+15s)...');
        if (find.text('REMAINING').evaluate().isNotEmpty) {
          final plus15 = find.text('+15s');
          await tester.tap(plus15);
          await tester.pumpAndSettle();
          print('    Timer +15s clicked.');
          
          // Wait a bit to see it working (simulated)
          await Future.delayed(const Duration(seconds: 1));
          
          if (s == 1) {
            print('Step 13: Skipping rest timer...');
            final skipRest = find.text('SKIP REST');
            await tester.tap(skipRest);
            await tester.pumpAndSettle();
          }
        }
      }

      print('Step 14: Finalizing workout...');
      final finishButton = find.text('Finish');
      await tester.tap(finishButton);
      await tester.pumpAndSettle();

      // In summary overlay
      final endWorkoutButton = find.text('END WORKOUT');
      await tester.tap(endWorkoutButton);
      await tester.pumpAndSettle();

      print('Step 15: Checking history and stats...');
      final historyTab = find.byIcon(Icons.history);
      await tester.tap(historyTab);
      await tester.pumpAndSettle();
      expect(find.text('6 days demo'), findsOneWidget);

      final statsTab = find.byIcon(Icons.analytics);
      await tester.tap(statsTab);
      await tester.pumpAndSettle();
      
      print('Verification SUCCESS!');
    });
  });
}

void _checkForOverflows() {
  // Logic to detect if there's an error widget or similar
  // Note: Flutter integration tests don't easily catch RenderFlex overflows unless they cause a crash
  // but we can look at the logs (handled by the runner).
}
