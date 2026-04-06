import Dexie, { type EntityTable } from 'dexie';

export type MuscleGroup = 'Chest' | 'Back' | 'Shoulders' | 'Biceps' | 'Triceps' | 'Legs' | 'Glutes' | 'Core' | 'Cardio' | 'Full Body' | 'Other';
export type EquipmentType = 'Barbell' | 'Dumbbell' | 'Machine' | 'Cable' | 'Bodyweight' | 'Kettlebell' | 'Bands' | 'Other';
export type SetType = 'Straight' | 'Superset' | 'Drop Set' | 'AMRAP' | 'Timed';

export interface Exercise {
  id?: number;
  name: string;
  primaryMuscle: MuscleGroup;
  secondaryMuscle?: MuscleGroup;
  equipment: EquipmentType;
  setType: SetType;
  restTime: number;
  instructions?: string;
  isCustom: boolean;
  lastUsed?: string;
}

export interface WorkoutTemplate {
  id?: number;
  name: string;
  description?: string;
  lastUsed?: string;
}

export interface TemplateDay {
  id?: number;
  templateId: number;
  name: string;
  order: number;
}

export interface TemplateSet {
  type: 'warmup' | 'working' | 'drop';
  reps: number;
  weight: number;
  rpe?: number | null;
}

export interface TemplateExercise {
  id?: number;
  dayId: number;
  exerciseId: number;
  order: number;
  setType: SetType;
  sets: TemplateSet[];
  restTime: number;
  notes?: string;
  supersetGroupId?: string;
}

export interface Workout {
  id?: number;
  name: string;
  date: string;
  startTime?: string;
  endTime?: string;
  duration?: number;
  templateId?: number;
  notes?: string;
  status: 'draft' | 'completed';
}

export interface WorkoutSet {
  id?: number;
  workoutId: number;
  exerciseId: number;
  exerciseOrder: number;
  setNumber: number;
  reps: number;
  weight: number;
  rpe?: number | null;
  type: 'warmup' | 'working' | 'drop';
  completed: boolean;
  completedAt?: string;
}

export interface BodyMeasurement {
  id?: number;
  date: string;
  weight?: number;
  chest?: number;
  waist?: number;
  hips?: number;
  leftArm?: number;
  rightArm?: number;
  leftThigh?: number;
  rightThigh?: number;
  calves?: number;
  bodyFat?: number;
}

export interface SyncQueueItem {
  id?: number;
  workoutId?: number;
  measurementId?: number;
  type: 'workout' | 'measurement';
  status: 'pending' | 'done' | 'failed';
  createdAt: string;
  attempts: number;
  error?: string;
}

const db = new Dexie('GymLogProDB') as Dexie & {
  exercises: EntityTable<Exercise, 'id'>;
  workout_templates: EntityTable<WorkoutTemplate, 'id'>;
  template_days: EntityTable<TemplateDay, 'id'>;
  template_exercises: EntityTable<TemplateExercise, 'id'>;
  workouts: EntityTable<Workout, 'id'>;
  workout_sets: EntityTable<WorkoutSet, 'id'>;
  body_measurements: EntityTable<BodyMeasurement, 'id'>;
  sync_queue: EntityTable<SyncQueueItem, 'id'>;
};

db.version(7).stores({
  exercises: '++id, name, primaryMuscle, equipment, isCustom, lastUsed',
  workout_templates: '++id, name, lastUsed',
  template_days: '++id, templateId, order',
  template_exercises: '++id, dayId, exerciseId, order',
  workouts: '++id, date, templateId, status',
  workout_sets: '++id, workoutId, exerciseId, exerciseOrder',
  body_measurements: '++id, date',
  sync_queue: '++id, workoutId, type, status, createdAt'
});

export { db };
