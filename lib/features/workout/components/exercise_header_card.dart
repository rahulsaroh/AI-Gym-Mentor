import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart' as entity;
import 'package:ai_gym_mentor/features/exercise_database/presentation/widgets/exercise_media_widget.dart';
import 'package:ai_gym_mentor/features/workout/models/workout_models.dart';

class ExerciseHeaderCard extends StatelessWidget {
  final entity.ExerciseEntity exercise;
  final VoidCallback onMenuTap;
  final bool isGlowing;
  final double glowValue;

  const ExerciseHeaderCard({
    super.key,
    required this.exercise,
    required this.onMenuTap,
    this.isGlowing = false,
    this.glowValue = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (isGlowing)
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              blurRadius: 20 * glowValue,
              spreadRadius: 4 * glowValue,
            ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exercise Media
              SizedBox(
                height: 220,
                width: double.infinity,
                child: ExerciseMediaWidget(
                  animatedUrl: exercise.gifUrl,
                  staticUrl: exercise.imageUrls.isNotEmpty ? exercise.imageUrls.first : null,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise.name,
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              ...exercise.primaryMuscles.map((m) => _buildPillBadge(context, m, Colors.blue)),
                              ...exercise.secondaryMuscles.map((m) => _buildPillBadge(context, m, Colors.blue.withOpacity(0.5))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      children: [
                        Material(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => context.push('/exercises/${exercise.id}'),
                            child: Container(
                              width: 48,
                              height: 48,
                              alignment: Alignment.center,
                              child: Icon(LucideIcons.info, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), size: 24),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Info',
                          style: GoogleFonts.inter(fontSize: 10, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 12,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.onSurface, size: 24),
              onPressed: onMenuTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillBadge(BuildContext context, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4), width: 0.5),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
