import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';

class ProgramDbSeeder {
  static final ProgramDbSeeder instance = ProgramDbSeeder._();
  ProgramDbSeeder._();

  static const String _seedKey = 'program_seed_v1';

  Future<void> seed(AppDatabase database) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_seedKey) == true) {
      debugPrint('ProgramDbSeeder: Already seeded, skipping...');
      return;
    }

    debugPrint('ProgramDbSeeder: Starting program seeding...');
    final repository = WorkoutRepository(database);

    try {
      // Load the Elite PPL program from assets
      final jsonString = await rootBundle.loadString('assets/data/ppl_elite_program.json');
      
      // We use the repository's import method to handle the heavy lifting
      // but we need to find the templateId after import to set it as active.
      await repository.importTemplateFromJson(jsonString);
      
      // Get all templates to find the one we just imported
      final templates = await repository.getAllTemplates();
      final eliteTemplate = templates.firstWhere(
        (t) => t.name.contains('6 Day PPL Elite'),
        orElse: () => templates.first,
      );

      // Set it as active if none is currently active
      final activeId = prefs.getInt('active_template_id');
      if (activeId == null) {
        await repository.setActiveTemplate(eliteTemplate.id);
        debugPrint('ProgramDbSeeder: Set "6 Day PPL Elite" as active template');
      }

      await prefs.setBool(_seedKey, true);
      debugPrint('ProgramDbSeeder: Seed completed successfully!');
    } catch (e) {
      debugPrint('ProgramDbSeeder: Error during seeding: $e');
    }
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_seedKey);
  }
}
