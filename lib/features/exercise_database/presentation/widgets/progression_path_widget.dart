import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';

class ProgressionPathWidget extends StatelessWidget {
  final List<ExerciseEntity> chain;
  final String currentExerciseId;

  const ProgressionPathWidget({
    super.key,
    required this.chain,
    required this.currentExerciseId,
  });

  @override
  Widget build(BuildContext context) {
    if (chain.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: Row(
        children: chain.asMap().entries.map((entry) {
          final index = entry.key;
          final ex = entry.value;
          final isCurrent = ex.id == currentExerciseId;
          final isLast = index == chain.length - 1;

          return Row(
            children: [
              _buildNode(context, ex, isCurrent),
              if (!isLast) _buildConnector(context),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNode(BuildContext context, ExerciseEntity ex, bool isCurrent) {
    return GestureDetector(
      onTap: isCurrent ? null : () => context.pushReplacement('/exercises/${ex.id}'),
      child: SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCurrent 
                  ? Theme.of(context).colorScheme.primary 
                  : Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCurrent 
                    ? Theme.of(context).colorScheme.primary 
                    : Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
              ),
              child: Icon(
                isCurrent ? Icons.fitness_center : Icons.circle,
                size: 20,
                color: isCurrent ? Colors.white : Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              ex.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                color: isCurrent 
                  ? Theme.of(context).colorScheme.primary 
                  : Theme.of(context).colorScheme.onSurface,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnector(BuildContext context) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.only(bottom: 40), // Align with circles
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
    );
  }
}
