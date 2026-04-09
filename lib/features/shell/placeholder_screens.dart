import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/core/cloud/cloud_integration_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(child: Text('Splash Screen')),
    );
  }
}

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(child: Text('Onboarding Screen')),
    );
  }
}

class MainShell extends ConsumerWidget {
  final StatefulNavigationShell child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cloudState = ref.watch(cloudIntegrationProvider);

    return Scaffold(
      body: child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (cloudState.isSyncEnabled) _buildSyncBar(context, cloudState),
          BottomNavigationBar(
            currentIndex: child.currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.outline,
            selectedFontSize: 11,
            unselectedFontSize: 10,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center), label: 'Active'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Exercise'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'History'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), label: 'Plan'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.analytics), label: 'Stats'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            onTap: (index) {
              child.goBranch(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSyncBar(BuildContext context, CloudIntegrationState state) {
    String message = 'Synced';
    Color color = Colors.green;
    IconData icon = Icons.check_circle_outline;

    if (state.connectivity == ConnectivityResult.none) {
      message = 'Offline - Sync paused';
      color = Colors.orange;
      icon = Icons.cloud_off;
    } else if (state.pendingSyncCount > 0) {
      message = 'Sync pending (${state.pendingSyncCount} items)';
      color = Colors.blue;
      icon = Icons.sync;
    } else if (state.lastSyncError != null) {
      message = 'Sync Error';
      color = Colors.red;
      icon = Icons.error_outline;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      color: color.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 8),
          Text(
            message,
            style: TextStyle(
                fontSize: 10, color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class WorkoutScreen extends ConsumerWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text('Workout Screen'));
  }
}

class ExerciseLibraryScreen extends ConsumerWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text('Exercise Library Screen'));
  }
}

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text('History Screen'));
  }
}

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text('Analytics Screen'));
  }
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Screen')),
    );
  }
}
