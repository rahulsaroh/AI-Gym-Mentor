import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';

class StartWorkoutScreen extends ConsumerWidget {
  const StartWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(workoutHomeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Start Workout',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        leading: IconButton(
            icon: const Icon(LucideIcons.x), onPressed: () => context.pop()),
      ),
      body: homeState.when(
        data: (state) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildOptionCard(
              context: context,
              icon: LucideIcons.zap,
              title: 'Quick Start',
              subtitle: 'Start an empty workout',
              color: Colors.green,
              onTap: () async {
                final id = await ref
                    .read(workoutHomeNotifierProvider.notifier)
                    .startWorkout(
                      name: 'Quick Workout',
                    );
                if (context.mounted) {
                  context.push('/app/workout/active?id=$id');
                }
              },
            ),
            const SizedBox(height: 16),
            if (state.templateId != null && !state.isRestDay) ...[
              _buildOptionCard(
                context: context,
                icon: LucideIcons.calendar,
                title: "Today's Plan",
                subtitle:
                    state.todayDayName ?? 'Start today\'s planned workout',
                color: Colors.blue,
                onTap: () async {
                  final id = await ref
                      .read(workoutHomeNotifierProvider.notifier)
                      .startWorkout(
                        templateId: state.templateId,
                        dayId: state.nextDayId,
                        name: state.todayDayName ?? 'Today\'s Workout',
                      );
                  if (context.mounted) {
                    context.push(
                        '/app/workout/active?id=$id&dayId=${state.nextDayId}');
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
            _buildOptionCard(
              context: context,
              icon: LucideIcons.refreshCw,
              title: 'Resume Draft',
              subtitle: state.activeDraft != null
                  ? 'Continue: ${state.activeDraft!.name}'
                  : 'No draft workouts',
              color: Colors.orange,
              enabled: state.activeDraft != null,
              onTap: state.activeDraft != null
                  ? () => context
                      .push('/app/workout/active?id=${state.activeDraft!.id}')
                  : null,
            ),
            const SizedBox(height: 16),
            _buildOptionCard(
              context: context,
              icon: LucideIcons.copy,
              title: 'From Template',
              subtitle: 'Choose from your programs',
              color: Colors.purple,
              onTap: () => context.push('/programs'),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback? onTap,
    bool enabled = true,
  }) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.withOpacity(0.3)),
        ),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(subtitle,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: 14)),
                    ],
                  ),
                ),
                Icon(LucideIcons.chevronRight,
                    color: Theme.of(context).colorScheme.outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
