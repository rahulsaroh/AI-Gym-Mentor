import React, { useState } from 'react';
import { X, Trophy, Clock, Dumbbell, Activity } from 'lucide-react';
import { Workout, WorkoutSet, Exercise } from '@/database/db';

interface WorkoutSummaryProps {
  workout: Workout;
  sets: WorkoutSet[];
  exercises: Exercise[];
  elapsedTime: number;
  prsAchieved: number;
  onSave: (notes: string) => void;
  onDiscard: () => void;
  onClose: () => void;
}

function formatTime(seconds: number) {
  const h = Math.floor(seconds / 3600);
  const m = Math.floor((seconds % 3600) / 60);
  if (h > 0) return `${h}h ${m}m`;
  return `${m}m`;
}

export default function WorkoutSummaryBottomSheet({ workout, sets, exercises, elapsedTime, prsAchieved, onSave, onDiscard, onClose }: WorkoutSummaryProps) {
  const [notes, setNotes] = useState(workout.notes || '');

  const completedSets = sets.filter(s => s.completed);
  const totalVolume = completedSets.reduce((acc, set) => acc + (set.weight * set.reps), 0);
  
  // Group sets by exercise
  const exerciseSummary = completedSets.reduce((acc, set) => {
    if (!acc[set.exerciseId]) {
      acc[set.exerciseId] = { count: 0, maxWeight: 0 };
    }
    acc[set.exerciseId].count += 1;
    if (set.weight > acc[set.exerciseId].maxWeight) {
      acc[set.exerciseId].maxWeight = set.weight;
    }
    return acc;
  }, {} as Record<number, { count: number, maxWeight: number }>);

  return (
    <div className="fixed inset-0 z-50 flex items-end justify-center bg-black/50 sm:items-center">
      <div className="w-full max-w-md rounded-t-2xl bg-white p-6 shadow-xl dark:bg-gray-900 sm:rounded-2xl max-h-[90vh] overflow-y-auto">
        <div className="mb-6 flex items-center justify-between">
          <h2 className="text-xl font-bold text-gray-900 dark:text-white">Workout Summary</h2>
          <button onClick={onClose} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
            <X size={24} />
          </button>
        </div>

        <div className="grid grid-cols-2 gap-4 mb-6">
          <div className="rounded-xl bg-gray-50 p-4 dark:bg-gray-800">
            <div className="flex items-center gap-2 text-gray-500 dark:text-gray-400 mb-1">
              <Clock size={16} />
              <span className="text-sm font-medium">Duration</span>
            </div>
            <div className="text-2xl font-bold text-gray-900 dark:text-white">{formatTime(elapsedTime)}</div>
          </div>
          
          <div className="rounded-xl bg-gray-50 p-4 dark:bg-gray-800">
            <div className="flex items-center gap-2 text-gray-500 dark:text-gray-400 mb-1">
              <Activity size={16} />
              <span className="text-sm font-medium">Volume</span>
            </div>
            <div className="text-2xl font-bold text-gray-900 dark:text-white">{totalVolume} kg</div>
          </div>

          <div className="rounded-xl bg-gray-50 p-4 dark:bg-gray-800">
            <div className="flex items-center gap-2 text-gray-500 dark:text-gray-400 mb-1">
              <Dumbbell size={16} />
              <span className="text-sm font-medium">Sets</span>
            </div>
            <div className="text-2xl font-bold text-gray-900 dark:text-white">{completedSets.length}</div>
          </div>

          <div className="rounded-xl bg-amber-50 p-4 dark:bg-amber-900/20">
            <div className="flex items-center gap-2 text-amber-600 dark:text-amber-500 mb-1">
              <Trophy size={16} />
              <span className="text-sm font-medium">PRs</span>
            </div>
            <div className="text-2xl font-bold text-amber-700 dark:text-amber-400">{prsAchieved}</div>
          </div>
        </div>

        <div className="mb-6 space-y-3">
          <h3 className="font-bold text-gray-900 dark:text-white">Exercises</h3>
          {Object.entries(exerciseSummary).map(([exId, stats]) => {
            const ex = exercises.find(e => e.id === Number(exId));
            return (
              <div key={exId} className="flex justify-between items-center text-sm">
                <span className="font-medium text-gray-700 dark:text-gray-300">{ex?.name || 'Unknown'}</span>
                <span className="text-gray-500 dark:text-gray-400">{stats.count} sets • Best: {stats.maxWeight}kg</span>
              </div>
            );
          })}
        </div>

        <div className="mb-8">
          <label className="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">Workout Notes</label>
          <textarea
            value={notes}
            onChange={(e) => setNotes(e.target.value)}
            className="w-full rounded-xl border border-gray-200 bg-gray-50 p-3 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
            rows={3}
            placeholder="How did it feel?"
          />
        </div>

        <div className="space-y-3">
          <button 
            onClick={() => onSave(notes)}
            className="w-full rounded-xl bg-primary py-3.5 font-bold text-white hover:bg-primary-dark"
          >
            Save Workout
          </button>
          <button 
            onClick={onDiscard}
            className="w-full rounded-xl py-3.5 font-bold text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20"
          >
            Discard Workout
          </button>
        </div>
      </div>
    </div>
  );
}
