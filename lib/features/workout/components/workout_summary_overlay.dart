import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/core/widgets/number_ticker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_gemini_pro/services/sync_worker.dart';
import 'package:gym_gemini_pro/services/plateau_service.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutSummaryOverlay extends ConsumerStatefulWidget {
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
  ConsumerState<WorkoutSummaryOverlay> createState() =>
      _WorkoutSummaryOverlayState();
}

class _WorkoutSummaryOverlayState extends ConsumerState<WorkoutSummaryOverlay>
    with TickerProviderStateMixin {
  late TextEditingController _notesController;
  late ConfettiController _confettiController;
  late List<AnimationController> _staggerControllers;
  late List<Animation<double>> _staggerAnimations;
  List<PlateauResult> _plateaus = [];
  bool _loadingPlateaus = true;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.workout.notes);

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));

    // Build stagger animations for each exercise row
    final exerciseCount = widget.sets.map((s) => s.exerciseId).toSet().length;
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
      _fetchPlateaus();
    });
  }

  Future<void> _fetchPlateaus() async {
    final service = ref.read(plateauServiceProvider.notifier);
    final results = <PlateauResult>[];

    final exerciseIds = widget.sets.map((s) => s.exerciseId).toSet().toList();
    for (final id in exerciseIds) {
      final res = await service.checkExercise(id);
      if (res != null) results.add(res);
    }

    if (mounted) {
      setState(() {
        _plateaus = results;
        _loadingPlateaus = false;
      });
    }
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final isVerySmall = constraints.maxWidth < 380;

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
              padding: EdgeInsets.all(isVerySmall ? 16 : 24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Workout Complete! 🎉',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const _SyncStatusChip(),
                            ],
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
                        height: isVerySmall ? 80 : 100,
                        width: isVerySmall ? 80 : 100,
                        child: Lottie.asset(
                          'assets/animations/trophy.json',
                          repeat: false,
                          errorBuilder: (_, __, ___) => const Icon(
                              LucideIcons.trophy,
                              size: 60,
                              color: Color(0xFFFFD700)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: isVerySmall ? 1 : 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: isVerySmall ? 3.0 : 1.5,
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

                    if (!_loadingPlateaus && _plateaus.isNotEmpty) ...[
                      _PlateauTransparencyCard(results: _plateaus),
                      const SizedBox(height: 24),
                    ],

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
                      final ex =
                          widget.exercises.firstWhere((e) => e.id == entry.key);
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
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  ex.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 4,
                                child: FittedBox(
                                  alignment: Alignment.centerRight,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '${entry.value.length} sets • Best: ${maxWeight.toStringAsFixed(1)}kg',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        fontSize: 13),
                                  ),
                                ),
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
                            .surfaceContainerHighest
                            .withValues(alpha: 0.3),
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
      },
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHighlight
            ? Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.5)
            : Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon,
                  size: 14, color: Theme.of(context).colorScheme.outline),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isHighlight
                        ? Theme.of(context).colorScheme.tertiary
                        : null,
                  ),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHighlight
            ? Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.5)
            : Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon,
                  size: 14, color: Theme.of(context).colorScheme.outline),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: NumberTicker(
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
          ),
        ],
      ),
    );
  }
}

class _SyncStatusChip extends ConsumerWidget {
  const _SyncStatusChip();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncStatus = ref.watch(syncWorkerProvider);

    Color color;
    String label;
    IconData icon;
    bool spinning = false;

    switch (syncStatus) {
      case SyncStatus.syncing:
        color = Colors.blue;
        label = 'Syncing...';
        icon = LucideIcons.refreshCw;
        spinning = true;
        break;
      case SyncStatus.success:
        color = Colors.green;
        label = 'Synced to Sheets';
        icon = LucideIcons.circleCheck;
        break;
      case SyncStatus.failed:
        color = Colors.orange;
        label = 'Sync Pending';
        icon = LucideIcons.clock;
        break;
      case SyncStatus.authenticationRequired:
        color = Colors.grey;
        label = 'Not Connected';
        icon = LucideIcons.cloudOff;
        break;
      case SyncStatus.idle:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (spinning)
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(strokeWidth: 2, color: color),
            )
          else
            Icon(icon, size: 12, color: color),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlateauTransparencyCard extends StatelessWidget {
  final List<PlateauResult> results;
  const _PlateauTransparencyCard({required this.results});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            colorScheme.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(LucideIcons.trendingDown,
                    color: colorScheme.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PLATEAU ALERT',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.primary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Progression Halted',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...results.map((res) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(res.exerciseName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            'Stuck for ${res.weeksStuck} sessions',
                            style: TextStyle(
                                fontSize: 12, color: colorScheme.outline),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: colorScheme.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Try Deload: ${res.deloadWeight}kg',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const Divider(height: 32),
          Text(
            'Common factors: Insufficient recovery, high volume, or nutritional deficit. Tap for details.',
            style: TextStyle(
                fontSize: 12,
                color: colorScheme.outline,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
