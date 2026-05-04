/// Removes duplicate exercises from the database by keeping the yuhonas_* version
/// and removing numeric-ID duplicates. Also normalizes exercise names to Title Case.
///
/// Usage: Run this function from a maintenance script or admin panel.
/// Note: This should be run AFTER backing up the database.
///
/// Returns: A summary of changes made.
Future<Map<String, dynamic>> removeDuplicateExercises() async {
  final db = AppDatabase();
  
  // Step 1: Find duplicates by name (case-insensitive)
  final allExercises = await db.select(db.exercises).get();
  final nameGroups = <String, List<ExerciseTable>>{};
  
  for (final ex in allExercises) {
    final normalized = ex.name.toLowerCase().trim();
    nameGroups.putIfAbsent(normalized, () => []).add(ex);
  }
  
  final duplicates = nameGroups.entries.where((e) => e.value.length > 1).toList();
  
  int removedCount = 0;
  int normalizedCount = 0;
  final changes = <String, dynamic>{};
  
  for (final group in duplicates) {
    final exercises = group.value;
    
    // Find yuhonas_* and numeric entries
    final yuhonasEntries = exercises.where((e) => 
        e.exerciseId?.startsWith('yuhonas_') ?? false).toList();
    final numericEntries = exercises.where((e) => 
        !(e.exerciseId?.startsWith('yuhonas_') ?? true)).toList();
    
    if (yuhonasEntries.isNotEmpty && numericEntries.isNotEmpty) {
      // Keep the first yuhonas entry, remove the rest
      for (final numeric in numericEntries) {
        // Check if this exercise is referenced in workout sets
        final referencedSets = await (db.select(db.workoutSets)
          ..where((t) => t.exerciseId.equals(numeric.id)))
          .get();
        
        if (referencedSets.isEmpty) {
          // Safe to delete
          await db.delete(db.exercises)
            ..where((t) => t.id.equals(numeric.id));
          removedCount++;
          
          // Clean up related records
          await db.delete(db.exerciseMuscles)
            ..where((t) => t.exerciseId.equals(numeric.id));
          await db.delete(db.exerciseBodyParts)
            ..where((t) => t.exerciseId.equals(numeric.id));
          await db.delete(db.exerciseInstructions)
            ..where((t) => t.exerciseId.equals(numeric.id));
          await db.delete(db.recentExercises)
            ..where((t) => t.exerciseId.equals(numeric.id));
          await db.delete(db.exerciseProgressions)
            ..where((t) => t.exerciseId.equals(numeric.id));
          await db.delete(db.exerciseProgressions)
            ..where((t) => t.progressionExerciseId.equals(numeric.id));
          await db.delete(db.exerciseEnrichedContent)
            ..where((t) => t.exerciseId.equals(numeric.id));
          
          changes['removed_${numeric.id}'] = {
            'name': numeric.name,
            'exerciseId': numeric.exerciseId,
            'reason': 'duplicate_with_yuhonas_id',
          };
        } else {
          // Has references - update reference to point to yuhonas ID instead
          final yuhonasEntry = yuhonasEntries.first;
          for (final set in referencedSets) {
            await (db.update(db.workoutSets)
              ..where((t) => t.id.equals(set.id)))
              .write(WorkoutSetsCompanion(
                exerciseId: Value(yuhonasEntry.id),
              ));
          }
          
          // Now safe to delete
          await db.delete(db.exercises)
            ..where((t) => t.id.equals(numeric.id));
          removedCount++;
          
          changes['migrated_${numeric.id}'] = {
            'name': numeric.name,
            'oldId': numeric.id,
            'newId': yuhonasEntry.id,
            'reason': 'migrated_references_to_yuhonas',
          };
        }
      }
    }
  }
  
  // Step 2: Normalize case (only for remaining entries)
  final remaining = await db.select(db.exercises).get();
  for (final ex in remaining) {
    final normalized = _toTitleCase(ex.name);
    if (normalized != ex.name) {
      await (db.update(db.exercises)
        ..where((t) => t.id.equals(ex.id)))
        .write(ExercisesCompanion(name: Value(normalized)));
      normalizedCount++;
      
      changes['normalized_${ex.id}'] = {
        'oldName': ex.name,
        'newName': normalized,
      };
    }
  }
  
  return {
    'removed': removedCount,
    'normalized': normalizedCount,
    'duplicateGroups': duplicates.length,
    'changes': changes,
  };
}

/// Converts a string to Title Case (e.g., "barbell curl" → "Barbell Curl")
String _toTitleCase(String input) {
  if (input.isEmpty) return input;
  
  // Handle special cases
  final specialCases = {
    '3/4': '3/4',
    '1/2': '1/2',
    'ii': 'II',
    'iii': 'III',
    'iv': 'IV',
  };
  
  return input.split(' ').map((word) {
    if (word.isEmpty) return word;
    
    // Check special cases
    for (final key in specialCases.keys) {
      if (word.toLowerCase().contains(key)) {
        return word.replaceAll(key, specialCases[key]!);
      }
    }
    
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}
