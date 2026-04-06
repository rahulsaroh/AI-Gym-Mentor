import React, { useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { ChevronLeft, Check, AlertTriangle } from 'lucide-react';
import { db } from '@/database/db';

export default function ImportPreviewScreen() {
  const location = useLocation();
  const navigate = useNavigate();
  const importData = location.state?.importData;
  const [conflictAction, setConflictAction] = useState<'replace' | 'copy'>('copy');
  const [existingProgramId, setExistingProgramId] = useState<number | null>(null);
  const [loading, setLoading] = useState(false);

  React.useEffect(() => {
    if (!importData) {
      navigate('/app/programs');
      return;
    }

    const checkConflict = async () => {
      const existing = await db.workout_templates.where('name').equals(importData.program.name).first();
      if (existing) {
        setExistingProgramId(existing.id!);
      }
    };
    checkConflict();
  }, [importData, navigate]);

  if (!importData) return null;

  const handleImport = async () => {
    setLoading(true);
    try {
      let programId = existingProgramId;

      if (existingProgramId && conflictAction === 'replace') {
        // Delete existing program's days and exercises
        const days = await db.template_days.where('templateId').equals(existingProgramId).toArray();
        const dayIds = days.map(d => d.id!);
        await db.template_days.bulkDelete(dayIds);
        const exercises = await db.template_exercises.where('dayId').anyOf(dayIds).toArray();
        await db.template_exercises.bulkDelete(exercises.map(e => e.id!));
        
        // Update program
        await db.workout_templates.update(existingProgramId, {
          description: importData.program.description,
        });
      } else {
        // Create new program
        const name = existingProgramId && conflictAction === 'copy' 
          ? `${importData.program.name} (Copy)` 
          : importData.program.name;
          
        programId = await db.workout_templates.add({
          name,
          description: importData.program.description,
        });
      }

      // Import days and exercises
      const allExercises = await db.exercises.toArray();

      for (const day of importData.program.days) {
        const dayId = await db.template_days.add({
          templateId: programId!,
          name: day.name,
          order: day.order,
        });

        for (const ex of day.exercises) {
          // Find matching exercise by name, or create a custom one if not found
          let exerciseId = allExercises.find(e => e.name.toLowerCase() === ex.exercise_name.toLowerCase())?.id;
          
          if (!exerciseId) {
            exerciseId = await db.exercises.add({
              name: ex.exercise_name,
              primaryMuscle: 'Other',
              equipment: 'Other',
              setType: 'Straight',
              restTime: 90,
              isCustom: true,
            });
            allExercises.push({ 
              id: exerciseId, 
              name: ex.exercise_name, 
              primaryMuscle: 'Other', 
              equipment: 'Other', 
              setType: 'Straight',
              restTime: 90,
              isCustom: true 
            });
          }

          await db.template_exercises.add({
            dayId,
            exerciseId,
            order: ex.order,
            setType: ex.set_type || 'Straight',
            sets: ex.sets || [{ type: 'working', reps: 8, weight: 0 }],
            restTime: ex.rest_time || 90,
            notes: ex.notes,
          });
        }
      }

      alert('Program imported successfully!');
      navigate('/app/programs');
    } catch (error) {
      console.error('Import failed:', error);
      alert('Failed to import program.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      <div className="sticky top-0 z-10 flex items-center justify-between bg-white p-4 shadow-sm dark:bg-gray-900">
        <div className="flex items-center">
          <button onClick={() => navigate('/app/programs')} className="mr-4 text-gray-900 dark:text-white">
            <ChevronLeft size={24} />
          </button>
          <h1 className="text-xl font-bold text-gray-900 dark:text-white">Import Preview</h1>
        </div>
      </div>

      <div className="flex-1 overflow-y-auto p-4 space-y-6">
        <div className="rounded-2xl bg-white p-6 shadow-sm border border-gray-100 dark:border-gray-800 dark:bg-gray-800">
          <h2 className="mb-2 text-2xl font-bold text-gray-900 dark:text-white">{importData.program.name}</h2>
          <p className="mb-4 text-sm text-gray-500 dark:text-gray-400">{importData.program.description}</p>
          
          <div className="flex gap-4 text-sm font-medium text-gray-700 dark:text-gray-300">
            <div><span className="text-primary">{importData.program.days.length}</span> Days</div>
            <div>
              <span className="text-primary">
                {importData.program.days.reduce((acc: number, day: any) => acc + day.exercises.length, 0)}
              </span> Exercises
            </div>
          </div>
        </div>

        {existingProgramId && (
          <div className="rounded-2xl border border-amber-200 bg-amber-50 p-4 dark:border-amber-900/50 dark:bg-amber-900/20">
            <div className="mb-3 flex items-center text-amber-800 dark:text-amber-500">
              <AlertTriangle size={20} className="mr-2" />
              <h3 className="font-bold">Program Already Exists</h3>
            </div>
            <p className="mb-4 text-sm text-amber-700 dark:text-amber-400">
              A program named "{importData.program.name}" already exists in your library.
            </p>
            
            <div className="space-y-2">
              <label className="flex items-center rounded-lg border border-amber-200 bg-white p-3 cursor-pointer dark:border-amber-800 dark:bg-gray-800">
                <input 
                  type="radio" 
                  name="conflict" 
                  value="copy" 
                  checked={conflictAction === 'copy'} 
                  onChange={() => setConflictAction('copy')}
                  className="mr-3 h-4 w-4 text-primary focus:ring-primary"
                />
                <span className="text-sm font-medium text-gray-900 dark:text-white">Import as Copy</span>
              </label>
              <label className="flex items-center rounded-lg border border-amber-200 bg-white p-3 cursor-pointer dark:border-amber-800 dark:bg-gray-800">
                <input 
                  type="radio" 
                  name="conflict" 
                  value="replace" 
                  checked={conflictAction === 'replace'} 
                  onChange={() => setConflictAction('replace')}
                  className="mr-3 h-4 w-4 text-primary focus:ring-primary"
                />
                <span className="text-sm font-medium text-gray-900 dark:text-white">Replace Existing</span>
              </label>
            </div>
          </div>
        )}

        <div className="space-y-4">
          <h3 className="font-bold text-gray-900 dark:text-white">Program Structure</h3>
          {importData.program.days.map((day: any, i: number) => (
            <div key={i} className="rounded-xl border border-gray-100 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
              <h4 className="font-bold text-gray-900 dark:text-white">{day.name}</h4>
              <ul className="mt-2 space-y-1">
                {day.exercises.map((ex: any, j: number) => (
                  <li key={j} className="text-sm text-gray-600 dark:text-gray-400">
                    • {ex.exercise_name} ({ex.sets.length} sets)
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>
      </div>

      <div className="bg-white p-4 shadow-[0_-4px_6px_-1px_rgba(0,0,0,0.05)] dark:bg-gray-900">
        <button
          onClick={handleImport}
          disabled={loading}
          className="flex w-full items-center justify-center rounded-xl bg-primary py-4 font-bold text-white transition-transform hover:scale-[1.02] active:scale-[0.98] disabled:opacity-50"
        >
          <Check size={20} className="mr-2" />
          {loading ? 'Importing...' : 'Confirm Import'}
        </button>
      </div>
    </div>
  );
}
