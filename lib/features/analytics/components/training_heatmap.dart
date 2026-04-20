import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingHeatmap extends ConsumerWidget {
  const TrainingHeatmap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityAsync = ref.watch(dailyActivityProvider);

    return activityAsync.when(
      data: (activity) => _HeatmapContent(activity: activity),
      loading: () => _SkeletonHeatmap(),
      error: (e, _) => const SizedBox.shrink(),
    );
  }
}

class _HeatmapContent extends StatelessWidget {
  final Map<DateTime, int> activity;

  const _HeatmapContent({required this.activity});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    // Show last 20 weeks (approx 140 days)
    final startDate = today.subtract(const Duration(days: 140));

    // Normalize start date to the beginning of that week (Monday)
    final adjustedStart =
        startDate.subtract(Duration(days: startDate.weekday - 1));
    final totalDays = today.difference(adjustedStart).inDays + 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Training Consistency',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  '${activity.length} active days',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 130,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.05),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(21, (weekIndex) {
                  // Column for each week
                  return Column(
                    children: List.generate(7, (dayIndex) {
                      final dayDate = adjustedStart
                          .add(Duration(days: (weekIndex * 7) + dayIndex));

                      if (dayDate.isAfter(today)) {
                        return _buildDayTile(context, null);
                      }

                      final normalizedDay =
                          DateTime(dayDate.year, dayDate.month, dayDate.day);
                      final sessions = activity[normalizedDay] ?? 0;

                      return _buildDayTile(context, sessions,
                          dayDate: normalizedDay);
                    }),
                  );
                }),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4,
            children: [
              Text('Less ',
                  style: GoogleFonts.inter(fontSize: 10, color: Colors.grey)),
              _buildDayTile(context, 0, size: 10),
              _buildDayTile(context, 1, size: 10),
              _buildDayTile(context, 2, size: 10),
              _buildDayTile(context, 3, size: 10),
              Text(' More',
                  style: GoogleFonts.inter(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayTile(BuildContext context, int? sessions,
      {DateTime? dayDate, double size = 12}) {
    Color color;
    if (sessions == null) {
      color = Colors.transparent;
    } else if (sessions == 0) {
      color = Theme.of(context)
          .colorScheme
          .surfaceContainerHighest
          .withOpacity(0.5);
    } else if (sessions == 1) {
      color = Theme.of(context).primaryColor.withOpacity(0.3);
    } else if (sessions == 2) {
      color = Theme.of(context).primaryColor.withOpacity(0.6);
    } else {
      color = Theme.of(context).primaryColor;
    }

    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _SkeletonHeatmap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
