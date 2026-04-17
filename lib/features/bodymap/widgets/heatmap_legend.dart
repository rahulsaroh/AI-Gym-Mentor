import 'package:flutter/material.dart';
import '../providers/bodymap_provider.dart';

class HeatmapLegend extends StatelessWidget {
  final BodyMapMode mode;

  const HeatmapLegend({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                mode == BodyMapMode.volume ? 'Less Active' : 'Rested',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              const Spacer(),
              Text(
                mode == BodyMapMode.volume ? 'Most Active' : 'Sore',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: mode == BodyMapMode.volume
                    ? [
                        const Color(0xFFBDBDBD),
                        const Color(0xFFFFEB3B),
                        const Color(0xFFE53935)
                      ]
                    : [
                        Colors.transparent,
                        const Color(0xFF7C4DFF).withOpacity(0.3),
                        const Color(0xFF7C4DFF),
                      ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
