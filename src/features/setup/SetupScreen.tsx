import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'motion/react';
import { cn } from '@/core/utils/cn';

type Unit = 'kg' | 'lbs';
type Experience = 'Beginner' | 'Intermediate' | 'Advanced';

export default function SetupScreen() {
  const navigate = useNavigate();
  const [name, setName] = useState('');
  const [unit, setUnit] = useState<Unit>('kg');
  const [experience, setExperience] = useState<Experience>('Beginner');

  const handleComplete = () => {
    if (!name.trim()) return;
    
    localStorage.setItem('userProfile', JSON.stringify({ name, unit, experience }));
    localStorage.setItem('hasCompletedSetup', 'true');
    navigate('/app');
  };

  return (
    <div className="flex h-screen w-full flex-col bg-surface px-6 pt-12 dark:bg-surface-dark">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="mx-auto w-full max-w-md flex-1"
      >
        <h1 className="mb-2 text-3xl font-bold text-gray-900 dark:text-white">Let's set you up</h1>
        <p className="mb-8 text-gray-600 dark:text-gray-400">Personalize your GymLog Pro experience.</p>

        <div className="space-y-6">
          <div>
            <label className="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
              What's your name?
            </label>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="e.g. Alex"
              className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/20 dark:border-gray-700 dark:bg-gray-800 dark:text-white"
            />
          </div>

          <div>
            <label className="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
              Preferred Unit
            </label>
            <div className="flex rounded-xl bg-gray-100 p-1 dark:bg-gray-800">
              {(['kg', 'lbs'] as Unit[]).map((u) => (
                <button
                  key={u}
                  onClick={() => setUnit(u)}
                  className={cn(
                    "flex-1 rounded-lg py-2 text-sm font-medium transition-colors",
                    unit === u 
                      ? "bg-white text-gray-900 shadow-sm dark:bg-gray-700 dark:text-white" 
                      : "text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200"
                  )}
                >
                  {u.toUpperCase()}
                </button>
              ))}
            </div>
          </div>

          <div>
            <label className="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
              Experience Level
            </label>
            <div className="space-y-2">
              {(['Beginner', 'Intermediate', 'Advanced'] as Experience[]).map((exp) => (
                <button
                  key={exp}
                  onClick={() => setExperience(exp)}
                  className={cn(
                    "w-full rounded-xl border p-4 text-left transition-colors",
                    experience === exp
                      ? "border-primary bg-primary/5 dark:bg-primary/10"
                      : "border-gray-200 bg-white hover:border-gray-300 dark:border-gray-700 dark:bg-gray-800 dark:hover:border-gray-600"
                  )}
                >
                  <div className="font-medium text-gray-900 dark:text-white">{exp}</div>
                </button>
              ))}
            </div>
          </div>
        </div>
      </motion.div>

      <div className="pb-12 pt-6">
        <button
          onClick={handleComplete}
          disabled={!name.trim()}
          className="w-full rounded-xl bg-primary py-4 text-lg font-semibold text-white shadow-lg transition-transform hover:scale-[1.02] active:scale-[0.98] disabled:opacity-50 disabled:hover:scale-100"
        >
          Complete Setup
        </button>
      </div>
    </div>
  );
}
