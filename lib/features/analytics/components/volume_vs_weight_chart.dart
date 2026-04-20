import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:intl/intl.dart';

class VolumeVsWeightChart extends ConsumerWidget {
  final WeightUnit unit;
  const VolumeVsWeightChart({super.key, required this.unit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendAsync = ref.watch(volumeVsWeightTrendProvider);

    return trendAsync.when(
      data: (data) => _ChartContent(data: data, unit: unit),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _ChartContent extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final WeightUnit unit;

  const _ChartContent({required this.data, required this.unit});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const Center(child: Text('Not enough data yet.'));

    // Convert volume from KG to Tons for display
    final dataWithTons = data
        .map((e) => {
              'date': e['date'],
              'volume': (e['volume'] as double) / 1000, // Convert kg to tons
              'weight': e['weight'] as double,
            })
        .toList();

    final maxVolume = dataWithTons
        .map((e) => e['volume'] as double)
        .reduce((a, b) => a > b ? a : b);
    final maxWeight = dataWithTons
        .map((e) => e['weight'] as double)
        .reduce((a, b) => a > b ? a : b);

    // Scale volume to weight range for display overlay
    final volumeScale =
        maxVolume > 0 && maxWeight > 0 ? maxWeight / maxVolume : 1.0;

    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  // Volume Line (Scaled to match weight range)
                  LineChartBarData(
                    spots: dataWithTons.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(),
                          (e.value['volume'] as double) * volumeScale);
                    }).toList(),
                    isCurved: true,
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.5),
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color:
                          Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    ),
                  ),
                  // Weight Line
                  LineChartBarData(
                    spots: dataWithTons.asMap().entries.map((e) {
                      return FlSpot(
                          e.key.toDouble(), e.value['weight'] as double);
                    }).toList(),
                    isCurved: true,
                    color: Colors.orange,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (val, meta) => Text(
                        '${val.toInt()}',
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (val, meta) {
                        final volVal =
                            maxWeight > 0 ? (val / volumeScale) : 0.0;
                        return Text(
                          '${volVal.toStringAsFixed(1)}T',
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withValues(alpha: 0.5)),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (val, meta) {
                        if (val.toInt() >= data.length ||
                            val.toInt() % 4 != 0) {
                          return const SizedBox.shrink();
                        }
                        final d = data[val.toInt()]['date'] as DateTime;
                        return Text(
                          DateFormat('MM/dd').format(d),
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                ),
                gridData: const FlGridData(show: true, drawVerticalLine: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(
                  label:
                      'Body Weight (${unit == WeightUnit.kg ? 'kg' : 'lbs'})',
                  color: Colors.orange),
              const SizedBox(width: 24),
              _LegendItem(
                  label: 'Weekly Volume (Tons)',
                  color: Theme.of(context).primaryColor),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  const _LegendItem({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}
