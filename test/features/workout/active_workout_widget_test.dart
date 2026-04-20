import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/features/workout/active_workout_screen.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' hide Column;

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('ActiveWorkoutScreen - Add Set button creates a new row',
      (tester) async {
    // 1. Seed necessary data
    final exId = await db.into(db.exercises).insert(const ExercisesCompanion(
      name: Value('Bench Press'),
      primaryMuscle: Value('Chest'),
      equipment: Value('Barbell'),
      setType: Value('Strength'),
    ));
    final workoutId = await db.into(db.workouts).insert(WorkoutsCompanion.insert(
      name: 'Test Workout',
      date: DateTime.now(),
      startTime: Value(DateTime.now()),
    ));
    await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
      workoutId: workoutId,
      exerciseId: exId,
      exerciseOrder: 0,
      setNumber: 1,
      reps: 0,
      weight: 0,
    ));

    // 2. Wrap screen in ProviderScope and Material
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
        ],
        child: MaterialApp(
          home: ActiveWorkoutScreen(workoutId: workoutId),
        ),
      ),
    );

    // Wait for initial data load using fixed pump duration
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));

    // 3. Find "Add Set" button, scroll into view, then tap
    final addSetButton = find.text('Add Set');
    expect(addSetButton, findsOneWidget);
    await tester.ensureVisible(addSetButton);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(addSetButton);
    await tester.pump(const Duration(milliseconds: 500));

    // 4. Verify a new set was added (check DB has 2 sets now)
    final sets = await (db.select(db.workoutSets)
          ..where((t) => t.workoutId.equals(workoutId)))
        .get();
    expect(sets.length, 2);
  });
}
