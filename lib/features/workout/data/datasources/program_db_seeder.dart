import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:ai_gym_mentor/core/database/initial_data.dart';

class ProgramDbSeeder {
  static final ProgramDbSeeder instance = ProgramDbSeeder._();
  ProgramDbSeeder._();

  static const String _seedKey = 'program_seed_v3';

  Future<void> seed(AppDatabase database) async {
    final prefs = await SharedPreferences.getInstance();
    
    // We check if we have already seeded. If not, we do a full seed.
    // If yes, we can still check for missing specific programs.
    final alreadySeeded = prefs.getBool(_seedKey) == true;

    debugPrint('ProgramDbSeeder: Starting program seeding check (alreadySeeded: $alreadySeeded)...');
    final repository = WorkoutRepository(database);

    try {
      final existingTemplates = await repository.getAllTemplates();
      final existingNames = existingTemplates.map((t) => t.name).toSet();

      int addedCount = 0;
      for (final program in allSamplePrograms) {
        if (!existingNames.contains(program.name)) {
          debugPrint('ProgramDbSeeder: Seeding missing program: ${program.name}');
          await repository.importTemplateFromJson(jsonEncode(program.toJson()));
          addedCount++;
        }
      }

      if (addedCount > 0) {
        debugPrint('ProgramDbSeeder: Seeded $addedCount new programs.');
        
        // If we didn't have an active template, set the first one we found/added
        final activeId = prefs.getInt('active_template_id');
        if (activeId == null) {
          final templates = await repository.getAllTemplates();
          if (templates.isNotEmpty) {
            await repository.setActiveTemplate(templates.first.id);
            debugPrint('ProgramDbSeeder: Set ${templates.first.name} as active template');
          }
        }
      } else {
        debugPrint('ProgramDbSeeder: No new programs needed seeding.');
      }

      await prefs.setBool(_seedKey, true);
    } catch (e) {
      debugPrint('ProgramDbSeeder: Error during seeding: $e');
    }
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_seedKey);
  }
}
