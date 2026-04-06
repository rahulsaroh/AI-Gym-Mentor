import React, { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { ChevronLeft, Activity, Info, TrendingUp } from 'lucide-react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer } from 'recharts';
import { db } from '@/database/db';

export default function ExerciseDetailScreen() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [showPosterior, setShowPosterior] = useState(false);
  const [expandedInstructions, setExpandedInstructions] = useState(false);

  const exercise = useLiveQuery(() => db.exercises.get(Number(id)), [id]);

  // Mock data for last 5 sessions
  const mockChartData = [
    { date: 'Mar 1', weight: 60 },
    { date: 'Mar 5', weight: 65 },
    { date: 'Mar 10', weight: 65 },
    { date: 'Mar 15', weight: 70 },
    { date: 'Mar 20', weight: 75 },
  ];

  if (!exercise) return <div className="p-4">Loading...</div>;

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      <div className="sticky top-0 z-10 flex items-center bg-white p-4 shadow-sm dark:bg-gray-900">
        <button onClick={() => navigate(-1)} className="mr-4 text-gray-900 dark:text-white">
          <ChevronLeft size={24} />
        </button>
        <h1 className="text-xl font-bold text-gray-900 dark:text-white truncate">{exercise.name}</h1>
      </div>

      <div className="flex-1 overflow-y-auto p-4 pb-24">
        <div className="mb-6 flex gap-2">
          <span className="rounded-full bg-primary/10 px-3 py-1 text-sm font-medium text-primary dark:bg-primary/20">
            {exercise.primaryMuscle}
          </span>
          <span className="flex items-center rounded-full bg-gray-100 px-3 py-1 text-sm font-medium text-gray-700 dark:bg-gray-800 dark:text-gray-300">
            <Activity size={14} className="mr-1" />
            {exercise.equipment}
          </span>
        </div>

        {/* Body Diagram Placeholder */}
        <div className="mb-6 flex flex-col items-center rounded-2xl bg-white p-6 shadow-sm dark:bg-gray-800">
          <div className="relative h-48 w-48 rounded-lg border-2 border-dashed border-gray-200 bg-gray-50 flex items-center justify-center dark:border-gray-700 dark:bg-gray-900">
            <p className="text-center text-sm text-gray-500 dark:text-gray-400">
              [SVG Diagram Placeholder]<br/>
              Highlighting: <span className="text-accent font-bold">{exercise.primaryMuscle}</span><br/>
              View: {showPosterior ? 'Posterior' : 'Anterior'}
            </p>
          </div>
          <button 
            onClick={() => setShowPosterior(!showPosterior)}
            className="mt-4 text-sm font-medium text-primary"
          >
            Switch to {showPosterior ? 'Anterior' : 'Posterior'} View
          </button>
        </div>

        {/* Instructions */}
        <div className="mb-6 rounded-2xl bg-white p-4 shadow-sm dark:bg-gray-800">
          <h3 className="mb-2 flex items-center font-bold text-gray-900 dark:text-white">
            <Info size={18} className="mr-2 text-primary" />
            Instructions
          </h3>
          <p className={`text-sm text-gray-600 dark:text-gray-300 ${!expandedInstructions ? 'line-clamp-3' : ''}`}>
            {exercise.instructions || "No instructions provided for this exercise. Focus on maintaining proper form and controlled movements."}
          </p>
          <button 
            onClick={() => setExpandedInstructions(!expandedInstructions)}
            className="mt-2 text-sm font-medium text-primary"
          >
            {expandedInstructions ? 'Show less' : 'Show more'}
          </button>
        </div>

        {/* All-Time Best */}
        <div className="mb-6 rounded-2xl bg-white p-4 shadow-sm dark:bg-gray-800">
          <h3 className="mb-4 flex items-center font-bold text-gray-900 dark:text-white">
            <TrendingUp size={18} className="mr-2 text-accent" />
            All-Time Best
          </h3>
          <div className="grid grid-cols-3 gap-4 text-center">
            <div>
              <p className="text-xs text-gray-500 dark:text-gray-400">Est. 1RM</p>
              <p className="text-lg font-bold text-gray-900 dark:text-white">85 kg</p>
            </div>
            <div>
              <p className="text-xs text-gray-500 dark:text-gray-400">Best Weight</p>
              <p className="text-lg font-bold text-gray-900 dark:text-white">75 kg</p>
            </div>
            <div>
              <p className="text-xs text-gray-500 dark:text-gray-400">Total Sets</p>
              <p className="text-lg font-bold text-gray-900 dark:text-white">42</p>
            </div>
          </div>
        </div>

        {/* Chart */}
        <div className="mb-6 rounded-2xl bg-white p-4 shadow-sm dark:bg-gray-800">
          <h3 className="mb-4 font-bold text-gray-900 dark:text-white">Last 5 Sessions</h3>
          <div className="h-48 w-full">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={mockChartData}>
                <XAxis dataKey="date" tick={{fontSize: 12}} axisLine={false} tickLine={false} />
                <YAxis hide />
                <Tooltip cursor={{fill: 'transparent'}} />
                <Bar dataKey="weight" fill="#1565C0" radius={[4, 4, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>

      <div className="fixed bottom-0 left-0 right-0 border-t border-gray-200 bg-white p-4 pb-safe dark:border-gray-800 dark:bg-gray-900">
        <button className="w-full rounded-xl bg-primary py-4 text-lg font-semibold text-white shadow-lg transition-transform hover:scale-[1.02] active:scale-[0.98]">
          Start with this exercise
        </button>
      </div>
    </div>
  );
}
