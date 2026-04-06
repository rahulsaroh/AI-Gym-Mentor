import React, { createContext, useContext, useState, useEffect } from 'react';

export interface Plate {
  weight: number;
  quantity: number;
}

export interface AppSettings {
  name: string;
  experienceLevel: 'Beginner' | 'Intermediate' | 'Advanced';
  weightUnit: 'kg' | 'lbs';
  theme: 'system' | 'light' | 'dark';
  accentColor: 'blue' | 'orange' | 'green' | 'purple' | 'red';
  fontSize: 'normal' | 'large';
  defaultRestStraight: number;
  defaultRestSuperset: number;
  defaultRestDrop: number;
  timerSound: boolean;
  timerVibration: boolean;
  backgroundNotification: boolean;
  barbellWeight: number;
  availablePlates: Plate[];
  autoIncrement: number;
  showRPE: boolean;
  showPreviousData: boolean;
  googleSheetsId?: string;
  googleAccessToken?: string;
  googleUserEmail?: string;
  googleUserPicture?: string;
}

const defaultSettings: AppSettings = {
  name: 'User',
  experienceLevel: 'Intermediate',
  weightUnit: 'kg',
  theme: 'system',
  accentColor: 'orange',
  fontSize: 'normal',
  defaultRestStraight: 90,
  defaultRestSuperset: 60,
  defaultRestDrop: 30,
  timerSound: true,
  timerVibration: true,
  backgroundNotification: false,
  barbellWeight: 20,
  availablePlates: [
    { weight: 25, quantity: 2 },
    { weight: 20, quantity: 6 },
    { weight: 15, quantity: 2 },
    { weight: 10, quantity: 4 },
    { weight: 5, quantity: 4 },
    { weight: 2.5, quantity: 2 },
    { weight: 1.25, quantity: 2 },
  ],
  autoIncrement: 0,
  showRPE: true,
  showPreviousData: true,
};

const SettingsContext = createContext<{
  settings: AppSettings;
  updateSettings: (newSettings: Partial<AppSettings>) => void;
} | null>(null);

const ACCENT_COLORS = {
  blue: '#1565C0',
  orange: '#f97316',
  green: '#10b981',
  purple: '#8b5cf6',
  red: '#ef4444',
};

export function SettingsProvider({ children }: { children: React.ReactNode }) {
  const [settings, setSettings] = useState<AppSettings>(() => {
    const stored = localStorage.getItem('gymlog_settings');
    return stored ? { ...defaultSettings, ...JSON.parse(stored) } : defaultSettings;
  });

  const updateSettings = (newSettings: Partial<AppSettings>) => {
    setSettings(prev => {
      const updated = { ...prev, ...newSettings };
      localStorage.setItem('gymlog_settings', JSON.stringify(updated));
      return updated;
    });
  };

  useEffect(() => {
    const root = window.document.documentElement;
    
    // Theme
    root.classList.remove('light', 'dark');
    if (settings.theme === 'system') {
      const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
      root.classList.add(systemTheme);
    } else {
      root.classList.add(settings.theme);
    }

    // Font size
    if (settings.fontSize === 'large') {
      root.style.fontSize = '18px';
    } else {
      root.style.fontSize = '16px';
    }
    
    // Accent color
    root.style.setProperty('--color-primary', ACCENT_COLORS[settings.accentColor]);

  }, [settings.theme, settings.fontSize, settings.accentColor]);

  return (
    <SettingsContext.Provider value={{ settings, updateSettings }}>
      {children}
    </SettingsContext.Provider>
  );
}

export function useSettings() {
  const context = useContext(SettingsContext);
  if (!context) throw new Error('useSettings must be used within SettingsProvider');
  return context;
}
