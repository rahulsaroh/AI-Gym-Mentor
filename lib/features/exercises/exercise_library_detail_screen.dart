import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/domain/entities/exercise.dart' as ent;
import 'package:ai_gym_mentor/features/exercises/exercise_repository.dart';
import 'package:drift/drift.dart' as drift;
import 'repositories/exercise_library_repository.dart';
import 'widgets/exercise_media_widget.dart';

class ExerciseLibraryDetailScreen extends ConsumerWidget {
  final String exerciseId;

  const ExerciseLibraryDetailScreen({super.key, required this.exerciseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(exerciseLibraryRepositoryProvider);
    final id = int.tryParse(exerciseId) ?? 0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<ent.Exercise?>(
        future: repository.getExerciseById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final exercise = snapshot.data;
          if (exercise == null) {
            return const Center(
                child: Text('Exercise not found',
                    style: TextStyle(color: Colors.white)));
          }

          return CustomScrollView(
            slivers: [
              _buildAppBar(context, exercise),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context, exercise),
                      const SizedBox(height: 24),
                      _buildInfoGrid(context, exercise),
                      const SizedBox(height: 32),
                      _buildInstructions(context, exercise),
                      const SizedBox(height: 48),
                      _buildAddButton(context, ref, exercise),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ent.Exercise exercise) {
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        background: ExerciseMediaWidget(
          animatedUrl: exercise.gifUrl,
          staticUrl: exercise.imageUrl,
          videoUrl: exercise.videoUrl,
          height: 350,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ent.Exercise exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercise.name.toUpperCase(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _badge(exercise.category, Colors.blue),
            const SizedBox(width: 8),
            _badge(exercise.difficulty, Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        text,
        style:
            TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoGrid(BuildContext context, ent.Exercise exercise) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _infoRow(LucideIcons.dumbbell, 'Equipment', exercise.equipment),
          const Divider(color: Colors.grey),
          _infoRow(LucideIcons.activity, 'Primary Muscle', exercise.primaryMuscle),
          if (exercise.secondaryMuscle != null) ...[
            const Divider(color: Colors.grey),
            _infoRow(LucideIcons.layers, 'Secondary Muscle', exercise.secondaryMuscle!),
          ],
          const Divider(color: Colors.grey),
          _infoRow(LucideIcons.settings, 'Mechanic', exercise.mechanic ?? 'Unknown'),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildInstructions(BuildContext context, ent.Exercise exercise) {
    final instructions = exercise.instructions ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'INSTRUCTIONS',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1),
        ),
        const SizedBox(height: 16),
        if (instructions.isEmpty)
          const Text('No instructions available.', style: TextStyle(color: Colors.grey)),
        ...instructions.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.blue,
                  child: Text('${entry.key + 1}',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.white)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.value,
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 14, height: 1.5),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildAddButton(
      BuildContext context, WidgetRef ref, ent.Exercise exercise) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () => _addToMyExercises(context, ref, exercise),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.blue[600],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: const Icon(LucideIcons.plus),
        label: const Text('ADD TO MY EXERCISES',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<void> _addToMyExercises(
      BuildContext context, WidgetRef ref, ent.Exercise exercise) async {
    final repository = ref.read(exerciseRepositoryProvider);

    final companion = ExercisesCompanion.insert(
      name: exercise.name,
      primaryMuscle: exercise.primaryMuscle,
      secondaryMuscle: drift.Value(exercise.secondaryMuscle),
      equipment: exercise.equipment,
      setType: exercise.setType,
      instructions: drift.Value(exercise.instructions?.join('|')),
      description: drift.Value(exercise.description),
      category: drift.Value(exercise.category),
      difficulty: drift.Value(exercise.difficulty),
      gifUrl: drift.Value(exercise.gifUrl),
      imageUrl: drift.Value(exercise.imageUrl),
      videoUrl: drift.Value(exercise.videoUrl),
      mechanic: drift.Value(exercise.mechanic),
      force: drift.Value(exercise.force),
      source: drift.Value(exercise.source),
      isCustom: const drift.Value(false),
    );

    try {
      await repository.saveExercise(companion);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${exercise.name} added to your workspace'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to add exercise: $e'),
              backgroundColor: Colors.red),
        );
      }
    }
  }
}
