import React, { useState, useMemo } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { db, WorkoutSet, Workout } from '@/database/db';
import { ChevronLeft, Trophy, Activity, Calendar } from 'lucide-react';
import { format, subMonths, isAfter, startOfWeek } from 'date-fns';
import { cn } from '@/core/utils/cn';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar } from 'recharts';

type FilterOption = '1M' | '3M' | '6M' | 'ALL';

export default function ExerciseHistoryScreen() {
  const { id } = useParams();
  const navigate = useNavigate();
  const exerciseId = Number(id);

  const [filter, setFilter] = useState<FilterOption>('6M');

  const exercise = useLiveQuery(() => db.exercises.get(exerciseId), [exerciseId]);
  const sets = useLiveQuery(() => db.workout_sets.where('exerciseId').equals(exerciseId).toArray(), [exerciseId]);
  const workouts = useLiveQuery(() => db.workouts.toArray());

  const data = useMemo(() => {
    if (!sets || !workouts || !exercise) return null;

    const completedSets = sets.filter(s => s.completed && s.type !== 'warmup');
    
    // Join with workouts to get dates
    const setsWithDates = completedSets.map(set => {
      const workout = workouts.find(w => w.id === set.workoutId);
      return {
        ...set,
        date: workout ? new Date(workout.date) : new Date(set.completedAt || ''),
        est1RM: set.weight * (1 + set.reps / 30)
      };
    }).filter(s => s.date.getTime() > 0);

    // Apply filter
    const now = new Date();
    let cutoffDate = new Date(0);
    if (filter === '1M') cutoffDate = subMonths(now, 1);
    if (filter === '3M') cutoffDate = subMonths(now, 3);
    if (filter === '6M') cutoffDate = subMonths(now, 6);

    const filteredSets = setsWithDates.filter(s => isAfter(s.date, cutoffDate));

    // Calculate All-Time Bests (from all sets, not just filtered)
    let maxWeight = 0;
    let maxReps = 0;
    let best1RM = 0;
    
    setsWithDates.forEach(s => {
      if (s.weight > maxWeight) maxWeight = s.weight;
      if (s.reps > maxReps) maxReps = s.reps;
      if (s.est1RM > best1RM) best1RM = s.est1RM;
    });

    // Group for Line Chart (Max 1RM per day)
    const daily1RM: Record<string, number> = {};
    filteredSets.forEach(s => {
      const dateStr = format(s.date, 'MMM d');
      if (!daily1RM[dateStr] || s.est1RM > daily1RM[dateStr]) {
        daily1RM[dateStr] = s.est1RM;
      }
    });
    const lineChartData = Object.entries(daily1RM)
      .map(([date, rm]) => ({ date, rm: Math.round(rm) }))
      .sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime()); // Rough sort

    // Group for Bar Chart (Volume per week)
    const weeklyVolume: Record<string, number> = {};
    filteredSets.forEach(s => {
      const weekStart = startOfWeek(s.date);
      const weekStr = format(weekStart, 'MMM d');
      weeklyVolume[weekStr] = (weeklyVolume[weekStr] || 0) + (s.weight * s.reps);
    });
    const barChartData = Object.entries(weeklyVolume)
      .map(([week, vol]) => ({ week, vol }))
      .sort((a, b) => new Date(a.week).getTime() - new Date(b.week).getTime());

    // History List (Group by workout)
    const historyList: { date: Date, topSet: string, est1RM: number }[] = [];
    const workoutGroups: Record<number, typeof setsWithDates> = {};
    
    filteredSets.forEach(s => {
      if (!workoutGroups[s.workoutId]) workoutGroups[s.workoutId] = [];
      workoutGroups[s.workoutId].push(s);
    });

    Object.values(workoutGroups).forEach(wSets => {
      if (wSets.length === 0) return;
      // Find top set by 1RM
      const topSet = wSets.reduce((prev, current) => (prev.est1RM > current.est1RM) ? prev : current);
      historyList.push({
        date: topSet.date,
        topSet: `${topSet.weight}kg x ${topSet.reps} reps`,
        est1RM: Math.round(topSet.est1RM)
      });
    });

    historyList.sort((a, b) => b.date.getTime() - a.date.getTime());

    return {
      maxWeight,
      maxReps,
      best1RM: Math.round(best1RM),
      totalSets: setsWithDates.length,
      lineChartData,
      barChartData,
      historyList
    };
  }, [sets, workouts, exercise, filter]);

  if (!exercise || !data) {
    return <div className="p-4 text-center">Loading...</div>;
  }

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      {/* AppBar */}
      <div className="flex items-center gap-3 border-b border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
        <button onClick={() => navigate(-1)} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
          <ChevronLeft size={24} />
        </button>
        <div>
          <h1 className="text-lg font-bold text-gray-900 dark:text-white">{exercise.name}</h1>
          <span className="rounded-full bg-primary/10 px-2 py-0.5 text-[10px] font-medium text-primary">
            {exercise.primaryMuscle}
          </span>
        </div>
      </div>

      <div className="flex-1 overflow-y-auto p-4 space-y-6">
        {/* All-Time Best Card */}
        <div className="rounded-xl bg-gradient-to-br from-gray-900 to-gray-800 p-4 text-white shadow-lg dark:from-gray-800 dark:to-gray-900">
          <div className="flex items-center gap-2 mb-4 text-amber-400">
            <Trophy size={20} />
            <h2 className="font-bold">All-Time Bests</h2>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <p className="text-xs text-gray-400">Max Weight</p>
              <p className="text-2xl font-bold">{data.maxWeight} <span className="text-sm font-normal text-gray-400">kg</span></p>
            </div>
            <div>
              <p className="text-xs text-gray-400">Best Est. 1RM</p>
              <p className="text-2xl font-bold">{data.best1RM} <span className="text-sm font-normal text-gray-400">kg</span></p>
            </div>
            <div>
              <p className="text-xs text-gray-400">Max Reps</p>
              <p className="text-xl font-bold">{data.maxReps}</p>
            </div>
            <div>
              <p className="text-xs text-gray-400">Total Sets Logged</p>
              <p className="text-xl font-bold">{data.totalSets}</p>
            </div>
          </div>
        </div>

        {/* Filter */}
        <div className="flex rounded-lg bg-gray-100 p-1 dark:bg-gray-800">
          {(['1M', '3M', '6M', 'ALL'] as FilterOption[]).map(opt => (
            <button
              key={opt}
              onClick={() => setFilter(opt)}
              className={cn(
                "flex-1 rounded-md py-1.5 text-sm font-medium transition-colors",
                filter === opt 
                  ? "bg-white text-gray-900 shadow-sm dark:bg-gray-700 dark:text-white" 
                  : "text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200"
              )}
            >
              {opt}
            </button>
          ))}
        </div>

        {/* 1RM Line Chart */}
        {data.lineChartData.length > 0 && (
          <div className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <h3 className="mb-4 flex items-center gap-2 text-sm font-bold text-gray-900 dark:text-white">
              <Activity size={16} className="text-primary" /> Estimated 1RM Over Time
            </h3>
            <div className="h-48 w-full">
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={data.lineChartData}>
                  <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e5e7eb" />
                  <XAxis dataKey="date" axisLine={false} tickLine={false} tick={{ fontSize: 10, fill: '#6b7280' }} />
                  <YAxis domain={['auto', 'auto']} axisLine={false} tickLine={false} tick={{ fontSize: 10, fill: '#6b7280' }} width={30} />
                  <Tooltip 
                    contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)' }}
                    labelStyle={{ color: '#374151', fontWeight: 'bold', marginBottom: '4px' }}
                  />
                  <Line type="monotone" dataKey="rm" stroke="#1565C0" strokeWidth={3} dot={{ r: 4, fill: '#1565C0', strokeWidth: 2, stroke: '#fff' }} activeDot={{ r: 6 }} />
                </LineChart>
              </ResponsiveContainer>
            </div>
          </div>
        )}

        {/* Volume Bar Chart */}
        {data.barChartData.length > 0 && (
          <div className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <h3 className="mb-4 flex items-center gap-2 text-sm font-bold text-gray-900 dark:text-white">
              <Activity size={16} className="text-green-500" /> Weekly Volume
            </h3>
            <div className="h-48 w-full">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={data.barChartData}>
                  <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e5e7eb" />
                  <XAxis dataKey="week" axisLine={false} tickLine={false} tick={{ fontSize: 10, fill: '#6b7280' }} />
                  <YAxis axisLine={false} tickLine={false} tick={{ fontSize: 10, fill: '#6b7280' }} width={40} />
                  <Tooltip 
                    contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)' }}
                    cursor={{ fill: '#f3f4f6' }}
                  />
                  <Bar dataKey="vol" fill="#10b981" radius={[4, 4, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>
        )}

        {/* History List */}
        <div>
          <h3 className="mb-3 text-sm font-bold text-gray-900 dark:text-white">Session History</h3>
          <div className="space-y-2">
            {data.historyList.map((session, idx) => (
              <div key={idx} className="flex items-center justify-between rounded-lg border border-gray-100 bg-white p-3 shadow-sm dark:border-gray-800 dark:bg-gray-800">
                <div className="flex items-center gap-3">
                  <div className="rounded-full bg-gray-100 p-2 dark:bg-gray-700">
                    <Calendar size={16} className="text-gray-500 dark:text-gray-400" />
                  </div>
                  <div>
                    <p className="text-sm font-bold text-gray-900 dark:text-white">{format(session.date, 'MMM d, yyyy')}</p>
                    <p className="text-xs text-gray-500 dark:text-gray-400">Top set: {session.topSet}</p>
                  </div>
                </div>
                <div className="text-right">
                  <p className="text-xs text-gray-500 dark:text-gray-400">Est. 1RM</p>
                  <p className="text-sm font-bold text-primary">{session.est1RM} kg</p>
                </div>
              </div>
            ))}
            {data.historyList.length === 0 && (
              <p className="text-center text-sm text-gray-500 dark:text-gray-400 py-4">No history found for this period.</p>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
