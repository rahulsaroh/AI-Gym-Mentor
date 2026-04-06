import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useGoogleLogin } from '@react-oauth/google';
import { useSettings } from '@/core/settings/SettingsContext';
import { ChevronLeft, Cloud, CheckCircle, AlertTriangle } from 'lucide-react';
import { createSpreadsheet } from '@/services/sheets_service';

export default function SheetsSetupScreen() {
  const navigate = useNavigate();
  const { updateSettings } = useSettings();
  const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle');
  const [errorMsg, setErrorMsg] = useState('');
  const [sheetUrl, setSheetUrl] = useState('');

  const login = useGoogleLogin({
    scope: 'https://www.googleapis.com/auth/spreadsheets https://www.googleapis.com/auth/drive.file',
    onSuccess: async (tokenResponse) => {
      setStatus('loading');
      try {
        // Fetch user info
        const userInfoRes = await fetch('https://www.googleapis.com/oauth2/v3/userinfo', {
          headers: { Authorization: `Bearer ${tokenResponse.access_token}` },
        });
        const userInfo = await userInfoRes.json();

        // Create Spreadsheet
        const spreadsheet = await createSpreadsheet(tokenResponse.access_token);
        
        updateSettings({
          googleAccessToken: tokenResponse.access_token,
          googleSheetsId: spreadsheet.spreadsheetId,
          googleUserEmail: userInfo.email,
          googleUserPicture: userInfo.picture,
        });

        setSheetUrl(spreadsheet.spreadsheetUrl);
        setStatus('success');
      } catch (err: any) {
        console.error('Setup failed:', err);
        setErrorMsg(err.message || 'Failed to create spreadsheet');
        setStatus('error');
      }
    },
    onError: (error) => {
      console.error('Login Failed:', error);
      setErrorMsg('Google Sign-In failed');
      setStatus('error');
    }
  });

  return (
    <div className="flex h-full flex-col bg-surface dark:bg-surface-dark">
      <div className="flex items-center gap-3 border-b border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
        <button onClick={() => navigate(-1)} className="text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
          <ChevronLeft size={24} />
        </button>
        <h1 className="text-lg font-bold text-gray-900 dark:text-white">Google Sheets Sync</h1>
      </div>

      <div className="flex-1 overflow-y-auto p-6 flex flex-col items-center justify-center text-center">
        {status === 'idle' && (
          <>
            <div className="mb-6 flex h-24 w-24 items-center justify-center rounded-3xl bg-blue-100 text-blue-600 dark:bg-blue-900/30 dark:text-blue-500">
              <Cloud size={48} />
            </div>
            <h2 className="mb-4 text-2xl font-bold text-gray-900 dark:text-white">Connect Google Sheets</h2>
            <p className="mb-8 text-gray-600 dark:text-gray-400">
              We'll create a Google Spreadsheet called <strong>GymLog Pro</strong> in your Google Drive. Every workout and body measurement will be logged there automatically.
            </p>
            <button 
              onClick={() => login()}
              className="w-full max-w-xs rounded-xl bg-primary py-4 font-bold text-white shadow-lg transition-transform hover:scale-105 active:scale-95"
            >
              Connect with Google
            </button>
          </>
        )}

        {status === 'loading' && (
          <>
            <div className="mb-6 flex h-24 w-24 items-center justify-center rounded-3xl bg-gray-100 text-gray-400 dark:bg-gray-800">
              <div className="h-10 w-10 animate-spin rounded-full border-4 border-primary border-t-transparent"></div>
            </div>
            <h2 className="mb-2 text-xl font-bold text-gray-900 dark:text-white">Setting up...</h2>
            <p className="text-gray-600 dark:text-gray-400">Creating your spreadsheet in Google Drive.</p>
          </>
        )}

        {status === 'success' && (
          <>
            <div className="mb-6 flex h-24 w-24 items-center justify-center rounded-3xl bg-green-100 text-green-600 dark:bg-green-900/30 dark:text-green-500">
              <CheckCircle size={48} />
            </div>
            <h2 className="mb-4 text-2xl font-bold text-gray-900 dark:text-white">Setup Complete!</h2>
            <p className="mb-8 text-gray-600 dark:text-gray-400">
              Your workouts will now sync automatically.
            </p>
            <div className="space-y-3 w-full max-w-xs">
              <a 
                href={sheetUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="flex w-full items-center justify-center rounded-xl bg-primary py-4 font-bold text-white shadow-lg transition-transform hover:scale-105 active:scale-95"
              >
                Open Spreadsheet
              </a>
              <button 
                onClick={() => navigate(-1)}
                className="w-full rounded-xl bg-gray-100 py-4 font-bold text-gray-900 hover:bg-gray-200 dark:bg-gray-800 dark:text-white dark:hover:bg-gray-700"
              >
                Done
              </button>
            </div>
          </>
        )}

        {status === 'error' && (
          <>
            <div className="mb-6 flex h-24 w-24 items-center justify-center rounded-3xl bg-red-100 text-red-600 dark:bg-red-900/30 dark:text-red-500">
              <AlertTriangle size={48} />
            </div>
            <h2 className="mb-4 text-2xl font-bold text-gray-900 dark:text-white">Setup Failed</h2>
            <p className="mb-8 text-red-600 dark:text-red-400">
              {errorMsg}
            </p>
            <button 
              onClick={() => login()}
              className="w-full max-w-xs rounded-xl bg-primary py-4 font-bold text-white shadow-lg transition-transform hover:scale-105 active:scale-95"
            >
              Try Again
            </button>
          </>
        )}
      </div>
    </div>
  );
}
