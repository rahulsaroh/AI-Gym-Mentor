import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/features/workout/workout_screen.dart';
import 'package:ai_gym_mentor/features/shell/placeholder_screens.dart'
    hide
        SplashScreen,
        OnboardingScreen,
        ExerciseLibraryScreen,
        WorkoutScreen,
        HistoryScreen,
        SettingsScreen;
import 'package:ai_gym_mentor/features/splash/splash_screen.dart';
import 'package:ai_gym_mentor/features/onboarding/onboarding_screen.dart';
import 'package:ai_gym_mentor/features/setup/setup_screen.dart';
import 'package:ai_gym_mentor/features/exercises/exercises_screen.dart';
import 'package:ai_gym_mentor/features/workout/active_workout_screen.dart';
import 'package:ai_gym_mentor/features/history/history_screen.dart';
import 'package:ai_gym_mentor/features/history/workout_detail_screen.dart';
import 'package:ai_gym_mentor/features/exercises/exercise_history_screen.dart';
import 'package:ai_gym_mentor/features/exercises/exercise_detail_screen.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_dashboard_screen.dart';
import 'package:ai_gym_mentor/features/analytics/pr_hall_of_fame_screen.dart';
import 'package:ai_gym_mentor/features/analytics/body_measurements_screen.dart';
import 'package:ai_gym_mentor/features/settings/settings_screen.dart';
import 'package:ai_gym_mentor/features/settings/plates_config_screen.dart';
import 'package:ai_gym_mentor/features/settings/about_screen.dart';
import 'package:ai_gym_mentor/features/settings/sheets_setup_screen.dart';
import 'package:ai_gym_mentor/features/programs/programs_screen.dart';
import 'package:ai_gym_mentor/features/programs/create_edit_program_screen.dart';
import 'package:ai_gym_mentor/features/workout/start_workout_screen.dart';
import 'package:ai_gym_mentor/features/settings/sync_log_screen.dart';
import 'package:ai_gym_mentor/features/exercises/exercise_library_screen.dart';
import 'package:ai_gym_mentor/features/exercises/exercise_library_detail_screen.dart';
import 'package:ai_gym_mentor/features/ai_mentor/ai_mentor_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/setup',
      builder: (context, state) => const SetupScreen(),
    ),
    GoRoute(
      path: '/active-workout',
      builder: (context, state) => const StartWorkoutScreen(),
    ),
    GoRoute(
      path: '/programs/create',
      builder: (context, state) => const CreateEditProgramScreen(),
    ),
    GoRoute(
      path: '/programs/edit/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return CreateEditProgramScreen(templateId: id);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(child: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/app',
              builder: (context, state) => const WorkoutHomeScreen(),
              routes: [
                GoRoute(
                  path: 'workout/active',
                  builder: (context, state) {
                    final idStr = state.uri.queryParameters['id'];
                    if (idStr == null) {
                      return const Scaffold(
                          body: Center(child: Text('Invalid workout ID')));
                    }
                    final id = int.tryParse(idStr) ?? 0;
                    final dayId = state.uri.queryParameters['dayId'] != null
                        ? int.tryParse(state.uri.queryParameters['dayId']!)
                        : null;
                    return ActiveWorkoutScreen(workoutId: id, dayId: dayId);
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/ai-mentor',
              builder: (context, state) => const AiMentorScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/exercises',
              builder: (context, state) => const ExercisesScreen(),
              routes: [
                GoRoute(
                  path: 'create',
                  builder: (context, state) =>
                      const ExerciseDetailScreen(exerciseId: 0),
                ),
                GoRoute(
                  path: ':id',
                  builder: (context, state) {
                    final idStr = state.pathParameters['id'];
                    if (idStr == 'create') {
                      return const ExerciseDetailScreen(exerciseId: 0);
                    }
                    final id = int.tryParse(idStr ?? '0') ?? 0;
                    return ExerciseDetailScreen(exerciseId: id);
                  },
                ),
                GoRoute(
                  path: ':id/edit',
                  builder: (context, state) {
                    final id =
                        int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
                    return ExerciseDetailScreen(
                        exerciseId: id, isEditing: true);
                  },
                ),
                GoRoute(
                  path: 'history/:id',
                  builder: (context, state) {
                    final id =
                        int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
                    return ExerciseHistoryScreen(exerciseId: id);
                  },
                ),
                GoRoute(
                  path: 'library',
                  builder: (context, state) => const ExerciseLibraryScreen(),
                  routes: [
                    GoRoute(
                      path: ':id',
                      builder: (context, state) {
                        final id = state.pathParameters['id'] ?? '';
                        return ExerciseLibraryDetailScreen(exerciseId: id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/history',
              builder: (context, state) => const HistoryScreen(),
              routes: [
                GoRoute(
                  path: 'workout/:id',
                  builder: (context, state) {
                    final id =
                        int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
                    return WorkoutDetailScreen(workoutId: id);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/programs',
              builder: (context, state) => const ProgramsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/analytics',
              builder: (context, state) => const AnalyticsDashboardScreen(),
              routes: [
                GoRoute(
                  path: 'prs',
                  builder: (context, state) => const PRHallOfFameScreen(),
                ),
                GoRoute(
                  path: 'measurements',
                  builder: (context, state) => const BodyMeasurementsScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: 'plates',
                  builder: (context, state) => const PlatesConfigScreen(),
                ),
                GoRoute(
                  path: 'about',
                  builder: (context, state) => const AboutScreen(),
                ),
                GoRoute(
                  path: 'setup-sheets',
                  builder: (context, state) => const SheetsSetupScreen(),
                ),
                GoRoute(
                  path: 'sheets-success',
                  builder: (context, state) {
                    final id = state.extra as String;
                    return SheetsSuccessScreen(spreadsheetId: id);
                  },
                ),
                GoRoute(
                  path: 'sync-log',
                  builder: (context, state) => const SyncLogScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
