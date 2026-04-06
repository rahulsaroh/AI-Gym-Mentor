import {StrictMode} from 'react';
import {createRoot} from 'react-dom/client';
import App from './App.tsx';
import './index.css';
import { seedDatabase } from './database/seed';
import { GoogleOAuthProvider } from '@react-oauth/google';

/**
 * PREREQUISITES: Google Sign-In & Google Sheets API
 * 1. Go to Google Cloud Console (https://console.cloud.google.com/)
 * 2. Create a new project or select an existing one.
 * 3. Enable the "Google Sheets API" and "Google Drive API".
 * 4. Go to APIs & Services > Credentials.
 * 5. Create Credentials > OAuth client ID.
 * 6. Application type: Web application.
 * 7. Add Authorized JavaScript origins: The URL of this app.
 * 8. Add Authorized redirect URIs: <APP_URL>
 * 9. Copy the Client ID and set it as VITE_GOOGLE_CLIENT_ID in your .env file.
 */

const GOOGLE_CLIENT_ID = import.meta.env.VITE_GOOGLE_CLIENT_ID || 'YOUR_GOOGLE_CLIENT_ID';

seedDatabase().then(() => {
  createRoot(document.getElementById('root')!).render(
    <StrictMode>
      <GoogleOAuthProvider clientId={GOOGLE_CLIENT_ID}>
        <App />
      </GoogleOAuthProvider>
    </StrictMode>,
  );
});
