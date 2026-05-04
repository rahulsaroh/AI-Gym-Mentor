import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YearActivityHeatmap extends StatelessWidget {
  final Map<DateTime, int> dailyActivity;
  final int year;

  const YearActivityHeatmap({
    super.key,
    required this.dailyActivity,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    // Generate all days for the year
    final firstDay = DateTime(year, 1, 1);
    final lastDay = DateTime(year, 12, 31);
    final daysInYear = lastDay.difference(firstDay).inDays + 1;

    // Grid: 7 rows (weeks) x ~53 columns
    // Actually simpler to just use a Wrap or a custom Grid
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Consistency Heatmap', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('$year Activity', style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final double boxSize = (constraints.maxWidth - (52 * 2)) / 53;
            
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: List.generate(12, (monthIdx) {
                    final month = monthIdx + 1;
                    final firstOfMonth = DateTime(year, month, 1);
                    final lastOfMonth = DateTime(year, month + 1, 0);
                    final days = lastOfMonth.day;
                    
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getMonthLabel(month),
                            style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: boxSize * 2.5, // approximation for month columns
                            child: Wrap(
                              spacing: 2,
                              runSpacing: 2,
                              children: List.generate(days, (dayIdx) {
                                final date = DateTime(year, month, dayIdx + 1);
                                final count = dailyActivity[DateTime(date.year, date.month, date.day)] ?? 0;
                                return Container(
                                  width: boxSize * 0.8,
                                  height: boxSize * 0.8,
                                  decoration: BoxDecoration(
                                    color: _getHeatmapColor(count),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    );
                 }),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildLegend(),
      ],
    );
  }

  String _getMonthLabel(int month) {
    const labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return labels[month - 1];
  }

  Color _getHeatmapColor(int count) {
    if (count == 0) return Colors.grey[200]!;
    if (count == 1) return Colors.green[200]!;
    if (count == 2) return Colors.green[400]!;
    return Colors.green[700]!;
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Less', style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey)),
        const SizedBox(width: 4),
        _legendBox(Colors.grey[200]!),
        _legendBox(Colors.green[200]!),
        _legendBox(Colors.green[400]!),
        _legendBox(Colors.green[700]!),
        const SizedBox(width: 4),
        Text('More', style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _legendBox(Color color) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(1)),
    );
  }
}
