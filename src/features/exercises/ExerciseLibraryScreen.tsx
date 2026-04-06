import React, { useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { useDebounce } from 'use-debounce';
import { Search, Plus, Dumbbell, Activity, RotateCcw } from 'lucide-react';
import { db, MuscleGroup, EquipmentType, Exercise } from '@/database/db';
import { cn } from '@/core/utils/cn';

const MUSCLE_GROUPS: ('All Muscles' | MuscleGroup)[] = ['All Muscles', 'Chest', 'Back', 'Shoulders', 'Biceps', 'Triceps', 'Legs', 'Glutes', 'Core', 'Cardio', 'Full Body'];
const EQUIPMENT_TYPES: ('All Equipment' | EquipmentType)[] = ['All Equipment', 'Barbell', 'Dumbbell', 'Machine', 'Cable', 'Bodyweight', 'Kettlebell', 'Bands', 'Other'];

export default function ExerciseLibraryScreen() {
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState('');
  const [debouncedSearch] = useDebounce(searchQuery, 300);
  
  const [selectedMuscle, setSelectedMuscle] = useState<string>('All Muscles');
  const [selectedEquipment, setSelectedEquipment] = useState<string>('All Equipment');

  const exercises = useLiveQuery(() => db.exercises.toArray()) || [];

  const filteredExercises = useMemo(() => {
    return exercises.filter(ex => {
      const matchesSearch = ex.name.toLowerCase().includes(debouncedSearch.toLowerCase());
      const matchesMuscle = selectedMuscle === 'All Muscles' || ex.primaryMuscle === selectedMuscle;
      const matchesEquipment = selectedEquipment === 'All Equipment' || ex.equipment === selectedEquipment;
      return matchesSearch && matchesMuscle && matchesEquipment;
    }).sort((a, b) => a.name.localeCompare(b.name));
  }, [exercises, debouncedSearch, selectedMuscle, selectedEquipment]);

  const recentlyUsed = useMemo(() => {
    return [...exercises]
      .filter(ex => ex.lastUsed)
      .sort((a, b) => new Date(b.lastUsed!).getTime() - new Date(a.lastUsed!).getTime())
      .slice(0, 10);
  }, [exercises]);

  // Group by first letter
  const groupedExercises = useMemo(() => {
    const groups: Record<string, Exercise[]> = {};
    filteredExercises.forEach(ex => {
      const letter = ex.name.charAt(0).toUpperCase();
      if (!groups[letter]) groups[letter] = [];
      groups[letter].push(ex);
    });
    return groups;
  }, [filteredExercises]);

  const resetFilters = () => {
    setSearchQuery('');
    setSelectedMuscle('All Muscles');
    setSelectedEquipment('All Equipment');
  };

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      {/* SliverAppBar equivalent */}
      <div className="sticky top-0 z-10 bg-white px-4 pb-4 pt-6 shadow-sm dark:bg-gray-900">
        <h1 className="mb-4 text-2xl font-bold text-gray-900 dark:text-white">Exercises</h1>
        <div className="relative">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" size={20} />
          <input
            type="text"
            placeholder="Search exercises..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full rounded-xl border border-gray-200 bg-gray-50 py-2.5 pl-10 pr-4 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
          />
        </div>

        {/* Filters */}
        <div className="mt-4 flex gap-2 overflow-x-auto pb-2 scrollbar-hide">
          {MUSCLE_GROUPS.map(muscle => (
            <button
              key={muscle}
              onClick={() => setSelectedMuscle(muscle)}
              className={cn(
                "whitespace-nowrap rounded-full px-4 py-1.5 text-sm font-medium transition-colors",
                selectedMuscle === muscle
                  ? "bg-primary text-white"
                  : "bg-gray-100 text-gray-600 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700"
              )}
            >
              {muscle}
            </button>
          ))}
        </div>
        <div className="flex gap-2 overflow-x-auto pb-2 scrollbar-hide">
          {EQUIPMENT_TYPES.map(eq => (
            <button
              key={eq}
              onClick={() => setSelectedEquipment(eq)}
              className={cn(
                "whitespace-nowrap rounded-full px-4 py-1.5 text-sm font-medium transition-colors",
                selectedEquipment === eq
                  ? "bg-accent text-white"
                  : "bg-gray-100 text-gray-600 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700"
              )}
            >
              {eq}
            </button>
          ))}
        </div>
      </div>

      <div className="flex-1 overflow-y-auto p-4">
        {/* Recently Used */}
        {recentlyUsed.length > 0 && selectedMuscle === 'All Muscles' && selectedEquipment === 'All Equipment' && !debouncedSearch && (
          <div className="mb-6">
            <h2 className="mb-3 text-sm font-semibold text-gray-500 dark:text-gray-400">Recently Used</h2>
            <div className="flex gap-3 overflow-x-auto pb-2 scrollbar-hide">
              {recentlyUsed.map(ex => (
                <div 
                  key={ex.id} 
                  onClick={() => navigate(`/app/exercises/${ex.id}`)}
                  className="min-w-[140px] cursor-pointer rounded-xl border border-gray-100 bg-white p-3 shadow-sm dark:border-gray-800 dark:bg-gray-800"
                >
                  <p className="truncate font-semibold text-gray-900 dark:text-white">{ex.name}</p>
                  <p className="text-xs text-gray-500 dark:text-gray-400">{ex.primaryMuscle}</p>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Main List */}
        {filteredExercises.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12 text-center">
            <Dumbbell className="mb-4 text-gray-300 dark:text-gray-600" size={48} />
            <p className="mb-4 text-gray-500 dark:text-gray-400">No exercises found. Try a different filter.</p>
            <button 
              onClick={resetFilters}
              className="flex items-center rounded-lg bg-gray-100 px-4 py-2 text-sm font-medium text-gray-700 dark:bg-gray-800 dark:text-gray-300"
            >
              <RotateCcw size={16} className="mr-2" />
              Reset Filters
            </button>
          </div>
        ) : (
          Object.keys(groupedExercises).map((letter) => {
            const items = groupedExercises[letter];
            return (
            <div key={letter} className="mb-6">
              <h3 className="sticky top-0 mb-2 bg-surface py-1 text-lg font-bold text-gray-900 dark:bg-surface-dark dark:text-white">
                {letter}
              </h3>
              <div className="space-y-2">
                {items.map(ex => (
                  <div 
                    key={ex.id}
                    onClick={() => navigate(`/app/exercises/${ex.id}`)}
                    className="flex cursor-pointer items-center justify-between rounded-xl bg-white p-4 shadow-sm transition-active hover:bg-gray-50 active:scale-[0.98] dark:bg-gray-800 dark:hover:bg-gray-750"
                  >
                    <div>
                      <div className="flex items-center space-x-2">
                        <h4 className="font-bold text-gray-900 dark:text-white">{ex.name}</h4>
                        {ex.isCustom && (
                          <span className="rounded bg-accent/10 px-1.5 py-0.5 text-[10px] font-bold uppercase tracking-wider text-accent">
                            Custom
                          </span>
                        )}
                      </div>
                      <div className="mt-1 flex items-center space-x-2 text-xs text-gray-500 dark:text-gray-400">
                        <span className="rounded-full bg-primary/10 px-2 py-0.5 font-medium text-primary dark:bg-primary/20 dark:text-primary-light">
                          {ex.primaryMuscle}
                        </span>
                        <span className="flex items-center">
                          <Activity size={12} className="mr-1" />
                          {ex.equipment}
                        </span>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )})
        )}
      </div>

      {/* FAB */}
      <button
        onClick={() => navigate('/app/exercises/create')}
        className="absolute bottom-24 right-6 flex h-14 w-14 items-center justify-center rounded-full bg-primary text-white shadow-lg transition-transform hover:scale-105 active:scale-95"
      >
        <Plus size={24} />
      </button>
    </div>
  );
}
