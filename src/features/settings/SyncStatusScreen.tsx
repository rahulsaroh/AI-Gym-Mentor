import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { db } from '@/database/db';
import { useSettings } from '@/core/settings/SettingsContext';
import { ChevronLeft, RefreshCw, CheckCircle, AlertTriangle, Clock } from 'lucide-react';
import { format } from 'date-fns';
import { processSyncQueue } from '@/services/sync_worker';

export default function SyncStatusScreen() {
  const navigate = useNavigate();
  const { settings } = useSettings();
  const [isSyncing, setIsSyncing] = useState(false);

  const queue = useLiveQuery(() => db.sync_queue.reverse().sortBy('createdAt'));

  const pendingCount = queue?.filter(q => q.status === 'pending').length || 0;
  const failedCount = queue?.filter(q => q.status === 'failed').length || 0;
  const doneCount = queue?.filter(q => q.status === 'done').length || 0;

  const handleSyncNow = async () => {
    if (!settings.googleAccessToken || !settings.googleSheetsId) return;
    setIsSyncing(true);
    await processSyncQueue(settings.googleAccessToken, settings.googleSheetsId);
    setIsSyncing(false);
  };

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      <div className="flex items-center gap-3 border-b border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
        <button onClick={() => navigate(-1)} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
          <ChevronLeft size={24} />
        </button>
        <h1 className="text-lg font-bold text-gray-900 dark:text-white">Sync Status</h1>
      </div>

      <div className="flex-1 overflow-y-auto p-4">
        <div className="mb-6 grid grid-cols-3 gap-4">
          <div className="rounded-xl border border-gray-100 bg-white p-4 text-center shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <Clock size={24} className="mx-auto mb-2 text-blue-500" />
            <p className="text-2xl font-bold text-gray-900 dark:text-white">{pendingCount}</p>
            <p className="text-xs font-medium text-gray-500 dark:text-gray-400">Pending</p>
          </div>
          <div className="rounded-xl border border-gray-100 bg-white p-4 text-center shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <AlertTriangle size={24} className="mx-auto mb-2 text-red-500" />
            <p className="text-2xl font-bold text-gray-900 dark:text-white">{failedCount}</p>
            <p className="text-xs font-medium text-gray-500 dark:text-gray-400">Failed</p>
          </div>
          <div className="rounded-xl border border-gray-100 bg-white p-4 text-center shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <CheckCircle size={24} className="mx-auto mb-2 text-green-500" />
            <p className="text-2xl font-bold text-gray-900 dark:text-white">{doneCount}</p>
            <p className="text-xs font-medium text-gray-500 dark:text-gray-400">Done</p>
          </div>
        </div>

        <button 
          onClick={handleSyncNow}
          disabled={isSyncing || pendingCount === 0}
          className="mb-8 flex w-full items-center justify-center gap-2 rounded-xl bg-primary py-4 font-bold text-white shadow-lg transition-transform hover:scale-[1.02] active:scale-95 disabled:opacity-50"
        >
          {isSyncing ? (
            <div className="h-5 w-5 animate-spin rounded-full border-2 border-white border-t-transparent"></div>
          ) : (
            <RefreshCw size={20} />
          )}
          {isSyncing ? 'Syncing...' : 'Sync Now'}
        </button>

        <h3 className="mb-3 text-sm font-bold text-gray-900 dark:text-white">Sync Log (Last 20)</h3>
        <div className="space-y-3">
          {queue?.slice(0, 20).map(item => (
            <div key={item.id} className="rounded-xl border border-gray-100 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  {item.status === 'done' && <CheckCircle size={16} className="text-green-500" />}
                  {item.status === 'pending' && <Clock size={16} className="text-blue-500" />}
                  {item.status === 'failed' && <AlertTriangle size={16} className="text-red-500" />}
                  <span className="text-sm font-bold capitalize text-gray-900 dark:text-white">{item.type}</span>
                </div>
                <span className="text-xs text-gray-500 dark:text-gray-400">{format(new Date(item.createdAt), 'MMM d, HH:mm')}</span>
              </div>
              {item.error && (
                <p className="mt-2 text-xs text-red-500">{item.error}</p>
              )}
            </div>
          ))}
          {queue?.length === 0 && (
            <p className="text-center text-sm text-gray-500 dark:text-gray-400 py-8">No sync events yet.</p>
          )}
        </div>
      </div>
    </div>
  );
}
