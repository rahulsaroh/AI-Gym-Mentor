import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:gym_gemini_pro/features/exercises/exercises_provider.dart';
import 'package:gym_gemini_pro/features/exercises/exercise_repository.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gym_gemini_pro/core/services/shake_detector.dart';
import 'package:gym_gemini_pro/services/sync_worker.dart';
import 'package:gym_gemini_pro/core/widgets/speed_dial_fab.dart';
import 'package:gym_gemini_pro/features/workout/components/pr_banner.dart';
import 'package:gym_gemini_pro/features/workout/components/set_type_selector.dart';
import 'package:gym_gemini_pro/services/progression_service.dart';
import 'package:gym_gemini_pro/features/workout/providers/workout_home_notifier.dart';
import 'package:gym_gemini_pro/features/workout/components/workout_summary_overlay.dart';
import 'package:gym_gemini_pro/features/workout/components/superset_bracket_painter.dart';
import 'package:gym_gemini_pro/features/workout/components/rest_timer_overlay.dart';
import 'package:gym_gemini_pro/features/workout/providers/timer_notifier.dart';
import 'package:gym_gemini_pro/features/settings/settings_provider.dart';
import 'package:gym_gemini_pro/core/utils/weight_converter.dart';
import 'package:gym_gemini_pro/features/settings/models/settings_state.dart';
import 'package:gym_gemini_pro/features/workout/providers/workout_duration_provider.dart';
import 'package:gym_gemini_pro/features/workout/components/plate_calculator_dialog.dart';
import 'package:gym_gemini_pro/features/exercises/components/exercise_picker_overlay.dart';

class ActiveWorkoutScreen extends ConsumerStatefulWidget {
  final int workoutId;
  final int? dayId;

  const ActiveWorkoutScreen({
    super.key,
    required this.workoutId,
    this.dayId,
  });

  @override
  ConsumerState<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}
class _ActiveWorkoutScreenState extends ConsumerState<ActiveWorkoutScreen> with TickerProviderStateMixin {
  bool _isInitializing = true;
  bool _timerStarted = false;
  int _prsAchieved = 0;
  
  // PR Celebration State
  late ConfettiController _confettiController;
  late AnimationController _glowController;
  int? _glowingExerciseId;
  String? _prExerciseName;
  String? _prAchievement;

  // Shake & Undo State
  late ShakeDetector _shakeDetector;
  WorkoutSet? _lastDeletedSet;
  ExerciseBlock? _lastDeletedExercise;

  // Ghost text history
  Map<int, List<WorkoutSet>> _previousSessionSets = {}; // exerciseId -> sets
  
  late ScrollController _scrollController;

  // Input management
  final TextEditingController _titleController = TextEditingController();
  bool _isEditingTitle = false;
  final Map<int, TextEditingController> _weightControllers = {};
  final Map<int, TextEditingController> _repsControllers = {};
  final Map<int, TextEditingController> _rpeControllers = {};
  final Map<int, TextEditingController> _noteControllers = {};
  final Map<int, FocusNode> _weightNodes = {};
  final Map<int, FocusNode> _repsNodes = {};
  final Map<int, FocusNode> _rpeNodes = {};

