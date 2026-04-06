/**
 * @license
 * SPDX-License-Identifier: Apache-2.0
 */

import React, { useEffect } from 'react';
import { RouterProvider } from 'react-router-dom';
import { router } from './core/router';
import { SettingsProvider, useSettings } from './core/settings/SettingsContext';
import { processSyncQueue } from './services/sync_worker';

function AppContent() {
  const { settings } = useSettings();

  useEffect(() => {
    const handleOnline = () => {
      if (settings.googleAccessToken && settings.googleSheetsId) {
        processSyncQueue(settings.googleAccessToken, settings.googleSheetsId);
      }
    };

    window.addEventListener('online', handleOnline);
    
    // Also try to sync on mount if online
    if (navigator.onLine) {
      handleOnline();
    }

    return () => window.removeEventListener('online', handleOnline);
  }, [settings.googleAccessToken, settings.googleSheetsId]);

  return <RouterProvider router={router} />;
}

export default function App() {
  return (
    <SettingsProvider>
      <AppContent />
    </SettingsProvider>
  );
}
