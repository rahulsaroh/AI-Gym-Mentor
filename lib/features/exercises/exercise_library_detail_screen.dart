import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/features/exercises/exercise_repository.dart';
import 'package:drift/drift.dart' as drift;
import 'models/exercise.dart' as model;
import 'repositories/exercise_library_repository.dart';
import 'widgets/exercise_media_widget.dart';

class ExerciseLibraryDetailScreen extends ConsumerWidget {
  final String exerciseId;

  const ExerciseLibraryDetailScreen({super.key, required this.exerciseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(exerciseLibraryRepositoryProvider);
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<model.Exercise?>(
        future: repository.getExerciseById(exerciseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final exercise = snapshot.data;
          if (exercise == null) {
            return const Center(child: Text('Exercise not found', style: TextStyle(color: Colors.white)));
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

  Widget _buildAppBar(BuildContext context, model.Exercise exercise) {
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

  Widget _buildHeader(BuildContext context, model.Exercise exercise) {
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
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoGrid(BuildContext context, model.Exercise exercise) {
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
          _infoRow(LucideIcons.activity, 'Primary Muscles', exercise.primaryMuscles.join(', ')),
          if (exercise.secondaryMuscles.isNotEmpty) ...[
            const Divider(color: Colors.grey),
            _infoRow(LucideIcons.layers, 'Secondary Muscles', exercise.secondaryMuscles.join(', ')),
          ],
          const Divider(color: Colors.grey),
          _infoRow(LucideIcons.cog, 'Mechanic', exercise.mechanic),
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
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildInstructions(BuildContext context, model.Exercise exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'INSTRUCTIONS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        const SizedBox(height: 16),
        ...exercise.instructions.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.blue,
                  child: Text('${entry.key + 1}', style: const TextStyle(fontSize: 12, color: Colors.white)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.value,
                    style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context, WidgetRef ref, model.Exercise exercise) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () => _addToMyExercises(context, ref, exercise),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.blue[600],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: const Icon(LucideIcons.plus),
        label: const Text('ADD TO MY EXERCISES', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<void> _addToMyExercises(BuildContext context, WidgetRef ref, model.Exercise exercise) async {
    final repository = ref.read(exerciseRepositoryProvider);
    
    final companion = ExercisesCompanion.insert(
      name: exercise.name,
      primaryMuscle: exercise.primaryMuscles.isNotEmpty ? exercise.primaryMuscles.first : 'None',
      secondaryMuscle: drift.Value(exercise.secondaryMuscles.isNotEmpty ? exercise.secondaryMuscles.join(', ') : null),
      equipment: exercise.equipment,
      setType: 'Straight',
      instructions: drift.Value(exercise.instructions.join('\n')),
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
          SnackBar(content: Text('Failed to add exercise: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}
