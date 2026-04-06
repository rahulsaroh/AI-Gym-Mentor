import React, { useState, useEffect, useMemo } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { db, Workout, WorkoutSet, Exercise } from '@/database/db';
import { Check, MoreVertical, Plus, Trash2, X, ChevronLeft, Timer } from 'lucide-react';
import { cn } from '@/core/utils/cn';
import ExercisePicker from '@/components/shared/ExercisePicker';
import PlateCalculator from './PlateCalculator';
import RestTimer from './RestTimer';
import WorkoutSummaryBottomSheet from './WorkoutSummaryBottomSheet';

import { queueWorkoutSync } from '@/services/sync_worker';

function formatTime(seconds: number) {
  const h = Math.floor(seconds / 3600);
  const m = Math.floor((seconds % 3600) / 60);
  const s = seconds % 60;
  if (h > 0) return `${h}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
  return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
}

export default function ActiveWorkoutScreen() {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const workoutId = Number(searchParams.get('id'));
  const dayId = searchParams.get('dayId') ? Number(searchParams.get('dayId')) : null;

  const workout = useLiveQuery(() => db.workouts.get(workoutId), [workoutId]);
  const sets = useLiveQuery(() => db.workout_sets.where('workoutId').equals(workoutId).toArray(), [workoutId]);
  const exercises = useLiveQuery(() => db.exercises.toArray());

  const [elapsedTime, setElapsedTime] = useState(0);
  const [showExercisePicker, setShowExercisePicker] = useState(false);
  const [isInitializing, setIsInitializing] = useState(true);
  
  const pastSets = useLiveQuery(async () => {
    if (!exercises) return {};
    const history: Record<number, WorkoutSet[]> = {};
    for (const ex of exercises) {
      const exSets = await db.workout_sets.where('exerciseId').equals(ex.id!).toArray();
      history[ex.id!] = exSets
        .filter(s => s.completed && s.workoutId !== workoutId)
        .sort((a, b) => new Date(b.completedAt || '').getTime() - new Date(a.completedAt || '').getTime());
    }
    return history;
  }, [exercises, workoutId]);

  const [plateCalcWeight, setPlateCalcWeight] = useState<number | null>(null);
  const [restTimer, setRestTimer] = useState<{ seconds: number, nextExercise?: string } | null>(null);
  const [prBanner, setPrBanner] = useState<{ exerciseName: string, weight: number } | null>(null);
  const [showSummary, setShowSummary] = useState(false);
  const [prsAchieved, setPrsAchieved] = useState(0);

  const [isOffline, setIsOffline] = useState(!navigator.onLine);

  useEffect(() => {
    const handleOnline = () => setIsOffline(false);
    const handleOffline = () => setIsOffline(true);
    window.addEventListener('online', handleOnline);
    window.addEventListener('offline', handleOffline);
    return () => {
      window.removeEventListener('online', handleOnline);
      window.removeEventListener('offline', handleOffline);
    };
  }, []);

  // Timer effect
  useEffect(() => {
    if (!workout?.startTime) return;
    const start = new Date(workout.startTime).getTime();
    
    const interval = setInterval(() => {
      setElapsedTime(Math.floor((Date.now() - start) / 1000));
    }, 1000);
    
    return () => clearInterval(interval);
  }, [workout?.startTime]);

  // Initialize from template if needed
  useEffect(() => {
    async function init() {
      if (!workout || !sets || !exercises) return;
      
      if (dayId && sets.length === 0 && isInitializing) {
        // Populate from template
        const templateExercises = await db.template_exercises.where('dayId').equals(dayId).toArray();
        templateExercises.sort((a, b) => a.order - b.order);
        
        const newSets: WorkoutSet[] = [];
        let exerciseOrder = 0;
        
        for (const te of templateExercises) {
          te.sets.forEach((ts, idx) => {
            newSets.push({
              workoutId,
              exerciseId: te.exerciseId,
              exerciseOrder,
              setNumber: idx + 1,
              reps: ts.reps,
              weight: ts.weight || 0,
              rpe: ts.rpe || null,
              type: ts.type as any,
              completed: false,
            });
          });
          exerciseOrder++;
        }
        
        if (newSets.length > 0) {
          await db.workout_sets.bulkAdd(newSets);
        }
      }
      setIsInitializing(false);
    }
    init();
  }, [workout, sets, exercises, dayId, workoutId, isInitializing]);

  // Group sets by exerciseOrder
  const exerciseBlocks = useMemo(() => {
    if (!sets) return [];
    const blocks: { exerciseOrder: number, exerciseId: number, sets: WorkoutSet[] }[] = [];
    
    // Sort sets by exerciseOrder then setNumber
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

  const handleUpdateWorkoutName = async (e: React.ChangeEvent<HTMLInputElement>) => {
    await db.workouts.update(workoutId, { name: e.target.value });
  };

  const handleAddExercise = async (exerciseId: number) => {
    const nextOrder = exerciseBlocks.length > 0 ? Math.max(...exerciseBlocks.map(b => b.exerciseOrder)) + 1 : 0;
    await db.workout_sets.add({
      workoutId,
      exerciseId,
      exerciseOrder: nextOrder,
      setNumber: 1,
      reps: 0,
      weight: 0,
      type: 'working',
      completed: false,
    });
    setShowExercisePicker(false);
  };

  const handleUpdateSet = async (setId: number, changes: Partial<WorkoutSet>) => {
    await db.workout_sets.update(setId, changes);
  };

  const handleToggleSet = async (set: WorkoutSet, exercise: Exercise | undefined) => {
    const newCompleted = !set.completed;
    await db.workout_sets.update(set.id!, { 
      completed: newCompleted,
      completedAt: newCompleted ? new Date().toISOString() : undefined
    });

    if (newCompleted) {
      if (navigator.vibrate) navigator.vibrate(50); // Haptic feedback
      
      // PR Check
      if (set.weight > 0 && set.reps > 0 && exercise) {
        const estimated1RM = set.weight * (1 + set.reps / 30);
        const pastSets = await db.workout_sets.where('exerciseId').equals(set.exerciseId).toArray();
        let best1RM = 0;
        for (const s of pastSets) {
          if (s.completed && s.workoutId !== workoutId) {
            const rm = s.weight * (1 + s.reps / 30);
            if (rm > best1RM) best1RM = rm;
          }
        }
        
        if (estimated1RM > best1RM && best1RM > 0) {
          setPrBanner({ exerciseName: exercise.name, weight: set.weight });
          setPrsAchieved(prev => prev + 1);
          setTimeout(() => setPrBanner(null), 3000);
        }
      }

      // Rest Timer
      if (exercise?.restTime) {
        // Find next exercise name if possible
        let nextExName = undefined;
        const currentBlockIdx = exerciseBlocks.findIndex(b => b.exerciseId === set.exerciseId);
        if (currentBlockIdx !== -1) {
          const block = exerciseBlocks[currentBlockIdx];
          const isLastSet = block.sets[block.sets.length - 1].id === set.id;
          if (isLastSet && currentBlockIdx < exerciseBlocks.length - 1) {
            const nextBlock = exerciseBlocks[currentBlockIdx + 1];
            nextExName = exercises?.find(e => e.id === nextBlock.exerciseId)?.name;
          }
        }
        setRestTimer({ seconds: exercise.restTime, nextExercise: nextExName });
      }
    }
  };

  const handleAddSet = async (block: typeof exerciseBlocks[0]) => {
    const lastSet = block.sets[block.sets.length - 1];
    await db.workout_sets.add({
      workoutId,
      exerciseId: block.exerciseId,
      exerciseOrder: block.exerciseOrder,
      setNumber: lastSet ? lastSet.setNumber + 1 : 1,
      reps: lastSet ? lastSet.reps : 0,
      weight: lastSet ? lastSet.weight : 0,
      rpe: lastSet ? lastSet.rpe : null,
      type: lastSet ? lastSet.type : 'working',
      completed: false,
    });
  };

  const handleRemoveSet = async (setId: number) => {
    await db.workout_sets.delete(setId);
  };

  const handleSaveWorkout = async (notes: string) => {
    await db.workouts.update(workoutId, {
      status: 'completed',
      endTime: new Date().toISOString(),
      duration: elapsedTime,
      notes,
    });
    // Delete incomplete sets
    const incompleteSets = sets?.filter(s => !s.completed) || [];
    for (const s of incompleteSets) {
      await db.workout_sets.delete(s.id!);
    }
    
    // Queue for sync
    await queueWorkoutSync(workoutId);
    
    navigate('/app/history', { replace: true });
  };

  const handleDiscardWorkout = async () => {
    await db.workouts.delete(workoutId);
    // Delete all sets
    const allSets = sets || [];
    for (const s of allSets) {
      await db.workout_sets.delete(s.id!);
    }
    navigate('/app/workout', { replace: true });
  };

  const completedSetsCount = sets?.filter(s => s.completed).length || 0;

  let pressTimer: NodeJS.Timeout;
  const handlePressStart = (weight: number) => {
    pressTimer = setTimeout(() => {
      setPlateCalcWeight(weight);
    }, 500);
  };
  const handlePressEnd = () => {
    clearTimeout(pressTimer);
  };

  if (!workout || !exercises) return <div className="p-4">Loading...</div>;

  return (
    <div className="flex h-full flex-col bg-gray-50 dark:bg-gray-900">
      {/* Header */}
      <div className="sticky top-0 z-10 bg-white px-4 py-3 shadow-sm dark:bg-gray-800">
        <div className="flex items-center justify-between">
          <button onClick={() => navigate(-1)} className="p-2 -ml-2 text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
            <ChevronLeft size={24} />
          </button>
          <div className="flex-1 px-2">
            <input 
              type="text" 
              value={workout.name} 
              onChange={handleUpdateWorkoutName}
              className="w-full bg-transparent text-center font-bold text-gray-900 focus:outline-none dark:text-white"
            />
            <div className="flex items-center justify-center gap-2 text-xs text-gray-500 dark:text-gray-400">
              <span className="flex items-center gap-1"><Timer size={12} /> {formatTime(elapsedTime)}</span>
              <span>•</span>
              <span>{completedSetsCount} sets done</span>
            </div>
          </div>
          <button 
            onClick={() => setShowSummary(true)}
            className="rounded-lg bg-primary px-4 py-1.5 text-sm font-bold text-white hover:bg-primary-dark"
          >
            Finish
          </button>
        </div>
      </div>

      {isOffline && (
        <div className="bg-orange-500 px-4 py-1 text-center text-xs font-bold text-white">
          Offline - Sync will happen when back online
        </div>
      )}

      {prBanner && (
        <div className="mx-4 mt-4 animate-in slide-in-from-top-4 fade-in rounded-xl bg-gradient-to-r from-amber-400 to-amber-600 p-3 text-center font-bold text-white shadow-lg">
          🏆 New PR! {prBanner.exerciseName} - {prBanner.weight}
        </div>
      )}

      {/* Exercise List */}
      <div className="flex-1 overflow-y-auto p-4 space-y-4 pb-24">
        {exerciseBlocks.map(block => {
          const exercise = exercises.find(e => e.id === block.exerciseId);
          return (
            <div key={block.exerciseOrder} className="rounded-xl border border-gray-200 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-800">
              {/* Card Header */}
              <div className="flex items-center justify-between border-b border-gray-100 p-3 dark:border-gray-700">
                <div className="flex items-center gap-2">
                  <h3 className="font-bold text-gray-900 dark:text-white">{exercise?.name || 'Unknown Exercise'}</h3>
                  <span className="rounded-full bg-primary/10 px-2 py-0.5 text-[10px] font-medium text-primary">
                    {exercise?.primaryMuscle}
                  </span>
                </div>
                <button className="p-1 text-gray-400 hover:text-gray-600 dark:hover:text-gray-200">
                  <MoreVertical size={18} />
                </button>
              </div>

              {/* Sets */}
              <div className="p-2">
                {/* Column Headers */}
                <div className="flex px-2 pb-2 text-xs font-medium text-gray-500 dark:text-gray-400">
                  <div className="w-8 text-center">Set</div>
                  <div className="flex-1 text-center">kg</div>
                  <div className="flex-1 text-center">Reps</div>
                  <div className="flex-1 text-center">RPE</div>
                  <div className="w-10 text-center"><Check size={14} className="mx-auto" /></div>
                </div>

                {/* Set Rows */}
                {block.sets.map((set, idx) => {
                  const prevSet = pastSets?.[block.exerciseId]?.filter(s => s.type === set.type)[idx];
                  return (
                  <div 
                    key={set.id} 
                    className={cn(
                      "flex items-center gap-2 rounded-lg p-1 mb-1 transition-colors relative group",
                      set.completed ? "bg-green-50 dark:bg-green-900/20" : "hover:bg-gray-50 dark:hover:bg-gray-700/50",
                      set.type === 'warmup' && !set.completed && "bg-yellow-50 dark:bg-yellow-900/20"
                    )}
                  >
                    <div className="w-8 text-center text-sm font-medium text-gray-500 dark:text-gray-400">
                      {set.type === 'warmup' ? 'W' : idx + 1}
                    </div>
                    
                    <div className="flex-1"
                         onPointerDown={() => handlePressStart(set.weight)}
                         onPointerUp={handlePressEnd}
                         onPointerLeave={handlePressEnd}
                    >
                      <input 
                        type="number" 
                        value={set.weight || ''}
                        onChange={e => handleUpdateSet(set.id!, { weight: Number(e.target.value) })}
                        className={cn(
                          "w-full rounded-md bg-gray-100 px-2 py-1.5 text-center text-sm font-semibold focus:bg-white focus:outline-none focus:ring-2 focus:ring-primary dark:bg-gray-700 dark:text-white dark:focus:bg-gray-600",
                          set.completed && "bg-transparent opacity-70"
                        )}
                        placeholder={prevSet ? String(prevSet.weight) : "-"}
                      />
                    </div>
                    
                    <div className="flex-1">
                      <input 
                        type="number" 
                        value={set.reps || ''}
                        onChange={e => handleUpdateSet(set.id!, { reps: Number(e.target.value) })}
                        className={cn(
                          "w-full rounded-md bg-gray-100 px-2 py-1.5 text-center text-sm font-semibold focus:bg-white focus:outline-none focus:ring-2 focus:ring-primary dark:bg-gray-700 dark:text-white dark:focus:bg-gray-600",
                          set.completed && "bg-transparent opacity-70"
                        )}
                        placeholder={prevSet ? String(prevSet.reps) : "-"}
                      />
                    </div>

                    <div className="flex-1">
                      <input 
                        type="number" 
                        step="0.5"
                        min="6"
                        max="10"
                        value={set.rpe || ''}
                        onChange={e => handleUpdateSet(set.id!, { rpe: e.target.value ? Number(e.target.value) : null })}
                        className={cn(
                          "w-full rounded-md bg-gray-100 px-2 py-1.5 text-center text-sm font-semibold focus:bg-white focus:outline-none focus:ring-2 focus:ring-primary dark:bg-gray-700 dark:text-white dark:focus:bg-gray-600",
                          set.completed && "bg-transparent opacity-70"
                        )}
                        placeholder={prevSet?.rpe ? String(prevSet.rpe) : "-"}
                      />
                    </div>

                    <div className="w-10 flex justify-center">
                      <button 
                        onClick={() => handleToggleSet(set, exercise)}
                        className={cn(
                          "flex h-8 w-8 items-center justify-center rounded-md transition-colors",
                          set.completed 
                            ? "bg-green-500 text-white" 
                            : "bg-gray-200 text-gray-400 hover:bg-gray-300 dark:bg-gray-600 dark:text-gray-400 dark:hover:bg-gray-500"
                        )}
                      >
                        <Check size={16} strokeWidth={3} />
                      </button>
                    </div>

                    <button 
                      onClick={() => handleRemoveSet(set.id!)}
                      className="p-2 text-red-500 opacity-0 transition-opacity group-hover:opacity-100 focus:opacity-100 sm:opacity-0 opacity-100"
                    >
                      <Trash2 size={18} />
                    </button>
                  </div>
                )})}

                <button 
                  onClick={() => handleAddSet(block)}
                  className="mt-2 flex w-full items-center justify-center gap-1 rounded-lg py-2 text-sm font-medium text-gray-500 hover:bg-gray-50 dark:text-gray-400 dark:hover:bg-gray-700"
                >
                  <Plus size={16} /> Add Set
                </button>
              </div>
            </div>
          );
        })}

        <button 
          onClick={() => setShowExercisePicker(true)}
          className="flex w-full items-center justify-center gap-2 rounded-xl border-2 border-dashed border-gray-300 p-4 font-medium text-gray-500 hover:border-primary hover:text-primary dark:border-gray-700 dark:text-gray-400 dark:hover:border-primary dark:hover:text-primary"
        >
          <Plus size={20} /> Add Exercise
        </button>
      </div>

      {showExercisePicker && (
        <ExercisePicker 
          onClose={() => setShowExercisePicker(false)} 
          onSelect={handleAddExercise} 
        />
      )}

      {plateCalcWeight !== null && (
        <PlateCalculator 
          targetWeight={plateCalcWeight} 
          onClose={() => setPlateCalcWeight(null)} 
        />
      )}

      {restTimer && (
        <RestTimer 
          initialSeconds={restTimer.seconds}
          nextExerciseName={restTimer.nextExercise}
          onClose={() => setRestTimer(null)}
        />
      )}

      {showSummary && (
        <WorkoutSummaryBottomSheet 
          workout={workout}
          sets={sets || []}
          exercises={exercises || []}
          elapsedTime={elapsedTime}
          prsAchieved={prsAchieved}
          onSave={handleSaveWorkout}
          onDiscard={handleDiscardWorkout}
          onClose={() => setShowSummary(false)}
        />
      )}
    </div>
  );
}
