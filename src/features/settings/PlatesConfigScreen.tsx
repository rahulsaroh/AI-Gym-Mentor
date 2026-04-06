import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useSettings, Plate } from '@/core/settings/SettingsContext';
import { ChevronLeft, Plus, Trash2 } from 'lucide-react';

export default function PlatesConfigScreen() {
  const navigate = useNavigate();
  const { settings, updateSettings } = useSettings();
  const [showAddModal, setShowAddModal] = useState(false);
  const [newWeight, setNewWeight] = useState('');
  const [newQuantity, setNewQuantity] = useState('2');

  const handleUpdateQuantity = (index: number, delta: number) => {
    const newPlates = [...settings.availablePlates];
    newPlates[index].quantity = Math.max(0, newPlates[index].quantity + delta);
    updateSettings({ availablePlates: newPlates });
  };

  const handleRemovePlate = (index: number) => {
    const newPlates = [...settings.availablePlates];
    newPlates.splice(index, 1);
    updateSettings({ availablePlates: newPlates });
  };

  const handleAddPlate = () => {
    const weight = parseFloat(newWeight);
    const quantity = parseInt(newQuantity, 10);
    if (!isNaN(weight) && weight > 0 && !isNaN(quantity) && quantity > 0) {
      const newPlates = [...settings.availablePlates];
      const existingIndex = newPlates.findIndex(p => p.weight === weight);
      if (existingIndex >= 0) {
        newPlates[existingIndex].quantity += quantity;
      } else {
        newPlates.push({ weight, quantity });
        newPlates.sort((a, b) => b.weight - a.weight);
      }
      updateSettings({ availablePlates: newPlates });
      setShowAddModal(false);
      setNewWeight('');
      setNewQuantity('2');
    }
  };

  const handleLoadStandard = () => {
    updateSettings({
      availablePlates: [
        { weight: 25, quantity: 2 },
        { weight: 20, quantity: 6 },
        { weight: 15, quantity: 2 },
        { weight: 10, quantity: 4 },
        { weight: 5, quantity: 4 },
        { weight: 2.5, quantity: 2 },
        { weight: 1.25, quantity: 2 },
      ]
    });
  };

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      <div className="flex items-center justify-between border-b border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
        <div className="flex items-center gap-3">
          <button onClick={() => navigate(-1)} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
            <ChevronLeft size={24} />
          </button>
          <h1 className="text-lg font-bold text-gray-900 dark:text-white">Configure Plates</h1>
        </div>
      </div>

      <div className="flex-1 overflow-y-auto p-4 pb-24">
        <button 
          onClick={handleLoadStandard}
          className="mb-6 w-full rounded-xl bg-gray-100 py-3 text-sm font-bold text-gray-900 hover:bg-gray-200 dark:bg-gray-800 dark:text-white dark:hover:bg-gray-700"
        >
          Load Standard Gym Set
        </button>

        <div className="space-y-3">
          {settings.availablePlates.map((plate, idx) => (
            <div key={idx} className="flex items-center justify-between rounded-xl border border-gray-100 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-gray-800">
              <div className="flex items-center gap-4">
                <div className="flex h-12 w-12 items-center justify-center rounded-full bg-primary/10 text-lg font-black text-primary">
                  {plate.weight}
                </div>
                <span className="text-sm font-medium text-gray-500 dark:text-gray-400">kg</span>
              </div>
              
              <div className="flex items-center gap-4">
                <div className="flex items-center gap-3 rounded-lg bg-gray-50 p-1 dark:bg-gray-900">
                  <button onClick={() => handleUpdateQuantity(idx, -2)} className="flex h-8 w-8 items-center justify-center rounded-md bg-white text-gray-600 shadow-sm dark:bg-gray-800 dark:text-gray-300">-</button>
                  <span className="w-8 text-center font-bold text-gray-900 dark:text-white">{plate.quantity}</span>
                  <button onClick={() => handleUpdateQuantity(idx, 2)} className="flex h-8 w-8 items-center justify-center rounded-md bg-white text-gray-600 shadow-sm dark:bg-gray-800 dark:text-gray-300">+</button>
                </div>
                <button onClick={() => handleRemovePlate(idx)} className="p-2 text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-full">
                  <Trash2 size={18} />
                </button>
              </div>
            </div>
          ))}
          {settings.availablePlates.length === 0 && (
            <p className="text-center text-sm text-gray-500 dark:text-gray-400 py-8">No plates configured.</p>
          )}
        </div>
      </div>

      <button
        onClick={() => setShowAddModal(true)}
        className="absolute bottom-6 right-4 flex h-14 w-14 items-center justify-center rounded-2xl bg-primary text-white shadow-lg transition-transform hover:scale-105 active:scale-95"
      >
        <Plus size={24} />
      </button>

      {showAddModal && (
        <div className="fixed inset-0 z-50 flex items-end justify-center bg-black/50 p-4 sm:items-center">
          <div className="w-full max-w-md rounded-2xl bg-white p-6 shadow-xl dark:bg-gray-900">
            <h2 className="mb-4 text-xl font-bold text-gray-900 dark:text-white">Add Custom Plate</h2>
            
            <div className="space-y-4">
              <div>
                <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Weight (kg)</label>
                <input 
                  type="number" 
                  step="0.25"
                  value={newWeight}
                  onChange={e => setNewWeight(e.target.value)}
                  placeholder="e.g. 1.25"
                  className="w-full rounded-xl border border-gray-200 bg-gray-50 p-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
                />
              </div>
              <div>
                <label className="mb-1 block text-sm font-medium text-gray-700 dark:text-gray-300">Quantity</label>
                <input 
                  type="number" 
                  step="2"
                  value={newQuantity}
                  onChange={e => setNewQuantity(e.target.value)}
                  className="w-full rounded-xl border border-gray-200 bg-gray-50 p-3 text-gray-900 focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-800 dark:text-white"
                />
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
                onClick={handleAddPlate}
                className="flex-1 rounded-xl bg-primary py-3 font-bold text-white hover:bg-primary/90"
              >
                Add
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
