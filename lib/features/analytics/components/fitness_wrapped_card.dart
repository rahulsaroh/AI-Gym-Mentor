import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/rendering.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:ui' as ui;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FitnessWrappedCard extends ConsumerStatefulWidget {
  const FitnessWrappedCard({super.key});

  @override
  ConsumerState<FitnessWrappedCard> createState() => _FitnessWrappedCardState();
}

class _FitnessWrappedCardState extends ConsumerState<FitnessWrappedCard> {
  final GlobalKey _globalKey = GlobalKey();

  Future<void> _shareWrapped() async {
    try {
      final boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/fitness_wrapped.png');
      await file.writeAsBytes(bytes);

      await Share.shareXFiles([XFile(file.path)], text: 'My Monthly Fitness Wrapped! 🚀');
    } catch (e) {
      debugPrint('Error sharing wrapped: $e');
    }
  }

  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    final activityAsync = ref.watch(dailyActivityProvider);
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();

    return statsAsync.when(
      data: (stats) {
        final volume = (stats['monthlyVolume'] as num).toDouble() / 1000;
        final prs = (stats['monthlyPRs'] as num?)?.toInt() ?? 0;
        final streaks = (stats['activeStreak'] as num?)?.toInt() ?? 0;
        final topMuscle = stats['topMuscle'] as String? ?? 'Legs';
        final workouts = (stats['monthlyWorkouts'] as num?)?.toInt() ?? 0;
        final unitSuffix = settings.weightUnit == WeightUnit.kg ? 'Tons' : 'k lbs';
        final displayVolume = settings.weightUnit == WeightUnit.kg
            ? volume
            : volume * 2.20462;

        return RepaintBoundary(
          key: _globalKey,
          child: Container(
            margin: const EdgeInsets.all(16),
            height: 380,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFFA855F7), Color(0xFFEC4899)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  children: [
                    // Slide 1: Volume & PRs
                    _buildSlide(
                      context,
                      title: 'STRENGTH',
                      subtitle: 'Progress this month',
                      stats: [
                        _WrappedStat(
                          label: 'Total Weight Lifted',
                          value: '${displayVolume.toStringAsFixed(1)} $unitSuffix',
                          icon: LucideIcons.trendingUp,
                        ),
                        _WrappedStat(
                          label: 'New Records Set',
                          value: '$prs PRs',
                          icon: LucideIcons.trophy,
                        ),
                      ],
                      footerValue: '$streaks Day Streak',
                    ),
                    // Slide 2: Focus & Consistency
                    _buildSlide(
                      context,
                      title: 'FOCUS',
                      subtitle: 'Where you put the work',
                      stats: [
                        _WrappedStat(
                          label: 'Main Focus',
                          value: topMuscle,
                          icon: LucideIcons.target,
                        ),
                        _WrappedStat(
                          label: 'Sessions Logged',
                          value: '$workouts Workouts',
                          icon: LucideIcons.calendarCheck,
                        ),
                      ],
                      footerValue: 'Top 5% of Users',
                    ),
                    // Slide 3: Growth
                    _buildConsistencySlide(context, activityAsync),
                  ],
                ),
                Positioned(
                  bottom: 24,
                  left: 24,
                  right: 24,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(3, (index) => _buildDot(index == _currentPage)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: _shareWrapped,
                          icon: const Icon(LucideIcons.share2, color: Colors.white, size: 20),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox(height: 350, child: Center(child: CircularProgressIndicator())),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildDot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 6),
      width: active ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: active ? 1.0 : 0.4),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildSlide(BuildContext context, {required String title, required String subtitle, required List<Widget> stats, required String footerValue}) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.outfit(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 2)),
          Text(subtitle, style: GoogleFonts.outfit(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 32),
          ...stats.map((s) => Padding(padding: const EdgeInsets.only(bottom: 20), child: s)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 24), // Add padding to avoid dots
            child: Text(footerValue, style: GoogleFonts.outfit(color: Colors.white.withValues(alpha: 0.9), fontSize: 16, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildConsistencySlide(BuildContext context, AsyncValue<Map<DateTime, int>> activityAsync) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CONSISTENCY', style: GoogleFonts.outfit(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 2)),
          Text('Yearly Progress', style: GoogleFonts.outfit(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 24),
          Expanded(
            child: activityAsync.maybeWhen(
              data: (activity) => Center(
                child: Opacity(
                  opacity: 0.8,
                  child: Transform.scale(
                    scale: 0.8,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(LucideIcons.layoutGrid, size: 100, color: Colors.white24), // Placeholder for heatmap snapshot
                    ),
                  ),
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _WrappedStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _WrappedStat(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              Text(value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}
