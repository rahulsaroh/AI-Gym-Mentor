import 'package:flutter_test/flutter_test.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:drift/native.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart' hide Column;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  late AppDatabase db;
  late WorkoutRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = WorkoutRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('End-to-End Workflow: 6 Days Demo Plan', () async {
    print('Step 1-4: Creating a 6-day plan with 3 exercises per day...');

    // 0. Ensure we have some exercises in DB
    final ex1 = await db.into(db.exercises).insert(const ExercisesCompanion(
          name: Value('Bench Press'),
          primaryMuscle: Value('Chest'),
          equipment: Value('Barbell'),
          setType: Value('Strength'),
        ));
    final ex2 = await db.into(db.exercises).insert(const ExercisesCompanion(
          name: Value('Squat'),
          primaryMuscle: Value('Quads'),
          equipment: Value('Barbell'),
          setType: Value('Strength'),
        ));

    // 1-2. Create a new plan with name "6 days demo"
    final templateId = await db
        .into(db.workoutTemplates)
        .insert(const WorkoutTemplatesCompanion(
          name: Value('6 days demo'),
          description: Value('Automated testing plan'),
        ));

    // 3. Make a 6 day plan
    for (int i = 0; i < 6; i++) {
      final dayId =
          await db.into(db.templateDays).insert(TemplateDaysCompanion.insert(
                templateId: templateId,
                name: 'Day ${i + 1}',
                order: i,
              ));

      // 4. Add 2-3 exercises to each day
      await db
          .into(db.templateExercises)
          .insert(TemplateExercisesCompanion.insert(
            dayId: dayId,
            exerciseId: ex1,
            order: 0,
            setsJson: '[{"sets":3, "reps":10, "rest":90}]',
          ));
      await db
          .into(db.templateExercises)
          .insert(TemplateExercisesCompanion.insert(
            dayId: dayId,
            exerciseId: ex2,
            order: 1,
            setsJson: '[{"sets":3, "reps":10, "rest":90}]',
          ));
    }

    print('Step 5: Making this program default workout program...');
    await repo.setActiveTemplate(templateId);
    final activeTemplate = await repo.getActiveTemplate();
    expect(activeTemplate?.id, templateId);

    print('Step 6: Starting today workout on top card (Day 1)...');
    final templateDays = await repo.getTemplateDays(templateId);
    final day1 = templateDays.first;

    final workoutId = await repo.createWorkout(
      name: 'Logged Workout',
      templateId: templateId,
      dayId: day1.id,
    );

    print('Step 7-9: Start workout and log 2-3 sets for each exercise...');
    final templateExercises = await repo.getTemplateExercises(day1.id);
    expect(templateExercises.length, 2);

    for (var te in templateExercises) {
      // 8. Add 2-3 sets to each exercise
      for (int s = 1; s <= 3; s++) {
        await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
              workoutId: workoutId,
              exerciseId: te.exercise.id,
              exerciseOrder: te.templateExercise.order,
              setNumber: s,
              reps: 10,
              weight: 60.0,
              completed: const Value(true),
              rir: const Value(2), // Testing the new RIR field
            ));
      }
    }

    print('Step 10: Ending workout...');
    await (db.update(db.workouts)..where((t) => t.id.equals(workoutId))).write(
      WorkoutsCompanion(
        status: const Value('completed'),
        endTime: Value(DateTime.now()),
      ),
    );

    print('Step 11: Checking history and stats...');
    final history = await repo.getHistoryWithVolume();
    expect(history.length, 1);
    expect(history.first['workout'].id, workoutId);
    expect(history.first['volume'],
        60.0 * 10 * 6); // 2 exercises * 3 sets * 60kg * 10 reps

    final stats = await repo.getStats();
    expect(stats['totalWorkouts'], 1);
    expect(stats['totalVolume'], 3600.0);
    print('Verification SUCCESS: Entire workflow completed correctly!');
  });
}
