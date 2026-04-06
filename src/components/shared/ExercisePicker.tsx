import React, { useState } from 'react';
import { useLiveQuery } from 'dexie-react-hooks';
import { X, Search } from 'lucide-react';
import { db } from '@/database/db';

export default function ExercisePicker({ onClose, onSelect }: { onClose: () => void, onSelect: (id: number) => void }) {
  const [search, setSearch] = useState('');
  const exercises = useLiveQuery(() => db.exercises.toArray());

  const filtered = exercises?.filter(e => 
    e.name.toLowerCase().includes(search.toLowerCase()) || 
    e.primaryMuscle.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="fixed inset-0 z-50 flex flex-col bg-white dark:bg-gray-900">
      <div className="flex items-center justify-between border-b border-gray-200 p-4 dark:border-gray-800">
        <h2 className="text-xl font-bold text-gray-900 dark:text-white">Select Exercise</h2>
        <button onClick={onClose} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
          <X size={24} />
        </button>
      </div>
      
      <div className="p-4">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" size={20} />
          <input
            type="text"
            placeholder="Search exercises..."
            value={search}
            onChange={e => setSearch(e.target.value)}
            className="w-full rounded-xl border border-gray-200 bg-gray-50 py-3 pl-10 pr-4 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
          />
        </div>
      </div>

      <div className="flex-1 overflow-y-auto p-4">
        <div className="space-y-2">
          {filtered?.map(ex => (
            <button
              key={ex.id}
              onClick={() => onSelect(ex.id!)}
              className="flex w-full items-center justify-between rounded-xl border border-gray-100 bg-white p-4 text-left shadow-sm hover:border-primary dark:border-gray-800 dark:bg-gray-800 dark:hover:border-primary"
            >
              <div>
                <h3 className="font-bold text-gray-900 dark:text-white">{ex.name}</h3>
                <p className="text-sm text-gray-500 dark:text-gray-400">{ex.primaryMuscle} • {ex.equipment}</p>
              </div>
            </button>
          ))}
          {filtered?.length === 0 && (
            <p className="text-center text-gray-500 dark:text-gray-400 mt-8">No exercises found.</p>
          )}
        </div>
      </div>
    </div>
  );
}
