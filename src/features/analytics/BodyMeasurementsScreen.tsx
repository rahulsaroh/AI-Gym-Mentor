import React, { useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useLiveQuery } from 'dexie-react-hooks';
import { db, BodyMeasurement } from '@/database/db';
import { ChevronLeft, Plus, Trash2 } from 'lucide-react';
import { format } from 'date-fns';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';
import { cn } from '@/core/utils/cn';
import { queueMeasurementSync } from '@/services/sync_worker';

type Metric = keyof Omit<BodyMeasurement, 'id' | 'date'>;

const METRICS: { key: Metric, label: string, unit: string }[] = [
  { key: 'weight', label: 'Bodyweight', unit: 'kg' },
  { key: 'bodyFat', label: 'Body Fat', unit: '%' },
  { key: 'chest', label: 'Chest', unit: 'cm' },
  { key: 'waist', label: 'Waist', unit: 'cm' },
  { key: 'hips', label: 'Hips', unit: 'cm' },
  { key: 'leftArm', label: 'Left Arm', unit: 'cm' },
  { key: 'rightArm', label: 'Right Arm', unit: 'cm' },
  { key: 'leftThigh', label: 'Left Thigh', unit: 'cm' },
  { key: 'rightThigh', label: 'Right Thigh', unit: 'cm' },
  { key: 'calves', label: 'Calves', unit: 'cm' },
];

