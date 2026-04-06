import React, { useState } from 'react';
import { X } from 'lucide-react';
import { cn } from '@/core/utils/cn';

interface PlateCalculatorProps {
  targetWeight: number;
  barWeight?: number;
  onClose: () => void;
}

const AVAILABLE_PLATES = [25, 20, 15, 10, 5, 2.5, 1.25]; // in kg/lbs

export default function PlateCalculator({ targetWeight, barWeight = 20, onClose }: PlateCalculatorProps) {
  const weightPerSide = (targetWeight - barWeight) / 2;
  
  const platesNeeded: { weight: number, count: number }[] = [];
  let remaining = weightPerSide;

  for (const plate of AVAILABLE_PLATES) {
    if (remaining >= plate) {
      const count = Math.floor(remaining / plate);
      platesNeeded.push({ weight: plate, count });
      remaining -= count * plate;
    }
  }

  return (
    <div className="fixed inset-0 z-50 flex items-end justify-center bg-black/50 sm:items-center">
      <div className="w-full max-w-md rounded-t-2xl bg-white p-6 shadow-xl dark:bg-gray-900 sm:rounded-2xl">
        <div className="mb-6 flex items-center justify-between">
          <h2 className="text-xl font-bold text-gray-900 dark:text-white">Plate Calculator</h2>
          <button onClick={onClose} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
            <X size={24} />
          </button>
        </div>

        <div className="mb-6 text-center">
          <div className="text-sm text-gray-500 dark:text-gray-400">Target Weight</div>
          <div className="text-4xl font-black text-gray-900 dark:text-white">{targetWeight}</div>
          <div className="text-sm text-gray-500 dark:text-gray-400 mt-1">Bar: {barWeight}</div>
        </div>

        {weightPerSide > 0 ? (
          <div className="space-y-4">
            <div className="text-center font-medium text-gray-900 dark:text-white">Per Side: {weightPerSide}</div>
            
            {/* Visual representation */}
            <div className="flex justify-center items-center h-32 bg-gray-100 dark:bg-gray-800 rounded-xl overflow-hidden relative">
              <div className="w-full h-4 bg-gray-400 absolute top-1/2 -translate-y-1/2 z-0" />
              <div className="flex items-center gap-1 z-10">
                {platesNeeded.map((p, i) => (
                  <React.Fragment key={i}>
                    {Array.from({ length: p.count }).map((_, j) => (
                      <div 
                        key={`${i}-${j}`}
                        className="bg-primary rounded-sm border border-primary-dark flex items-center justify-center text-white text-xs font-bold"
                        style={{ 
                          height: `${Math.max(40, p.weight * 3)}px`, 
                          width: `${Math.max(12, p.weight * 1.5)}px` 
                        }}
                      >
                        {p.weight >= 10 && p.weight}
                      </div>
                    ))}
                  </React.Fragment>
                ))}
              </div>
            </div>

            <div className="grid grid-cols-2 gap-2">
              {platesNeeded.map((p, i) => (
                <div key={i} className="flex justify-between rounded-lg bg-gray-50 p-3 dark:bg-gray-800">
                  <span className="font-bold text-gray-900 dark:text-white">{p.weight}</span>
                  <span className="text-gray-500 dark:text-gray-400">x {p.count}</span>
                </div>
              ))}
            </div>
          </div>
        ) : (
          <div className="text-center text-gray-500 dark:text-gray-400">
            Weight is less than or equal to bar weight.
          </div>
        )}
      </div>
    </div>
  );
}
