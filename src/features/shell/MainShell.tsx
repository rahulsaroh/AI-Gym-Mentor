import React from 'react';
import { Outlet, NavLink, useLocation } from 'react-router-dom';
import { Dumbbell, History, LayoutList, LineChart, Settings } from 'lucide-react';
import { cn } from '@/core/utils/cn';

const navItems = [
  { path: '/app', icon: Dumbbell, label: 'Workout' },
  { path: '/app/history', icon: History, label: 'History' },
  { path: '/app/programs', icon: LayoutList, label: 'Programs' },
  { path: '/app/analytics', icon: LineChart, label: 'Analytics' },
  { path: '/app/settings', icon: Settings, label: 'Settings' },
];

export default function MainShell() {
  const location = useLocation();

  return (
    <div className="flex h-screen w-full flex-col bg-surface dark:bg-surface-dark">
      <main className="flex-1 overflow-y-auto pb-20">
        <Outlet />
      </main>

      <nav className="fixed bottom-0 left-0 right-0 border-t border-gray-200 bg-white pb-safe pt-2 dark:border-gray-800 dark:bg-gray-900">
        <div className="mx-auto flex max-w-md justify-around px-2 pb-2">
          {navItems.map((item) => {
            const Icon = item.icon;
            const isActive = location.pathname === item.path || (item.path !== '/app' && location.pathname.startsWith(item.path));
            
            return (
              <NavLink
                key={item.path}
                to={item.path}
                className={cn(
                  "flex flex-col items-center justify-center w-16 space-y-1 transition-colors",
                  isActive 
                    ? "text-primary" 
                    : "text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-gray-200"
                )}
              >
                <Icon size={24} strokeWidth={isActive ? 2.5 : 2} />
                <span className="text-[10px] font-medium">{item.label}</span>
              </NavLink>
            );
          })}
        </div>
      </nav>
    </div>
  );
}
