import { createBrowserRouter, Navigate } from 'react-router-dom';
import SplashScreen from '@/features/splash/SplashScreen';
import OnboardingScreen from '@/features/onboarding/OnboardingScreen';
import SetupScreen from '@/features/setup/SetupScreen';
import MainShell from '@/features/shell/MainShell';
import WorkoutScreen from '@/features/workout/WorkoutScreen';
import ActiveWorkoutScreen from '@/features/workout/ActiveWorkoutScreen';
import HistoryScreen from '@/features/history/HistoryScreen';
import WorkoutDetailScreen from '@/features/history/WorkoutDetailScreen';
import ProgramsScreen from '@/features/programs/ProgramsScreen';
import CreateEditProgramScreen from '@/features/programs/CreateEditProgramScreen';
import DayBuilderScreen from '@/features/programs/DayBuilderScreen';
import ImportPreviewScreen from '@/features/programs/ImportPreviewScreen';
import AnalyticsScreen from '@/features/analytics/AnalyticsScreen';
import PRHallOfFameScreen from '@/features/analytics/PRHallOfFameScreen';
import BodyMeasurementsScreen from '@/features/analytics/BodyMeasurementsScreen';
import SettingsScreen from '@/features/settings/SettingsScreen';
import PlatesConfigScreen from '@/features/settings/PlatesConfigScreen';
import AboutScreen from '@/features/settings/AboutScreen';
import SheetsSetupScreen from '@/features/settings/SheetsSetupScreen';
import SyncStatusScreen from '@/features/settings/SyncStatusScreen';
import ExerciseLibraryScreen from '@/features/exercises/ExerciseLibraryScreen';
import ExerciseDetailScreen from '@/features/exercises/ExerciseDetailScreen';
import CreateEditExerciseScreen from '@/features/exercises/CreateEditExerciseScreen';
import ExerciseHistoryScreen from '@/features/exercises/ExerciseHistoryScreen';

export const router = createBrowserRouter([
  {
    path: '/',
    element: <SplashScreen />,
  },
  {
    path: '/onboarding',
    element: <OnboardingScreen />,
  },
  {
    path: '/setup',
    element: <SetupScreen />,
  },
  {
    path: '/app',
    element: <MainShell />,
    children: [
      {
        index: true,
        element: <WorkoutScreen />,
      },
      {
        path: 'exercises',
        element: <ExerciseLibraryScreen />,
      },
      {
        path: 'history',
        element: <HistoryScreen />,
      },
      {
        path: 'programs',
        element: <ProgramsScreen />,
      },
      {
        path: 'analytics',
        element: <AnalyticsScreen />,
      },
      {
        path: 'settings',
        element: <SettingsScreen />,
      },
    ],
  },
  {
    path: '/app/workout/active',
    element: <ActiveWorkoutScreen />,
  },
  {
    path: '/app/history/:id',
    element: <WorkoutDetailScreen />,
  },
  {
    path: '/app/analytics/prs',
    element: <PRHallOfFameScreen />,
  },
  {
    path: '/app/analytics/measurements',
    element: <BodyMeasurementsScreen />,
  },
  {
    path: '/app/settings/plates',
    element: <PlatesConfigScreen />,
  },
  {
    path: '/app/settings/about',
    element: <AboutScreen />,
  },
  {
    path: '/app/settings/sheets-setup',
    element: <SheetsSetupScreen />,
  },
  {
    path: '/app/settings/sync',
    element: <SyncStatusScreen />,
  },
  {
    path: '/app/programs/create',
    element: <CreateEditProgramScreen />,
  },
  {
    path: '/app/programs/:id/edit',
    element: <CreateEditProgramScreen />,
  },
  {
    path: '/app/programs/:programId/day/:dayId',
    element: <DayBuilderScreen />,
  },
  {
    path: '/app/programs/import',
    element: <ImportPreviewScreen />,
  },
  {
    path: '/app/exercises/create',
    element: <CreateEditExerciseScreen />,
  },
  {
    path: '/app/exercises/:id',
    element: <ExerciseDetailScreen />,
  },
  {
    path: '/app/exercises/:id/history',
    element: <ExerciseHistoryScreen />,
  },
  {
    path: '*',
    element: <Navigate to="/" replace />,
  }
]);
