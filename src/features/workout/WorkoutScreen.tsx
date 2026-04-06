import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { Play, FileText, Clock, X } from 'lucide-react';
import { db } from '@/database/db';

function ProgramPicker({ onClose, onSelect }: { onClose: () => void, onSelect: (programId: number, dayId: number) => void }) {
  const programs = useLiveQuery(async () => {
    const progs = await db.workout_templates.toArray();
    const days = await db.template_days.toArray();
    return progs.map(p => ({
      ...p,
      days: days.filter(d => d.templateId === p.id).sort((a, b) => a.order - b.order)
    }));
  });

  return (
    <div className="fixed inset-0 z-50 flex flex-col bg-white dark:bg-gray-900">
      <div className="flex items-center justify-between border-b border-gray-200 p-4 dark:border-gray-800">
        <h2 className="text-xl font-bold text-gray-900 dark:text-white">Select Template</h2>
        <button onClick={onClose} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
          <X size={24} />
        </button>
      </div>
      <div className="flex-1 overflow-y-auto p-4 space-y-4">
        {programs?.map(program => (
          <div key={program.id} className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <h3 className="font-bold text-gray-900 dark:text-white mb-2">{program.name}</h3>
            <div className="space-y-2">
              {program.days.map(day => (
                <button
                  key={day.id}
                  onClick={() => onSelect(program.id!, day.id!)}
                  className="w-full text-left rounded-lg bg-gray-50 p-3 hover:bg-gray-100 dark:bg-gray-700 dark:hover:bg-gray-600"
                >
                  <span className="font-medium text-gray-900 dark:text-white">{day.name}</span>
                </button>
              ))}
            </div>
          </div>
        ))}
        {programs?.length === 0 && (
          <p className="text-center text-gray-500 dark:text-gray-400 mt-8">No programs found. Create one in the Programs tab.</p>
        )}
      </div>
    </div>
  );
}

export default function WorkoutScreen() {
  const navigate = useNavigate();
  const [showPicker, setShowPicker] = useState(false);

  const activeDraft = useLiveQuery(() => 
    db.workouts.where('status').equals('draft').first()
  );

  const startQuickWorkout = async () => {
    // If there's a draft, we should probably warn them or just overwrite it?
    // Let's just navigate to active workout, it will create a new one if no draft is passed,
    // or we can create it here and pass the ID.
    const workoutId = await db.workouts.add({
      name: 'Quick Workout',
      date: new Date().toISOString(),
      startTime: new Date().toISOString(),
      status: 'draft',
    });
    navigate(`/app/workout/active?id=${workoutId}`);
  };

  const startFromTemplate = async (programId: number, dayId: number) => {
    const program = await db.workout_templates.get(programId);
    const day = await db.template_days.get(dayId);
    
    const workoutId = await db.workouts.add({
      name: `${program?.name} - ${day?.name}`,
      date: new Date().toISOString(),
      startTime: new Date().toISOString(),
      templateId: programId,
      status: 'draft',
    });
    
    navigate(`/app/workout/active?id=${workoutId}&dayId=${dayId}`);
  };

  const resumeDraft = () => {
    if (activeDraft) {
      navigate(`/app/workout/active?id=${activeDraft.id}`);
    }
  };

  return (
    <div className="flex h-full flex-col p-4 bg-surface dark:bg-surface-dark">
      <h2 className="mb-6 text-2xl font-bold text-gray-900 dark:text-white">Start Workout</h2>
      
      <div className="space-y-4">
        <button 
          onClick={startQuickWorkout}
          className="flex w-full items-center rounded-2xl bg-primary p-6 text-white shadow-lg transition-transform hover:scale-[1.02] active:scale-[0.98]"
        >
          <div className="mr-4 rounded-full bg-white/20 p-3">
            <Play size={24} className="fill-white" />
          </div>
          <div className="text-left">
            <h3 className="text-lg font-bold">Quick Start</h3>
            <p className="text-sm text-primary-light">Start an empty workout</p>
          </div>
        </button>

        <button 
          onClick={() => setShowPicker(true)}
          className="flex w-full items-center rounded-2xl bg-white p-6 text-gray-900 shadow-sm border border-gray-100 transition-transform hover:scale-[1.02] active:scale-[0.98] dark:bg-gray-800 dark:border-gray-700 dark:text-white"
        >
          <div className="mr-4 rounded-full bg-gray-100 p-3 dark:bg-gray-700">
            <FileText size={24} className="text-accent" />
          </div>
          <div className="text-left">
            <h3 className="text-lg font-bold">From Template</h3>
            <p className="text-sm text-gray-500 dark:text-gray-400">Choose a saved program</p>
          </div>
        </button>

        {activeDraft && (
          <button 
            onClick={resumeDraft}
            className="flex w-full items-center rounded-2xl bg-white p-6 text-gray-900 shadow-sm border border-gray-100 transition-transform hover:scale-[1.02] active:scale-[0.98] dark:bg-gray-800 dark:border-gray-700 dark:text-white"
          >
            <div className="mr-4 rounded-full bg-amber-100 p-3 dark:bg-amber-900/30">
              <Clock size={24} className="text-amber-600 dark:text-amber-500" />
            </div>
            <div className="text-left">
              <h3 className="text-lg font-bold">Resume Draft</h3>
              <p className="text-sm text-gray-500 dark:text-gray-400">
                {activeDraft.name} • {new Date(activeDraft.date).toLocaleDateString()}
              </p>
            </div>
          </button>
        )}
      </div>

      {showPicker && <ProgramPicker onClose={() => setShowPicker(false)} onSelect={startFromTemplate} />}
    </div>
  );
}
