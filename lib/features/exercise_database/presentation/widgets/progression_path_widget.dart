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

    return Column(
      children: chain.asMap().entries.map((entry) {
        final index = entry.key;
        final ex = entry.value;
        final isCurrent = ex.id.toString() == currentExerciseId;
        final isLast = index == chain.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timeline Column
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: isCurrent 
                          ? Theme.of(context).colorScheme.primary 
                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                        shape: BoxShape.circle,
                        boxShadow: isCurrent ? [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ] : null,
                        border: Border.all(
                          color: isCurrent 
                            ? Theme.of(context).colorScheme.primary 
                            : Theme.of(context).colorScheme.outlineVariant,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isCurrent 
                              ? Colors.white 
                              : Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                isCurrent ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outlineVariant,
                                Theme.of(context).colorScheme.outlineVariant,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Content Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: InkWell(
                    onTap: isCurrent ? null : () => context.pushReplacement('/exercises/${ex.id}'),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isCurrent 
                          ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.05) 
                          : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isCurrent 
                            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2) 
                            : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ex.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                                    color: isCurrent 
                                      ? Theme.of(context).colorScheme.primary 
                                      : Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  ex.difficulty.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isCurrent)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'CURRENT',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
