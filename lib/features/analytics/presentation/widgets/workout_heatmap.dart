import 'package:flutter/material.dart';

class WorkoutHeatmap extends StatelessWidget {
  final Map<DateTime, int> activity;

  const WorkoutHeatmap({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    // We'll show the last 52 weeks
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    // Calculate the start date (Monday of the week 51 weeks ago)
    final firstDayToShow = today.subtract(Duration(days: (today.weekday - 1) + (51 * 7)));
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Consistency',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true, // Start from today
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMonthLabels(firstDayToShow),
              const SizedBox(width: 8),
              _buildHeatmapGrid(firstDayToShow, today),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildLegend(context),
      ],
    );
  }

  Widget _buildMonthLabels(DateTime start) {
    // This is a bit complex for a simple grid, 
    // so we'll just show weekday initials for now
    return const Column(
      children: [
        SizedBox(height: 12), // Align with first row
        _WeekdayLabel('M'),
        _WeekdayLabel(''),
        _WeekdayLabel('W'),
        _WeekdayLabel(''),
        _WeekdayLabel('F'),
        _WeekdayLabel(''),
        _WeekdayLabel('S'),
      ],
    );
  }

  Widget _buildHeatmapGrid(DateTime start, DateTime end) {
    final weeks = 52;
    return Row(
      children: List.generate(weeks, (weekIndex) {
        return Column(
          children: List.generate(7, (dayIndex) {
            final date = start.add(Duration(days: (weekIndex * 7) + dayIndex));
            if (date.isAfter(end)) return _HeatmapCell(level: -1);
            
            final count = activity[DateTime(date.year, date.month, date.day)] ?? 0;
            return _HeatmapCell(level: count);
          }),
        );
      }),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Less', style: TextStyle(fontSize: 10, color: Colors.grey)),
          const SizedBox(width: 4),
          _HeatmapCell(level: 0, size: 10, margin: 1),
          _HeatmapCell(level: 1, size: 10, margin: 1),
          _HeatmapCell(level: 2, size: 10, margin: 1),
          _HeatmapCell(level: 3, size: 10, margin: 1),
          const SizedBox(width: 4),
          const Text('More', style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  final String label;
  const _WeekdayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        label,
        style: const TextStyle(fontSize: 9, color: Colors.grey),
      ),
    );
  }
}

class _HeatmapCell extends StatelessWidget {
  final int level;
  final double size;
  final double margin;

  const _HeatmapCell({required this.level, this.size = 12, this.margin = 1});

  @override
  Widget build(BuildContext context) {
    if (level == -1) return SizedBox(width: size + (margin * 2), height: size + (margin * 2));

    Color color;
    if (level == 0) {
      color = Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);
    } else if (level == 1) {
      color = Theme.of(context).colorScheme.primary.withValues(alpha: 0.2);
    } else if (level == 2) {
      color = Theme.of(context).colorScheme.primary.withValues(alpha: 0.5);
    } else {
      color = Theme.of(context).colorScheme.primary;
    }

    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
