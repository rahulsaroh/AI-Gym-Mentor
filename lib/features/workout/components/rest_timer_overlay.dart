import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/workout/providers/timer_notifier.dart';

class RestTimerOverlay extends ConsumerWidget {
  final String? nextExerciseName;
  final VoidCallback onClose;

  const RestTimerOverlay({
    super.key,
    this.nextExerciseName,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);
    final notifier = ref.read(timerProvider.notifier);

    final double progress = timerState.initialDuration > 0
        ? timerState.remainingSeconds / timerState.initialDuration
        : 0;

    // Auto-close overlay when timer finishes or stops
    ref.listen(timerProvider, (previous, next) {
      if (!next.isRunning && next.remainingSeconds == 0) {
        onClose();
      }
    });

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 40,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(context),
          const SizedBox(height: 16),
          _buildHeader(context, timerState.exerciseName, nextExerciseName),
          const SizedBox(height: 40),
          _buildTimerCircle(context, timerState.remainingSeconds, progress),
          const SizedBox(height: 48),
          _buildControls(context, notifier, timerState.isRunning),
          const SizedBox(height: 32),
          _buildSkipButton(context, notifier, onClose),
        ],
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String? currentEx, String? nextEx) {
    return Column(
      children: [
        Text(
          'Resting after: ${currentEx ?? 'Exercise'}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        const SizedBox(height: 4),
        if (nextEx != null)
          Text(
            'Next: $nextEx',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
      ],
    );
  }

  Widget _buildTimerCircle(
      BuildContext context, int remaining, double progress) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 220,
          height: 220,
          child: CustomPaint(
            painter: TimerPainter(
              progress: progress,
              color: Theme.of(context).primaryColor,
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _formatTime(remaining),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 56,
                letterSpacing: -2,
                fontFeatures: [const FontFeature.tabularFigures()],
              ),
            ),
            Text(
              'REMAINING',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    letterSpacing: 2,
                    color: Theme.of(context).colorScheme.outline,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildControls(
      BuildContext context, TimerNotifier notifier, bool isRunning) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TimerActionButton(
          label: '-15s',
          onPressed: () => notifier.extend(-15),
          isSecondary: true,
        ),
        const SizedBox(width: 24),
        GestureDetector(
          onTap: () => isRunning ? notifier.pause() : notifier.resume(),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isRunning ? LucideIcons.pause : LucideIcons.play,
              size: 32,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(width: 24),
        _TimerActionButton(
          label: '+15s',
          onPressed: () => notifier.extend(15),
          isSecondary: true,
        ),
      ],
    );
  }

  Widget _buildSkipButton(
      BuildContext context, TimerNotifier notifier, VoidCallback onClose) {
    return TextButton(
      onPressed: () {
        notifier.stop();
      },
      child: Text(
        'SKIP REST',
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }
}

class _TimerActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isSecondary;

  const _TimerActionButton({
    required this.label,
    required this.onPressed,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  TimerPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    const strokeWidth = 12.0;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);

    final angle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -pi / 2,
      angle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