export default function BodyMeasurementsScreen() {
  const navigate = useNavigate();
  const [selectedMetric, setSelectedMetric] = useState<Metric>('weight');
  const [showAddModal, setShowAddModal] = useState(false);
  const [newMeasurement, setNewMeasurement] = useState<Partial<BodyMeasurement>>({ date: new Date().toISOString() });

  const measurements = useLiveQuery(() => db.body_measurements.reverse().sortBy('date'));

  const chartData = useMemo(() => {
    if (!measurements) return [];
    return [...measurements].reverse().map(m => ({
      date: format(new Date(m.date), 'MMM d'),
      value: m[selectedMetric]
    })).filter(m => m.value !== undefined && m.value !== null);
  }, [measurements, selectedMetric]);

  const handleSave = async () => {
    if (!newMeasurement.date) return;
    const id = await db.body_measurements.add(newMeasurement as BodyMeasurement);
    await queueMeasurementSync(id as number);
    setShowAddModal(false);
    setNewMeasurement({ date: new Date().toISOString() });
  };

  const handleDelete = async (id: number) => {
    if (window.confirm('Delete this measurement?')) {
      await db.body_measurements.delete(id);
    }
  };

  const currentMetricInfo = METRICS.find(m => m.key === selectedMetric)!;

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      {/* AppBar */}
      <div className="flex items-center justify-between border-b border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
        <div className="flex items-center gap-3">
          <button onClick={() => navigate(-1)} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
            <ChevronLeft size={24} />
          </button>
          <h1 className="text-lg font-bold text-gray-900 dark:text-white">Body Measurements</h1>
        </div>
      </div>

      <div className="flex-1 overflow-y-auto pb-24">
        {/* Metric Selector */}
        <div className="sticky top-0 z-10 bg-surface/90 p-4 backdrop-blur-sm dark:bg-surface-dark/90">
          <div className="flex gap-2 overflow-x-auto no-scrollbar">
            {METRICS.map(m => (
              <button
                key={m.key}
                onClick={() => setSelectedMetric(m.key)}
                className={cn(
                  "whitespace-nowrap rounded-full px-4 py-1.5 text-sm font-medium transition-colors",
                  selectedMetric === m.key
                    ? "bg-primary text-white"
                    : "bg-gray-100 text-gray-600 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700"
                )}
              >
                {m.label}
              </button>
            ))}
          </div>
        </div>

        {/* Chart */}
        <div className="p-4">
          <div className="rounded-xl border border-gray-100 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
            <h3 className="mb-4 text-sm font-bold text-gray-900 dark:text-white">{currentMetricInfo.label} Trend</h3>
            {chartData.length > 0 ? (
              <div className="h-48 w-full">
                <ResponsiveContainer width="100%" height="100%">
                  <LineChart data={chartData}>
                    <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e5e7eb" />
                    <XAxis dataKey="date" axisLine={false} tickLine={false} tick={{ fontSize: 10, fill: '#6b7280' }} />
                    <YAxis domain={['auto', 'auto']} axisLine={false} tickLine={false} tick={{ fontSize: 10, fill: '#6b7280' }} width={30} />
                    <Tooltip 
                      contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)' }}
                      formatter={(value: number) => [`${value} ${currentMetricInfo.unit}`, currentMetricInfo.label]}
                    />
                    <Line type="monotone" dataKey="value" stroke="#1565C0" strokeWidth={3} dot={{ r: 4, fill: '#1565C0', strokeWidth: 2, stroke: '#fff' }} activeDot={{ r: 6 }} />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            ) : (
              <div className="flex h-48 items-center justify-center text-sm text-gray-500 dark:text-gray-400">
                No data for this metric yet.
              </div>
            )}
          </div>
        </div>

        {/* History List */}
        <div className="px-4 pb-4">
          <h3 className="mb-3 text-sm font-bold text-gray-900 dark:text-white">History</h3>
          <div className="space-y-2">
            {measurements?.map(m => (
              <div key={m.id} className="flex items-center justify-between rounded-lg border border-gray-100 bg-white p-3 shadow-sm dark:border-gray-800 dark:bg-gray-800">
                <div>
                  <p className="font-bold text-gray-900 dark:text-white">{format(new Date(m.date), 'MMM d, yyyy')}</p>
                  <div className="mt-1 flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-500 dark:text-gray-400">
                    {METRICS.map(metric => m[metric.key] !== undefined && (
                      <span key={metric.key}>{metric.label}: <span className="font-medium text-gray-900 dark:text-white">{m[metric.key]}{metric.unit}</span></span>
                    ))}
                  </div>
                </div>
                <button 
                  onClick={() => handleDelete(m.id!)}
                  className="p-2 text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-full"
                >
                  <Trash2 size={18} />
                </button>
              </div>
            ))}
            {measurements?.length === 0 && (
              <p className="text-center text-sm text-gray-500 dark:text-gray-400 py-4">No measurements logged yet.</p>
            )}
          </div>
        </div>
      </div>

      {/* FAB */}
      <button
        onClick={() => setShowAddModal(true)}
        className="absolute bottom-20 right-4 flex h-14 w-14 items-center justify-center rounded-2xl bg-primary text-white shadow-lg transition-transform hover:scale-105 active:scale-95"
      >
        <Plus size={24} />
      </button>

      {/* Add Modal */}
      {showAddModal && (
        <div className="fixed inset-0 z-50 flex items-end justify-center bg-black/50 p-4 sm:items-center">
          <div className="w-full max-w-md rounded-2xl bg-white p-6 shadow-xl dark:bg-gray-900 max-h-[90vh] overflow-y-auto">
            <h2 className="mb-4 text-xl font-bold text-gray-900 dark:text-white">Log Measurements</h2>
            
            <div className="space-y-4">
              <div>
                <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Date</label>
                <input 
                  type="date" 
                  value={newMeasurement.date ? newMeasurement.date.split('T')[0] : ''}
                  onChange={e => setNewMeasurement({ ...newMeasurement, date: new Date(e.target.value).toISOString() })}
                  className="w-full rounded-xl border border-gray-200 bg-gray-50 p-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                {METRICS.map(m => (
                  <div key={m.key}>
                    <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">{m.label} ({m.unit})</label>
                    <input 
                      type="number" 
                      step="0.1"
                      value={newMeasurement[m.key] || ''}
                      onChange={e => setNewMeasurement({ ...newMeasurement, [m.key]: e.target.value ? Number(e.target.value) : undefined })}
                      className="w-full rounded-xl border border-gray-200 bg-gray-50 p-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
                    />
                  </div>
                ))}
              </div>
            </div>

            <div className="mt-6 flex gap-3">
              <button 
                onClick={() => setShowAddModal(false)}
                className="flex-1 rounded-xl bg-gray-100 py-3 font-bold text-gray-900 hover:bg-gray-200 dark:bg-gray-800 dark:text-white dark:hover:bg-gray-700"
              >
                Cancel
              </button>
              <button 
                onClick={handleSave}
                className="flex-1 rounded-xl bg-primary py-3 font-bold text-white hover:bg-primary/90"
              >
                Save
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
