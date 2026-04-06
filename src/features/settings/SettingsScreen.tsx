import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useSettings } from '@/core/settings/SettingsContext';
import { db } from '@/database/db';
import { ChevronRight, Download, Upload, Trash2, AlertTriangle, User, Palette, Timer, Dumbbell, Settings2, Cloud, Database } from 'lucide-react';
import { cn } from '@/core/utils/cn';

function SectionHeader({ icon: Icon, title }: { icon: any, title: string }) {
  return (
    <div className="mb-3 mt-6 flex items-center gap-2 px-4 text-sm font-bold text-primary">
      <Icon size={18} />
      <span>{title}</span>
    </div>
  );
}

export default function SettingsScreen() {
  const navigate = useNavigate();
  const { settings, updateSettings } = useSettings();
  const [deleteConfirm, setDeleteConfirm] = useState('');

  const handleExportJSON = async () => {
    const workouts = await db.workouts.toArray();
    const sets = await db.workout_sets.toArray();
    const data = { workouts, sets };
    const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `gymlog_backup_${new Date().toISOString().split('T')[0]}.json`;
    a.click();
  };

  const handleExportCSV = async () => {
    const workouts = await db.workouts.toArray();
    const sets = await db.workout_sets.toArray();
    const exercises = await db.exercises.toArray();

    let csv = 'Date,Workout Name,Exercise,Set#,Weight,Reps,RPE,Volume,Notes\n';
    
    sets.forEach(s => {
      const w = workouts.find(w => w.id === s.workoutId);
      const ex = exercises.find(e => e.id === s.exerciseId);
      if (w && ex) {
        csv += `"${w.date}","${w.name}","${ex.name}",${s.setNumber},${s.weight},${s.reps},${s.rpe || ''},${s.weight * s.reps},"${w.notes || ''}"\n`;
      }
    });

    const blob = new Blob([csv], { type: 'text/csv' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `gymlog_workouts_${new Date().toISOString().split('T')[0]}.csv`;
    a.click();
  };

  const handleClearHistory = async () => {
    if (deleteConfirm === 'DELETE') {
      await db.workouts.clear();
      await db.workout_sets.clear();
      setDeleteConfirm('');
      alert('Workout history cleared.');
    }
  };

  const handleFactoryReset = async () => {
    if (deleteConfirm === 'DELETE') {
      await db.delete();
      window.location.href = '/';
    }
  };

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      <div className="flex items-center justify-between border-b border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
        <h1 className="text-xl font-bold text-gray-900 dark:text-white">Settings</h1>
        <button onClick={() => navigate('/app/settings/about')} className="text-sm font-bold text-primary">About</button>
      </div>

      <div className="flex-1 overflow-y-auto pb-24">
        
        {/* Profile */}
        <SectionHeader icon={User} title="Profile" />
        <div className="mx-4 overflow-hidden rounded-xl border border-gray-100 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-800">
          <div className="border-b border-gray-100 p-4 dark:border-gray-700">
            <label className="mb-1 block text-xs font-medium text-gray-500 dark:text-gray-400">Name</label>
            <input 
              type="text" 
              value={settings.name}
              onChange={e => updateSettings({ name: e.target.value })}
              className="w-full bg-transparent text-gray-900 focus:outline-none dark:text-white"
            />
          </div>
          <div className="border-b border-gray-100 p-4 dark:border-gray-700">
            <label className="mb-1 block text-xs font-medium text-gray-500 dark:text-gray-400">Experience Level</label>
            <select 
              value={settings.experienceLevel}
              onChange={e => updateSettings({ experienceLevel: e.target.value as any })}
              className="w-full bg-transparent text-gray-900 focus:outline-none dark:text-white"
            >
              <option value="Beginner">Beginner</option>
              <option value="Intermediate">Intermediate</option>
              <option value="Advanced">Advanced</option>
            </select>
          </div>
          <div className="p-4">
            <label className="mb-2 block text-xs font-medium text-gray-500 dark:text-gray-400">Bodyweight Unit</label>
            <div className="flex rounded-lg bg-gray-100 p-1 dark:bg-gray-900">
              {(['kg', 'lbs'] as const).map(unit => (
                <button
                  key={unit}
                  onClick={() => updateSettings({ weightUnit: unit })}
                  className={cn(
                    "flex-1 rounded-md py-1.5 text-sm font-medium transition-colors",
                    settings.weightUnit === unit ? "bg-white text-gray-900 shadow-sm dark:bg-gray-700 dark:text-white" : "text-gray-500 dark:text-gray-400"
                  )}
                >
                  {unit.toUpperCase()}
                </button>
              ))}
            </div>
          </div>
        </div>

        {/* Appearance */}
        <SectionHeader icon={Palette} title="Appearance" />
        <div className="mx-4 overflow-hidden rounded-xl border border-gray-100 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-800">
          <div className="border-b border-gray-100 p-4 dark:border-gray-700">
            <label className="mb-2 block text-xs font-medium text-gray-500 dark:text-gray-400">Theme</label>
            <div className="flex rounded-lg bg-gray-100 p-1 dark:bg-gray-900">
              {(['light', 'dark', 'system'] as const).map(t => (
                <button
                  key={t}
                  onClick={() => updateSettings({ theme: t })}
                  className={cn(
                    "flex-1 rounded-md py-1.5 text-sm font-medium capitalize transition-colors",
                    settings.theme === t ? "bg-white text-gray-900 shadow-sm dark:bg-gray-700 dark:text-white" : "text-gray-500 dark:text-gray-400"
                  )}
                >
                  {t}
                </button>
              ))}
            </div>
          </div>
          <div className="border-b border-gray-100 p-4 dark:border-gray-700">
            <label className="mb-2 block text-xs font-medium text-gray-500 dark:text-gray-400">Accent Color</label>
            <div className="flex gap-3">
              {(['blue', 'orange', 'green', 'purple', 'red'] as const).map(c => (
                <button
                  key={c}
                  onClick={() => updateSettings({ accentColor: c })}
                  className={cn(
                    "h-8 w-8 rounded-full border-2",
                    settings.accentColor === c ? "border-gray-900 dark:border-white" : "border-transparent",
                    c === 'blue' && "bg-[#1565C0]",
                    c === 'orange' && "bg-[#f97316]",
                    c === 'green' && "bg-[#10b981]",
                    c === 'purple' && "bg-[#8b5cf6]",
                    c === 'red' && "bg-[#ef4444]"
                  )}
                />
              ))}
            </div>
          </div>
          <div className="p-4">
            <label className="mb-2 block text-xs font-medium text-gray-500 dark:text-gray-400">Font Size</label>
            <div className="flex rounded-lg bg-gray-100 p-1 dark:bg-gray-900">
              {(['normal', 'large'] as const).map(fs => (
                <button
                  key={fs}
                  onClick={() => updateSettings({ fontSize: fs })}
                  className={cn(
                    "flex-1 rounded-md py-1.5 text-sm font-medium capitalize transition-colors",
                    settings.fontSize === fs ? "bg-white text-gray-900 shadow-sm dark:bg-gray-700 dark:text-white" : "text-gray-500 dark:text-gray-400"
                  )}
                >
                  {fs}
                </button>
              ))}
            </div>
          </div>
        </div>

        {/* Rest Timer */}
        <SectionHeader icon={Timer} title="Rest Timer" />
        <div className="mx-4 overflow-hidden rounded-xl border border-gray-100 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-800">
          <div className="flex items-center justify-between border-b border-gray-100 p-4 dark:border-gray-700">
            <span className="text-sm font-medium text-gray-900 dark:text-white">Straight Sets</span>
            <div className="flex items-center gap-3">
              <button onClick={() => updateSettings({ defaultRestStraight: Math.max(30, settings.defaultRestStraight - 30) })} className="h-8 w-8 rounded-full bg-gray-100 dark:bg-gray-700">-</button>
              <span className="w-12 text-center text-sm font-bold">{settings.defaultRestStraight}s</span>
              <button onClick={() => updateSettings({ defaultRestStraight: Math.min(300, settings.defaultRestStraight + 30) })} className="h-8 w-8 rounded-full bg-gray-100 dark:bg-gray-700">+</button>
            </div>
          </div>
          <div className="flex items-center justify-between border-b border-gray-100 p-4 dark:border-gray-700">
            <span className="text-sm font-medium text-gray-900 dark:text-white">Supersets</span>
            <div className="flex items-center gap-3">
              <button onClick={() => updateSettings({ defaultRestSuperset: Math.max(30, settings.defaultRestSuperset - 30) })} className="h-8 w-8 rounded-full bg-gray-100 dark:bg-gray-700">-</button>
              <span className="w-12 text-center text-sm font-bold">{settings.defaultRestSuperset}s</span>
              <button onClick={() => updateSettings({ defaultRestSuperset: Math.min(300, settings.defaultRestSuperset + 30) })} className="h-8 w-8 rounded-full bg-gray-100 dark:bg-gray-700">+</button>
            </div>
          </div>
          <div className="flex items-center justify-between border-b border-gray-100 p-4 dark:border-gray-700">
            <span className="text-sm font-medium text-gray-900 dark:text-white">Drop Sets</span>
            <div className="flex items-center gap-3">
              <button onClick={() => updateSettings({ defaultRestDrop: Math.max(30, settings.defaultRestDrop - 30) })} className="h-8 w-8 rounded-full bg-gray-100 dark:bg-gray-700">-</button>
              <span className="w-12 text-center text-sm font-bold">{settings.defaultRestDrop}s</span>
              <button onClick={() => updateSettings({ defaultRestDrop: Math.min(300, settings.defaultRestDrop + 30) })} className="h-8 w-8 rounded-full bg-gray-100 dark:bg-gray-700">+</button>
            </div>
          </div>
          <div className="flex items-center justify-between border-b border-gray-100 p-4 dark:border-gray-700">
            <span className="text-sm font-medium text-gray-900 dark:text-white">Timer Sound</span>
            <input type="checkbox" checked={settings.timerSound} onChange={e => updateSettings({ timerSound: e.target.checked })} className="h-5 w-5 accent-primary" />
          </div>
          <div className="flex items-center justify-between p-4">
            <span className="text-sm font-medium text-gray-900 dark:text-white">Timer Vibration</span>
            <input type="checkbox" checked={settings.timerVibration} onChange={e => updateSettings({ timerVibration: e.target.checked })} className="h-5 w-5 accent-primary" />
          </div>
        </div>

        {/* Plate Calculator */}
        <SectionHeader icon={Dumbbell} title="Plate Calculator" />
        <div className="mx-4 overflow-hidden rounded-xl border border-gray-100 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-800">
          <div 
            onClick={() => navigate('/app/settings/plates')}
            className="flex cursor-pointer items-center justify-between border-b border-gray-100 p-4 hover:bg-gray-50 dark:border-gray-700 dark:hover:bg-gray-700/50"
          >
            <span className="text-sm font-medium text-gray-900 dark:text-white">Configure Available Plates</span>
            <ChevronRight size={18} className="text-gray-400" />
          </div>
          <div className="p-4">
            <label className="mb-2 block text-xs font-medium text-gray-500 dark:text-gray-400">Barbell Weight</label>
            <div className="flex rounded-lg bg-gray-100 p-1 dark:bg-gray-900">
              {[20, 15, 10].map(w => (
                <button
                  key={w}
                  onClick={() => updateSettings({ barbellWeight: w })}
                  className={cn(
                    "flex-1 rounded-md py-1.5 text-sm font-medium transition-colors",
                    settings.barbellWeight === w ? "bg-white text-gray-900 shadow-sm dark:bg-gray-700 dark:text-white" : "text-gray-500 dark:text-gray-400"
                  )}
                >
                  {w}kg
                </button>
              ))}
            </div>
          </div>
        </div>

        {/* Training Preferences */}
        <SectionHeader icon={Settings2} title="Training Preferences" />
        <div className="mx-4 overflow-hidden rounded-xl border border-gray-100 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-800">
          <div className="border-b border-gray-100 p-4 dark:border-gray-700">
            <label className="mb-2 block text-xs font-medium text-gray-500 dark:text-gray-400">Auto Weight Increment</label>
            <div className="flex rounded-lg bg-gray-100 p-1 dark:bg-gray-900">
              {[0, 1, 2.5, 5].map(inc => (
                <button
                  key={inc}
                  onClick={() => updateSettings({ autoIncrement: inc })}
                  className={cn(
                    "flex-1 rounded-md py-1.5 text-sm font-medium transition-colors",
                    settings.autoIncrement === inc ? "bg-white text-gray-900 shadow-sm dark:bg-gray-700 dark:text-white" : "text-gray-500 dark:text-gray-400"
                  )}
                >
                  {inc === 0 ? 'Off' : `+${inc}`}
                </button>
              ))}
            </div>
          </div>
          <div className="flex items-center justify-between border-b border-gray-100 p-4 dark:border-gray-700">
            <span className="text-sm font-medium text-gray-900 dark:text-white">Show RPE Field</span>
            <input type="checkbox" checked={settings.showRPE} onChange={e => updateSettings({ showRPE: e.target.checked })} className="h-5 w-5 accent-primary" />
          </div>
          <div className="flex items-center justify-between p-4">
            <span className="text-sm font-medium text-gray-900 dark:text-white">Show Previous Session Data</span>
            <input type="checkbox" checked={settings.showPreviousData} onChange={e => updateSettings({ showPreviousData: e.target.checked })} className="h-5 w-5 accent-primary" />
          </div>
        </div>

        {/* Google Sheets Sync */}
        <SectionHeader icon={Cloud} title="Google Sheets Sync" />
        <div className="mx-4 overflow-hidden rounded-xl border border-gray-100 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-800">
          {settings.googleAccessToken ? (
            <div className="p-4">
              <div className="mb-4 flex items-center gap-4">
                {settings.googleUserPicture ? (
                  <img src={settings.googleUserPicture} alt="Profile" className="h-12 w-12 rounded-full" referrerPolicy="no-referrer" />
                ) : (
                  <div className="flex h-12 w-12 items-center justify-center rounded-full bg-gray-100 dark:bg-gray-700">
                    <User size={24} className="text-gray-500 dark:text-gray-400" />
                  </div>
                )}
                <div>
                  <p className="font-bold text-gray-900 dark:text-white">{settings.googleUserEmail}</p>
                  <p className="text-xs text-gray-500 dark:text-gray-400">Connected to Google Sheets</p>
                </div>
              </div>
              <div className="flex gap-3">
                <button 
                  onClick={() => navigate('/app/settings/sync')}
                  className="flex-1 rounded-xl bg-primary py-2 text-sm font-bold text-white hover:bg-primary/90"
                >
                  Sync Status
                </button>
                <button 
                  onClick={() => updateSettings({ googleAccessToken: undefined, googleSheetsId: undefined, googleUserEmail: undefined, googleUserPicture: undefined })}
                  className="flex-1 rounded-xl bg-gray-100 py-2 text-sm font-bold text-gray-900 hover:bg-gray-200 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600"
                >
                  Sign Out
                </button>
              </div>
            </div>
          ) : (
            <div className="p-4 text-center">
              <p className="mb-3 text-sm text-gray-500 dark:text-gray-400">Connect to Google Sheets to automatically backup your workouts.</p>
              <button 
                onClick={() => navigate('/app/settings/sheets-setup')}
                className="rounded-lg bg-primary px-6 py-2 text-sm font-bold text-white hover:bg-primary/90"
              >
                Connect Google Account
              </button>
            </div>
          )}
        </div>

        {/* Data */}
        <SectionHeader icon={Database} title="Data" />
        <div className="mx-4 overflow-hidden rounded-xl border border-gray-100 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-800">
          <button onClick={handleExportJSON} className="flex w-full items-center gap-3 border-b border-gray-100 p-4 text-left hover:bg-gray-50 dark:border-gray-700 dark:hover:bg-gray-700/50">
            <Download size={18} className="text-gray-500" />
            <span className="text-sm font-medium text-gray-900 dark:text-white">Export All Workouts (JSON)</span>
          </button>
          <button onClick={handleExportCSV} className="flex w-full items-center gap-3 border-b border-gray-100 p-4 text-left hover:bg-gray-50 dark:border-gray-700 dark:hover:bg-gray-700/50">
            <Download size={18} className="text-gray-500" />
            <span className="text-sm font-medium text-gray-900 dark:text-white">Export All Workouts (CSV)</span>
          </button>
          <button className="flex w-full items-center gap-3 p-4 text-left hover:bg-gray-50 dark:hover:bg-gray-700/50">
            <Upload size={18} className="text-gray-500" />
            <span className="text-sm font-medium text-gray-900 dark:text-white">Import from Backup</span>
          </button>
        </div>

        {/* Danger Zone */}
        <SectionHeader icon={AlertTriangle} title="Danger Zone" />
        <div className="mx-4 overflow-hidden rounded-xl border border-red-200 bg-red-50 shadow-sm dark:border-red-900/30 dark:bg-red-900/10">
          <div className="p-4">
            <p className="mb-3 text-xs text-red-600 dark:text-red-400">Type 'DELETE' to confirm destructive actions.</p>
            <input 
              type="text" 
              placeholder="Type DELETE"
              value={deleteConfirm}
              onChange={e => setDeleteConfirm(e.target.value)}
              className="mb-4 w-full rounded-lg border border-red-200 bg-white p-2 text-sm text-gray-900 focus:border-red-500 focus:outline-none dark:border-red-800 dark:bg-gray-800 dark:text-white"
            />
            <div className="space-y-2">
              <button 
                onClick={handleClearHistory}
                disabled={deleteConfirm !== 'DELETE'}
                className="flex w-full items-center justify-center gap-2 rounded-lg bg-red-100 py-2 text-sm font-bold text-red-600 disabled:opacity-50 dark:bg-red-900/30 dark:text-red-400"
              >
                <Trash2 size={16} />
                Clear Workout History
              </button>
              <button 
                onClick={handleFactoryReset}
                disabled={deleteConfirm !== 'DELETE'}
                className="flex w-full items-center justify-center gap-2 rounded-lg bg-red-600 py-2 text-sm font-bold text-white disabled:opacity-50"
              >
                <AlertTriangle size={16} />
                Factory Reset
              </button>
            </div>
          </div>
        </div>

      </div>
    </div>
  );
}
