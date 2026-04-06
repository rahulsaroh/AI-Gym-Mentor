import { db, Exercise } from './db';
import exercisesData from '../assets/data/exercises.json';

export async function seedDatabase() {
  try {
    const count = await db.exercises.count();
    if (count === 0) {
      console.log('Seeding database with exercises...');
      await db.exercises.bulkAdd(exercisesData as Exercise[]);
      console.log('Database seeded successfully.');
      
      await seedPrograms();
    }
  } catch (error) {
    console.error('Failed to seed database:', error);
  }
}

async function seedPrograms() {
  const squat = await db.exercises.where('name').equals('Squat').first();
  const bench = await db.exercises.where('name').equals('Barbell Bench Press').first();
  const deadlift = await db.exercises.where('name').equals('Deadlift').first();
  const pullup = await db.exercises.where('name').equals('Pull-ups').first();
  const ohp = await db.exercises.where('name').equals('Overhead Press').first();
  const row = await db.exercises.where('name').equals('Barbell Row').first();
  const legPress = await db.exercises.where('name').equals('Leg Press').first();
  const curl = await db.exercises.where('name').equals('Barbell Curl').first();
  const pushdown = await db.exercises.where('name').equals('Triceps Pushdown').first();

  if (!squat || !bench || !deadlift || !pullup || !ohp || !row) return;

  // Program 1: Full Body 3x/week
  const p1Id = await db.workout_templates.add({
    name: 'Full Body 3x/week',
    description: 'A classic full body routine for beginners and intermediates.',
  });

  const d1Id = await db.template_days.add({ templateId: p1Id, name: 'Workout A', order: 0 });
  await db.template_exercises.bulkAdd([
    { dayId: d1Id, exerciseId: squat.id!, order: 0, setType: 'Straight', sets: [{type: 'working', reps: 5, weight: 0}, {type: 'working', reps: 5, weight: 0}, {type: 'working', reps: 5, weight: 0}], restTime: 180 },
    { dayId: d1Id, exerciseId: bench.id!, order: 1, setType: 'Straight', sets: [{type: 'working', reps: 5, weight: 0}, {type: 'working', reps: 5, weight: 0}, {type: 'working', reps: 5, weight: 0}], restTime: 180 },
    { dayId: d1Id, exerciseId: row.id!, order: 2, setType: 'Straight', sets: [{type: 'working', reps: 5, weight: 0}, {type: 'working', reps: 5, weight: 0}, {type: 'working', reps: 5, weight: 0}], restTime: 180 },
  ]);

  const d2Id = await db.template_days.add({ templateId: p1Id, name: 'Workout B', order: 1 });
  await db.template_exercises.bulkAdd([
    { dayId: d2Id, exerciseId: deadlift.id!, order: 0, setType: 'Straight', sets: [{type: 'working', reps: 5, weight: 0}], restTime: 180 },
    { dayId: d2Id, exerciseId: ohp.id!, order: 1, setType: 'Straight', sets: [{type: 'working', reps: 5, weight: 0}, {type: 'working', reps: 5, weight: 0}, {type: 'working', reps: 5, weight: 0}], restTime: 180 },
    { dayId: d2Id, exerciseId: pullup.id!, order: 2, setType: 'Straight', sets: [{type: 'working', reps: 5, weight: 0}, {type: 'working', reps: 5, weight: 0}, {type: 'working', reps: 5, weight: 0}], restTime: 180 },
  ]);

  // Program 2: Push Pull Legs 6x/week
  const p2Id = await db.workout_templates.add({
    name: 'Push Pull Legs 6x/week',
    description: 'Advanced 6-day split for maximum hypertrophy.',
  });
  
  const d3Id = await db.template_days.add({ templateId: p2Id, name: 'Push', order: 0 });
  await db.template_exercises.bulkAdd([
    { dayId: d3Id, exerciseId: bench.id!, order: 0, setType: 'Straight', sets: [{type: 'working', reps: 8, weight: 0}, {type: 'working', reps: 8, weight: 0}, {type: 'working', reps: 8, weight: 0}], restTime: 120 },
    { dayId: d3Id, exerciseId: ohp.id!, order: 1, setType: 'Straight', sets: [{type: 'working', reps: 10, weight: 0}, {type: 'working', reps: 10, weight: 0}, {type: 'working', reps: 10, weight: 0}], restTime: 120 },
    { dayId: d3Id, exerciseId: pushdown?.id || bench.id!, order: 2, setType: 'Straight', sets: [{type: 'working', reps: 12, weight: 0}, {type: 'working', reps: 12, weight: 0}, {type: 'working', reps: 12, weight: 0}], restTime: 90 },
  ]);

  const d4Id = await db.template_days.add({ templateId: p2Id, name: 'Pull', order: 1 });
  await db.template_exercises.bulkAdd([
    { dayId: d4Id, exerciseId: row.id!, order: 0, setType: 'Straight', sets: [{type: 'working', reps: 8, weight: 0}, {type: 'working', reps: 8, weight: 0}, {type: 'working', reps: 8, weight: 0}], restTime: 120 },
    { dayId: d4Id, exerciseId: pullup.id!, order: 1, setType: 'Straight', sets: [{type: 'working', reps: 10, weight: 0}, {type: 'working', reps: 10, weight: 0}, {type: 'working', reps: 10, weight: 0}], restTime: 120 },
    { dayId: d4Id, exerciseId: curl?.id || row.id!, order: 2, setType: 'Straight', sets: [{type: 'working', reps: 12, weight: 0}, {type: 'working', reps: 12, weight: 0}, {type: 'working', reps: 12, weight: 0}], restTime: 90 },
  ]);

  const d5Id = await db.template_days.add({ templateId: p2Id, name: 'Legs', order: 2 });
  await db.template_exercises.bulkAdd([
    { dayId: d5Id, exerciseId: squat.id!, order: 0, setType: 'Straight', sets: [{type: 'working', reps: 8, weight: 0}, {type: 'working', reps: 8, weight: 0}, {type: 'working', reps: 8, weight: 0}], restTime: 120 },
    { dayId: d5Id, exerciseId: legPress?.id || squat.id!, order: 1, setType: 'Straight', sets: [{type: 'working', reps: 10, weight: 0}, {type: 'working', reps: 10, weight: 0}, {type: 'working', reps: 10, weight: 0}], restTime: 120 },
  ]);

  // Program 3: Upper Lower 4x/week
  const p3Id = await db.workout_templates.add({
    name: 'Upper Lower 4x/week',
    description: 'Balanced 4-day split for strength and size.',
  });
  
  const d6Id = await db.template_days.add({ templateId: p3Id, name: 'Upper', order: 0 });
  await db.template_exercises.bulkAdd([
    { dayId: d6Id, exerciseId: bench.id!, order: 0, setType: 'Straight', sets: [{type: 'working', reps: 6, weight: 0}, {type: 'working', reps: 6, weight: 0}, {type: 'working', reps: 6, weight: 0}, {type: 'working', reps: 6, weight: 0}], restTime: 180 },
    { dayId: d6Id, exerciseId: row.id!, order: 1, setType: 'Straight', sets: [{type: 'working', reps: 6, weight: 0}, {type: 'working', reps: 6, weight: 0}, {type: 'working', reps: 6, weight: 0}, {type: 'working', reps: 6, weight: 0}], restTime: 180 },
  ]);

  const d7Id = await db.template_days.add({ templateId: p3Id, name: 'Lower', order: 1 });
  await db.template_exercises.bulkAdd([
    { dayId: d7Id, exerciseId: squat.id!, order: 0, setType: 'Straight', sets: [{type: 'working', reps: 6, weight: 0}, {type: 'working', reps: 6, weight: 0}, {type: 'working', reps: 6, weight: 0}, {type: 'working', reps: 6, weight: 0}], restTime: 180 },
    { dayId: d7Id, exerciseId: deadlift.id!, order: 1, setType: 'Straight', sets: [{type: 'working', reps: 6, weight: 0}, {type: 'working', reps: 6, weight: 0}], restTime: 180 },
  ]);
}
