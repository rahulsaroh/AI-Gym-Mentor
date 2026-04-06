import React, { useMemo, useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { db, Workout, WorkoutSet, Exercise } from '@/database/db';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar, Cell, RadarChart, PolarGrid, PolarAngleAxis, PolarRadiusAxis, Radar, Legend } from 'recharts';
import { format, subWeeks, startOfWeek, isAfter, subMonths, startOfMonth, endOfMonth, differenceInDays } from 'date-fns';
import { Activity, AlertTriangle, ChevronRight, Dumbbell, Flame, Clock, Trophy, X } from 'lucide-react';
import { cn } from '@/core/utils/cn';

function formatDuration(seconds: number) {
  const m = Math.floor(seconds / 60);
  return `${m}m`;
}

export default function AnalyticsScreen() {
  const navigate = useNavigate();

  const workouts = useLiveQuery(() => db.workouts.where('status').equals('completed').toArray());
  const sets = useLiveQuery(() => db.workout_sets.toArray());
  const exercises = useLiveQuery(() => db.exercises.toArray());

  const [dismissedAlerts, setDismissedAlerts] = useState<Record<number, number>>({});

  useEffect(() => {
    const stored = localStorage.getItem('gymlog_dismissed_alerts');
    if (stored) {
      setDismissedAlerts(JSON.parse(stored));
    }
  }, []);

  const dismissAlert = (exerciseId: number) => {
    const newDismissed = { ...dismissedAlerts, [exerciseId]: Date.now() };
    setDismissedAlerts(newDismissed);
    localStorage.setItem('gymlog_dismissed_alerts', JSON.stringify(newDismissed));
  };

  const data = useMemo(() => {
    if (!workouts || !sets || !exercises) return null;

    const now = new Date();
    const thisMonthStart = startOfMonth(now);
    const lastMonthStart = startOfMonth(subMonths(now, 1));
    const lastMonthEnd = endOfMonth(subMonths(now, 1));

    // Overview Stats
    let thisMonthVolume = 0;
    let workoutsThisMonth = 0;
    let totalDurationThisMonth = 0;

    const completedSets = sets.filter(s => s.completed && s.type !== 'warmup');
    
    // Map sets to their workouts for dates
    const setsWithDates = completedSets.map(set => {
      const workout = workouts.find(w => w.id === set.workoutId);
      return {
        ...set,
        date: workout ? new Date(workout.date) : new Date(0),
        est1RM: set.weight * (1 + set.reps / 30)
      };
    }).filter(s => s.date.getTime() > 0);

    workouts.forEach(w => {
      const wDate = new Date(w.date);
      if (isAfter(wDate, thisMonthStart)) {
        workoutsThisMonth++;
        totalDurationThisMonth += (w.duration || 0);
      }
    });

    setsWithDates.forEach(s => {
      if (isAfter(s.date, thisMonthStart)) {
        thisMonthVolume += (s.weight * s.reps);
      }
    });

    const avgSessionDuration = workoutsThisMonth > 0 ? totalDurationThisMonth / workoutsThisMonth : 0;

    // Active Streak (rough calculation)
    let activeStreak = 0;
    const sortedWorkouts = [...workouts].sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());
    if (sortedWorkouts.length > 0) {
      let lastDate = new Date(sortedWorkouts[0].date);
      if (differenceInDays(now, lastDate) <= 7) {
        activeStreak = 1;
        for (let i = 1; i < sortedWorkouts.length; i++) {
          const wDate = new Date(sortedWorkouts[i].date);
          const diff = differenceInDays(lastDate, wDate);
          if (diff > 0 && diff <= 7) {
            activeStreak++;
            lastDate = wDate;
          } else if (diff > 7) {
            break;
          }
        }
      }
    }

    // Weekly Volume Trend & Frequency (Last 12 weeks)
    const weeklyData: { week: string, vol: number, count: number, date: Date }[] = [];
    for (let i = 11; i >= 0; i--) {
      const weekStart = startOfWeek(subWeeks(now, i));
      weeklyData.push({
        week: format(weekStart, 'MMM d'),
        vol: 0,
        count: 0,
        date: weekStart
      });
    }

    setsWithDates.forEach(s => {
      const weekStart = startOfWeek(s.date);
      const weekData = weeklyData.find(w => w.date.getTime() === weekStart.getTime());
      if (weekData) {
        weekData.vol += (s.weight * s.reps);
      }
    });

    workouts.forEach(w => {
      const weekStart = startOfWeek(new Date(w.date));
      const weekData = weeklyData.find(wd => wd.date.getTime() === weekStart.getTime());
      if (weekData) {
        weekData.count++;
      }
    });

    // Muscle Group Balance (Radar Chart)
    const radarAxes = ['Chest', 'Back', 'Shoulders', 'Biceps', 'Triceps', 'Legs', 'Core', 'Cardio'];
    const radarData = radarAxes.map(axis => ({
      subject: axis,
      thisMonth: 0,
      lastMonth: 0,
      fullMax: 100 // Placeholder max
    }));

    setsWithDates.forEach(s => {
      const ex = exercises.find(e => e.id === s.exerciseId);
      if (ex) {
        let axis = ex.primaryMuscle;
        if (axis === 'Glutes') axis = 'Legs';
        
        const radarItem = radarData.find(r => r.subject === axis);
        if (radarItem) {
          if (isAfter(s.date, thisMonthStart)) {
            radarItem.thisMonth += (s.weight * s.reps);
          } else if (isAfter(s.date, lastMonthStart) && !isAfter(s.date, lastMonthEnd)) {
            radarItem.lastMonth += (s.weight * s.reps);
          }
        }
      }
    });

    // Normalize radar data for better visualization
    let maxRadarVol = 1;
    radarData.forEach(r => {
      if (r.thisMonth > maxRadarVol) maxRadarVol = r.thisMonth;
      if (r.lastMonth > maxRadarVol) maxRadarVol = r.lastMonth;
    });
    radarData.forEach(r => {
      r.fullMax = maxRadarVol;
    });

    // Plateau Detection
    const alerts: { exerciseId: number, exerciseName: string, suggestion: string, history: number[] }[] = [];
    const oneWeekAgo = Date.now() - 7 * 24 * 60 * 60 * 1000;

    exercises.forEach(ex => {
      if (dismissedAlerts[ex.id!] && dismissedAlerts[ex.id!] > oneWeekAgo) return;

      const exSets = setsWithDates.filter(s => s.exerciseId === ex.id);
      
      // Group by workout to get session 1RMs
      const session1RMs: Record<number, number> = {};
      exSets.forEach(s => {
        if (!session1RMs[s.workoutId] || s.est1RM > session1RMs[s.workoutId]) {
          session1RMs[s.workoutId] = s.est1RM;
        }
      });

      const sessionRMsArray = Object.entries(session1RMs)
        .map(([wId, rm]) => {
          const w = workouts.find(w => w.id === Number(wId));
          return { date: w ? new Date(w.date) : new Date(0), rm };
        })
        .sort((a, b) => a.date.getTime() - b.date.getTime())
        .map(x => x.rm);

      if (sessionRMsArray.length >= 5) {
        const last5 = sessionRMsArray.slice(-5);
        const max = Math.max(...last5);
        const min = Math.min(...last5);
        
        if (max - min < 2.5) {
          alerts.push({
            exerciseId: ex.id!,
            exerciseName: ex.name,
            history: last5.map(v => Math.round(v)),
            suggestion: 'Try adding 1 rep or reducing weight by 10% to reset progression.'
          });
        }
      }
    });

    // Recent PRs (Last 30 days)
    const recentPRs: { exerciseName: string, weight: number, reps: number, date: Date }[] = [];
    const thirtyDaysAgo = subMonths(now, 1);
    
    // Calculate all-time bests up to each point
    const bests: Record<number, number> = {};
    const sortedSets = [...setsWithDates].sort((a, b) => a.date.getTime() - b.date.getTime());
    
    sortedSets.forEach(s => {
      if (!bests[s.exerciseId] || s.est1RM > bests[s.exerciseId]) {
        if (bests[s.exerciseId] && isAfter(s.date, thirtyDaysAgo)) {
          const ex = exercises.find(e => e.id === s.exerciseId);
          if (ex) {
            // Check if we already added a PR for this exercise recently, if so, update it if better
            const existing = recentPRs.find(pr => pr.exerciseName === ex.name);
            if (!existing) {
              recentPRs.push({ exerciseName: ex.name, weight: s.weight, reps: s.reps, date: s.date });
            } else if (s.date > existing.date) {
              existing.weight = s.weight;
              existing.reps = s.reps;
              existing.date = s.date;
            }
          }
        }
        bests[s.exerciseId] = s.est1RM;
      }
    });

    recentPRs.sort((a, b) => b.date.getTime() - a.date.getTime());

    return {
      thisMonthVolume,
      workoutsThisMonth,
      avgSessionDuration,
      activeStreak,
      weeklyData,
      radarData,
      alerts,
      recentPRs
    };
  }, [workouts, sets, exercises, dismissedAlerts]);

  if (!data) {
    return (
      <div className="flex h-full flex-col bg-surface p-4 dark:bg-surface-dark">
        <div className="animate-pulse space-y-4">
          <div className="h-24 rounded-xl bg-gray-200 dark:bg-gray-800" />
          <div className="h-64 rounded-xl bg-gray-200 dark:bg-gray-800" />
          <div className="h-64 rounded-xl bg-gray-200 dark:bg-gray-800" />
        </div>
      </div>
    );
  }

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      {/* AppBar */}
      <div className="flex items-center justify-between border-b border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
        <h1 className="text-xl font-bold text-gray-900 dark:text-white">Analytics</h1>
        <button 
          onClick={() => navigate('/app/analytics/measurements')}
          className="text-sm font-bold text-primary hover:text-primary/80"
        >
          Measurements
        </button>
      </div>

      <div className="flex-1 overflow-y-auto pb-24">
        {/* Overview Cards Row */}
        <div className="flex gap-4 overflow-x-auto p-4 no-scrollbar">
          <div className="min-w-[140px] flex-shrink-0 rounded-xl border border-gray-100 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <div className="mb-2 flex items-center gap-2 text-gray-500 dark:text-gray-400">
              <Dumbbell size={16} />
              <span className="text-xs font-medium">Volume (Month)</span>
            </div>
            <p className="text-xl font-bold text-gray-900 dark:text-white">{data.thisMonthVolume.toLocaleString()} <span className="text-sm font-normal text-gray-500">kg</span></p>
          </div>
          <div className="min-w-[140px] flex-shrink-0 rounded-xl border border-gray-100 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <div className="mb-2 flex items-center gap-2 text-gray-500 dark:text-gray-400">
              <Activity size={16} />
              <span className="text-xs font-medium">Workouts (Month)</span>
            </div>
            <p className="text-xl font-bold text-gray-900 dark:text-white">{data.workoutsThisMonth}</p>
          </div>
          <div className="min-w-[140px] flex-shrink-0 rounded-xl border border-gray-100 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <div className="mb-2 flex items-center gap-2 text-gray-500 dark:text-gray-400">
              <Clock size={16} />
              <span className="text-xs font-medium">Avg Duration</span>
            </div>
            <p className="text-xl font-bold text-gray-900 dark:text-white">{formatDuration(data.avgSessionDuration)}</p>
          </div>
          <div className="min-w-[140px] flex-shrink-0 rounded-xl border border-gray-100 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <div className="mb-2 flex items-center gap-2 text-orange-500">
              <Flame size={16} />
              <span className="text-xs font-medium">Active Streak</span>
            </div>
            <p className="text-xl font-bold text-gray-900 dark:text-white">{data.activeStreak} <span className="text-sm font-normal text-gray-500">weeks</span></p>
          </div>
        </div>

        <div className="space-y-6 px-4">
          {/* Progression Alerts */}
          {data.alerts.length > 0 && (
            <div className="space-y-3">
              <h3 className="text-sm font-bold text-gray-900 dark:text-white">Progression Alerts</h3>
              {data.alerts.map(alert => (
                <div key={alert.exerciseId} className="relative rounded-xl border border-yellow-200 bg-yellow-50 p-4 dark:border-yellow-900/30 dark:bg-yellow-900/20">
                  <button 
                    onClick={() => dismissAlert(alert.exerciseId)}
                    className="absolute right-2 top-2 p-1 text-yellow-600 hover:text-yellow-800 dark:text-yellow-500 dark:hover:text-yellow-300"
                  >
                    <X size={16} />
                  </button>
                  <div className="flex items-start gap-3">
                    <AlertTriangle size={20} className="mt-0.5 text-yellow-600 dark:text-yellow-500" />
                    <div>
                      <h4 className="font-bold text-yellow-800 dark:text-yellow-500">{alert.exerciseName} Plateau</h4>
                      <p className="mt-1 text-xs text-yellow-700 dark:text-yellow-400">
                        Last 5 sessions (1RM): {alert.history.join(', ')} kg
                      </p>
                      <p className="mt-2 text-sm font-medium text-yellow-800 dark:text-yellow-500">
                        Suggestion: {alert.suggestion}
                      </p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}

          {/* Recent PRs */}
          {data.recentPRs.length > 0 && (
            <div>
              <div className="mb-3 flex items-center justify-between">
                <h3 className="text-sm font-bold text-gray-900 dark:text-white">Recent PRs (30 Days)</h3>
                <button 
                  onClick={() => navigate('/app/analytics/prs')}
                  className="text-xs font-bold text-primary hover:text-primary/80"
                >
                  View All
                </button>
              </div>
              <div className="flex gap-3 overflow-x-auto no-scrollbar pb-2">
                {data.recentPRs.map((pr, idx) => (
                  <div key={idx} className="min-w-[160px] flex-shrink-0 rounded-xl bg-gradient-to-br from-amber-400 to-amber-600 p-3 text-white shadow-sm">
                    <div className="mb-2 flex items-center gap-2">
                      <Trophy size={16} />
                      <span className="text-xs font-medium opacity-90">{format(pr.date, 'MMM d')}</span>
                    </div>
                    <p className="font-bold truncate">{pr.exerciseName}</p>
                    <p className="text-lg font-black">{pr.weight}kg <span className="text-sm font-medium opacity-90">x {pr.reps}</span></p>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Weekly Volume Trend */}
          <div className="rounded-xl border border-gray-100 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <h3 className="mb-4 text-sm font-bold text-gray-900 dark:text-white">Weekly Volume Trend</h3>
            <div className="h-64 w-full">
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={data.weeklyData} margin={{ top: 5, right: 5, left: -20, bottom: 0 }}>
                  <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e5e7eb" />
                  <XAxis dataKey="week" axisLine={false} tickLine={false} tick={{ fontSize: 10, fill: '#6b7280' }} />
                  <YAxis axisLine={false} tickLine={false} tick={{ fontSize: 10, fill: '#6b7280' }} tickFormatter={(val) => `${val / 1000}k`} />
                  <Tooltip 
                    contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)' }}
                    formatter={(value: number) => [`${value.toLocaleString()} kg`, 'Volume']}
                    labelStyle={{ color: '#374151', fontWeight: 'bold', marginBottom: '4px' }}
                  />
                  <Line type="monotone" dataKey="vol" stroke="#1565C0" strokeWidth={3} dot={{ r: 4, fill: '#1565C0', strokeWidth: 2, stroke: '#fff' }} activeDot={{ r: 6 }} />
                </LineChart>
              </ResponsiveContainer>
            </div>
          </div>

          {/* Workout Frequency */}
          <div className="rounded-xl border border-gray-100 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <h3 className="mb-4 text-sm font-bold text-gray-900 dark:text-white">Workout Frequency</h3>
            <div className="h-48 w-full">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={data.weeklyData} margin={{ top: 5, right: 5, left: -20, bottom: 0 }}>
                  <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e5e7eb" />
                  <XAxis dataKey="week" axisLine={false} tickLine={false} tick={{ fontSize: 10, fill: '#6b7280' }} />
                  <YAxis axisLine={false} tickLine={false} tick={{ fontSize: 10, fill: '#6b7280' }} allowDecimals={false} />
                  <Tooltip 
                    contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)' }}
                    cursor={{ fill: '#f3f4f6' }}
                  />
                  <Bar dataKey="count" radius={[4, 4, 0, 0]}>
                    {data.weeklyData.map((entry, index) => (
                      <Cell key={`cell-${index}`} fill={entry.count >= 3 ? '#10b981' : '#f59e0b'} />
                    ))}
                  </Bar>
                </BarChart>
              </ResponsiveContainer>
            </div>
            <p className="mt-2 text-center text-xs text-gray-500 dark:text-gray-400">
              Target: 3 workouts/week
            </p>
          </div>

          {/* Muscle Group Balance */}
          <div className="rounded-xl border border-gray-100 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <h3 className="mb-4 text-sm font-bold text-gray-900 dark:text-white">Muscle Group Balance</h3>
            <div className="h-64 w-full">
              <ResponsiveContainer width="100%" height="100%">
                <RadarChart cx="50%" cy="50%" outerRadius="70%" data={data.radarData}>
                  <PolarGrid stroke="#e5e7eb" />
                  <PolarAngleAxis dataKey="subject" tick={{ fill: '#6b7280', fontSize: 10 }} />
                  <PolarRadiusAxis angle={30} domain={[0, 'auto']} tick={false} axisLine={false} />
                  <Radar name="This Month" dataKey="thisMonth" stroke="#1565C0" fill="#1565C0" fillOpacity={0.5} />
                  <Radar name="Last Month" dataKey="lastMonth" stroke="#9ca3af" fill="#9ca3af" fillOpacity={0.3} />
                  <Legend wrapperStyle={{ fontSize: '12px' }} />
                  <Tooltip />
                </RadarChart>
              </ResponsiveContainer>
            </div>
          </div>

        </div>
      </div>
    </div>
  );
}
