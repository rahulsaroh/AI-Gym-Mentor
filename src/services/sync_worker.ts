import { db } from '@/database/db';
import { appendWorkout, syncBodyMeasurement } from './sheets_service';

export async function processSyncQueue(accessToken: string, spreadsheetId: string) {
  const pendingItems = await db.sync_queue.where('status').equals('pending').toArray();
  
  if (pendingItems.length === 0) return;

  for (const item of pendingItems) {
    try {
      if (item.type === 'workout' && item.workoutId) {
        const workout = await db.workouts.get(item.workoutId);
        if (workout) {
          const sets = await db.workout_sets.where('workoutId').equals(workout.id!).toArray();
          const exercises = await db.exercises.toArray();
          await appendWorkout(accessToken, spreadsheetId, workout, sets, exercises);
        }
      } else if (item.type === 'measurement' && item.measurementId) {
        const measurement = await db.body_measurements.get(item.measurementId);
        if (measurement) {
          await syncBodyMeasurement(accessToken, spreadsheetId, measurement);
        }
      }

      await db.sync_queue.update(item.id!, { status: 'done' });
    } catch (error: any) {
      console.error('Sync error:', error);
      const attempts = item.attempts + 1;
      const status = attempts >= 3 ? 'failed' : 'pending';
      await db.sync_queue.update(item.id!, { 
        attempts, 
        status, 
        error: error.message || 'Unknown error' 
      });
    }
  }
}

// Helper to add to queue
export async function queueWorkoutSync(workoutId: number) {
  await db.sync_queue.add({
    workoutId,
    type: 'workout',
    status: 'pending',
    createdAt: new Date().toISOString(),
    attempts: 0
  });
}

export async function queueMeasurementSync(measurementId: number) {
  await db.sync_queue.add({
    measurementId,
    type: 'measurement',
    status: 'pending',
    createdAt: new Date().toISOString(),
    attempts: 0
  });
}
