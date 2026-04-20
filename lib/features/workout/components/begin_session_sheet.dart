import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';
import 'package:ai_gym_mentor/features/workout/components/instant_workout_generator_sheet.dart';
import 'package:ai_gym_mentor/features/workout/workout_providers.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:ai_gym_mentor/core/domain/entities/workout_program.dart';
import 'package:ai_gym_mentor/core/domain/entities/workout_session.dart';

class BeginSessionSheet extends ConsumerWidget {
  const BeginSessionSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(workoutHomeProvider);
    final templatesAsync = ref.watch(workoutTemplatesProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Begin Session',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(LucideIcons.x),
                style: IconButton.styleFrom(
                  backgroundColor:
                      colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 1. Active / Resume Session
          homeState.when(
            data: (state) {
              if (state.activeDraft != null) {
                return _ResumeCard(workout: state.activeDraft!);
              }
              return const SizedBox.shrink();
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: 16),

          // 2. My Programs
          Text(
            'MY PROGRAMS',
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: templatesAsync.when(
              data: (templates) {
                if (templates.isEmpty) {
                  return _EmptyTemplatesPlaceholder();
                }
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: templates.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => _ProgramCard(
                    template: templates[index],
                    onSelect: () =>
                        _startTemplateWorkout(context, ref, templates[index]),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('Error loading templates: $err'),
            ),
          ),

          const SizedBox(height: 32),

          // 2.5 AI Generator
          _AiMagicCard(),

          const SizedBox(height: 32),

          // 3. Quick Actions
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _startEmptyWorkout(context, ref),
                  icon: const Icon(LucideIcons.plus, size: 20),
                  label: const Text('START EMPTY'),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/programs');
                  },
                  icon: const Icon(LucideIcons.layers, size: 20),
                  label: const Text('EXPLORE'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> _startTemplateWorkout(
      BuildContext context, WidgetRef ref, WorkoutProgram template) async {
    final repo = ref.read(workoutRepositoryProvider);
    final days = await repo.getTemplateDays(template.id);
    
    if (days.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This program has no days defined.')),
        );
      }
      return;
    }

    int? selectedDayId;

    if (days.length == 1) {
      selectedDayId = days.first.id;
    } else {
      // Show day picker dialog
      if (context.mounted) {
        selectedDayId = await showDialog<int>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Select Day', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  return ListTile(
                    title: Text(day.name, style: GoogleFonts.outfit()),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: Text('${index + 1}', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () => Navigator.pop(context, day.id),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CANCEL'),
              ),
            ],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        );
      }
    }

    if (selectedDayId == null) return;

    final id = await ref.read(workoutHomeProvider.notifier).startWorkout(
          templateId: template.id,
          dayId: selectedDayId,
          name: '${template.name} - ${days.firstWhere((d) => d.id == selectedDayId).name}',
        );

    if (context.mounted) {
      final router = GoRouter.of(context);
      Navigator.pop(context); // Close sheet after creation
      router.push('/app/workout/active?id=$id&dayId=$selectedDayId');
    }
  }


  Future<void> _startEmptyWorkout(BuildContext context, WidgetRef ref) async {
    final id =
        await ref.read(workoutHomeProvider.notifier).startWorkout(
              name: 'Quick Workout',
            );
    if (context.mounted) {
      final router = GoRouter.of(context);
      Navigator.pop(context); // Close sheet AFTER creation
      router.push('/app/workout/active?id=$id');
    }
  }
}

class _ResumeCard extends StatelessWidget {
  final WorkoutSession workout;
  const _ResumeCard({required this.workout});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        final router = GoRouter.of(context);
        Navigator.pop(context);
        router.push('/app/workout/active?id=${workout.id}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(LucideIcons.play, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CONTINUE SESSION',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.primary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    workout.name,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final WorkoutProgram template;
  final VoidCallback onSelect;

  const _ProgramCard({required this.template, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.secondary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(LucideIcons.clipboardList,
                  color: colorScheme.secondary, size: 18),
            ),
            const Spacer(),
            Text(
              template.name,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '${template.description?.take(20) ?? "No description"}...',
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyTemplatesPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            style: BorderStyle.none),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.circlePlus, color: colorScheme.outline, size: 32),
          const SizedBox(height: 8),
          Text(
            'No programs yet',
            style: TextStyle(
                color: colorScheme.outline, fontWeight: FontWeight.bold),
          ),
          Text(
            'Create one from templates',
            style: TextStyle(color: colorScheme.outline, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _AiMagicCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const InstantWorkoutGeneratorSheet(),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary.withValues(alpha: 0.1),
              colorScheme.tertiary.withValues(alpha: 0.1)
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.2),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.sparkles, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI MAGIC GENERATOR',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: colorScheme.primary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Create a personalized workout in seconds',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight, color: colorScheme.primary, size: 24),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String take(int n) => length <= n ? this : substring(0, n);
}
