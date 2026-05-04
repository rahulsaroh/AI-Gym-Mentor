import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MuscleBalanceChart extends StatelessWidget {
  final Map<String, dynamic> balanceData;

  const MuscleBalanceChart({super.key, required this.balanceData});

  @override
  Widget build(BuildContext context) {
    final labels = balanceData['labels'] as List<dynamic>;
    final thisMonth = balanceData['thisMonth'] as List<dynamic>;
    
    if (labels.isEmpty) {
      return const Center(child: Text('Add more workouts to see muscle distribution.'));
    }

    // Find max value to normalization
    double maxVal = 0;
    for (var v in thisMonth) {
      if (v > maxVal) maxVal = v.toDouble();
    }
    if (maxVal == 0) maxVal = 1;

    return AspectRatio(
      aspectRatio: 1.2,
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.polygon,
          dataSets: [
            RadarDataSet(
              fillColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.25),
              borderColor: Theme.of(context).colorScheme.primary,
              entryRadius: 2.5,
              dataEntries: thisMonth.map((v) => RadarEntry(value: (v.toDouble() / maxVal) * 100)).toList(),
              borderWidth: 2,
            ),
          ],
          getTitle: (index, angle) {
            if (index >= labels.length) return const RadarChartTitle(text: '');
            return RadarChartTitle(
              text: labels[index].toString(),
              angle: angle,
            );
          },

          tickCount: 3,
          ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 0),
          gridBorderData: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
          radarBorderData: const BorderSide(color: Colors.transparent),
          tickBorderData: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
          radarBackgroundColor: Colors.transparent,
        ),
      ),
    );

  }
}
