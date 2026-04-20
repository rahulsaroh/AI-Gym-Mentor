import 'package:flutter_test/flutter_test.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/services/progression_service.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart' hide Column, isNull, isNotNull;
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
      ],
    );
  });

  tearDown(() {
    container.dispose();
    db.close();
  });

  group('ProgressionService - 1RM Formulas', () {
    final service = ProgressionService();

    test('calculateEpley calculates correctly', () {
      expect(service.calculateEpley(100, 10), 100 * (1 + 10 / 30));
    });

    test('calculateBrzycki calculates correctly', () {
      expect(service.calculateBrzycki(100, 10), 100 * (36 / (37 - 10)));
    });

    test('getAll1RMs returns consistent results', () {
      final results = service.getAll1RMs(100, 10);
      expect(results['Epley'], isNotNull);
      expect(results['Brzycki'], isNotNull);
      expect(results['Lombardi'], isNotNull);
      expect(results['OConner'], isNotNull);
    });
  });

  group('ProgressionService - Logic', () {
    test('getSuggestion returns null when no history exists', () async {
      final service = container.read(progressionServiceProvider.notifier);
      final suggestion = await service.getSuggestion(1);
      expect(suggestion, isNull);
    });

    test('getSuggestion suggests increase when all targets hit', () async {
      final service = container.read(progressionServiceProvider.notifier);

      // 1. Setup exercise (include all required fields)
      await db.into(db.exercises).insert(const ExercisesCompanion(
        id: Value(1),
        name: Value('Bench Press'),
        primaryMuscle: Value('Chest'),
        equipment: Value('Barbell'),
        setType: Value('Straight'),
      ));

      // 2. Setup mock history (Hit all targets)
      final workoutId = await db.into(db.workouts).insert(WorkoutsCompanion.insert(
        name: 'Last Workout',
        date: DateTime.now().subtract(const Duration(days: 2)),
        startTime: Value(DateTime.now().subtract(const Duration(days: 2))),
      ));

      for (int i = 0; i < 3; i++) {
        await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
          workoutId: workoutId,
          exerciseId: 1,
          exerciseOrder: 0,
          setNumber: i + 1,
          reps: 10,
          weight: 100,
          completed: const Value(true),
          completedAt: Value(DateTime.now().subtract(const Duration(days: 2))),
        ));
      }

      // 3. Get suggestion (Default target is 10 reps)
      final suggestion = await service.getSuggestion(1, targetReps: 10);

      expect(suggestion, isNotNull);
      expect(suggestion!.suggestedWeight, 102.5); // Default increment is 2.5
      expect(suggestion.trendArrow, 'flat'); // Only one session
    });

    test('getSuggestion suggests maintain when target not fully hit', () async {
      final service = container.read(progressionServiceProvider.notifier);

      await db.into(db.exercises).insert(const ExercisesCompanion(
        id: Value(2),
        name: Value('Squat'),
        primaryMuscle: Value('Quads'),
        equipment: Value('Barbell'),
        setType: Value('Straight'),
      ));

      final workoutId = await db.into(db.workouts).insert(WorkoutsCompanion.insert(
        name: 'Last Workout',
        date: DateTime.now().subtract(const Duration(days: 2)),
        startTime: Value(DateTime.now().subtract(const Duration(days: 2))),
      ));

      // Missed some reps
      await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
        workoutId: workoutId,
        exerciseId: 2,
        exerciseOrder: 0,
        setNumber: 1,
        reps: 10,
        weight: 100,
        completed: const Value(true),
        completedAt: Value(DateTime.now().subtract(const Duration(days: 2))),
      ));
      await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
        workoutId: workoutId,
        exerciseId: 2,
        exerciseOrder: 0,
        setNumber: 2,
        reps: 8,
        weight: 100,
        completed: const Value(true),
        completedAt: Value(DateTime.now().subtract(const Duration(days: 2))),
      ));

      final suggestion = await service.getSuggestion(2, targetReps: 10);

      expect(suggestion!.suggestedWeight, 100.0);
      expect(suggestion.reason, contains('Maintain'));
    });
  });
}
