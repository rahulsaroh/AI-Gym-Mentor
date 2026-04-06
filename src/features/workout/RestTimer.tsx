import React, { useState, useEffect } from 'react';
import { X, Play, Pause, SkipForward, Plus, Minus } from 'lucide-react';
import { cn } from '@/core/utils/cn';

interface RestTimerProps {
  initialSeconds: number;
  exerciseName?: string;
  nextExerciseName?: string;
  onClose: () => void;
}

export default function RestTimer({ initialSeconds, exerciseName, nextExerciseName, onClose }: RestTimerProps) {
  const [timeLeft, setTimeLeft] = useState(initialSeconds);
  const [isActive, setIsActive] = useState(true);

  useEffect(() => {
    let interval: NodeJS.Timeout;
    if (isActive && timeLeft > 0) {
      interval = setInterval(() => {
        setTimeLeft((prev) => prev - 1);
      }, 1000);
    } else if (timeLeft === 0) {
      setIsActive(false);
      // Play sound / vibrate
      if (navigator.vibrate) navigator.vibrate([200, 100, 200]);
      
      // Web Notification
      if (Notification.permission === 'granted') {
        new Notification('Rest complete!', {
          body: 'Time for next set',
          icon: '/favicon.ico',
        });
      }
    }
    return () => clearInterval(interval);
  }, [isActive, timeLeft]);

  useEffect(() => {
    // Request notification permission
    if (Notification.permission !== 'granted' && Notification.permission !== 'denied') {
      Notification.requestPermission();
    }
  }, []);

  const formatTime = (seconds: number) => {
    const m = Math.floor(seconds / 60);
    const s = seconds % 60;
    return `${m}:${s.toString().padStart(2, '0')}`;
  };

  const progress = (timeLeft / initialSeconds) * 100;

  return (
    <div className="fixed inset-x-0 bottom-0 z-50 rounded-t-3xl bg-white p-6 shadow-[0_-10px_40px_rgba(0,0,0,0.1)] dark:bg-gray-900 border-t border-gray-200 dark:border-gray-800">
      <div className="mb-4 flex items-center justify-between">
        <div>
          <h3 className="font-bold text-gray-900 dark:text-white">Rest Timer</h3>
          {nextExerciseName && (
            <p className="text-sm text-gray-500 dark:text-gray-400">Next: {nextExerciseName}</p>
          )}
        </div>
        <button onClick={onClose} className="rounded-full bg-gray-100 p-2 text-gray-500 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700">
          <X size={20} />
        </button>
      </div>

      <div className="flex flex-col items-center justify-center py-4">
        <div className="relative flex h-32 w-32 items-center justify-center">
          <svg className="absolute inset-0 h-full w-full -rotate-90 transform" viewBox="0 0 100 100">
            <circle
              className="text-gray-100 dark:text-gray-800"
              strokeWidth="8"
              stroke="currentColor"
              fill="transparent"
              r="40"
              cx="50"
              cy="50"
            />
            <circle
              className={cn("text-primary transition-all duration-1000 ease-linear", timeLeft === 0 ? "text-green-500" : "")}
              strokeWidth="8"
              strokeDasharray={251.2}
              strokeDashoffset={251.2 - (251.2 * progress) / 100}
              strokeLinecap="round"
              stroke="currentColor"
              fill="transparent"
              r="40"
              cx="50"
              cy="50"
            />
          </svg>
          <span className="text-3xl font-black text-gray-900 dark:text-white">{formatTime(timeLeft)}</span>
        </div>

        <div className="mt-8 flex items-center justify-center gap-6">
          <button 
            onClick={() => setTimeLeft(prev => Math.max(0, prev - 15))}
            className="flex h-12 w-12 items-center justify-center rounded-full bg-gray-100 text-gray-600 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700"
          >
            -15s
          </button>
          
          <button 
            onClick={() => setIsActive(!isActive)}
            className="flex h-16 w-16 items-center justify-center rounded-full bg-primary text-white shadow-lg hover:bg-primary-dark"
          >
            {isActive ? <Pause size={28} className="fill-white" /> : <Play size={28} className="fill-white ml-1" />}
          </button>

          <button 
            onClick={() => setTimeLeft(prev => prev + 15)}
            className="flex h-12 w-12 items-center justify-center rounded-full bg-gray-100 text-gray-600 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700"
          >
            +15s
          </button>
        </div>
        
        <button 
          onClick={onClose}
          className="mt-6 text-sm font-medium text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white"
        >
          Skip Rest
        </button>
      </div>
    </div>
  );
}
