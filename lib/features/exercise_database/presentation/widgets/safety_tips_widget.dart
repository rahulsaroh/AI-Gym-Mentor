import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SafetyTipsWidget extends StatelessWidget {
  final List<String> tips;

  const SafetyTipsWidget({
    super.key,
    required this.tips,
  });

  @override
  Widget build(BuildContext context) {
    if (tips.isEmpty) {
      return _buildTipCard('Always warm up before performing this exercise.');
    }

    return Column(
      children: tips.map((tip) => _buildTipCard(tip)).toList(),
    );
  }

  Widget _buildTipCard(String tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: Colors.amber, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(LucideIcons.shieldAlert, size: 18, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
