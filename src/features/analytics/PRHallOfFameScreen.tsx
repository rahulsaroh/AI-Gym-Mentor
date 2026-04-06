import React, { useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { db } from '@/database/db';
import { ChevronLeft, Trophy, Search } from 'lucide-react';
import { format } from 'date-fns';
import { cn } from '@/core/utils/cn';

type SortOption = 'Recent' | 'Highest 1RM';

export default function PRHallOfFameScreen() {
  const navigate = useNavigate();
  const [filterMuscle, setFilterMuscle] = useState<string>('All');
  const [sortBy, setSortBy] = useState<SortOption>('Recent');

  const sets = useLiveQuery(() => db.workout_sets.toArray());
  const workouts = useLiveQuery(() => db.workouts.toArray());
  const exercises = useLiveQuery(() => db.exercises.toArray());

  const prs = useMemo(() => {
    if (!sets || !workouts || !exercises) return [];

    const bests: Record<number, { weight: number, reps: number, est1RM: number, date: Date, exerciseName: string, muscle: string }> = {};

    const completedSets = sets.filter(s => s.completed && s.type !== 'warmup');
    
    completedSets.forEach(s => {
      const ex = exercises.find(e => e.id === s.exerciseId);
      if (!ex) return;

      const workout = workouts.find(w => w.id === s.workoutId);
      if (!workout) return;

      const est1RM = s.weight * (1 + s.reps / 30);
      
      if (!bests[s.exerciseId] || est1RM > bests[s.exerciseId].est1RM) {
        bests[s.exerciseId] = {
          weight: s.weight,
          reps: s.reps,
          est1RM,
          date: new Date(workout.date),
          exerciseName: ex.name,
          muscle: ex.primaryMuscle
        };
      }
    });

    let result = Object.entries(bests).map(([exId, data]) => ({
      exerciseId: Number(exId),
      ...data
    }));

    if (filterMuscle !== 'All') {
      result = result.filter(pr => pr.muscle === filterMuscle);
    }

    if (sortBy === 'Recent') {
      result.sort((a, b) => b.date.getTime() - a.date.getTime());
    } else {
      result.sort((a, b) => b.est1RM - a.est1RM);
    }

    return result;
  }, [sets, workouts, exercises, filterMuscle, sortBy]);

  const muscleGroups = useMemo(() => {
    if (!exercises) return ['All'];
    const groups = new Set(exercises.map(e => e.primaryMuscle));
    return ['All', ...Array.from(groups).sort()];
  }, [exercises]);

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      {/* AppBar */}
      <div className="flex items-center gap-3 border-b border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
        <button onClick={() => navigate(-1)} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
          <ChevronLeft size={24} />
        </button>
        <h1 className="text-lg font-bold text-gray-900 dark:text-white">PR Hall of Fame</h1>
      </div>

      <div className="flex-1 overflow-y-auto">
        {/* Filters */}
        <div className="sticky top-0 z-10 bg-surface/90 p-4 backdrop-blur-sm dark:bg-surface-dark/90">
          <div className="mb-3 flex gap-2 overflow-x-auto no-scrollbar">
            {muscleGroups.map(m => (
              <button
                key={m}
                onClick={() => setFilterMuscle(m)}
                className={cn(
                  "whitespace-nowrap rounded-full px-4 py-1.5 text-sm font-medium transition-colors",
                  filterMuscle === m
                    ? "bg-primary text-white"
                    : "bg-gray-100 text-gray-600 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700"
                )}
              >
                {m}
              </button>
            ))}
          </div>
          <div className="flex rounded-lg bg-gray-100 p-1 dark:bg-gray-800">
            {(['Recent', 'Highest 1RM'] as SortOption[]).map(opt => (
              <button
                key={opt}
                onClick={() => setSortBy(opt)}
                className={cn(
                  "flex-1 rounded-md py-1.5 text-sm font-medium transition-colors",
                  sortBy === opt 
                    ? "bg-white text-gray-900 shadow-sm dark:bg-gray-700 dark:text-white" 
                    : "text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200"
                )}
              >
                {opt}
              </button>
            ))}
          </div>
        </div>

        {/* PR List */}
        <div className="p-4 space-y-3">
          {prs.map(pr => (
            <div 
              key={pr.exerciseId}
              onClick={() => navigate(`/app/exercises/${pr.exerciseId}/history`)}
              className="flex cursor-pointer items-center justify-between rounded-xl border border-gray-100 bg-white p-4 shadow-sm transition-transform hover:scale-[1.02] dark:border-gray-800 dark:bg-gray-800"
            >
              <div className="flex items-center gap-4">
                <div className="flex h-12 w-12 items-center justify-center rounded-full bg-amber-100 text-amber-600 dark:bg-amber-900/30 dark:text-amber-500">
                  <Trophy size={24} />
                </div>
                <div>
                  <h3 className="font-bold text-gray-900 dark:text-white">{pr.exerciseName}</h3>
                  <p className="text-sm text-gray-500 dark:text-gray-400">{format(pr.date, 'MMM d, yyyy')}</p>
                </div>
              </div>
              <div className="text-right">
                <p className="text-lg font-black text-gray-900 dark:text-white">{pr.weight}kg <span className="text-sm font-medium text-gray-500 dark:text-gray-400">x {pr.reps}</span></p>
                <p className="text-xs font-medium text-primary">Est 1RM: {Math.round(pr.est1RM)}kg</p>
              </div>
            </div>
          ))}
          {prs.length === 0 && (
            <div className="py-12 text-center text-gray-500 dark:text-gray-400">
              <Trophy size={48} className="mx-auto mb-4 opacity-20" />
              <p>No PRs found for this filter.</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