  @override
  void initState() {
    super.initState();
    _initializeFromTemplate();
    _loadHistory();

    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) _glowController.reverse();
        else if (status == AnimationStatus.dismissed) _glowController.forward();
      });

    _shakeDetector = ShakeDetector();
    _shakeDetector.onShake.listen((_) => _handleShake());
    _shakeDetector.start();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _glowController.dispose();
    _shakeDetector.dispose();
    _titleController.dispose();
    for (var c in _weightControllers.values) c.dispose();
    for (var c in _repsControllers.values) c.dispose();
    for (var c in _rpeControllers.values) c.dispose();
    for (var c in _noteControllers.values) c.dispose();
    for (var n in _weightNodes.values) n.dispose();
    for (var n in _repsNodes.values) n.dispose();
    for (var n in _rpeNodes.values) n.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  TextEditingController _getController(int setId, String type, String initialValue) {
    final Map<int, TextEditingController> map;
    switch (type) {
      case 'weight': map = _weightControllers; break;
      case 'reps': map = _repsControllers; break;
      case 'rpe': map = _rpeControllers; break;
      case 'note': map = _noteControllers; break;
      default: throw UnimplementedError();
    }
    if (!map.containsKey(setId)) {
      map[setId] = TextEditingController(text: initialValue);
    }
    return map[setId]!;
  }

  FocusNode _getNode(int setId, String type) {
    final Map<int, FocusNode> map;
    switch (type) {
      case 'weight': map = _weightNodes; break;
      case 'reps': map = _repsNodes; break;
      case 'rpe': map = _rpeNodes; break;
      default: throw UnimplementedError();
    }
    if (!map.containsKey(setId)) {
      map[setId] = FocusNode();
    }
    return map[setId]!;
  }

  void _startTimer(DateTime startTime) {
    ref.read(workoutDurationProvider.notifier).start(startTime);
  }

  Future<void> _initializeFromTemplate() async {
    if (widget.dayId == null) {
      if (mounted) setState(() => _isInitializing = false);
      return;
    }
    final db = ref.read(appDatabaseProvider);
    final existingSets = await (db.select(db.workoutSets)..where((t) => t.workoutId.equals(widget.workoutId))).get();
    if (existingSets.isEmpty) {
      final templateExercises = await (db.select(db.templateExercises)
            ..where((t) => t.dayId.equals(widget.dayId!))
            ..orderBy([(t) => OrderingTerm(expression: t.order)]))
          .get();
      for (var i = 0; i < templateExercises.length; i++) {
        final te = templateExercises[i];
        await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
              workoutId: widget.workoutId,
              exerciseId: te.exerciseId,
              exerciseOrder: i,
              setNumber: 1,
              reps: 10,
              weight: 0,
              setType: Value(te.setType),
              supersetGroupId: Value(te.supersetGroupId),
            ));
      }
    }
    if (mounted) setState(() => _isInitializing = false);
  }

  String _formatDuration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    if (h > 0) return '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final db = ref.watch(appDatabaseProvider);
    final workoutStream = db.select(db.workouts)..where((t) => t.id.equals(widget.workoutId));
    final setsStream = db.select(db.workoutSets)
      ..where((t) => t.workoutId.equals(widget.workoutId))
      ..orderBy([(t) => OrderingTerm(expression: t.exerciseOrder), (t) => OrderingTerm(expression: t.setNumber)]);

    return StreamBuilder<List<Workout>>(
      stream: workoutStream.watch(),
      builder: (context, workoutSnapshot) {
        final workout = workoutSnapshot.data?.firstOrNull;
        if (workout == null) return const Scaffold(body: Center(child: Text('Workout not found')));

        // Initialize duration timer safely outside of the build return path if not already started
        if (!_timerStarted) {
          _timerStarted = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _startTimer(workout.startTime ?? workout.date);
          });
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: const Icon(LucideIcons.chevronLeft), onPressed: () => context.pop()),
            title: StreamBuilder<List<WorkoutSet>>(
              stream: (db.select(db.workoutSets)..where((t) => t.workoutId.equals(widget.workoutId))).watch(),
              builder: (context, snapshot) {
                final sets = snapshot.data ?? [];
                final completedCount = sets.where((s) => s.completed).length;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditingTitle = true;
                      _titleController.text = workout.name;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_isEditingTitle)
                        SizedBox(
                          height: 32,
                          child: TextField(
                            controller: _titleController,
                            autofocus: true,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                            ),
                            onSubmitted: (val) async {
                              final db = ref.read(appDatabaseProvider);
                              await (db.update(db.workouts)..where((t) => t.id.equals(widget.workoutId))).write(
                                WorkoutsCompanion(name: Value(val)),
                              );
                              setState(() => _isEditingTitle = false);
                            },
                          ),
                        )
                      else
                        Text(workout.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                      Flexible(
                        child: Row(
                          children: [
                            Consumer(
                              builder: (context, ref, _) {
                                final duration = ref.watch(workoutDurationProvider);
                                return Text(_formatDuration(duration), style: const TextStyle(fontSize: 12));
                              },
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                '• $completedCount/${sets.length} sets',
                                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilledButton(
                  onPressed: () => _showSummary(workout),
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Finish', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              StreamBuilder<List<WorkoutSet>>(
                stream: setsStream.watch(),
                builder: (context, setsSnapshot) {
                  final sets = setsSnapshot.data ?? [];
                  if (mounted) {
                    HapticFeedback.mediumImpact();
                  }
                  final exerciseBlocks = _groupSetsByExercise(sets);
                  return ReorderableListView.builder(
                    scrollController: _scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemCount: exerciseBlocks.length + 1,
                    onReorder: (old, New) => _reorderExercises(exerciseBlocks, old, New),
                    itemBuilder: (context, index) {
                      if (index == exerciseBlocks.length) return const SizedBox(height: 100, key: ValueKey('fab_space'));
                      final block = exerciseBlocks[index];
                      
                      // Superset logic: check if this block is part of a group
                      final currentGroupId = block.sets.first.supersetGroupId;
                      bool isFirst = false;
                      bool isLast = false;
                      bool isMiddle = false;

                      if (currentGroupId != null) {
                        final groupBlocks = exerciseBlocks.where((b) => b.sets.first.supersetGroupId == currentGroupId).toList();
                        if (groupBlocks.length > 1) {
                          final idxInGroup = groupBlocks.indexOf(block);
                          isFirst = idxInGroup == 0;
                          isLast = idxInGroup == groupBlocks.length - 1;
                          isMiddle = !isFirst && !isLast;
                        }
                      }

                      return RepaintBoundary(
                        key: ValueKey('ex_${block.exerciseId}_${block.exerciseOrder}'),
                        child: SupersetConnector(
                          isFirst: isFirst,
                          isLast: isLast,
                          isMiddle: isMiddle,
                          color: Theme.of(context).primaryColor,
                          child: _buildExerciseBlock(block, exerciseBlocks),
                        ),
                      );
                    },
                  );
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
                  numberOfParticles: 20,
                  gravity: 0.1,
                ),
              ),
              if (_prExerciseName != null)
                Positioned(
                  top: 20, left: 0, right: 0,
                  child: PRBanner(
                    exerciseName: _prExerciseName!,
                    achievement: _prAchievement!,
                    onDismissed: () => setState(() { _prExerciseName = null; _prAchievement = null; }),
                  ),
                ),
            ],
          ),
          floatingActionButton: SpeedDialFab(
            icon: LucideIcons.plus,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            children: [
              SpeedDialChild(
                icon: LucideIcons.plus,
                label: 'Add Exercise',
                onTap: () {
                  HapticFeedback.lightImpact();
                  _showExercisePicker();
                },
              ),
              SpeedDialChild(
                icon: LucideIcons.plus,
                label: 'New Library Exercise',
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.push('/exercises/create');
                },
              ),
              SpeedDialChild(icon: LucideIcons.layers, label: 'Add Superset', onTap: () {}),
              SpeedDialChild(icon: LucideIcons.check, label: 'Finish Workout', onTap: () => _showSummary(workout)),
            ],
          ),
        );
      },
    );
  }

  List<ExerciseBlock> _groupSetsByExercise(List<WorkoutSet> sets) {
    final Map<int, ExerciseBlock> groups = {};
    for (final set in sets) {
      groups.putIfAbsent(set.exerciseOrder, () => ExerciseBlock(exerciseOrder: set.exerciseOrder, exerciseId: set.exerciseId, sets: []))
            .sets.add(set);
    }
    return groups.values.toList()..sort((a, b) => a.exerciseOrder.compareTo(b.exerciseOrder));
  }

  Widget _buildExerciseBlock(ExerciseBlock block, List<ExerciseBlock> allBlocks) {
    final exercisesAsync = ref.watch(allExercisesProvider);
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();
    final unit = settings.weightUnit;
    return exercisesAsync.when(
      data: (exercises) {
        if (exercises.isEmpty) return const Center(child: Text('No exercises found in library'));
        final exercise = exercises.firstWhere(
          (e) => e.id == block.exerciseId,
          orElse: () => exercises.first,
        );
        final bool isGlowing = _glowingExerciseId == exercise.id;
        return AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            final double glow = isGlowing ? _glowController.value : 0.0;
            return Card(
              elevation: glow * 10, margin: const EdgeInsets.only(bottom: 16),
              shadowColor: Colors.amber.withOpacity(glow),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isGlowing ? Colors.amber.withOpacity(0.4 + glow * 0.6) : Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
                  width: isGlowing ? 2.0 : 1.0,
                ),
              ),
              child: child,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18), overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            _buildMuscleChip(exercise.primaryMuscle),
                            if (exercise.secondaryMuscle != null) _buildMuscleChip(exercise.secondaryMuscle!, isSecondary: true),
                          ],
                        ),
                      ],
                    )),
                    Semantics(
                      label: 'Exercise options for ${exercise.name}',
                      button: true,
                      child: IconButton(
                        icon: const Icon(Icons.more_vert, size: 20),
                        onPressed: () => _showExerciseMenu(block, exercise),
                      ),
                    ),
                  ],
                ),
                _buildSuggestionChip(exercise.id, block),
                const SizedBox(height: 12),
                TextField(
                  controller: _getController(block.sets.first.id, 'note', block.sets.first.notes ?? ''),
                  decoration: InputDecoration(
                    hintText: 'Add a note...',
                    hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
                    isDense: true, contentPadding: const EdgeInsets.symmetric(vertical: 8), border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 12),
                  onChanged: (val) => _updateSet(block.sets.first.id, notes: val),
                ),
                const SizedBox(height: 8),
                Row(children: [
                  const SizedBox(width: 38, child: Text('Set', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  Expanded(child: Text(unit == WeightUnit.kg ? 'kg' : 'lbs', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  const Expanded(child: Text('Reps', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  const Expanded(child: Text('RPE', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  const SizedBox(width: 48),
                ]),
                const Divider(),
                ...block.sets.asMap().entries.map((entry) => _buildSetRow(entry.value, entry.key + 1, exercise, block, allBlocks)),
                const SizedBox(height: 8),
                Semantics(
                  label: 'Add new set to ${exercise.name}',
                  button: true,
                  child: TextButton.icon(
                    onPressed: () => _addSet(block),
                    icon: const Icon(LucideIcons.plus, size: 16),
                    label: const Text('Add Set', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(88, 48), // Ensure touch target
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildMuscleChip(String label, {bool isSecondary = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isSecondary ? Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5) : Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label.toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: isSecondary ? Theme.of(context).colorScheme.onSecondaryContainer : Theme.of(context).colorScheme.onPrimaryContainer)),
    );
  }

  Widget _buildSetRow(WorkoutSet set, int index, Exercise exercise, ExerciseBlock block, List<ExerciseBlock> allBlocks) {
    final isCompleted = set.completed;
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();
    final unit = settings.weightUnit;
    final Color rowColor = isCompleted 
        ? Colors.green.withOpacity(0.1) 
        : (set.setType == SetType.warmup ? Colors.orange.withOpacity(0.05) : Colors.transparent);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Slidable(
        key: ValueKey('slide_set_${set.id}'),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              onPressed: (_) {
                _removeSet(set.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Set deleted'),
                    action: SnackBarAction(label: 'Undo', onPressed: () => _handleShake()),
                  ),
                );
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: LucideIcons.trash,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: GestureDetector(
          onLongPress: () => _duplicateSet(set),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            decoration: BoxDecoration(
              color: rowColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 38,
                  child: _buildSetTypeBadge(set, index),
                ),
                Expanded(
                  child: _buildCellInput(
                    setId: set.id,
                    type: 'weight',
                    value: set.weight == 0 ? '' : WeightConverter.toDisplay(set.weight, unit).toStringAsFixed(1),
                    hint: _getPreviousValue(set.exerciseId, set.setNumber, 'weight', unit),
                    onChanged: (val) => _updateSet(set.id, weight: WeightConverter.toStorage(double.tryParse(val) ?? 0, unit)),
                    isCompleted: isCompleted,
                    onLongPress: () => _showPlateCalculator(WeightConverter.toDisplay(set.weight, unit)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text('×', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
                Expanded(
                  child: _buildCellInput(
                    setId: set.id,
                    type: 'reps',
                    value: set.reps == 0 ? '' : set.reps.toInt().toString(),
                    hint: _getPreviousValue(set.exerciseId, set.setNumber, 'reps', unit),
                    onChanged: (val) => _updateSet(set.id, reps: double.tryParse(val) ?? 0),
                    isCompleted: isCompleted,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildRpePicker(set, isCompleted),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _toggleSet(set, exercise, block, allBlocks),
                  child: Container(
                    width: 48,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCompleted ? Colors.green : Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      LucideIcons.check,
                      size: 18,
                      color: isCompleted ? Colors.white : Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRpePicker(WorkoutSet set, bool isCompleted) {
    return GestureDetector(
      onTap: isCompleted ? null : () => _showRpePicker(set),
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: isCompleted ? Colors.transparent : Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          set.rpe == null ? 'RPE' : set.rpe.toString(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: set.rpe == null ? Theme.of(context).colorScheme.outline.withOpacity(0.5) : (isCompleted ? Theme.of(context).colorScheme.outline : null),
          ),
        ),
      ),
    );
  }

  void _showRpePicker(WorkoutSet set) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select RPE', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Rate of Perceived Exertion (1-10)', style: TextStyle(color: Theme.of(context).colorScheme.outline)),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 11,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  if (index == 0) return _buildRpeChip(set, null);
                  return _buildRpeChip(set, index.toDouble());
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildRpeChip(WorkoutSet set, double? value) {
    final isSelected = set.rpe == value;
    return ChoiceChip(
      label: Text(value == null ? 'None' : value.toString()),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          _updateSet(set.id, rpe: value);
          Navigator.pop(context);
        }
      },
    );
  }

  Widget _buildCellInput({
    required int setId,
    required String type,
    required String value,
    required String hint,
    required Function(String) onChanged,
    bool isCompleted = false,
    VoidCallback? onLongPress,
  }) {
    return Semantics(
      label: '$type for set',
      child: GestureDetector(
        onLongPress: onLongPress,
        child: TextField(
          focusNode: _getNode(setId, type),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isCompleted ? Theme.of(context).colorScheme.outline : null,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            filled: true,
            fillColor: isCompleted ? Colors.transparent : Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            hintText: hint,
            hintStyle: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline.withOpacity(0.4)),
          ),
          controller: _getController(setId, type, value),
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
        ),
      ),
    );
  }

  Future<void> _addSet(ExerciseBlock block) async {
    final db = ref.read(appDatabaseProvider);
    final lastSet = block.sets.last;
    await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
          workoutId: widget.workoutId,
          exerciseId: block.exerciseId,
          exerciseOrder: block.exerciseOrder,
          setNumber: lastSet.setNumber + 1,
          reps: lastSet.reps,
          weight: lastSet.weight,
          setType: Value(lastSet.setType),
        ));
    _loadHistory();
    
    // Auto-scroll slightly to show the new set
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.offset + 60,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _loadHistory() async {
    final db = ref.read(appDatabaseProvider);
    final completedWorkouts = await (db.select(db.workouts)
      ..where((t) => t.status.equals('completed'))
      ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]))
      .get();
    if (completedWorkouts.isEmpty) return;
    final lastWorkoutId = completedWorkouts.first.id;
    final historySets = await (db.select(db.workoutSets)..where((t) => t.workoutId.equals(lastWorkoutId))).get();
    final Map<int, List<WorkoutSet>> historyMap = {};
    for (var s in historySets) {
      historyMap.putIfAbsent(s.exerciseId, () => []).add(s);
    }
    if (mounted) setState(() => _previousSessionSets = historyMap);
  }

  String _getPreviousValue(int exerciseId, int setNumber, String type, WeightUnit unit) {
    if (!_previousSessionSets.containsKey(exerciseId)) return '-';
    final sets = _previousSessionSets[exerciseId]!;
    final match = sets.where((s) => s.setNumber == setNumber).firstOrNull ?? sets.lastOrNull;
    if (match == null) return '-';
    switch (type) {
      case 'weight': return match.weight == 0 ? '-' : WeightConverter.toDisplay(match.weight, unit).toStringAsFixed(1);
      case 'reps': return match.reps == 0 ? '-' : match.reps.toInt().toString();
      case 'rpe': return match.rpe == null ? '-' : match.rpe.toString();
      default: return '-';
    }
  }

  Future<void> _updateSet(int setId, {double? weight, double? reps, double? rpe, String? notes}) async {
    final db = ref.read(appDatabaseProvider);
    await (db.update(db.workoutSets)..where((t) => t.id.equals(setId))).write(
      WorkoutSetsCompanion(
        weight: weight != null ? Value(weight) : const Value.absent(),
        reps: reps != null ? Value(reps) : const Value.absent(),
        rpe: rpe != null ? Value(rpe) : const Value.absent(),
        notes: notes != null ? Value(notes) : const Value.absent(),
      ),
    );
  }

  Future<void> _toggleSet(WorkoutSet set, Exercise exercise, ExerciseBlock block, List<ExerciseBlock> allBlocks) async {
    final db = ref.read(appDatabaseProvider);
    final newCompleted = !set.completed;
    await (db.update(db.workoutSets)..where((t) => t.id.equals(set.id))).write(
      WorkoutSetsCompanion(
        completed: Value(newCompleted),
        completedAt: Value(newCompleted ? DateTime.now() : null),
      ),
    );
    if (newCompleted) {
      HapticFeedback.mediumImpact();
      _autoAdvance(set, block, allBlocks);
      _checkPR(set, exercise);
      if (exercise.restTime > 0) {
        String? nextExName;
        final currentIdx = allBlocks.indexOf(block);
        if (block.sets.last.id == set.id && currentIdx < allBlocks.length - 1) {
          final nextBlock = allBlocks[currentIdx + 1];
          final exercises = await ref.read(exerciseRepositoryProvider).getAllExercises();
          final nextEx = exercises.where((e) => e.id == nextBlock.exerciseId).firstOrNull;
          nextExName = nextEx?.name;
        }
        _showRestTimer(exercise.restTime, exercise.name, nextExName);
      }
    }
  }

  void _autoAdvance(WorkoutSet currentSet, ExerciseBlock block, List<ExerciseBlock> allBlocks) {
    final setIndex = block.sets.indexOf(currentSet);
    if (setIndex < block.sets.length - 1) {
      _getNode(block.sets[setIndex + 1].id, 'weight').requestFocus();
    } else {
      final blockIndex = allBlocks.indexOf(block);
      if (blockIndex < allBlocks.length - 1 && allBlocks[blockIndex + 1].sets.isNotEmpty) {
        _getNode(allBlocks[blockIndex + 1].sets.first.id, 'weight').requestFocus();
      }
    }
  }

  Future<void> _reorderExercises(List<ExerciseBlock> blocks, int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = blocks.removeAt(oldIndex);
    blocks.insert(newIndex, item);
    final db = ref.read(appDatabaseProvider);
    await db.transaction(() async {
      for (int i = 0; i < blocks.length; i++) {
        await (db.update(db.workoutSets)..where((t) => t.workoutId.equals(widget.workoutId) & t.exerciseOrder.equals(blocks[i].exerciseOrder)))
            .write(WorkoutSetsCompanion(exerciseOrder: Value(i)));
      }
    });
  }

  Future<void> _duplicateSet(WorkoutSet set) async {
    final db = ref.read(appDatabaseProvider);
    final setsInExercise = await (db.select(db.workoutSets)..where((t) => t.workoutId.equals(widget.workoutId) & t.exerciseOrder.equals(set.exerciseOrder))).get();
    final maxSetNum = setsInExercise.map((s) => s.setNumber).reduce((a, b) => a > b ? a : b);
    await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
      workoutId: widget.workoutId, exerciseId: set.exerciseId, exerciseOrder: set.exerciseOrder,
      setNumber: maxSetNum + 1, reps: set.reps, weight: set.weight, setType: Value(set.setType), notes: Value(set.notes),
    ));
  }

  Future<void> _checkPR(WorkoutSet set, Exercise exercise) async {
    if (set.weight <= 0 || set.reps <= 0) return;
    final db = ref.read(appDatabaseProvider);
    final double currentRM = set.weight * (1 + set.reps / 30);
    final pastSets = await (db.select(db.workoutSets)
      ..where((t) => t.exerciseId.equals(set.exerciseId) & t.completed.equals(true) & t.workoutId.equals(widget.workoutId).not()))
      .get();
    double bestPastRM = 0;
    for (var s in pastSets) {
      final rm = s.weight * (1 + s.reps / 30);
      if (rm > bestPastRM) bestPastRM = rm;
    }
    if (currentRM > bestPastRM && bestPastRM > 0) {
      if (mounted) {
        setState(() { 
          _prExerciseName = exercise.name; 
          _prAchievement = '${set.weight}kg x ${set.reps.toInt()}'; 
          _prsAchieved++; 
          _glowingExerciseId = exercise.id; 
        });
        _confettiController.play(); 
        _glowController.forward(); 
        SystemSound.play(SystemSoundType.click); 
        HapticFeedback.heavyImpact();
        
        // Persist PR status to database
        final db = ref.read(appDatabaseProvider);
        await (db.update(db.workoutSets)..where((t) => t.id.equals(set.id))).write(
          WorkoutSetsCompanion(isPr: const Value(true)),
        );
      }
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) { setState(() { _glowingExerciseId = null; }); _glowController.stop(); }
      });
    }
  }

  void _handleShake() {
    if (_lastDeletedSet != null) { _undoLastDeletion(); _lastDeletedSet = null; }
    else if (_lastDeletedExercise != null) { _undoLastDeletion(); _lastDeletedExercise = null; }
  }

  void _undoLastDeletion() async {
    final db = ref.read(appDatabaseProvider);
    if (_lastDeletedSet != null) {
      final s = _lastDeletedSet!;
        await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
        workoutId: s.workoutId, exerciseId: s.exerciseId, exerciseOrder: s.exerciseOrder,
        setNumber: s.setNumber, reps: s.reps, weight: s.weight, setType: Value(s.setType), notes: Value(s.notes), completed: Value(s.completed),
      ));
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Set restored')));
    } else if (_lastDeletedExercise != null) {
      final e = _lastDeletedExercise!;
      for (final s in e.sets) {
        await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
          workoutId: s.workoutId, exerciseId: s.exerciseId, exerciseOrder: s.exerciseOrder,
          setNumber: s.setNumber, reps: s.reps, weight: s.weight, setType: Value(s.setType), notes: Value(s.notes), completed: Value(s.completed),
        ));
      }
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exercise restored')));
    }
  }

  Future<void> _removeSet(int setId) async {
    final db = ref.read(appDatabaseProvider);
    final sets = await (db.select(db.workoutSets)..where((t) => t.id.equals(setId))).get();
    if (sets.isNotEmpty && mounted) {
      setState(() { _lastDeletedSet = sets.first; _lastDeletedExercise = null; });
    }
    await (db.delete(db.workoutSets)..where((t) => t.id.equals(setId))).go();
  }

  Future<void> _removeExercise(ExerciseBlock block) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Exercise?'),
        content: const Text('This will remove the exercise and all its sets from this session.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Remove', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      if (mounted) { setState(() { _lastDeletedExercise = block; _lastDeletedSet = null; }); }
      final db = ref.read(appDatabaseProvider);
      await (db.delete(db.workoutSets)..where((t) => t.workoutId.equals(widget.workoutId) & t.exerciseOrder.equals(block.exerciseOrder))).go();
    }
  }

  Future<void> _showRestTimer(int seconds, String currentExName, String? nextExName) async {
    final notifier = ref.read(timerNotifierProvider.notifier);
    final hasPermission = await notifier.checkPermissions();
    
    if (!hasPermission && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notifications are required for the rest timer to work in background.')),
      );
    }

    notifier.start(seconds, currentExName);
    if (mounted) {
      showModalBottomSheet(
        context: context, 
        backgroundColor: Colors.transparent, 
        isScrollControlled: true, 
        builder: (context) => RestTimerOverlay(
          nextExerciseName: nextExName, 
          onClose: () => Navigator.pop(context),
        ),
      );
    }
  }

  void _showPlateCalculator(double weight) {
    showDialog(context: context, builder: (context) => PlateCalculatorDialog(targetWeight: weight));
  }

  void _showExerciseMenu(ExerciseBlock block, Exercise exercise) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(LucideIcons.activity),
              title: const Text('Change Set Type'),
              subtitle: Text('Current: ${block.sets.first.setType.name}'),
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => SetTypeSelector(
                    currentType: block.sets.first.setType,
                    onSelect: (type) => _changeSetType(block, type),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.merge),
              title: const Text('Add to Superset'),
              subtitle: const Text('Link another exercise with this one'),
              onTap: () {
                Navigator.pop(context);
                _addToSuperset(block);
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.trash, color: Colors.red),
              title: const Text('Remove Exercise', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _removeExercise(block);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeSetType(ExerciseBlock block, SetType type) async {
    final db = ref.read(appDatabaseProvider);
    await (db.update(db.workoutSets)
          ..where((t) => t.workoutId.equals(widget.workoutId) & t.exerciseOrder.equals(block.exerciseOrder)))
        .write(WorkoutSetsCompanion(setType: Value(type)));
  }

  void _addToSuperset(ExerciseBlock block) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExercisePickerOverlay(
        onSelect: (id) async {
          final db = ref.read(appDatabaseProvider);
          final groupId = block.sets.first.supersetGroupId ?? const Uuid().v4();
          
          // Ensure original exercise has the group ID
          if (block.sets.first.supersetGroupId == null) {
            await (db.update(db.workoutSets)
                  ..where((t) => t.workoutId.equals(widget.workoutId) & t.exerciseOrder.equals(block.exerciseOrder)))
                .write(WorkoutSetsCompanion(supersetGroupId: Value(groupId)));
          }

          // Add new exercise in the same group, right after this one
          final existingSets = await (db.select(db.workoutSets)..where((t) => t.workoutId.equals(widget.workoutId))).get();
          final targetOrder = block.exerciseOrder + 1;
          
          // Shift existing exercises
          await db.transaction(() async {
            final blocksToShift = existingSets.where((s) => s.exerciseOrder >= targetOrder).map((s) => s.exerciseOrder).toSet().toList()..sort((a,b) => b.compareTo(a));
            for (var order in blocksToShift) {
              await (db.update(db.workoutSets)..where((t) => t.workoutId.equals(widget.workoutId) & t.exerciseOrder.equals(order)))
                  .write(WorkoutSetsCompanion(exerciseOrder: Value(order + 1)));
            }
            
            // Insert new exercise block
            await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
              workoutId: widget.workoutId,
              exerciseId: id,
              exerciseOrder: targetOrder,
              setNumber: 1,
              reps: 0,
              weight: 0,
              setType: Value(block.sets.first.setType), // Match set type
              supersetGroupId: Value(groupId),
            ));
          });
        },
      ),
    );
  }

  void _showExercisePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExercisePickerOverlay(
        onSelect: (id) async {
          final db = ref.read(appDatabaseProvider);
          final existingSets = await (db.select(db.workoutSets)..where((t) => t.workoutId.equals(widget.workoutId))).get();
          final nextOrder = existingSets.isEmpty ? 0 : existingSets.map((s) => s.exerciseOrder).reduce((a, b) => a > b ? a : b) + 1;
          await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
            workoutId: widget.workoutId,
            exerciseId: id,
            exerciseOrder: nextOrder,
            setNumber: 1,
            reps: 0,
            weight: 0,
            setType: const Value(SetType.straight),
          ));
        },
      ),
    );
  }

  Widget _buildSetTypeBadge(WorkoutSet set, int index) {
    String text = '$index';
    Color color = Theme.of(context).colorScheme.outline;
    
    switch (set.setType) {
      case SetType.warmup: text = 'W'; color = Colors.orange; break;
      case SetType.dropSet: text = 'D'; color = Colors.purple; break;
      case SetType.amrap: text = 'A'; color = Colors.red; break;
      case SetType.timed: text = 'T'; color = Colors.blue; break;
      case SetType.restPause: text = 'RP'; color = Colors.cyan; break;
      case SetType.cluster: text = 'C'; color = Colors.teal; break;
      case SetType.straight: break;
      case SetType.superset: text = 'S'; color = Colors.indigo; break;
    }

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  void _showSummary(Workout workout) async {
    final db = ref.read(appDatabaseProvider);
    final sets = await (db.select(db.workoutSets)..where((t) => t.workoutId.equals(widget.workoutId))).get();
    
    final completedSetsCount = sets.where((s) => s.completed).length;
    if (completedSetsCount == 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Log at least one set before finishing!'), backgroundColor: Colors.orange),
      );
      return;
    }

    final exercises = await ref.read(exerciseRepositoryProvider).getAllExercises();
    final duration = ref.read(workoutDurationProvider);
    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => WorkoutSummaryOverlay(
        workout: workout,
        sets: sets,
        exercises: exercises,
        elapsedSeconds: duration,
        prsAchieved: _prsAchieved,
        onSave: (notes) => _finishWorkout(workout, notes),
        onDiscard: _discardWorkout,
      ),
    );
  }

  Future<void> _finishWorkout(Workout workout, String notes) async {
    final db = ref.read(appDatabaseProvider);
    final duration = ref.read(workoutDurationProvider);
    await db.transaction(() async {
      await db.update(db.workouts).replace(workout.copyWith(
        status: 'completed',
        endTime: Value(DateTime.now()),
        duration: Value(duration),
        notes: Value(notes),
      ));
      await db.into(db.syncQueue).insert(SyncQueueCompanion.insert(workoutId: Value(workout.id), type: 'workout', createdAt: DateTime.now()));
    });
    
    // Trigger Sync
    ref.read(syncWorkerProvider.notifier).processQueue();

    if (mounted) {
      ref.invalidate(workoutHomeNotifierProvider);
      context.go('/app');
    }
  }

  Widget _buildSuggestionChip(int exerciseId, ExerciseBlock block) {
    return Consumer(
      builder: (context, ref, _) {
        final suggestionAsync = ref.watch(exerciseSuggestionProvider(exerciseId));
        final settings = ref.watch(settingsProvider).value ?? const SettingsState();
        final unit = settings.weightUnit;
        return suggestionAsync.when(
          data: (suggestion) {
            if (suggestion == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () {
                  // Find first incomplete set and update its weight
                  final firstIncomplete = block.sets.firstWhere((s) => !s.completed, orElse: () => block.sets.first);
                  _updateSet(firstIncomplete.id, weight: suggestion.suggestedWeight);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        suggestion.trendArrow == 'up' ? LucideIcons.trendingUp : (suggestion.trendArrow == 'down' ? LucideIcons.trendingDown : LucideIcons.dot),
                        size: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Suggested: ${WeightConverter.format(suggestion.suggestedWeight, unit)}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(LucideIcons.mousePointerClick, size: 10, color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
                    ],
                  ),
                ),
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        );
      },
    );
  }

  Future<void> _discardWorkout() async {
    final confirm = await showDialog<bool>(context: context, builder: (context) => AlertDialog(title: const Text('Discard Workout?'), content: const Text('All progress will be lost.'), actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')), TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Discard', style: TextStyle(color: Colors.red)))]));
    if (confirm == true) {
      final db = ref.read(appDatabaseProvider);
      await (db.delete(db.workouts)..where((t) => t.id.equals(widget.workoutId))).go();
      await (db.delete(db.workoutSets)..where((t) => t.workoutId.equals(widget.workoutId))).go();
      if (mounted) context.go('/app');
    }
  }
}

class ExerciseBlock {
  final int exerciseOrder;
  final int exerciseId;
  final List<WorkoutSet> sets;

  ExerciseBlock({required this.exerciseOrder, required this.exerciseId, required this.sets});
}
