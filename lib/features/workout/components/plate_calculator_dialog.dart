import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PlateCalculatorDialog extends StatelessWidget {
  final double targetWeight;
  final double barWeight;

  const PlateCalculatorDialog({
    super.key,
    required this.targetWeight,
    this.barWeight = 20.0,
  });

  static const List<double> availablePlates = [25.0, 20.0, 15.0, 10.0, 5.0, 2.5, 1.25];

  @override
  Widget build(BuildContext context) {
    final weightPerSide = (targetWeight - barWeight) / 2;
    final List<Map<String, dynamic>> platesNeeded = [];
    double remaining = weightPerSide;

    if (weightPerSide > 0) {
      for (final plate in availablePlates) {
        if (remaining >= plate) {
          final count = (remaining / plate).floor();
          platesNeeded.add({'weight': plate, 'count': count});
          remaining -= count * plate;
        }
      }
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Plate Calculator',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(LucideIcons.x),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Text('Target Weight', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  '${targetWeight.toStringAsFixed(1)} kg',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                Text('Bar: ${barWeight.toStringAsFixed(1)} kg',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 24),
            if (weightPerSide > 0) ...[
              Text(
                'Per Side: ${weightPerSide.toStringAsFixed(2)} kg',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 40,
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                      ),
                      const SizedBox(width: 4),
                      ...platesNeeded.expand((p) {
                        return List.generate(p['count'], (index) {
                          final double h = (p['weight'] * 2.0).clamp(30.0, 80.0);
                          final double w = (p['weight'] * 0.8).clamp(8.0, 20.0);
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            width: w,
                            height: h,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Center(
                              child: p['weight'] >= 10
                                  ? RotatedBox(
                                      quarterTurns: 1,
                                      child: Text(
                                        '${p['weight'].toInt()}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          );
                        });
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: platesNeeded.length,
                  itemBuilder: (context, index) {
                    final p = platesNeeded[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${p['weight']} kg',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('x ${p['count']}',
                              style: TextStyle(color: Theme.of(context).colorScheme.outline)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ] else
              const Text('Weight is less than or equal to bar weight.'),
          ],
        ),
      ),
    );
  }
}
