import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/core/widgets/number_ticker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:lottie/lottie.dart';

class WorkoutSummaryOverlay extends StatefulWidget {
  final Workout workout;
  final List<WorkoutSet> sets;
  final List<Exercise> exercises;
  final int elapsedSeconds;
  final int prsAchieved;
  final Function(String) onSave;
  final VoidCallback onDiscard;

  const WorkoutSummaryOverlay({
    super.key,
    required this.workout,
    required this.sets,
    required this.exercises,
    required this.elapsedSeconds,
    required this.prsAchieved,
    required this.onSave,
    required this.onDiscard,
  });

  @override
  State<WorkoutSummaryOverlay> createState() => _WorkoutSummaryOverlayState();
}

class _WorkoutSummaryOverlayState extends State<WorkoutSummaryOverlay>
    with TickerProviderStateMixin {
  late TextEditingController _notesController;
  late ConfettiController _confettiController;
  late List<AnimationController> _staggerControllers;
  late List<Animation<double>> _staggerAnimations;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.workout.notes);

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));

    // Build stagger animations for each exercise row
    final exerciseCount = widget.sets
        .map((s) => s.exerciseId)
        .toSet()
        .length;
    _staggerControllers = List.generate(
      exerciseCount,
      (_) => AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _staggerAnimations = _staggerControllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeOutBack))
        .toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final reduce = MediaQuery.of(context).disableAnimations;
      if (reduce) {
        _confettiController.play();
        for (var c in _staggerControllers) {
          c.value = 1.0;
        }
      } else {
        _confettiController.play();
        for (var i = 0; i < _staggerControllers.length; i++) {
          Future.delayed(Duration(milliseconds: 200 + i * 100), () {
            if (mounted) _staggerControllers[i].forward();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    _confettiController.dispose();
    for (var c in _staggerControllers) {
      c.dispose();
    }
    super.dispose();
  }

  String _formatTime(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }

  @override
  Widget build(BuildContext context) {
    final completedSets = widget.sets.where((s) => s.completed).toList();
    final totalVolume =
        completedSets.fold(0.0, (acc, s) => acc + (s.weight * s.reps));

    final Map<int, List<WorkoutSet>> setsByExercise = {};
    for (final set in completedSets) {
      setsByExercise.putIfAbsent(set.exerciseId, () => []).add(set);
    }
    final exerciseEntries = setsByExercise.entries.toList();

    return Stack(
      children: [
        // Confetti at top center
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Color(0xFFFFD700),
              Color(0xFF1E88E5),
              Color(0xFFE91E63),
              Color(0xFF4CAF50),
            ],
            numberOfParticles: 30,
            maxBlastForce: 60,
            minBlastForce: 20,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Workout Complete! 🎉',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(LucideIcons.x),
                    ),
                  ],
                ),
                // Lottie trophy
                Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Lottie.asset(
                      'assets/animations/trophy.json',
                      repeat: false,
                      errorBuilder: (_, __, ___) =>
                          const Icon(LucideIcons.trophy,
                              size: 80, color: Color(0xFFFFD700)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  children: [
                    _buildSummaryCard(
                      context,
                      icon: LucideIcons.clock,
                      label: 'Duration',
                      value: _formatTime(widget.elapsedSeconds),
                    ),
                    _buildAnimatedCard(
                      context,
                      icon: LucideIcons.activity,
                      label: 'Volume',
                      numericValue: totalVolume,
                      suffix: ' kg',
                    ),
                    _buildAnimatedCard(
                      context,
                      icon: LucideIcons.dumbbell,
                      label: 'Sets',
                      numericValue: completedSets.length.toDouble(),
                    ),
                    _buildAnimatedCard(
                      context,
                      icon: LucideIcons.trophy,
                      label: 'PRs',
                      numericValue: widget.prsAchieved.toDouble(),
                      isHighlight: true,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Exercises',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                // Staggered exercise rows
                ...exerciseEntries.asMap().entries.map((mapEntry) {
                  final index = mapEntry.key;
                  final entry = mapEntry.value;
                  final ex = widget.exercises
                      .firstWhere((e) => e.id == entry.key);
                  final maxWeight = entry.value.fold(
                      0.0, (prev, s) => s.weight > prev ? s.weight : prev);

                  final animation = index < _staggerAnimations.length
                      ? _staggerAnimations[index]
                      : const AlwaysStoppedAnimation(1.0);

                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) => Opacity(
                      opacity: animation.value.clamp(0.0, 1.0),
                      child: Transform.translate(
                        offset: Offset(0, (1 - animation.value) * 20),
                        child: child,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ex.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          Text(
                            '${entry.value.length} sets • Best: ${maxWeight.toStringAsFixed(1)}kg',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 24),
                const Text('Workout Notes',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'How did it feel?',
                    filled: true,
                    fillColor: Theme.of(context)
                        .colorScheme
                        .surfaceVariant
                        .withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => widget.onSave(_notesController.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primary,
                      foregroundColor:
                          Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Save Workout',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: widget.onDiscard,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Discard Workout',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    bool isHighlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighlight
            ? Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.5)
            : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Theme.of(context).colorScheme.outline),
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isHighlight
                      ? Theme.of(context).colorScheme.tertiary
                      : null,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required double numericValue,
    String suffix = '',
    bool isHighlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighlight
            ? Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.5)
            : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Theme.of(context).colorScheme.outline),
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          const Spacer(),
          NumberTicker(
            value: numericValue,
            suffix: suffix,
            decimalPlaces: suffix == ' kg' ? 1 : 0,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isHighlight
                      ? Theme.of(context).colorScheme.tertiary
                      : null,
                ),
          ),
        ],
      ),
    );
  }
}
