import 'package:flutter/material.dart';
import '../../../core/domain/models/muscle_heat_data.dart';

class MuscleDetailSheet extends StatelessWidget {
  final String muscle;
  final MuscleHeatData data;

  const MuscleDetailSheet({
    super.key,
    required this.muscle,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                muscle.toUpperCase(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
              ),
              const Spacer(),
              _buildStatusChip(context),
            ],
          ),
          const SizedBox(height: 24),
          _buildStatRow(
            context,
            Icons.fitness_center,
            '7-Day Volume',
            '${data.volumeKg.toStringAsFixed(0)} kg',
          ),
          const SizedBox(height: 16),
          _buildStatRow(
            context,
            Icons.flash_on,
            'Soreness Level',
            '${(data.domsScore * 100).toInt()}%',
          ),
          if (data.domsScore > 0.5) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.orange),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This muscle may still be recovering. Consider lighter work today.',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    final bool isHighlyActive = data.normalizedLoad > 0.7;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isHighlyActive
            ? Colors.red.withOpacity(0.1)
            : Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlyActive
              ? Colors.red.withOpacity(0.3)
              : Colors.green.withOpacity(0.3),
        ),
      ),
      child: Text(
        isHighlyActive ? 'HIGH ACTIVITY' : 'OPTIMAL',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isHighlyActive ? Colors.red : Colors.green,
        ),
      ),
    );
  }

  Widget _buildStatRow(
      BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).primaryColor),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(color: Colors.white70)),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
