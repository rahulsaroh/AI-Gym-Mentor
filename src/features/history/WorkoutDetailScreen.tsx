import React, { useState, useMemo } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { db, WorkoutSet, Exercise } from '@/database/db';
import { ChevronLeft, Edit2, Trash2, Clock, Dumbbell, Trophy, Check } from 'lucide-react';
import { format } from 'date-fns';
import { cn } from '@/core/utils/cn';

function formatDuration(seconds: number) {
  const h = Math.floor(seconds / 3600);
  const m = Math.floor((seconds % 3600) / 60);
  if (h > 0) return `${h}h ${m}m`;
  return `${m}m`;
}

export default function WorkoutDetailScreen() {
  const { id } = useParams();
  const navigate = useNavigate();
  const workoutId = Number(id);

  const workout = useLiveQuery(() => db.workouts.get(workoutId), [workoutId]);
  const sets = useLiveQuery(() => db.workout_sets.where('workoutId').equals(workoutId).toArray(), [workoutId]);
  const exercises = useLiveQuery(() => db.exercises.toArray());

  const [isEditing, setIsEditing] = useState(false);

  // Fetch all sets for PR calculation
  const allSets = useLiveQuery(() => db.workout_sets.toArray());
  const allWorkouts = useLiveQuery(() => db.workouts.toArray());

  const prs = useMemo(() => {
    if (!sets || !allSets || !allWorkouts || !exercises || !workout) return [];
    
    const prList: { exerciseName: string, weight: number, reps: number }[] = [];
    
    // For each completed working set in this workout
    const workoutSets = sets.filter(s => s.completed && s.type !== 'warmup');
    
    workoutSets.forEach(set => {
      const ex = exercises.find(e => e.id === set.exerciseId);
      if (!ex) return;

      const est1RM = set.weight * (1 + set.reps / 30);
      
      // Find all sets for this exercise completed BEFORE this workout
      const pastSets = allSets.filter(s => {
        if (s.exerciseId !== set.exerciseId || !s.completed || s.type === 'warmup') return false;
        const w = allWorkouts.find(w => w.id === s.workoutId);
        if (!w) return false;
        return new Date(w.date).getTime() < new Date(workout.date).getTime();
      });

      let bestPast1RM = 0;
      pastSets.forEach(ps => {
        const ps1RM = ps.weight * (1 + ps.reps / 30);
        if (ps1RM > bestPast1RM) bestPast1RM = ps1RM;
      });

      if (est1RM > bestPast1RM && bestPast1RM > 0) {
        // It's a PR! Check if we already added this exercise to avoid duplicates
        if (!prList.find(pr => pr.exerciseName === ex.name)) {
          prList.push({ exerciseName: ex.name, weight: set.weight, reps: set.reps });
        }
      }
    });

    return prList;
  }, [sets, allSets, allWorkouts, exercises, workout]);

  const exerciseBlocks = useMemo(() => {
    if (!sets) return [];
    const blocks: { exerciseOrder: number, exerciseId: number, sets: WorkoutSet[] }[] = [];
    
    const sortedSets = [...sets].sort((a, b) => {
      if (a.exerciseOrder !== b.exerciseOrder) return a.exerciseOrder - b.exerciseOrder;
      return a.setNumber - b.setNumber;
    });

    sortedSets.forEach(set => {
      let block = blocks.find(b => b.exerciseOrder === set.exerciseOrder);
      if (!block) {
        block = { exerciseOrder: set.exerciseOrder, exerciseId: set.exerciseId, sets: [] };
        blocks.push(block);
      }
      block.sets.push(set);
    });

    return blocks;
  }, [sets]);

  const muscleVolume = useMemo<{ map: Record<string, number>, total: number }>(() => {
    if (!sets || !exercises) return { map: {}, total: 0 };
    const map: Record<string, number> = {};
    let total = 0;
    
    sets.filter(s => s.completed).forEach(set => {
      const ex = exercises.find(e => e.id === set.exerciseId);
      if (ex) {
        const vol = set.weight * set.reps;
        map[ex.primaryMuscle] = (map[ex.primaryMuscle] || 0) + vol;
        total += vol;
      }
    });
    
    return { map, total };
  }, [sets, exercises]);

  const handleDelete = async () => {
    if (window.confirm('Are you sure you want to delete this workout? This action cannot be undone.')) {
      await db.workouts.delete(workoutId);
      if (sets) {
        for (const s of sets) {
          await db.workout_sets.delete(s.id!);
        }
      }
      navigate('/app/history', { replace: true });
    }
  };

  const handleUpdateSet = async (setId: number, changes: Partial<WorkoutSet>) => {
    await db.workout_sets.update(setId, changes);
  };

  if (!workout || !sets || !exercises) {
    return <div className="p-4 text-center">Loading...</div>;
  }

  const totalVolume = sets.filter(s => s.completed).reduce((acc, set) => acc + (set.weight * set.reps), 0);

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      {/* AppBar */}
      <div className="flex items-center justify-between border-b border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
        <div className="flex items-center gap-3">
          <button onClick={() => navigate(-1)} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
            <ChevronLeft size={24} />
          </button>
          <div>
            <h1 className="text-lg font-bold text-gray-900 dark:text-white">
              {format(new Date(workout.date), 'MMM d, yyyy')}
            </h1>
            <p className="text-xs text-gray-500 dark:text-gray-400">{workout.name}</p>
          </div>
        </div>
        <button 
          onClick={() => setIsEditing(!isEditing)}
          className={cn(
            "rounded-lg px-3 py-1.5 text-sm font-bold transition-colors",
            isEditing 
              ? "bg-primary text-white" 
              : "bg-gray-100 text-gray-600 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700"
          )}
        >
          {isEditing ? 'Done' : 'Edit'}
        </button>
      </div>

      <div className="flex-1 overflow-y-auto p-4 space-y-6">
        {/* Summary Stats */}
        <div className="grid grid-cols-2 gap-4">
          <div className="rounded-xl bg-white p-4 shadow-sm border border-gray-100 dark:bg-gray-800 dark:border-gray-700">
            <div className="flex items-center gap-2 text-gray-500 dark:text-gray-400 mb-1">
              <Clock size={16} />
              <span className="text-sm font-medium">Duration</span>
            </div>
            <div className="text-xl font-bold text-gray-900 dark:text-white">{formatDuration(workout.duration || 0)}</div>
          </div>
          <div className="rounded-xl bg-white p-4 shadow-sm border border-gray-100 dark:bg-gray-800 dark:border-gray-700">
            <div className="flex items-center gap-2 text-gray-500 dark:text-gray-400 mb-1">
              <Dumbbell size={16} />
              <span className="text-sm font-medium">Volume</span>
            </div>
            <div className="text-xl font-bold text-gray-900 dark:text-white">{totalVolume} kg</div>
          </div>
        </div>

        {/* Muscle Volume Bar */}
        {muscleVolume.total > 0 && (
          <div className="rounded-xl bg-white p-4 shadow-sm border border-gray-100 dark:bg-gray-800 dark:border-gray-700">
            <h3 className="text-sm font-bold text-gray-900 dark:text-white mb-3">Muscle Group Volume</h3>
            <div className="flex h-4 w-full overflow-hidden rounded-full bg-gray-100 dark:bg-gray-700">
              {Object.entries(muscleVolume.map).map(([muscle, vol], idx) => {
                const colors = ['bg-blue-500', 'bg-purple-500', 'bg-green-500', 'bg-orange-500', 'bg-pink-500'];
                const pct = (Number(vol) / muscleVolume.total) * 100;
                return (
                  <div 
                    key={muscle} 
                    style={{ width: `${pct}%` }} 
                    className={colors[idx % colors.length]}
                    title={`${muscle}: ${Math.round(pct)}%`}
                  />
                );
              })}
            </div>
            <div className="mt-3 flex flex-wrap gap-2">
              {Object.entries(muscleVolume.map).map(([muscle, vol], idx) => {
                const colors = ['text-blue-500', 'text-purple-500', 'text-green-500', 'text-orange-500', 'text-pink-500'];
                const pct = (Number(vol) / muscleVolume.total) * 100;
                return (
                  <div key={muscle} className="flex items-center gap-1 text-xs">
                    <div className={cn("h-2 w-2 rounded-full", colors[idx % colors.length].replace('text-', 'bg-'))} />
                    <span className="text-gray-600 dark:text-gray-300">{muscle} ({Math.round(pct)}%)</span>
                  </div>
                );
              })}
            </div>
          </div>
        )}

        {/* Notes */}
        {workout.notes && (
          <div className="rounded-xl bg-amber-50 p-4 dark:bg-amber-900/20">
            <h3 className="text-sm font-bold text-amber-800 dark:text-amber-500 mb-1">Notes</h3>
            <p className="text-sm text-amber-700 dark:text-amber-400">{workout.notes}</p>
          </div>
        )}

        {/* PRs */}
        {prs.length > 0 && (
          <div className="rounded-xl bg-gradient-to-r from-amber-400 to-amber-600 p-4 text-white shadow-sm">
            <h3 className="flex items-center gap-2 text-sm font-bold mb-2">
              <Trophy size={16} /> PRs Achieved
            </h3>
            <div className="space-y-1">
              {prs.map((pr, idx) => (
                <div key={idx} className="flex items-center justify-between text-sm font-medium">
                  <span>{pr.exerciseName}</span>
                  <span>{pr.weight}kg x {pr.reps}</span>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Exercises */}
        <div className="space-y-4">
          {exerciseBlocks.map(block => {
            const exercise = exercises.find(e => e.id === block.exerciseId);
            return (
              <div key={block.exerciseOrder} className="rounded-xl border border-gray-200 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-800">
                <div 
                  className="flex items-center justify-between border-b border-gray-100 p-3 cursor-pointer hover:bg-gray-50 dark:border-gray-700 dark:hover:bg-gray-700/50"
                  onClick={() => navigate(`/app/exercises/${exercise?.id}/history`)}
                >
                  <div className="flex items-center gap-2">
                    <h3 className="font-bold text-gray-900 dark:text-white">{exercise?.name || 'Unknown Exercise'}</h3>
                    <span className="rounded-full bg-primary/10 px-2 py-0.5 text-[10px] font-medium text-primary">
                      {exercise?.primaryMuscle}
                    </span>
                  </div>
                  <ChevronLeft size={16} className="rotate-180 text-gray-400" />
                </div>

                <div className="p-2">
                  <div className="flex px-2 pb-2 text-xs font-medium text-gray-500 dark:text-gray-400">
                    <div className="w-8 text-center">Set</div>
                    <div className="flex-1 text-center">kg</div>
                    <div className="flex-1 text-center">Reps</div>
                    <div className="flex-1 text-center">RPE</div>
                    <div className="w-16 text-right">Vol</div>
                  </div>

                  {block.sets.map((set, idx) => (
                    <div 
                      key={set.id} 
                      className={cn(
                        "flex items-center gap-2 rounded-lg p-1 mb-1",
                        !set.completed && "opacity-50",
                        set.type === 'warmup' && "bg-gray-50 dark:bg-gray-700/30"
                      )}
                    >
                      <div className="w-8 text-center text-sm font-medium text-gray-500 dark:text-gray-400">
                        {set.type === 'warmup' ? 'W' : idx + 1}
                      </div>
                      
                      {isEditing ? (
                        <>
                          <div className="flex-1">
                            <input 
                              type="number" 
                              value={set.weight || ''}
                              onChange={e => handleUpdateSet(set.id!, { weight: Number(e.target.value) })}
                              className="w-full rounded-md bg-gray-100 px-2 py-1 text-center text-sm font-semibold focus:bg-white focus:outline-none focus:ring-2 focus:ring-primary dark:bg-gray-700 dark:text-white"
                            />
                          </div>
                          <div className="flex-1">
                            <input 
                              type="number" 
                              value={set.reps || ''}
                              onChange={e => handleUpdateSet(set.id!, { reps: Number(e.target.value) })}
                              className="w-full rounded-md bg-gray-100 px-2 py-1 text-center text-sm font-semibold focus:bg-white focus:outline-none focus:ring-2 focus:ring-primary dark:bg-gray-700 dark:text-white"
                            />
                          </div>
                          <div className="flex-1">
                            <input 
                              type="number" 
                              step="0.5"
                              value={set.rpe || ''}
                              onChange={e => handleUpdateSet(set.id!, { rpe: e.target.value ? Number(e.target.value) : null })}
                              className="w-full rounded-md bg-gray-100 px-2 py-1 text-center text-sm font-semibold focus:bg-white focus:outline-none focus:ring-2 focus:ring-primary dark:bg-gray-700 dark:text-white"
                            />
                          </div>
                        </>
                      ) : (
                        <>
                          <div className="flex-1 text-center text-sm font-semibold text-gray-900 dark:text-white">
                            {set.weight}
                          </div>
                          <div className="flex-1 text-center text-sm font-semibold text-gray-900 dark:text-white">
                            {set.reps}
                          </div>
                          <div className="flex-1 text-center text-sm text-gray-500 dark:text-gray-400">
                            {set.rpe || '-'}
                          </div>
                        </>
                      )}

                      <div className="w-16 text-right text-sm font-medium text-gray-500 dark:text-gray-400">
                        {set.weight * set.reps}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            );
          })}
        </div>

        <button 
          onClick={handleDelete}
          className="mt-8 flex w-full items-center justify-center gap-2 rounded-xl border border-red-200 bg-red-50 py-3 font-bold text-red-600 hover:bg-red-100 dark:border-red-900/30 dark:bg-red-900/20 dark:text-red-500 dark:hover:bg-red-900/40"
        >
          <Trash2 size={20} /> Delete Workout
        </button>
      </div>
    </div>
  );
}
