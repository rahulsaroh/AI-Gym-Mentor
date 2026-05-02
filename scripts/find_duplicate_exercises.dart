import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:drift/drift.dart';

void main() async {
  final db = AppDatabase();
  
  // Find duplicate exercises by name
  final allExercises = await db.select(db.exercises).get();
  
  print('=== Duplicate Exercise Analysis ===\n');
  print('Total exercises in database: ${allExercises.length}\n');
  
  // Group by name
  final nameGroups = <String, List<ExerciseTable>>{};
  for (final ex in allExercises) {
    nameGroups.putIfAbsent(ex.name, () => []).add(ex);
  }
  
  // Find duplicates by name
  final nameDuplicates = nameGroups.entries.where((e) => e.value.length > 1).toList();
  nameDuplicates.sort((a, b) => b.value.length.compareTo(a.value.length));
  
  print('--- Duplicates by Name ---\n');
  int nameDupCount = 0;
  for (final group in nameDuplicates) {
    nameDupCount += group.value.length;
    print('Name: "${group.key}" (${group.value.length} duplicates)');
    for (final ex in group.value) {
      print('  - ID: ${ex.id}, exerciseId: ${ex.exerciseId ?? "(null)"}, source: ${ex.source}, category: ${ex.category}, equipment: ${ex.equipment}');
    }
    print('');
  }
  
  // Group by exerciseId (external ID)
  final idGroups = <String, List<ExerciseTable>>{};
  for (final ex in allExercises) {
    if (ex.exerciseId != null) {
      idGroups.putIfAbsent(ex.exerciseId!, () => []).add(ex);
    }
  }
  
  final idDuplicates = idGroups.entries.where((e) => e.value.length > 1).toList();
  idDuplicates.sort((a, b) => b.value.length.compareTo(a.value.length));
  
  print('--- Duplicates by exercise_id ---\n');
  int idDupCount = 0;
  for (final group in idDuplicates) {
    idDupCount += group.value.length;
    print('ID: "${group.key}" (${group.value.length} duplicates)');
    for (final ex in group.value) {
      print('  - DB ID: ${ex.id}, name: "${ex.name}", source: ${ex.source}');
    }
    print('');
  }
  
  // Group by name + category + equipment (near duplicates)
  final keyGroups = <String, List<ExerciseTable>>{};
  for (final ex in allExercises) {
    final key = '${ex.name}|${ex.category}|${ex.equipment}'.toLowerCase();
    keyGroups.putIfAbsent(key, () => []).add(ex);
  }
  
  final keyDuplicates = keyGroups.entries.where((e) => e.value.length > 1).toList();
  keyDuplicates.sort((a, b) => b.value.length.compareTo(a.value.length));
  
  print('--- Duplicates by Name+Category+Equipment ---\n');
  int keyDupCount = 0;
  for (final group in keyDuplicates) {
    keyDupCount += group.value.length;
    print('Key: "${group.key}" (${group.value.length} duplicates)');
    for (final ex in group.value) {
      print('  - ID: ${ex.id}, exerciseId: ${ex.exerciseId ?? "(null)"}, diff: ${ex.difficulty}');
    }
    print('');
  }
  
  print('=== Summary ===');
  print('Total exercises: ${allExercises.length}');
  print('Exercises with duplicate names: $nameDupCount (in ${nameDuplicates.length} groups)');
  print('Exercises with duplicate exercise_id: $idDupCount (in ${idDuplicates.length} groups)');
  print('Exercises with duplicate name+cat+equip: $keyDupCount (in ${keyDuplicates.length} groups)');
  
  // Count by source
  final sourceCounts = <String, int>{};
  for (final ex in allExercises) {
    sourceCounts[ex.source] = (sourceCounts[ex.source] ?? 0) + 1;
  }
  print('\n--- By Source ---');
  sourceCounts.forEach((k, v) => print('$k: $v'));
  
  // Count unique names
  final uniqueNames = allExercises.map((e) => e.name).toSet().length;
  print('\nUnique names: $uniqueNames');
  print('Unique exercise_ids: ${idGroups.length}');
}
