import React from 'react';
import { useNavigate } from 'react-router-dom';
import { ChevronLeft, Dumbbell, Github, Globe, Twitter } from 'lucide-react';

export default function AboutScreen() {
  const navigate = useNavigate();

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      <div className="flex items-center gap-3 border-b border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
        <button onClick={() => navigate(-1)} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
          <ChevronLeft size={24} />
        </button>
        <h1 className="text-lg font-bold text-gray-900 dark:text-white">About GymLog Pro</h1>
      </div>

      <div className="flex-1 overflow-y-auto p-6">
        <div className="mb-8 flex flex-col items-center text-center">
          <div className="mb-4 flex h-24 w-24 items-center justify-center rounded-3xl bg-primary text-white shadow-xl">
            <Dumbbell size={48} />
          </div>
          <h2 className="text-2xl font-black text-gray-900 dark:text-white">GymLog Pro</h2>
          <p className="text-sm font-medium text-gray-500 dark:text-gray-400">Version 1.0.0</p>
          <p className="text-xs text-gray-400 dark:text-gray-500">Build 2026.04.04</p>
        </div>

        <div className="mb-8 rounded-xl border border-gray-100 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-800">
          <h3 className="mb-3 text-sm font-bold text-gray-900 dark:text-white">What's New</h3>
          <ul className="space-y-2 text-sm text-gray-600 dark:text-gray-300">
            <li>✨ Complete redesign with Material 3 styling</li>
            <li>📊 Advanced Analytics Dashboard with PR tracking</li>
            <li>💪 New Plate Calculator feature</li>
            <li>🌙 Improved Dark Mode support</li>
            <li>⚡ Lightning fast offline-first architecture</li>
          </ul>
        </div>

        <div className="mb-8 rounded-xl border border-gray-100 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-800">
          <h3 className="mb-3 text-sm font-bold text-gray-900 dark:text-white">Open Source Licenses</h3>
          <p className="text-sm text-gray-600 dark:text-gray-300">
            GymLog Pro uses several open source libraries. 
            <br/><br/>
            - React<br/>
            - React Router<br/>
            - Dexie.js<br/>
            - Recharts<br/>
            - Tailwind CSS<br/>
            - Lucide Icons<br/>
            - date-fns
          </p>
        </div>

        <div className="flex justify-center gap-6 text-gray-400">
          <a href="#" className="hover:text-primary transition-colors"><Globe size={24} /></a>
          <a href="#" className="hover:text-primary transition-colors"><Twitter size={24} /></a>
          <a href="#" className="hover:text-primary transition-colors"><Github size={24} /></a>
        </div>
        
        <p className="mt-8 text-center text-xs text-gray-400">
          &copy; 2026 GymLog Pro. All rights reserved.
        </p>
      </div>
    </div>
  );
}
