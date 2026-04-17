import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ScanHistoryTimeline extends StatelessWidget {
  final List<DateTime> scanHistory;
  final DateTime selectedDate;

  const ScanHistoryTimeline({
    super.key,
    required this.scanHistory,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    const tealColor = Color(0xFF01B4C0);
    const mutedGrey = Color(0xFF9E9E9E);
    const dividerColor = Color(0xFF444444);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'SCAN HISTORY',
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Divider Line
              Container(
                height: 1,
                color: dividerColor,
              ),
              // Dates and Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: scanHistory.asMap().entries.map((entry) {
                  final index = entry.key;
                  final date = entry.value;
                  final isSelected = date == selectedDate;
                  final isOldest = index == scanHistory.length - 1; // Mar 14 is oldest in example
                  
                  // The user specifically mentioned "The oldest date 'Mar 14' dot should be teal (active/selected)"
                  // but also "most recent date having a teal dot". 
                  // In the screenshot Mart 14 is the one with the teal circle.
                  final dotColor = isOldest ? tealColor : dividerColor;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: dotColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat('MMM d').format(date),
                        style: GoogleFonts.dmSans(
                          color: mutedGrey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
