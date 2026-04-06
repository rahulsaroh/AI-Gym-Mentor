import React, { useState, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { Plus, MoreVertical, Calendar, Dumbbell, Upload, Download, Copy, Trash2, Edit2 } from 'lucide-react';
import { db } from '@/database/db';
import { cn } from '@/core/utils/cn';

export default function ProgramsScreen() {
  const navigate = useNavigate();
  const [menuOpenId, setMenuOpenId] = useState<number | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const programsWithStats = useLiveQuery(async () => {
    const programs = await db.workout_templates.toArray();
    const days = await db.template_days.toArray();
    const templateExercises = await db.template_exercises.toArray();
    const exercises = await db.exercises.toArray();

    return programs.map(p => {
      const pDays = days.filter(d => d.templateId === p.id);
      const dayIds = pDays.map(d => d.id);
      const pExercises = templateExercises.filter(te => dayIds.includes(te.dayId));
      
      const muscleCounts: Record<string, number> = {};
      pExercises.forEach(te => {
        const ex = exercises.find(e => e.id === te.exerciseId);
        if (ex) {
          muscleCounts[ex.primaryMuscle] = (muscleCounts[ex.primaryMuscle] || 0) + 1;
        }
      });
      const topMuscles = Object.entries(muscleCounts)
        .sort((a, b) => b[1] - a[1])
        .slice(0, 3)
        .map(e => e[0]);

      return {
        ...p,
        dayCount: pDays.length,
        exerciseCount: pExercises.length,
        topMuscles
      };
    });
  });

  const handleDuplicate = async (id: number) => {
    const program = await db.workout_templates.get(id);
    if (!program) return;

    const newProgramId = await db.workout_templates.add({
      name: `${program.name} (Copy)`,
      description: program.description,
    });

    const days = await db.template_days.where('templateId').equals(id).toArray();
    for (const day of days) {
      const newDayId = await db.template_days.add({
        templateId: newProgramId,
        name: day.name,
        order: day.order,
      });

      const exercises = await db.template_exercises.where('dayId').equals(day.id!).toArray();
      for (const ex of exercises) {
        await db.template_exercises.add({
          dayId: newDayId,
          exerciseId: ex.exerciseId,
          order: ex.order,
          setType: ex.setType,
          sets: ex.sets,
          restTime: ex.restTime,
          notes: ex.notes,
          supersetGroupId: ex.supersetGroupId,
        });
      }
    }

    setMenuOpenId(null);
  };

  const handleDelete = async (id: number) => {
    if (confirm('Delete this program?')) {
      await db.workout_templates.delete(id);
      const days = await db.template_days.where('templateId').equals(id).toArray();
      const dayIds = days.map(d => d.id!);
      await db.template_days.bulkDelete(dayIds);
      
      const exercises = await db.template_exercises.where('dayId').anyOf(dayIds).toArray();
      await db.template_exercises.bulkDelete(exercises.map(e => e.id!));
    }
    setMenuOpenId(null);
  };

  const handleExport = async (id: number) => {
    const program = await db.workout_templates.get(id);
    if (!program) return;
    
    const days = await db.template_days.where('templateId').equals(id).sortBy('order');
    const dayIds = days.map(d => d.id!);
    const exercises = await db.template_exercises.where('dayId').anyOf(dayIds).sortBy('order');
    const allExercises = await db.exercises.toArray();

    const exportData = {
      gymlog_version: '1.0',
      export_date: new Date().toISOString(),
      ai_prompt_hint: "This is a workout program exported from GymLog Pro. You can modify it and import it back.",
      program: {
        name: program.name,
        description: program.description,
        days: days.map(d => ({
          name: d.name,
          order: d.order,
          exercises: exercises.filter(e => e.dayId === d.id).map(e => {
            const ex = allExercises.find(ex => ex.id === e.exerciseId);
            return {
              exercise_name: ex?.name,
              order: e.order,
              set_type: e.setType,
              sets: e.sets,
              rest_time: e.restTime,
              notes: e.notes
            };
          })
        }))
      }
    };

    const blob = new Blob([JSON.stringify(exportData, null, 2)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `${program.name.replace(/\s+/g, '_')}_export.json`;
    a.click();
    URL.revokeObjectURL(url);
    setMenuOpenId(null);
  };

  const handleImportClick = () => {
    fileInputRef.current?.click();
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (event) => {
      try {
        const json = JSON.parse(event.target?.result as string);
        if (!json.gymlog_version || !json.program) {
          alert('Invalid GymLog Pro export file.');
          return;
        }
        navigate('/app/programs/import', { state: { importData: json } });
      } catch (error) {
        alert('Failed to parse JSON file.');
      }
    };
    reader.readAsText(file);
    
    // Reset input
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
  };

  if (!programsWithStats) return <div className="p-4">Loading...</div>;

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      <div className="sticky top-0 z-10 flex items-center justify-between bg-white px-4 pb-4 pt-6 shadow-sm dark:bg-gray-900">
        <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Programs</h1>
        <button 
          onClick={handleImportClick}
          className="rounded-full bg-gray-100 p-2 text-gray-600 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700"
          title="Import Program"
        >
          <Upload size={20} />
        </button>
        <input 
          type="file" 
          accept=".json" 
          ref={fileInputRef} 
          onChange={handleFileChange} 
          className="hidden" 
        />
      </div>

      <div className="flex-1 overflow-y-auto p-4">
        {programsWithStats.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12 text-center">
            <Calendar className="mb-4 text-gray-300 dark:text-gray-600" size={48} />
            <p className="mb-4 text-gray-500 dark:text-gray-400">No programs found.</p>
            <button 
              onClick={() => navigate('/app/programs/create')}
              className="rounded-lg bg-primary px-4 py-2 font-medium text-white shadow-md"
            >
              Create your first program
            </button>
          </div>
        ) : (
          <div className="grid grid-cols-2 gap-4">
            {programsWithStats.map(program => (
              <div 
                key={program.id}
                className="relative flex flex-col rounded-2xl bg-white p-4 shadow-sm border border-gray-100 dark:border-gray-800 dark:bg-gray-800"
              >
                <div className="mb-2 flex items-start justify-between">
                  <h3 className="font-bold text-gray-900 line-clamp-2 dark:text-white">{program.name}</h3>
                  <button 
                    onClick={() => setMenuOpenId(menuOpenId === program.id ? null : program.id!)}
                    className="ml-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-200"
                  >
                    <MoreVertical size={18} />
                  </button>
                </div>
                
                <p className="mb-4 text-xs text-gray-500 line-clamp-1 dark:text-gray-400">
                  {program.description || 'No description'}
                </p>

                <div className="mb-4 flex flex-wrap gap-2">
                  <span className="flex items-center rounded bg-gray-100 px-2 py-1 text-[10px] font-medium text-gray-600 dark:bg-gray-700 dark:text-gray-300">
                    <Calendar size={10} className="mr-1" /> {program.dayCount} Days
                  </span>
                  <span className="flex items-center rounded bg-gray-100 px-2 py-1 text-[10px] font-medium text-gray-600 dark:bg-gray-700 dark:text-gray-300">
                    <Dumbbell size={10} className="mr-1" /> {program.exerciseCount} Exs
                  </span>
                </div>

                <div className="mt-auto flex items-center justify-between">
                  <div className="flex -space-x-1">
                    {program.topMuscles.map((m, i) => (
                      <div 
                        key={m} 
                        className="h-4 w-4 rounded-full border border-white bg-primary dark:border-gray-800"
                        title={m}
                        style={{ opacity: 1 - i * 0.2 }}
                      />
                    ))}
                  </div>
                  <span className="text-[10px] text-gray-400">
                    {program.lastUsed ? new Date(program.lastUsed).toLocaleDateString() : 'Never used'}
                  </span>
                </div>

                {/* Context Menu */}
                {menuOpenId === program.id && (
                  <div className="absolute right-2 top-10 z-20 w-40 rounded-xl border border-gray-100 bg-white py-2 shadow-lg dark:border-gray-700 dark:bg-gray-800">
                    <button 
                      onClick={() => { setMenuOpenId(null); navigate(`/app/programs/${program.id}/edit`); }}
                      className="flex w-full items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 dark:text-gray-200 dark:hover:bg-gray-700"
                    >
                      <Edit2 size={14} className="mr-2" /> Edit
                    </button>
                    <button 
                      onClick={() => handleDuplicate(program.id!)}
                      className="flex w-full items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 dark:text-gray-200 dark:hover:bg-gray-700"
                    >
                      <Copy size={14} className="mr-2" /> Duplicate
                    </button>
                    <button 
                      onClick={() => handleExport(program.id!)}
                      className="flex w-full items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 dark:text-gray-200 dark:hover:bg-gray-700"
                    >
                      <Download size={14} className="mr-2" /> Export JSON
                    </button>
                    <button 
                      onClick={() => handleDelete(program.id!)}
                      className="flex w-full items-center px-4 py-2 text-sm text-red-600 hover:bg-red-50 dark:text-red-400 dark:hover:bg-red-900/20"
                    >
                      <Trash2 size={14} className="mr-2" /> Delete
                    </button>
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>

      {/* FAB */}
      <button
        onClick={() => navigate('/app/programs/create')}
        className="absolute bottom-24 right-6 flex h-14 w-14 items-center justify-center rounded-full bg-primary text-white shadow-lg transition-transform hover:scale-105 active:scale-95"
      >
        <Plus size={24} />
      </button>
    </div>
  );
}
