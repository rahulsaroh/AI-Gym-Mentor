import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ai_gym_mentor/main.dart' as app;
import 'package:ai_gym_mentor/services/export_service.dart';
import 'package:ai_gym_mentor/services/import_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Body Measurements Flow Test', (tester) async {
    app.main();
    await tester.pump(const Duration(seconds: 5)); await tester.pump();;

    // 1. Add sample body measurements on any two dates
    // Handle onboarding if it appears
    await tester.pump(const Duration(seconds: 5)); await tester.pump();;
    
    // Skip Onboarding
    if (find.text('Skip').evaluate().isNotEmpty) {
      await tester.tap(find.text('Skip'));
      await tester.pump(const Duration(seconds: 2));
      await tester.pump();
    }
    
    // Handle Setup Screen if it appears
    if (find.text("Let's set you up").evaluate().isNotEmpty) {
      await tester.enterText(find.byType(TextField).first, 'Test User');
      await tester.pump(const Duration(seconds: 2)); await tester.pump();;
      await tester.tap(find.text('Complete Setup'));
      await tester.pump(const Duration(seconds: 5)); await tester.pump();;
    }

    // Navigate to Stats Tab
    print('DEBUG: Navigating to Stats Tab');
    final statsTab = find.byIcon(Icons.analytics);
    await tester.tap(statsTab.evaluate().isNotEmpty ? statsTab : find.text('Stats').last);
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(); // One more pump to be sure

    // Wait for the tabs to appear (Glance, Strength, Growth, etc.)
    await tester.pump(const Duration(seconds: 2)); await tester.pump();;

    // Go to "Measurements" tab
    print('DEBUG: Navigating to Measurements Tab');
    final growthTab = find.descendant(of: find.byType(TabBar), matching: find.text('Measurements'));
    if (growthTab.evaluate().isNotEmpty) {
      await tester.tap(growthTab);
      await tester.pump(const Duration(seconds: 2));
      await tester.pump();
    } else {
      print('DEBUG: Measurements tab not found via TabBar, trying text directly');
      final growthText = find.text('Measurements');
      if (growthText.evaluate().isNotEmpty) {
        await tester.tap(growthText.first);
        await tester.pump(const Duration(seconds: 2));
        await tester.pump();
      } else {
        print('DEBUG: Measurements tab absolutely not found');
      }
    }

    // Take screenshot 1: Initial state
    await binding.convertFlutterSurfaceToImage();
    await binding.takeScreenshot('1_body_measurements_initial');

    // 1. Add sample body measurements
    print('DEBUG: Adding sample measurements');
    // Check if "Seed Sample Data" button exists (it should since we cleared app data)
    final seedButton = find.text('Seed Sample Data');
    if (seedButton.evaluate().isNotEmpty) {
      print('DEBUG: Seeding via button');
      await tester.tap(seedButton);
      await tester.pump(const Duration(seconds: 2)); await tester.pump();;
    } else {
      print('DEBUG: Manual seeding');
      // Fallback to manual add if seed button not found
      Future<void> addMeasurement(double weight, double targetWeight, String notes) async {
        final fab = find.byType(FloatingActionButton);
        if (fab.evaluate().isNotEmpty) {
          await tester.tap(fab);
        } else {
          await tester.tap(find.text('+ Log Entry'));
        }
        await tester.pump(const Duration(seconds: 2)); await tester.pump();;
        
        final weightRow = find.ancestor(of: find.text('Weight'), matching: find.byType(Row));
        final textFields = find.descendant(of: weightRow, matching: find.byType(TextField));
        
        await tester.enterText(textFields.at(0), weight.toString());
        await tester.enterText(textFields.at(1), targetWeight.toString());
        await tester.enterText(find.byType(TextField).last, notes);
        
        await tester.tap(find.text('Save'));
        await tester.pump(const Duration(seconds: 2)); await tester.pump();;
      }

      await addMeasurement(80.5, 75.0, 'Measurement 1');
      await tester.pump(const Duration(seconds: 2)); await tester.pump();;
      await addMeasurement(81.0, 75.0, 'Measurement 2');
      await tester.pump(const Duration(seconds: 2)); await tester.pump();;
    }

    // Take screenshot 2: After adding
    await binding.convertFlutterSurfaceToImage();
    await binding.takeScreenshot('2_after_adding_measurements');

    // 2. Export that file
    final directory = await getApplicationDocumentsDirectory();
    final exportPath = '${directory.path}/test_export.xlsx';
    ExportService.testExportPath = exportPath;

    await tester.tap(find.text('Settings'));
    await tester.pump(const Duration(seconds: 2)); await tester.pump();;
    
    await tester.tap(find.text('Excel Data Sync'));
    await tester.pump(const Duration(seconds: 2)); await tester.pump();;
    
    await tester.tap(find.text('Export to Excel (.xlsx)'));
    await tester.pump(const Duration(seconds: 5));
    await tester.pump();

    // Take screenshot 3: Export Result
    await binding.convertFlutterSurfaceToImage();
    await binding.takeScreenshot('3_export_result');
    
    await tester.tap(find.text('Close'));
    await tester.pump(const Duration(seconds: 2)); await tester.pump();;

    // 3. Delete body measurements programmatically since swipe history UI is gone
    final container = ProviderScope.containerOf(tester.element(find.byType(app.GymGeminiApp)));
    final db = container.read(appDatabaseProvider);
    await db.delete(db.bodyMeasurements).go();
    await tester.pump(const Duration(seconds: 2)); await tester.pump();;

    // Take screenshot 4: After deletion
    await binding.convertFlutterSurfaceToImage();
    await binding.takeScreenshot('4_after_deletion');

    // 4. Import that file again to add body measurements of those 2 days in the app
    await tester.tap(find.text('Settings'));
    await tester.pump(const Duration(seconds: 2)); await tester.pump();;
    
    await tester.tap(find.text('Excel Data Sync'));
    await tester.pump(const Duration(seconds: 2)); await tester.pump();;

    ImportService.testImportPath = exportPath;
    await tester.tap(find.text('Import from Excel (.xlsx)'));
    await tester.pump(const Duration(seconds: 2)); await tester.pump();;
    
    // In ImportMappingScreen
    await tester.tap(find.text('Import'));
    await tester.pump(const Duration(seconds: 5));
    await tester.pump();

    // Take screenshot 5: After import
    await binding.convertFlutterSurfaceToImage();
    await binding.takeScreenshot('5_after_import');

    // 5. Check if everything matches correctly
    await tester.tap(find.byIcon(Icons.analytics));
    await tester.pump(const Duration(seconds: 2)); await tester.pump();;
    
    await tester.tap(find.text('Measurements'));
    await tester.pump(const Duration(seconds: 2)); await tester.pump();;
    
    // Check for the seeded values
    final hasSeeded = find.text('Current 82.5 kg | Target: 75.0 kg').evaluate().isNotEmpty;
    if (hasSeeded) {
      expect(find.textContaining('82.5 kg'), findsWidgets);
    } else {
      expect(find.textContaining('81.0 kg'), findsWidgets);
    }

    // Take screenshot 6: Final state
    await binding.convertFlutterSurfaceToImage();
    await binding.takeScreenshot('6_final_verification');
  });
}
