import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/features/workout/workout_screen.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:ai_gym_mentor/features/shell/placeholder_screens.dart'
    hide
        SplashScreen,
        OnboardingScreen,
        WorkoutScreen,
        HistoryScreen,
        SettingsScreen;
import 'package:ai_gym_mentor/features/splash/splash_screen.dart';
import 'package:ai_gym_mentor/features/onboarding/onboarding_screen.dart';
import 'package:ai_gym_mentor/features/setup/setup_screen.dart';
import 'package:ai_gym_mentor/features/onboarding/welcome_back_screen.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/screens/muscle_group_screen.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/screens/exercise_history_screen.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/screens/exercise_detail_screen.dart';
import 'package:ai_gym_mentor/features/workout/active_workout_screen.dart';
import 'package:ai_gym_mentor/features/history/history_screen.dart';
import 'package:ai_gym_mentor/features/history/workout_detail_screen.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_dashboard_screen.dart';
import 'package:ai_gym_mentor/features/analytics/pr_hall_of_fame_screen.dart';
import 'package:ai_gym_mentor/features/analytics/progress_photos_screen.dart';
import 'package:ai_gym_mentor/features/settings/settings_screen.dart';
import 'package:ai_gym_mentor/features/settings/plates_config_screen.dart';
import 'package:ai_gym_mentor/features/settings/about_screen.dart';
import 'package:ai_gym_mentor/features/programs/programs_screen.dart';
import 'package:ai_gym_mentor/features/programs/create_edit_program_screen.dart';
import 'package:ai_gym_mentor/features/programs/program_details_screen.dart';
import 'package:ai_gym_mentor/features/programs/mesocycle_wizard_screen.dart';
import 'package:ai_gym_mentor/features/programs/mesocycle_details_screen.dart';
import 'package:ai_gym_mentor/features/workout/start_workout_screen.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/screens/github_exercise_library_screen.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/screens/year_in_review_screen.dart';
import 'package:ai_gym_mentor/features/bodymap/screens/body_scan_screen.dart';

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
      path: '/welcome-back',
      builder: (context, state) {
        final path = state.uri.queryParameters['path'] ?? '';
        return WelcomeBackScreen(filePath: path);
      },
    ),
    GoRoute(
      path: '/active-workout',
      builder: (context, state) => const StartWorkoutScreen(),
    ),
    GoRoute(
      path: '/app/workout/active',
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
    // Exercise library — accessible via push from Settings or anywhere, not a bottom tab
    GoRoute(
      path: '/exercises',
      builder: (context, state) => const GithubExerciseLibraryScreen(),
      routes: [
        GoRoute(
          path: 'muscle-groups',
          builder: (context, state) => const MuscleGroupScreen(),
        ),
        GoRoute(
          path: 'create',
          builder: (context, state) => ExerciseDetailScreen(
              exerciseId: 0, templateExercise: state.extra as ExerciseEntity?),
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
            final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
            return ExerciseDetailScreen(exerciseId: id, isEditing: true);
          },
        ),
        GoRoute(
          path: 'history/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
            return ExerciseHistoryScreen(exerciseId: id);
          },
        ),
      ],
    ),
    // GitHub Exercise Library
    GoRoute(
      path: '/exercise-library',
      builder: (context, state) => const GithubExerciseLibraryScreen(),
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
              routes: [
                GoRoute(
                  path: 'details/:id',
                  builder: (context, state) {
                    final idStr = state.pathParameters['id'];
                    final id = int.tryParse(idStr ?? '0') ?? 0;
                    return ProgramDetailScreen(templateId: id);
                  },
                ),
                GoRoute(
                  path: 'create',
                  builder: (context, state) => const CreateEditProgramScreen(),
                ),
                GoRoute(
                  path: 'edit/:id',
                  builder: (context, state) {
                    final id =
                        int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
                    return CreateEditProgramScreen(templateId: id);
                  },
                ),
                GoRoute(
                  path: 'mesocycle/create',
                  builder: (context, state) => const MesocycleWizardScreen(),
                ),
                GoRoute(
                  path: 'mesocycle/:id',
                  builder: (context, state) {
                    final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
                    return MesocycleDetailsScreen(mesocycleId: id);
                  },
                ),

              ],
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
                  redirect: (context, state) => '/analytics',
                ),
                GoRoute(
                  path: 'photos',
                  builder: (context, state) => const ProgressPhotosScreen(),
                ),
                GoRoute(
                  path: 'bodymap',
                  builder: (context, state) => const BodyScanScreen(),
                ),
                GoRoute(
                  path: 'year-in-review/:year',
                  builder: (context, state) {
                    final year = int.tryParse(state.pathParameters['year'] ?? '') ?? DateTime.now().year;
                    return YearInReviewScreen(initialYear: year);
                  },
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
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
