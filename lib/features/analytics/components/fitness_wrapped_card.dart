import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      final boundary = _globalKey.currentContext!.findRenderObject() as ui.RenderRepaintBoundary;
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

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();

    return statsAsync.when(
      data: (stats) {
        final volume = (stats['monthlyVolume'] as num).toDouble() / 1000;
        final prs = (stats['monthlyPRs'] as num?)?.toInt() ?? 0;
        final streaks = (stats['activeStreak'] as num?)?.toInt() ?? 0;
        final topMuscle = stats['topMuscle'] as String? ?? 'Legs';
        final unitSuffix =
            settings.weightUnit == WeightUnit.kg ? 'Tons' : 'k lbs';
        final displayVolume = settings.weightUnit == WeightUnit.kg
            ? volume
            : volume * 2.20462; // Conversion if stored as kg in DB

        return RepaintBoundary(
          key: _globalKey,
          child: Container(
            margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MONTHLY',
                        style: GoogleFonts.outfit(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        'WRAPPED',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const Icon(LucideIcons.flame, color: Colors.white, size: 40),
                ],
              ),
              const SizedBox(height: 32),
              _WrappedStat(
                label: 'Total Weight Lifted',
                value: '${displayVolume.toStringAsFixed(1)} $unitSuffix',
                icon: LucideIcons.trendingUp,
              ),
              const SizedBox(height: 16),
              _WrappedStat(
                label: 'New Records Set',
                value: '$prs PRs',
                icon: LucideIcons.trophy,
              ),
              const SizedBox(height: 16),
              _WrappedStat(
                label: 'Main Focus',
                value: topMuscle,
                icon: LucideIcons.target,
              ),
              const Divider(color: Colors.white24, height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Active Streak',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7), fontSize: 13),
                      ),
                      Text(
                        '$streaks Days',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: _shareWrapped,
                    icon: const Icon(LucideIcons.share2, size: 16),
                    label: const Text('SHARE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ),
        );
      },
      loading: () => const SizedBox(
          height: 350,
          child: Center(child: CircularProgressIndicator(color: Colors.white))),
      error: (_, __) => const SizedBox.shrink(),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
