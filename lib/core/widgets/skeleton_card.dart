import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A generic skeleton loading card using shimmer effect.
/// Matches the shape of real content cards.
class SkeletonCard extends StatelessWidget {
  final double height;
  final double? width;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final Widget? child;

  const SkeletonCard({
    super.key,
    this.height = 80,
    this.width,
    this.borderRadius = 16,
    this.margin,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[900]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[800]! : Colors.grey[100]!;

    return Padding(
      padding:
          margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        period: const Duration(milliseconds: 1500),
        child: child ??
            Container(
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

/// A full-page shimmer placeholder for the Workout Home Dashboard.
class SkeletonDashboard extends StatelessWidget {
  const SkeletonDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 60),
        const SkeletonCard(
            height: 80, margin: EdgeInsets.symmetric(horizontal: 20)), // Header
        const SizedBox(height: 20),
        const SkeletonCard(
            height: 200,
            borderRadius: 30,
            margin: EdgeInsets.symmetric(horizontal: 20)), // Today's Plan
        const SizedBox(height: 20),
        Row(
          children: const [
            Expanded(
                child: SkeletonCard(
                    height: 100, margin: EdgeInsets.only(left: 20, right: 6))),
            Expanded(
                child: SkeletonCard(
                    height: 100, margin: EdgeInsets.symmetric(horizontal: 6))),
            Expanded(
                child: SkeletonCard(
                    height: 100, margin: EdgeInsets.only(left: 6, right: 20))),
          ],
        ), // Quick Actions
        const SizedBox(height: 20),
        const SkeletonCard(
            height: 150,
            margin: EdgeInsets.symmetric(horizontal: 20)), // Last Workout
        const SkeletonCard(
            height: 150,
            margin: EdgeInsets.symmetric(horizontal: 20)), // Weekly Volume
      ],
    );
  }
}
