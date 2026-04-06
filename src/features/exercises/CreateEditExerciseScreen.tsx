import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ChevronLeft, Save } from 'lucide-react';
import { db, MuscleGroup, EquipmentType, SetType } from '@/database/db';

const MUSCLE_GROUPS: MuscleGroup[] = ['Chest', 'Back', 'Shoulders', 'Biceps', 'Triceps', 'Legs', 'Glutes', 'Core', 'Cardio', 'Full Body'];
const EQUIPMENT_TYPES: EquipmentType[] = ['Barbell', 'Dumbbell', 'Machine', 'Cable', 'Bodyweight', 'Kettlebell', 'Bands', 'Other'];
const SET_TYPES: SetType[] = ['Straight', 'Superset', 'Drop Set', 'AMRAP', 'Timed'];

export default function CreateEditExerciseScreen() {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const [name, setName] = useState('');
  const [primaryMuscle, setPrimaryMuscle] = useState<MuscleGroup>('Chest');
  const [secondaryMuscle, setSecondaryMuscle] = useState<MuscleGroup | ''>('');
  const [equipment, setEquipment] = useState<EquipmentType>('Dumbbell');
  const [setType, setSetType] = useState<SetType>('Straight');
  const [restTime, setRestTime] = useState('90');
  const [instructions, setInstructions] = useState('');

  const handleSave = async () => {
    if (!name.trim()) {
      setError('Exercise name is required');
      return;
    }

    setLoading(true);
    setError('');

    try {
      // Check for uniqueness
      const existing = await db.exercises.where('name').equalsIgnoreCase(name.trim()).first();
      if (existing) {
        setError('An exercise with this name already exists');
        setLoading(false);
        return;
      }

      await db.exercises.add({
        name: name.trim(),
        primaryMuscle,
        secondaryMuscle: secondaryMuscle || undefined,
        equipment,
        setType,
        restTime: parseInt(restTime) || 90,
        instructions: instructions.trim(),
        isCustom: true,
      });

      navigate(-1);
    } catch (err) {
      setError('Failed to save exercise');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      <div className="sticky top-0 z-10 flex items-center justify-between bg-white p-4 shadow-sm dark:bg-gray-900">
        <div className="flex items-center">
          <button onClick={() => navigate(-1)} className="mr-4 text-gray-900 dark:text-white">
            <ChevronLeft size={24} />
          </button>
          <h1 className="text-xl font-bold text-gray-900 dark:text-white">Create Exercise</h1>
        </div>
        <button 
          onClick={handleSave}
          disabled={loading}
          className="flex items-center rounded-lg bg-primary px-4 py-2 text-sm font-medium text-white disabled:opacity-50"
        >
          {loading ? 'Saving...' : <><Save size={16} className="mr-2" /> Save</>}
        </button>
      </div>

      <div className="flex-1 overflow-y-auto p-4 space-y-6">
        {error && (
          <div className="rounded-lg bg-red-50 p-3 text-sm text-red-600 dark:bg-red-900/20 dark:text-red-400">
            {error}
          </div>
        )}

        <div>
          <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Exercise Name *</label>
          <input
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
            placeholder="e.g. Incline Dumbbell Press"
            className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
          />
        </div>

        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Primary Muscle</label>
            <select
              value={primaryMuscle}
              onChange={(e) => setPrimaryMuscle(e.target.value as MuscleGroup)}
              className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
            >
              {MUSCLE_GROUPS.map(m => <option key={m} value={m}>{m}</option>)}
            </select>
          </div>
          <div>
            <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Secondary Muscle</label>
            <select
              value={secondaryMuscle}
              onChange={(e) => setSecondaryMuscle(e.target.value as MuscleGroup | '')}
              className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
            >
              <option value="">None</option>
              {MUSCLE_GROUPS.map(m => <option key={m} value={m}>{m}</option>)}
            </select>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Equipment</label>
            <select
              value={equipment}
              onChange={(e) => setEquipment(e.target.value as EquipmentType)}
              className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
            >
              {EQUIPMENT_TYPES.map(eq => <option key={eq} value={eq}>{eq}</option>)}
            </select>
          </div>
          <div>
            <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Set Type</label>
            <select
              value={setType}
              onChange={(e) => setSetType(e.target.value as SetType)}
              className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
            >
              {SET_TYPES.map(st => <option key={st} value={st}>{st}</option>)}
            </select>
          </div>
        </div>

        <div>
          <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Default Rest Time (sec)</label>
          <input
            type="number"
            value={restTime}
            onChange={(e) => setRestTime(e.target.value)}
            className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
          />
        </div>

        <div>
          <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Instructions / Notes</label>
          <textarea
            value={instructions}
            onChange={(e) => setInstructions(e.target.value)}
            rows={4}
            className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
          />
        </div>
      </div>
    </div>
  );
}
