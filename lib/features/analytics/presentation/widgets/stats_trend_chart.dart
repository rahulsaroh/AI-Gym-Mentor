import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum StatType { volume, duration, weight }

class StatsTrendChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final StatType type;
  final String? valueSuffix;

  const StatsTrendChart({
    super.key,
    required this.data,
    required this.type,
    this.valueSuffix,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('Not enough data for this period.'),
      ));
    }

    final key = _getDataKey();
    
    return Container(
      height: 220,
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index < 0 || index >= data.length || index % 4 != 0) {
                    return const SizedBox.shrink();
                  }
                  final date = data[index]['date'] as DateTime;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      DateFormat('MMM d').format(date),
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: data.asMap().entries.map((e) {
                double value = (e.value[key] as num).toDouble();
                if (type == StatType.volume) value /= 1000; // Scale to tons
                return FlSpot(e.key.toDouble(), value);
              }).toList(),
              isCurved: true,
              color: _getColor(context),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    _getColor(context).withValues(alpha: 0.2),
                    _getColor(context).withValues(alpha: 0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => Theme.of(context).colorScheme.surfaceContainerHighest,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  String label = spot.y.toStringAsFixed(1);
                  if (type == StatType.volume) label += ' Tons';
                  else if (type == StatType.duration) label += ' min';
                  else if (valueSuffix != null) label += valueSuffix!;
                  
                  return LineTooltipItem(
                    label,
                    TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  String _getDataKey() {
    switch (type) {
      case StatType.volume: return 'volume';
      case StatType.duration: return 'duration';
      case StatType.weight: return 'weight';
    }
  }

  Color _getColor(BuildContext context) {
    switch (type) {
      case StatType.volume: return Theme.of(context).colorScheme.primary;
      case StatType.duration: return Colors.orange;
      case StatType.weight: return Colors.teal;
    }
  }
}
