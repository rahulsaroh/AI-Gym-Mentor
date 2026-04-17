import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataPointsRow extends StatelessWidget {
  final double bodyFat;
  final double leanMass;
  final double weight;

  const DataPointsRow({
    super.key,
    required this.bodyFat,
    required this.leanMass,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            'DATA POINTS',
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDataCard(
                icon: Icons.arrow_downward,
                label: 'Body Fat',
                value: '$bodyFat%',
              ),
              _buildDataCard(
                icon: Icons.arrow_upward,
                label: 'Lean Mass',
                value: '$leanMass kg',
              ),
              _buildDataCard(
                icon: Icons.monitor_weight_outlined,
                label: 'Weight',
                value: '$weight kg',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDataCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    const tealColor = Color(0xFF01B4C0);
    const cardColor = Color(0xFF2A2A2A);

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: cardColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: tealColor,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
