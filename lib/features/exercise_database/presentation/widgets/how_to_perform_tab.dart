import 'package:flutter/material.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/widgets/instruction_step_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Complete "How to Perform" tab widget for exercise details.
///
/// Displays a scrollable list of numbered instruction steps with:
/// - Numbered circles with step numbers
/// - Instruction text with good readability
/// - Vertical spacing between steps
/// - Placeholder when no instructions available
/// - Pure Flutter implementation (no external packages)
///
/// Usage in ExerciseDetailScreen:
/// ```dart
/// TabBarView(
///   controller: _tabController,
///   children: [
///     _buildOverviewTab(exercise),
///     HowToPerformTab(exercise: exercise),  // Use this directly
///     _buildProgressTab(exercise),
///   ],
/// )
/// ```
class HowToPerformTab extends StatelessWidget {
  final ExerciseEntity exercise;

  const HowToPerformTab({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    final hasInstructions = exercise.instructions.isNotEmpty;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        child: hasInstructions
            ? _buildInstructionsList(context)
            : _buildEmptyPlaceholder(context),
      ),
    );
  }

  /// Build the list of numbered instruction steps
  Widget _buildInstructionsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: exercise.instructions.asMap().entries.map((entry) {
        final stepNumber = entry.key + 1;
        final instruction = entry.value;
        final isLast = stepNumber == exercise.instructions.length;

        return InstructionStepWidget(
          stepNumber: stepNumber,
          instruction: instruction,
          isLast: isLast,
        );
      }).toList(),
    );
  }

  /// Build empty state placeholder
  Widget _buildEmptyPlaceholder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 40),
        Icon(
          LucideIcons.infoIcon,
          size: 48,
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
        ),
        const SizedBox(height: 16),
        Text(
          'No instructions available',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Check back soon or try a similar exercise',
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
