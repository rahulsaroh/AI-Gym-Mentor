import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:ai_gym_mentor/core/domain/entities/workout_program.dart' as ent;
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';

class ProgramDetailScreen extends ConsumerWidget {
  final int templateId;

  const ProgramDetailScreen({super.key, required this.templateId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<ent.WorkoutProgram>>(
        future: ref.read(workoutRepositoryProvider).getAllTemplates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final program = snapshot.data?.firstWhere((t) => t.id == templateId, 
            orElse: () => throw Exception('Program not found'));
          
          if (program == null) return const Center(child: Text('Program not found'));

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  _buildAppBar(context, program),
                  _buildHeader(context, program),
                  _buildOverview(context, program),
                  _buildSchedule(context, ref, program),
                  const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
                ],
              ),
              _buildBottomButton(context, ref, program),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ent.WorkoutProgram program) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.orange[800],
      leading: IconButton(
        icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
        onPressed: () => context.pop(),
        style: IconButton.styleFrom(backgroundColor: Colors.black26),
      ),
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.sparkles, color: Colors.white),
          onPressed: () {},
          style: IconButton.styleFrom(backgroundColor: Colors.black26),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange[900]!, Colors.orange[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Opacity(
              opacity: 0.2,
              child: Icon(LucideIcons.dumbbell, size: 80, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ent.WorkoutProgram program) {
    final duration = (program as dynamic).duration?.toString() ?? '12 Weeks';
    final goal = (program as dynamic).goal?.toString() ?? 'Aesthetics';

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    program.name,
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.orange[100]!),
                  ),
                  child: Text(
                    duration,
                    style: GoogleFonts.outfit(
                      color: Colors.orange[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                _tag(goal),
                _tag('Muscle Gain'),
                _tag('Strength'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          color: Colors.grey[600],
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildOverview(BuildContext context, ent.WorkoutProgram program) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              program.description ?? 'A comprehensive strength building program designed for peak performance.',
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchedule(BuildContext context, WidgetRef ref, ent.WorkoutProgram program) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plan Schedule',
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey[100]!),
              ),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  'Week 1',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[800],
                  ),
                ),
                trailing: Icon(LucideIcons.chevronUp, color: Colors.teal[900]),
                children: program.days.map((day) => _buildDayItem(context, ref, day, program.name)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayItem(BuildContext context, WidgetRef ref, ent.ProgramDay day, String programName) {
    final muscleGroups = _deriveMuscleGroups(day);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Day ${day.order + 1}',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      muscleGroups,
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[700],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(LucideIcons.play, size: 20, color: Colors.green),
                    onPressed: () => _showStartDayConfirm(context, ref, day, programName),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.green.withOpacity(0.1),
                      padding: const EdgeInsets.all(4),
                    ),
                    constraints: const BoxConstraints(),
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Start this day',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...day.exercises.map((ex) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(LucideIcons.circleCheckBig, size: 18, color: Colors.orange[300]),
                const SizedBox(width: 12),
                Text(
                  ex.exercise.name,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  String _deriveMuscleGroups(ent.ProgramDay day) {
    if (day.exercises.isEmpty) return 'Rest Day';
    final muscles = day.exercises.map((e) => e.exercise.primaryMuscles.firstOrNull ?? "Other").toSet().toList();
    if (muscles.length > 2) return '${muscles[0]} & More';
    return muscles.join(' & ');
  }

  Widget _buildBottomButton(BuildContext context, WidgetRef ref, ent.WorkoutProgram program) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () async {
              final repo = ref.read(workoutRepositoryProvider);
              final days = await repo.getTemplateDays(templateId);
              if (days.isNotEmpty && context.mounted) {
                final id = await ref.read(workoutHomeProvider.notifier).startWorkout(
                  templateId: templateId,
                  dayId: days.first.id,
                  name: program.name,
                );
                if (context.mounted) {
                  context.push('/app/workout/active?id=$id&dayId=${days.first.id}');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[700],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Text(
              'Start Default Schedule',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showStartDayConfirm(BuildContext context, WidgetRef ref, ent.ProgramDay day, String programName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Start ${day.name}?'),
        content: Text('Do you want to start this specific workout session now?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final id = await ref.read(workoutHomeProvider.notifier).startWorkout(
                templateId: day.templateId,
                dayId: day.id,
                name: programName,
              );
              if (context.mounted) {
                context.push('/app/workout/active?id=$id&dayId=${day.id}');
              }
            },
            child: const Text('Start Now', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
