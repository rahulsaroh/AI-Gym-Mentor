import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A generic skeleton loading card using shimmer effect.
/// Matches the shape of real content cards.
class SkeletonCard extends StatelessWidget {
  final double height;
  final double? width;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const SkeletonCard({
    super.key,
    this.height = 80,
    this.width,
    this.borderRadius = 16,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[850]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          height: height,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}

/// A skeleton mimicking a stat row (label + value side by side).
class SkeletonStatRow extends StatelessWidget {
  const SkeletonStatRow({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[850]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Row(
          children: [
            Container(width: 120, height: 14, decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(8))),
            const Spacer(),
            Container(width: 60, height: 14, decoration: BoxDecoration(color: baseColor, borderRadius: BorderRadius.circular(8))),
          ],
        ),
      ),
    );
  }
}
