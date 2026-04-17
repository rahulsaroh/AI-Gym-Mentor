import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/body_scan_data.dart';

class BodyScanImageStack extends StatelessWidget {
  final BodyScanData data;

  const BodyScanImageStack({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    const tealColor = Color(0xFF01B4C0);
    const mutedGrey = Color(0xFFAAAAAA);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF006B70).withOpacity(0.25),
            blurRadius: 80,
            spreadRadius: 20,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = width * 1.77; // Aspect ratio of the image (approx based on typical mobile screen)

          return Stack(
            children: [
              // Background 3D Body Scan Image
              Image.asset(
                'assets/images/body_scan_3d.png',
                width: width,
                fit: BoxFit.contain,
              ),

              // LEFT SIDE ANNOTATIONS
              _buildAnnotation(
                top: height * 0.28,
                left: width * 0.05,
                label: 'Left Bicep',
                value: '${data.leftBicep} cm',
                delta: data.leftBicepDelta,
                isLeft: true,
              ),
              _buildAnnotation(
                top: height * 0.38,
                left: width * 0.05,
                label: 'Chest',
                value: '${data.chest} cm',
                delta: data.chestDelta,
                isLeft: true,
              ),
              _buildAnnotation(
                top: height * 0.50,
                left: width * 0.05,
                label: 'Waist',
                value: '${data.waist} cm',
                delta: data.waistDelta,
                isLeft: true,
              ),
              _buildAnnotation(
                top: height * 0.60,
                left: width * 0.05,
                label: 'Hips',
                value: '${data.hips} cm',
                delta: data.hipsDelta,
                isLeft: true,
              ),
              _buildAnnotation(
                top: height * 0.73,
                left: width * 0.05,
                label: 'Left Thigh',
                value: '${data.leftThigh} cm',
                delta: data.leftThighDelta,
                isLeft: true,
              ),
              _buildAnnotation(
                top: height * 0.86,
                left: width * 0.05,
                label: 'Left Calf',
                value: '${data.leftCalf} cm',
                delta: data.leftCalfDelta,
                isLeft: true,
              ),

              // RIGHT SIDE ANNOTATIONS
              _buildAnnotation(
                top: height * 0.38,
                right: width * 0.05,
                label: 'Right Bicep',
                value: '${data.rightBicep} cm',
                delta: data.rightBicepDelta,
                isLeft: false,
              ),
              _buildAnnotation(
                top: height * 0.73,
                right: width * 0.05,
                label: 'Right Thigh',
                value: '${data.rightThigh} cm',
                delta: data.rightThighDelta,
                isLeft: false,
              ),
              _buildAnnotation(
                top: height * 0.86,
                right: width * 0.05,
                label: 'Right Calf',
                value: '${data.rightCalf} cm',
                delta: data.rightCalfDelta,
                isLeft: false,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnnotation({
    required double top,
    double? left,
    double? right,
    required String label,
    required String value,
    required double delta,
    required bool isLeft,
  }) {
    final tealColor = const Color(0xFF01B4C0);
    final mutedGrey = const Color(0xFFAAAAAA);
    final deltaText = delta >= 0 ? '+${delta.toStringAsFixed(1)}' : delta.toStringAsFixed(1);
    final deltaColor = delta > 0 ? tealColor : mutedGrey;

    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Column(
        crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '($deltaText cm)',
            style: GoogleFonts.dmSans(
              color: deltaColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
