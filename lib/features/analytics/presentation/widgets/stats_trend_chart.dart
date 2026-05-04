import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

enum StatType { volume, duration, weight }

class StatsTrendChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final StatType type;
  final String? valueSuffix;
  final double? targetValue;

  const StatsTrendChart({
    super.key,
    required this.data,
    required this.type,
    this.valueSuffix,
    this.targetValue,
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
      height: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),
          const BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            offset: Offset(-5, -5),
          ),
        ],
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 1,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
            getDrawingVerticalLine: (value) => FlLine(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    meta: meta,
                    space: 8,
                    child: Text(
                      value.toInt().toString(),
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.6),
                      ),
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index < 0 || index >= data.length) return const SizedBox.shrink();
                  
                  // Show labels every few points
                  if (data.length > 5 && index % (data.length ~/ 3) != 0) {
                    return const SizedBox.shrink();
                  }

                  final date = data[index]['date'] as DateTime;
                  return SideTitleWidget(
                    meta: meta,
                    space: 8,
                    child: Text(
                      DateFormat('MMM d').format(date),
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.6),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1), width: 1),
              left: BorderSide(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1), width: 1),
            ),
          ),
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              if (targetValue != null)
                HorizontalLine(
                  y: targetValue!,
                  color: Colors.orange.withValues(alpha: 0.4),
                  strokeWidth: 2,
                  dashArray: [8, 4],
                  label: HorizontalLineLabel(
                    show: true,
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(right: 8, bottom: 8),
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.orange.withValues(alpha: 0.8),
                    ),
                    labelResolver: (line) => 'GOAL: ${targetValue!.toStringAsFixed(1)}',
                  ),
                ),
            ],
          ),
          lineBarsData: [
            LineChartBarData(
              spots: data.asMap().entries.map((e) {
                double value = (e.value[key] as num).toDouble();
                if (type == StatType.volume) value /= 1000; // Scale to tons
                return FlSpot(e.key.toDouble(), value);
              }).toList(),
              isCurved: true,
              curveSmoothness: 0.35,
              color: _getColor(context),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                  radius: 3,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: _getColor(context),
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    _getColor(context).withValues(alpha: 0.15),
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
              getTooltipColor: (_) => Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
              tooltipBorder: BorderSide(color: _getColor(context).withValues(alpha: 0.2)),
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  String label = spot.y.toStringAsFixed(1);
                  if (type == StatType.volume) {
                    label += ' Tons';
                  } else if (type == StatType.duration) label += ' min';
                  else if (valueSuffix != null) label += valueSuffix!;
                  
                  final date = data[spot.x.toInt()]['date'] as DateTime;
                  return LineTooltipItem(
                    '$label\n',
                    GoogleFonts.outfit(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: DateFormat('MMM d, yyyy').format(date),
                        style: GoogleFonts.outfit(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
            handleBuiltInTouches: true,
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
