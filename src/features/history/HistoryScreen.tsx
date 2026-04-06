import React, { useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { db, Workout, WorkoutSet, Exercise } from '@/database/db';
import { Flame, Activity, Calendar, Trash2, Clock, Dumbbell } from 'lucide-react';
import { format, subMonths, startOfMonth, endOfMonth, eachDayOfInterval, isSameDay, isToday, startOfWeek, endOfWeek, subDays } from 'date-fns';
import { cn } from '@/core/utils/cn';

function formatDuration(seconds: number) {
  const h = Math.floor(seconds / 3600);
  const m = Math.floor((seconds % 3600) / 60);
  if (h > 0) return `${h}h ${m}m`;
  return `${m}m`;
}

export default function HistoryScreen() {
  const navigate = useNavigate();
  
  const [limit, setLimit] = useState(20);
  
  const workouts = useLiveQuery(() => 
    db.workouts.where('status').equals('completed').reverse().sortBy('date')
  );
  
  const sets = useLiveQuery(() => db.workout_sets.toArray());
  const exercises = useLiveQuery(() => db.exercises.toArray());

  const handleScroll = (e: React.UIEvent<HTMLDivElement>) => {
    const { scrollTop, clientHeight, scrollHeight } = e.currentTarget;
    if (scrollHeight - scrollTop <= clientHeight * 1.5) {
      setLimit(prev => prev + 20);
    }
  };

  const [deletedWorkout, setDeletedWorkout] = useState<Workout | null>(null);
  const [deletedSets, setDeletedSets] = useState<WorkoutSet[]>([]);
  const [showUndo, setShowUndo] = useState(false);

  // Calculate Stats
  const stats = useMemo(() => {
    if (!workouts || !sets) return { currentStreak: 0, longestStreak: 0, totalWorkouts: 0, totalVolume: 0 };
    
    const totalWorkouts = workouts.length;
    const completedSets = sets.filter(s => s.completed);
    const totalVolume = completedSets.reduce((acc, set) => acc + (set.weight * set.reps), 0);

    // Calculate streaks
    let currentStreak = 0;
    let longestStreak = 0;
    let tempStreak = 0;
    let lastDate: Date | null = null;

    // Sort ascending for streak calculation
    const sortedWorkouts = [...workouts].sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime());
    
    sortedWorkouts.forEach(w => {
      const wDate = new Date(w.date);
      wDate.setHours(0, 0, 0, 0);
      
      if (!lastDate) {
        tempStreak = 1;
      } else {
        const diffDays = Math.floor((wDate.getTime() - lastDate.getTime()) / (1000 * 60 * 60 * 24));
        if (diffDays === 1) {
          tempStreak++;
        } else if (diffDays > 1) {
          if (tempStreak > longestStreak) longestStreak = tempStreak;
          tempStreak = 1;
        }
      }
      lastDate = wDate;
    });
    
    if (tempStreak > longestStreak) longestStreak = tempStreak;
    
    // Check if current streak is still active (worked out today or yesterday)
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    if (lastDate) {
      const diffDays = Math.floor((today.getTime() - lastDate.getTime()) / (1000 * 60 * 60 * 24));
      if (diffDays <= 1) {
        currentStreak = tempStreak;
      }
    }

    return { currentStreak, longestStreak, totalWorkouts, totalVolume };
  }, [workouts, sets]);

  // Generate Calendar Data (Last 12 Months)
  const calendarMonths = useMemo(() => {
    const months = [];
    const today = new Date();
    for (let i = 11; i >= 0; i--) {
      const monthDate = subMonths(today, i);
      const start = startOfWeek(startOfMonth(monthDate));
      const end = endOfWeek(endOfMonth(monthDate));
      const days = eachDayOfInterval({ start, end });
      months.push({
        label: format(monthDate, 'MMM yyyy'),
        days,
        isCurrentMonth: i === 0
      });
    }
    return months;
  }, []);

  // Calculate volume per day for heatmap
  const volumePerDay = useMemo(() => {
    if (!workouts || !sets) return {};
    const map: Record<string, number> = {};
    
    workouts.forEach(w => {
      const dateStr = format(new Date(w.date), 'yyyy-MM-dd');
      const wSets = sets.filter(s => s.workoutId === w.id && s.completed);
      const vol = wSets.reduce((acc, set) => acc + (set.weight * set.reps), 0);
      map[dateStr] = (map[dateStr] || 0) + vol;
    });
    
    return map;
  }, [workouts, sets]);

  const getIntensityClass = (date: Date) => {
    const dateStr = format(date, 'yyyy-MM-dd');
    const vol = volumePerDay[dateStr] || 0;
    if (vol === 0) return 'bg-gray-100 dark:bg-gray-800';
    if (vol < 5000) return 'bg-blue-200 dark:bg-blue-900/40';
    if (vol < 10000) return 'bg-blue-400 dark:bg-blue-700';
    return 'bg-blue-800 dark:bg-blue-500'; // Heavy
  };

  // Group workouts by date
  const groupedWorkouts = useMemo(() => {
    if (!workouts) return [];
    const groups: { label: string, workouts: Workout[] }[] = [];
    
    const today = new Date();
    const startOfThisWeek = startOfWeek(today);
    const startOfLastWeek = subDays(startOfThisWeek, 7);

    const limitedWorkouts = workouts.slice(0, limit);

    limitedWorkouts.forEach(w => {
      const wDate = new Date(w.date);
      let label = format(wDate, 'MMMM yyyy');
      
      if (wDate >= startOfThisWeek) {
        label = 'This Week';
      } else if (wDate >= startOfLastWeek && wDate < startOfThisWeek) {
        label = 'Last Week';
      }

      let group = groups.find(g => g.label === label);
      if (!group) {
        group = { label, workouts: [] };
        groups.push(group);
      }
      group.workouts.push(w);
    });

    return groups;
  }, [workouts, limit]);

  const handleDelete = async (workout: Workout) => {
    if (window.confirm('Delete this workout?')) {
      const wSets = sets?.filter(s => s.workoutId === workout.id) || [];
      setDeletedWorkout(workout);
      setDeletedSets(wSets);
      
      await db.workouts.delete(workout.id!);
      for (const s of wSets) {
        await db.workout_sets.delete(s.id!);
      }
      
      setShowUndo(true);
      setTimeout(() => setShowUndo(false), 5000);
    }
  };

  const handleUndo = async () => {
    if (deletedWorkout) {
      const newWorkoutId = await db.workouts.add(deletedWorkout);
      const newSets = deletedSets.map(s => ({ ...s, workoutId: newWorkoutId, id: undefined }));
      await db.workout_sets.bulkAdd(newSets);
      setShowUndo(false);
      setDeletedWorkout(null);
      setDeletedSets([]);
    }
  };

  const scrollToWorkout = (date: Date) => {
    const dateStr = format(date, 'yyyy-MM-dd');
    const el = document.getElementById(`workout-${dateStr}`);
    if (el) {
      el.scrollIntoView({ behavior: 'smooth', block: 'center' });
    } else {
      // Show snackbar (simulated with alert for now, or just ignore)
      console.log('No workout on this date');
    }
  };

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      {/* Header Stats Card */}
      <div className="p-4 pb-2">
        <div className="grid grid-cols-2 gap-3">
          <div className="rounded-xl bg-white p-3 shadow-sm border border-gray-100 dark:bg-gray-800 dark:border-gray-700">
            <div className="flex items-center gap-1.5 text-orange-500 mb-1">
              <Flame size={16} />
              <span className="text-xs font-medium">Current Streak</span>
            </div>
            <div className="text-xl font-bold text-gray-900 dark:text-white">{stats.currentStreak} days</div>
          </div>
          <div className="rounded-xl bg-white p-3 shadow-sm border border-gray-100 dark:bg-gray-800 dark:border-gray-700">
            <div className="flex items-center gap-1.5 text-blue-500 mb-1">
              <Activity size={16} />
              <span className="text-xs font-medium">Longest Streak</span>
            </div>
            <div className="text-xl font-bold text-gray-900 dark:text-white">{stats.longestStreak} days</div>
          </div>
          <div className="rounded-xl bg-white p-3 shadow-sm border border-gray-100 dark:bg-gray-800 dark:border-gray-700">
            <div className="flex items-center gap-1.5 text-primary mb-1">
              <Calendar size={16} />
              <span className="text-xs font-medium">Total Workouts</span>
            </div>
            <div className="text-xl font-bold text-gray-900 dark:text-white">{stats.totalWorkouts}</div>
          </div>
          <div className="rounded-xl bg-white p-3 shadow-sm border border-gray-100 dark:bg-gray-800 dark:border-gray-700">
            <div className="flex items-center gap-1.5 text-green-500 mb-1">
              <Dumbbell size={16} />
              <span className="text-xs font-medium">Total Volume</span>
            </div>
            <div className="text-xl font-bold text-gray-900 dark:text-white">{(stats.totalVolume / 1000).toFixed(1)}k kg</div>
          </div>
        </div>
      </div>

      {/* Calendar Heatmap */}
      <div className="px-4 py-2 overflow-x-auto no-scrollbar">
        <div className="flex gap-6 pb-2" style={{ width: 'max-content' }}>
          {calendarMonths.map((month, mIdx) => (
            <div key={mIdx} className="flex flex-col gap-1">
              <span className="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">{month.label}</span>
              <div className="grid grid-cols-7 gap-1">
                {month.days.map((day, dIdx) => (
                  <button
                    key={dIdx}
                    onClick={() => scrollToWorkout(day)}
                    className={cn(
                      "w-4 h-4 rounded-sm transition-transform hover:scale-110",
                      getIntensityClass(day),
                      isToday(day) && "ring-2 ring-orange-500 ring-offset-1 dark:ring-offset-gray-900",
                      month.isCurrentMonth && day.getMonth() !== new Date().getMonth() && "opacity-20"
                    )}
                    title={`${format(day, 'MMM d, yyyy')}: ${volumePerDay[format(day, 'yyyy-MM-dd')] || 0}kg`}
                  />
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Workout List */}
      <div className="flex-1 overflow-y-auto px-4 pb-24" onScroll={handleScroll}>
        {groupedWorkouts.map(group => (
          <div key={group.label} className="mb-6">
            <h3 className="sticky top-0 z-10 bg-surface/90 py-2 text-sm font-bold text-gray-500 backdrop-blur-sm dark:bg-surface-dark/90 dark:text-gray-400">
              {group.label}
            </h3>
            <div className="space-y-3">
              {group.workouts.map(workout => {
                const wSets = sets?.filter(s => s.workoutId === workout.id && s.completed) || [];
                const vol = wSets.reduce((acc, set) => acc + (set.weight * set.reps), 0);
                
                // Get top 3 exercises
                const exIds = Array.from(new Set(wSets.map(s => s.exerciseId)));
                const topExercises = exIds.slice(0, 3).map(id => exercises?.find(e => e.id === id)?.name).filter(Boolean);
                
                // Get unique muscle groups
                const muscleGroups = Array.from(new Set(exIds.map(id => exercises?.find(e => e.id === id)?.primaryMuscle).filter(Boolean)));
                const muscleColors: Record<string, string> = {
                  'Chest': 'bg-blue-500',
                  'Back': 'bg-purple-500',
                  'Legs': 'bg-green-500',
                  'Shoulders': 'bg-orange-500',
                  'Arms': 'bg-pink-500',
                  'Core': 'bg-yellow-500',
                  'Cardio': 'bg-red-500',
                };

                return (
                  <div key={workout.id} id={`workout-${format(new Date(workout.date), 'yyyy-MM-dd')}`} className="group relative overflow-hidden rounded-xl bg-white shadow-sm border border-gray-100 dark:bg-gray-800 dark:border-gray-700">
                    <div 
                      className="relative z-10 flex cursor-pointer flex-col p-4 transition-transform group-hover:-translate-x-16 bg-white dark:bg-gray-800"
                      onClick={() => navigate(`/app/history/${workout.id}`)}
                    >
                      <div className="flex items-center justify-between mb-2">
                        <h4 className="font-bold text-gray-900 dark:text-white">{workout.name}</h4>
                        <span className="text-xs font-medium text-gray-500 dark:text-gray-400">
                          {format(new Date(workout.date), 'MMM d, EEE')}
                        </span>
                      </div>
                      
                      <div className="flex items-center gap-4 text-xs text-gray-500 dark:text-gray-400 mb-3">
                        <div className="flex items-center gap-1">
                          <Clock size={14} />
                          <span>{formatDuration(workout.duration || 0)}</span>
                        </div>
                        <div className="flex items-center gap-1">
                          <Dumbbell size={14} />
                          <span>{vol} kg</span>
                        </div>
                        <div className="flex items-center gap-1 ml-auto">
                          {muscleGroups.map(m => (
                            <div 
                              key={m} 
                              className={cn("h-2 w-2 rounded-full", muscleColors[m as string] || 'bg-gray-400')} 
                              title={m as string}
                            />
                          ))}
                        </div>
                      </div>

                      <p className="text-sm text-gray-600 dark:text-gray-300 truncate">
                        {topExercises.join(', ')}
                        {exIds.length > 3 ? ` +${exIds.length - 3} more` : ''}
                      </p>
                    </div>

                    {/* Delete Action Background */}
                    <div className="absolute inset-y-0 right-0 z-0 flex w-16 items-center justify-center bg-red-500">
                      <button 
                        onClick={() => handleDelete(workout)}
                        className="flex h-full w-full items-center justify-center text-white"
                      >
                        <Trash2 size={20} />
                      </button>
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        ))}
        
        {(!workouts || workouts.length === 0) && (
          <div className="flex flex-col items-center justify-center py-12 text-center">
            <div className="mb-4 rounded-full bg-gray-100 p-4 dark:bg-gray-800">
              <Calendar size={32} className="text-gray-400" />
            </div>
            <h3 className="text-lg font-bold text-gray-900 dark:text-white">No workouts yet</h3>
            <p className="text-sm text-gray-500 dark:text-gray-400">Complete a workout to see it here.</p>
          </div>
        )}
      </div>

      {/* Undo Snackbar */}
      {showUndo && (
        <div className="fixed bottom-20 left-4 right-4 z-50 flex items-center justify-between rounded-lg bg-gray-900 px-4 py-3 text-white shadow-lg dark:bg-gray-100 dark:text-gray-900 animate-in slide-in-from-bottom-4">
          <span className="text-sm font-medium">Workout deleted</span>
          <button onClick={handleUndo} className="text-sm font-bold text-primary dark:text-primary-dark">
            UNDO
          </button>
        </div>
      )}
    </div>
  );
}
