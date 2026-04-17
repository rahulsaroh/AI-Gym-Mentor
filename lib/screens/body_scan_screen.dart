import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/body_scan_data.dart';
import '../widgets/body_scan_image_stack.dart';
import '../widgets/scan_history_timeline.dart';
import '../widgets/data_points_row.dart';

class BodyScanScreen extends StatefulWidget {
  const BodyScanScreen({super.key});

  @override
  State<BodyScanScreen> createState() => _BodyScanScreenState();
}

class _BodyScanScreenState extends State<BodyScanScreen> {
  late BodyScanData _data;

  @override
  void initState() {
    super.initState();
    _data = BodyScanData(
      userName: "Alex M.",
      gender: "Male",
      age: 34,
      scanDateTime: DateTime(2026, 4, 17, 10, 45),
      leftBicep: 36.4,
      leftBicepDelta: -0.2,
      chest: 105.8,
      chestDelta: 1.1,
      waist: 83.1,
      waistDelta: -0.8,
      hips: 98.5,
      hipsDelta: -0.3,
      leftThigh: 61.2,
      leftThighDelta: 0.9,
      leftCalf: 40.1,
      leftCalfDelta: 0.2,
      rightBicep: 36.3,
      rightBicepDelta: -0.1,
      rightThigh: 61.1,
      rightThighDelta: 0.8,
      rightCalf: 40.0,
      rightCalfDelta: 0.1,
      bodyFat: 14.2,
      leanMass: 72.5,
      weight: 84.5,
      scanHistory: [
        DateTime(2026, 3, 28),
        DateTime(2026, 3, 21),
        DateTime(2026, 3, 14),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF0A0E14);
    final dateStr = DateFormat('MMMM d, h:mm a').format(_data.scanDateTime);
    // Replace "April" with "Today" if it's today (mocking for the requirement)
    final displayDate = "Today, ${DateFormat('h:mm a').format(_data.scanDateTime)}";

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderRow(displayDate),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  child: Text(
                    displayDate,
                    style: GoogleFonts.dmSans(
                      color: const Color(0xFF9E9E9E),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              BodyScanImageStack(data: _data),
              const SizedBox(height: 24),
              ScanHistoryTimeline(
                scanHistory: _data.scanHistory,
                selectedDate: _data.scanHistory.last, // Mar 14 is highlighted in requirement
              ),
              const SizedBox(height: 16),
              DataPointsRow(
                bodyFat: _data.bodyFat,
                leanMass: _data.leanMass,
                weight: _data.weight,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow(String displayDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LEFT: Scan date/time
          Text(
            displayDate,
            style: GoogleFonts.dmSans(
              color: const Color(0xFF9E9E9E),
              fontSize: 13,
            ),
          ),
          // CENTER: Title
          Text(
            'BODY SCAN',
            style: GoogleFonts.rajdhani(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // RIGHT: User Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${_data.userName} | ${_data.gender} ${_data.age}',
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '●',
                    style: TextStyle(
                      color: Color(0xFF01B4C0),
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Active Scan',
                    style: GoogleFonts.dmSans(
                      color: const Color(0xFF01B4C0),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
