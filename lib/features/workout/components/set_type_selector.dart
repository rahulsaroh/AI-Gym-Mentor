import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/core/database/database.dart';

class SetTypeSelector extends StatelessWidget {
  final SetType currentType;
  final Function(SetType) onSelect;

  const SetTypeSelector({
    super.key,
    required this.currentType,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            'Select Set Type',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Changes apply to all future sets for this exercise',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildTypeCard(
                  context,
                  type: SetType.straight,
                  icon: LucideIcons.activity,
                  title: 'Straight Set',
                  desc: 'Standard set with target weight and reps.',
                  example: '3 sets of 10 @ 80kg',
                ),
                _buildTypeCard(
                  context,
                  type: SetType.warmup,
                  icon: LucideIcons.flame,
                  title: 'Warmup Set',
                  desc: 'Low intensity set to prepare for working sets.',
                  example: '15 reps @ 20kg (Barbell only)',
                ),
                _buildTypeCard(
                  context,
                  type: SetType.dropSet,
                  icon: LucideIcons.arrowDownWideNarrow,
                  title: 'Drop Set',
                  desc:
                      'Perform a set, then immediately drop weight and continue.',
                  example: '80kg x 8 -> 60kg x 10 -> 40kg x 12',
                ),
                _buildTypeCard(
                  context,
                  type: SetType.amrap,
                  icon: LucideIcons.infinity,
                  title: 'AMRAP',
                  desc: 'As Many Reps As Possible. Push to failure.',
                  example: 'Target: 10+. Achieved: 14',
                ),
                _buildTypeCard(
                  context,
                  type: SetType.timed,
                  icon: LucideIcons.timer,
                  title: 'Timed Set',
                  desc: 'Hold a position or perform for a fixed duration.',
                  example: 'Plank for 60 seconds',
                ),
                _buildTypeCard(
                  context,
                  type: SetType.restPause,
                  icon: LucideIcons.circlePause,
                  title: 'Rest-Pause',
                  desc:
                      'Short breaks (10-15s) between mini-sets to hit high reps.',
                  example: '15 total reps (8 + 4 + 3)',
                ),
                _buildTypeCard(
                  context,
                  type: SetType.cluster,
                  icon: LucideIcons.layers,
                  title: 'Cluster Set',
                  desc: 'Intra-set rest periods for heavy weight safety.',
                  example: '3 clusters of 2 reps with 15s rest',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeCard(
    BuildContext context, {
    required SetType type,
    required IconData icon,
    required String title,
    required String desc,
    required String example,
  }) {
    final isSelected = currentType == type;
    final color =
        isSelected ? Theme.of(context).primaryColor : Colors.transparent;

    return GestureDetector(
      onTap: () {
        onSelect(type);
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected ? color.withOpacity(0.1) : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey[800]!,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.grey[800]!.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon,
                  color: isSelected ? Colors.white : Colors.grey[400],
                  size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isSelected ? color : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 13, color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'E.g. $example',
                    style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: color.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(LucideIcons.circleCheck,
                  color: Colors.green, size: 20),
          ],
        ),
      ),
    );
  }
}
