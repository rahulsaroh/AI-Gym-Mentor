import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/core/database/database.dart' as db;
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:ai_gym_mentor/features/exercises/exercises_provider.dart';
import 'package:ai_gym_mentor/features/exercises/exercise_repository.dart';
import 'package:ai_gym_mentor/core/domain/entities/exercise.dart';
import 'package:ai_gym_mentor/core/domain/entities/exercise.dart' as entity;
import 'package:confetti/confetti.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ai_gym_mentor/services/sync_worker.dart';
import 'package:ai_gym_mentor/core/widgets/speed_dial_fab.dart';
import 'package:ai_gym_mentor/features/workout/components/pr_banner.dart';
import 'package:ai_gym_mentor/features/workout/components/set_type_selector.dart';
import 'package:ai_gym_mentor/services/progression_service.dart';
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';
import 'package:ai_gym_mentor/features/workout/components/workout_summary_overlay.dart';
import 'package:ai_gym_mentor/features/workout/components/superset_bracket_painter.dart';
import 'package:ai_gym_mentor/features/workout/components/rest_timer_overlay.dart';
import 'package:ai_gym_mentor/features/workout/providers/timer_notifier.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/core/utils/weight_converter.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:ai_gym_mentor/features/workout/providers/workout_duration_provider.dart';
import 'package:ai_gym_mentor/features/workout/components/plate_calculator_dialog.dart';
import 'package:ai_gym_mentor/features/exercises/components/exercise_picker_overlay.dart';

class ActiveWorkoutScreen extends ConsumerStatefulWidget {
  final int workoutId;
  final int? dayId;

  const ActiveWorkoutScreen({
    super.key,
    required this.workoutId,
    this.dayId,
  });

  @override
  ConsumerState<ActiveWorkoutScreen> createState() =>
      _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends ConsumerState<ActiveWorkoutScreen>
    with TickerProviderStateMixin {
  bool _isInitializing = true;
  bool _timerStarted = false;
  int _prsAchieved = 0;

  // PR Celebration State
  late ConfettiController _confettiController;
  late AnimationController _glowController;
  int? _glowingExerciseId;
  String? _prExerciseName;
  String? _prAchievement;

  // Undo State
  db.WorkoutSet? _lastDeletedSet;
  ExerciseBlock? _lastDeletedExercise;

  // Ghost text history
  Map<int, List<db.WorkoutSet>> _previousSessionSets = {}; // exerciseId -> sets

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

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _glowController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _glowController.forward();
        }
      });

    // Removed _shakeDetector as per scope control plan
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _glowController.dispose();
    // Removed _shakeDetector.dispose()
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

  TextEditingController _getController(
      int setId, String type, String initialValue) {
    final Map<int, TextEditingController> map;
    switch (type) {
      case 'weight':
        map = _weightControllers;
        break;
      case 'reps':
        map = _repsControllers;
        break;
      case 'rpe':
        map = _rpeControllers;
        break;
      case 'note':
        map = _noteControllers;
        break;
      default:
        throw UnimplementedError();
    }
    if (!map.containsKey(setId)) {
      map[setId] = TextEditingController(text: initialValue);
    }
    return map[setId]!;
  }

  FocusNode _getNode(int setId, String type) {
    final Map<int, FocusNode> map;
    switch (type) {
      case 'weight':
        map = _weightNodes;
        break;
      case 'reps':
        map = _repsNodes;
        break;
      case 'rpe':
        map = _rpeNodes;
        break;
      default:
        throw UnimplementedError();
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
    final database = ref.read(db.appDatabaseProvider);
    final existingSets = await (database.select(database.workoutSets)
          ..where((t) => t.workoutId.equals(widget.workoutId)))
        .get();
    if (existingSets.isEmpty) {
      final templateExercises = await (database.select(database.templateExercises)
            ..where((t) => t.dayId.equals(widget.dayId!))
            ..orderBy([(t) => OrderingTerm(expression: t.order)]))
          .get();
      for (var i = 0; i < templateExercises.length; i++) {
        final te = templateExercises[i];
        await database.into(database.workoutSets).insert(db.WorkoutSetsCompanion.insert(
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
    if (h > 0) {
      return '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final database = ref.read(db.appDatabaseProvider);
    final workoutStream = database.select(database.workouts)
      ..where((t) => t.id.equals(widget.workoutId));

    return StreamBuilder<List<db.Workout>>(
      stream: workoutStream.watch(),
      builder: (context, workoutSnapshot) {
        final workout = workoutSnapshot.data?.firstOrNull;
        if (workout == null) {
          return const Scaffold(body: Center(child: Text('Workout not found')));
        }

        if (!_timerStarted) {
          _timerStarted = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _startTimer(workout.startTime ?? workout.date);
          });
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(LucideIcons.chevronLeft),
                onPressed: () => context.pop()),
            title: _ActiveWorkoutHeader(
              workoutId: widget.workoutId,
              isEditingTitle: _isEditingTitle,
              onEditTitle: (val) => setState(() => _isEditingTitle = val),
              titleController: _titleController,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilledButton(
                  onPressed: () => _showSummary(workout),
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Finish',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          body: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;
              final bool? discard = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Discard Workout?'),
                  content: const Text(
                      'Are you sure you want to discard this workout? All progress will be lost.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('RESUME'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('DISCARD'),
                    ),
                  ],
                ),
              );
              if (discard == true) {
                _discardWorkout();
              }
            },
            child: Stack(
              children: [
                StreamBuilder<List<db.WorkoutSet>>(
                  stream: _watchSets(),
                  builder: (context, setsSnapshot) {
                    final sets = setsSnapshot.data ?? [];
                    if (mounted) {
                      HapticFeedback.mediumImpact();
                    }
                    final exerciseBlocks = _groupSetsByExercise(sets);
                    return ReorderableListView.builder(
                      scrollController: _scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: exerciseBlocks.length + 1,
                      onReorder: (oldIndex, newIndex) =>
                          _reorderExercises(exerciseBlocks, oldIndex, newIndex),
                      itemBuilder: (context, index) {
                        if (index == exerciseBlocks.length) {
                          return const SizedBox(
                              height: 100, key: ValueKey('fab_space'));
                        }
                        final block = exerciseBlocks[index];

                        final currentGroupId = block.sets.first.supersetGroupId;
                        bool isFirst = false;
                        bool isLast = false;
                        bool isMiddle = false;

                        if (currentGroupId != null) {
                          final groupBlocks = exerciseBlocks
                              .where((b) =>
                                  b.sets.first.supersetGroupId == currentGroupId)
                              .toList();
                          if (groupBlocks.length > 1) {
                            final idxInGroup = groupBlocks.indexOf(block);
                            isFirst = idxInGroup == 0;
                            isLast = idxInGroup == groupBlocks.length - 1;
                            isMiddle = !isFirst && !isLast;
                          }
                        }

                        return RepaintBoundary(
                          key: ValueKey(
                              'ex_${block.exerciseId}_${block.exerciseOrder}'),
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
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                    numberOfParticles: 20,
                    gravity: 0.1,
                  ),
                ),
                if (_prExerciseName != null)
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: PRBanner(
                      exerciseName: _prExerciseName!,
                      achievement: _prAchievement!,
                      onDismissed: () => setState(() {
                        _prExerciseName = null;
                        _prAchievement = null;
                      }),
                    ),
                  ),
              ],
            ),
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
              SpeedDialChild(
                  icon: LucideIcons.layers,
                  label: 'Add Superset',
                  onTap: () {}),
              SpeedDialChild(
                  icon: LucideIcons.check,
                  label: 'Finish Workout',
                  onTap: () => _showSummary(workout)),
              SpeedDialChild(
                icon: LucideIcons.trash2,
                label: 'Discard Workout',
                backgroundColor: Colors.red.withValues(alpha: 0.1),
                foregroundColor: Colors.red,
                onTap: () {
                  HapticFeedback.heavyImpact();
                  _discardWorkout();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Stream<List<db.WorkoutSet>> _watchSets() {
    final database = ref.read(db.appDatabaseProvider);
    return (database.select(database.workoutSets)
          ..where((t) => t.workoutId.equals(widget.workoutId)))
        .watch();
  }

  List<ExerciseBlock> _groupSetsByExercise(List<db.WorkoutSet> sets) {
    final Map<int, ExerciseBlock> groups = {};
    for (final set in sets) {
      groups
          .putIfAbsent(
              set.exerciseOrder,
              () => ExerciseBlock(
                  exerciseOrder: set.exerciseOrder,
                  exerciseId: set.exerciseId,
                  sets: []))
          .sets
          .add(set);
    }
    return groups.values.toList()
      ..sort((a, b) => a.exerciseOrder.compareTo(b.exerciseOrder));
  }

  Widget _buildExerciseBlock(
      ExerciseBlock block, List<ExerciseBlock> allBlocks) {
    final exercisesAsync = ref.watch(allExercisesProvider);
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();
    final unit = settings.weightUnit;
    return exercisesAsync.when(
      data: (exercises) {
        if (exercises.isEmpty) {
          return const Center(child: Text('No exercises found in library'));
        }
        final Exercise exercise = exercises.firstWhere(
          (e) => e.id == block.exerciseId,
          orElse: () => exercises.first,
        );
        final bool isGlowing = _glowingExerciseId == exercise.id;
        return AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            final double glow = isGlowing ? _glowController.value : 0.0;
            return Card(
              elevation: glow * 10,
              margin: const EdgeInsets.only(bottom: 16),
              shadowColor: Colors.amber.withValues(alpha: glow),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isGlowing
                      ? Colors.amber.withValues(alpha: 0.4 + glow * 0.6)
                      : Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withValues(alpha: 0.5),
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
                    ReorderableDragStartListener(
                      index: allBlocks.indexOf(block),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Icon(
                          LucideIcons.gripVertical,
                          size: 20,
                          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(exercise.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            _buildMuscleChip(exercise.primaryMuscle),
                            if (exercise.secondaryMuscle != null)
                              _buildMuscleChip(exercise.secondaryMuscle!,
                                  isSecondary: true),
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
                if (exercise.instructions != null &&
                    exercise.instructions!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      children: [
                        Icon(LucideIcons.lightbulb,
                            size: 14,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            exercise.instructions!.join('\n'),
                            style: TextStyle(
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                _buildSuggestionChip(exercise.id, block),
                const SizedBox(height: 12),
                TextField(
                  controller: _getController(block.sets.first.id, 'note',
                      block.sets.first.notes ?? ''),
                  decoration: InputDecoration(
                    hintText: 'Add a note...',
                    hintStyle: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.outline),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 12),
                  onChanged: (val) =>
                      _updateSet(block.sets.first.id, notes: val),
                ),
                const SizedBox(height: 8),
                Row(children: [
                  const SizedBox(
                      width: 38,
                      child: Text('Set',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text(unit == WeightUnit.kg ? 'kg' : 'lbs',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold))),
                  const Expanded(
                      child: Text('Reps',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold))),
                  const Expanded(
                      child: Text('RPE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold))),
                  const SizedBox(width: 48),
                ]),
                const Divider(),
                ...block.sets.asMap().entries.map((entry) => _buildSetRow(
                    entry.value, entry.key + 1, exercise, block, allBlocks)),
                const SizedBox(height: 8),
                Semantics(
                  label: 'Add new set to ${exercise.name}',
                  button: true,
                  child: TextButton.icon(
                    onPressed: () => _addSet(block),
                    icon: const Icon(LucideIcons.plus, size: 16),
                    label: const Text('Add Set',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(88, 48),
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
        color: isSecondary
            ? Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.5)
            : Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label.toUpperCase(),
          style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: isSecondary
                  ? Theme.of(context).colorScheme.onSecondaryContainer
                  : Theme.of(context).colorScheme.onPrimaryContainer)),
    );
  }

  Widget _buildSetRow(db.WorkoutSet set, int index, entity.Exercise exercise,
      ExerciseBlock block, List<ExerciseBlock> allBlocks) {
    final isCompleted = set.completed;
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();
    final unit = settings.weightUnit;
    final Color rowColor = isCompleted
        ? Colors.green.withValues(alpha: 0.1)
        : (set.setType == db.SetType.warmup
            ? Colors.orange.withValues(alpha: 0.05)
            : Colors.transparent);

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
                    action: SnackBarAction(
                        label: 'Undo', onPressed: () => _handleShake()),
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
                    value: set.weight == 0
                        ? ''
                        : WeightConverter.toDisplay(set.weight, unit)
                            .toStringAsFixed(1),
                    hint: _getPreviousValue(
                        set.exerciseId, set.setNumber, 'weight', unit),
                    onChanged: (val) => _updateSet(set.id,
                        weight: WeightConverter.toStorage(
                            double.tryParse(val) ?? 0, unit)),
                    isCompleted: isCompleted,
                    onLongPress: () => _showPlateCalculator(
                        WeightConverter.toDisplay(set.weight, unit)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text('×',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
                Expanded(
                  child: _buildCellInput(
                    setId: set.id,
                    type: 'reps',
                    value: set.reps == 0 ? '' : set.reps.toInt().toString(),
                    hint: _getPreviousValue(
                        set.exerciseId, set.setNumber, 'reps', unit),
                    onChanged: (val) =>
                        _updateSet(set.id, reps: double.tryParse(val) ?? 0),
                    isCompleted: isCompleted,
                  ),
                ),
                Expanded(
                  child: _buildRpePicker(set, isCompleted),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _buildRirPicker(set, isCompleted),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _toggleSet(set, exercise, block, allBlocks),
                  child: Container(
                    width: 54,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Colors.green
                          : Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                      border: isCompleted 
                        ? null 
                        : Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
                    ),
                    child: Icon(
                      LucideIcons.check,
                      size: 22,
                      color: isCompleted
                          ? Colors.white
                          : Theme.of(context).colorScheme.outline,
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

  Widget _buildRpePicker(db.WorkoutSet set, bool isCompleted) {
    return GestureDetector(
      onTap: isCompleted ? null : () => _showIntensityPicker(set, true),
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: isCompleted
              ? Colors.transparent
              : Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          set.rpe == null ? 'RPE' : set.rpe.toString(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: set.rpe == null
                ? Theme.of(context).colorScheme.outline.withValues(alpha: 0.5)
                : (isCompleted ? Theme.of(context).colorScheme.outline : null),
          ),
        ),
      ),
    );
  }

  Widget _buildRirPicker(db.WorkoutSet set, bool isCompleted) {
    return GestureDetector(
      onTap: isCompleted ? null : () => _showIntensityPicker(set, false),
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: isCompleted
              ? Colors.transparent
              : Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          set.rir == null ? 'RIR' : set.rir.toString(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: set.rir == null
                ? Theme.of(context).colorScheme.outline.withValues(alpha: 0.5)
                : (isCompleted ? Theme.of(context).colorScheme.outline : null),
          ),
        ),
      ),
    );
  }

  void _showIntensityPicker(db.WorkoutSet set, bool forRpe) {
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
            Text(forRpe ? 'Select RPE' : 'Select RIR',
                style: GoogleFonts.outfit(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
                forRpe
                    ? 'Rate of Perceived Exertion (1-10)'
                    : 'Reps In Reserve (How many more could you do?)',
                style: TextStyle(color: Theme.of(context).colorScheme.outline)),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: forRpe ? 11 : 6,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  if (index == 0) return _buildIntensityChip(set, null, forRpe);
                  return _buildIntensityChip(
                      set, (index - (forRpe ? 0 : 0)).toDouble(), forRpe);
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildIntensityChip(db.WorkoutSet set, double? value, bool forRpe) {
    final double? currentValue = forRpe ? set.rpe : (set.rir?.toDouble());
    final isSelected = currentValue == value;
    return ChoiceChip(
      label: Text(value == null
          ? 'None'
          : (forRpe ? value.toString() : value.toInt().toString())),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          if (forRpe) {
            _updateSet(set.id, rpe: value);
          } else {
            _updateSet(set.id, rir: value?.toInt());
          }
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
    final bool hasHint = hint != '-' && hint.isNotEmpty;
    final controller = _getController(setId, type, value);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Semantics(
                label: '$type for set',
                child: GestureDetector(
                  onLongPress: onLongPress,
                  child: TextField(
                    focusNode: _getNode(setId, type),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? Theme.of(context).colorScheme.outline : null,
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                      filled: true,
                      fillColor: isCompleted
                          ? Colors.transparent
                          : Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(alpha: 0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: hint,
                      hintStyle: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4)),
                    ),
                    controller: controller,
                    textInputAction: TextInputAction.next,
                    onChanged: onChanged,
                    onTap: () {
                      if (controller.text.isEmpty && hasHint) {
                        HapticFeedback.lightImpact();
                        controller.text = hint;
                        onChanged(hint);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        if (!isCompleted)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildQuickButton(
                  icon: LucideIcons.minus,
                  onPressed: () => _adjustValue(setId, type, controller, onChanged, -1),
                ),
                const SizedBox(width: 8),
                _buildQuickButton(
                  icon: LucideIcons.plus,
                  onPressed: () => _adjustValue(setId, type, controller, onChanged, 1),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _adjustValue(int setId, String type, TextEditingController controller, Function(String) onChanged, double direction) {
    HapticFeedback.lightImpact();
    double current = double.tryParse(controller.text) ?? 0;
    
    double step = type == 'weight' ? 2.5 : 1.0;
    double next = current + (direction * step);
    
    if (next < 0) next = 0;
    
    String formatted = type == 'weight' ? next.toStringAsFixed(1) : next.toInt().toString();
    if (formatted.endsWith('.0')) formatted = formatted.substring(0, formatted.length - 2);
    
    controller.text = formatted;
    onChanged(formatted);
  }

  Widget _buildQuickButton({required IconData icon, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 14, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  Future<void> _addSet(ExerciseBlock block) async {
    final database = ref.read(db.appDatabaseProvider);
    final lastSet = block.sets.last;
    await database.into(database.workoutSets).insert(db.WorkoutSetsCompanion.insert(
          workoutId: widget.workoutId,
          exerciseId: block.exerciseId,
          exerciseOrder: block.exerciseOrder,
          setNumber: lastSet.setNumber + 1,
          reps: lastSet.reps,
          weight: lastSet.weight,
          setType: Value(lastSet.setType),
        ));
    _loadHistory();

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
    final database = ref.read(db.appDatabaseProvider);
    final completedWorkouts = await (database.select(database.workouts)
          ..where((t) => t.status.equals('completed'))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)
          ]))
        .get();
    if (completedWorkouts.isEmpty) return;
    final lastWorkoutId = completedWorkouts.first.id;
    final historySets = await (database.select(database.workoutSets)
          ..where((t) => t.workoutId.equals(lastWorkoutId)))
        .get();
    final Map<int, List<db.WorkoutSet>> historyMap = {};
    for (var s in historySets) {
      historyMap.putIfAbsent(s.exerciseId, () => []).add(s);
    }
    if (mounted) setState(() => _previousSessionSets = historyMap);
  }

  String _getPreviousValue(
      int exerciseId, int setNumber, String type, WeightUnit unit) {
    if (!_previousSessionSets.containsKey(exerciseId)) return '-';
    final sets = _previousSessionSets[exerciseId]!;
    final match = sets.where((s) => s.setNumber == setNumber).firstOrNull ??
        sets.lastOrNull;
    if (match == null) return '-';
    switch (type) {
      case 'weight':
        return match.weight == 0
            ? '-'
            : WeightConverter.toDisplay(match.weight, unit).toStringAsFixed(1);
      case 'reps':
        return match.reps == 0 ? '-' : match.reps.toInt().toString();
      case 'rpe':
        return match.rpe == null ? '-' : match.rpe.toString();
      case 'rir':
        return match.rir == null ? '-' : match.rir.toString();
      default:
        return '-';
    }
  }

  Future<void> _updateSet(int setId,
      {double? weight,
      double? reps,
      double? rpe,
      int? rir,
      String? notes}) async {
    final database = ref.read(db.appDatabaseProvider);
    await (database.update(database.workoutSets)..where((t) => t.id.equals(setId))).write(
      db.WorkoutSetsCompanion(
        weight: weight != null ? Value(weight) : const Value.absent(),
        reps: reps != null ? Value(reps) : const Value.absent(),
        rpe: rpe != null ? Value(rpe) : const Value.absent(),
        rir: rir != null ? Value(rir) : const Value.absent(),
        notes: notes != null ? Value(notes) : const Value.absent(),
      ),
    );
  }

  Future<void> _toggleSet(db.WorkoutSet set, entity.Exercise exercise,
      ExerciseBlock block, List<ExerciseBlock> allBlocks) async {
    final database = ref.read(db.appDatabaseProvider);
    final newCompleted = !set.completed;
    await (database.update(database.workoutSets)..where((t) => t.id.equals(set.id))).write(
      db.WorkoutSetsCompanion(
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
          final exercises =
              await ref.read(exerciseRepositoryProvider).getAllExercises();
          final nextEx =
              exercises.where((e) => e.id == nextBlock.exerciseId).firstOrNull;
          nextExName = nextEx?.name;
        }
        _showRestTimer(exercise.restTime, exercise.name, nextExName);
      }
    }
  }

  void _autoAdvance(db.WorkoutSet currentSet, ExerciseBlock block,
      List<ExerciseBlock> allBlocks) {
    final setIndex = block.sets.indexOf(currentSet);
    if (setIndex < block.sets.length - 1) {
      _getNode(block.sets[setIndex + 1].id, 'weight').requestFocus();
    } else {
      final blockIndex = allBlocks.indexOf(block);
      if (blockIndex < allBlocks.length - 1 &&
          allBlocks[blockIndex + 1].sets.isNotEmpty) {
        _getNode(allBlocks[blockIndex + 1].sets.first.id, 'weight')
            .requestFocus();
      }
    }
  }

  Future<void> _reorderExercises(
      List<ExerciseBlock> blocks, int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = blocks.removeAt(oldIndex);
    blocks.insert(newIndex, item);
    final database = ref.read(db.appDatabaseProvider);
    await database.transaction(() async {
      for (int i = 0; i < blocks.length; i++) {
        await (database.update(database.workoutSets)
              ..where((t) =>
                  t.workoutId.equals(widget.workoutId) &
                  t.exerciseOrder.equals(blocks[i].exerciseOrder)))
            .write(db.WorkoutSetsCompanion(exerciseOrder: Value(i)));
      }
    });
  }

  Future<void> _duplicateSet(db.WorkoutSet set) async {
    final database = ref.read(db.appDatabaseProvider);
    final setsInExercise = await (database.select(database.workoutSets)
          ..where((t) =>
              t.workoutId.equals(widget.workoutId) &
              t.exerciseOrder.equals(set.exerciseOrder)))
        .get();
    final maxSetNum =
        setsInExercise.map((s) => s.setNumber).reduce((a, b) => a > b ? a : b);
    await database.into(database.workoutSets).insert(db.WorkoutSetsCompanion.insert(
          workoutId: widget.workoutId,
          exerciseId: set.exerciseId,
          exerciseOrder: set.exerciseOrder,
          setNumber: maxSetNum + 1,
          reps: set.reps,
          weight: set.weight,
          setType: Value(set.setType),
          notes: Value(set.notes),
        ));
  }

  Future<void> _checkPR(db.WorkoutSet set, entity.Exercise exercise) async {
    if (set.weight <= 0 || set.reps <= 0) return;
    final database = ref.read(db.appDatabaseProvider);
    final double currentRM = set.weight * (1 + set.reps / 30);
    final pastSets = await (database.select(database.workoutSets)
          ..where((t) =>
              t.exerciseId.equals(set.exerciseId) &
              t.completed.equals(true) &
              t.workoutId.equals(widget.workoutId).not()))
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

        final database = ref.read(db.appDatabaseProvider);
        await (database.update(database.workoutSets)..where((t) => t.id.equals(set.id)))
            .write(
          db.WorkoutSetsCompanion(isPr: const Value(true)),
        );
      }
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) {
          setState(() {
            _glowingExerciseId = null;
          });
          _glowController.stop();
        }
      });
    }
  }

  void _handleShake() {
    if (_lastDeletedSet != null) {
      _undoLastDeletion();
      _lastDeletedSet = null;
    } else if (_lastDeletedExercise != null) {
      _undoLastDeletion();
      _lastDeletedExercise = null;
    }
  }

  void _undoLastDeletion() async {
    final database = ref.read(db.appDatabaseProvider);
    if (_lastDeletedSet != null) {
      final s = _lastDeletedSet!;
      await database.into(database.workoutSets).insert(db.WorkoutSetsCompanion.insert(
            workoutId: s.workoutId,
            exerciseId: s.exerciseId,
            exerciseOrder: s.exerciseOrder,
            setNumber: s.setNumber,
            reps: s.reps,
            weight: s.weight,
            setType: Value(s.setType),
            notes: Value(s.notes),
            completed: Value(s.completed),
          ));
      if (mounted)
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Set restored')));
    } else if (_lastDeletedExercise != null) {
      final e = _lastDeletedExercise!;
      for (final s in e.sets) {
        await database.into(database.workoutSets).insert(db.WorkoutSetsCompanion.insert(
              workoutId: s.workoutId,
              exerciseId: s.exerciseId,
              exerciseOrder: s.exerciseOrder,
              setNumber: s.setNumber,
              reps: s.reps,
              weight: s.weight,
              setType: Value(s.setType),
              notes: Value(s.notes),
              completed: Value(s.completed),
            ));
      }
      if (mounted)
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Exercise restored')));
    }
  }

  Future<void> _removeSet(int setId) async {
    final database = ref.read(db.appDatabaseProvider);
    final sets = await (database.select(database.workoutSets)
          ..where((t) => t.id.equals(setId)))
        .get();
    if (sets.isNotEmpty && mounted) {
      setState(() {
        _lastDeletedSet = sets.first;
        _lastDeletedExercise = null;
      });
    }
    await (database.delete(database.workoutSets)..where((t) => t.id.equals(setId))).go();
  }

  Future<void> _removeExercise(ExerciseBlock block) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Exercise?'),
        content: const Text(
            'This will remove the exercise and all its sets from this session.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Remove', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      if (mounted) {
        setState(() {
          _lastDeletedExercise = block;
          _lastDeletedSet = null;
        });
      }
      final database = ref.read(db.appDatabaseProvider);
      await (database.delete(database.workoutSets)
            ..where((t) =>
                t.workoutId.equals(widget.workoutId) &
                t.exerciseOrder.equals(block.exerciseOrder)))
          .go();
    }
  }

  Future<void> _showRestTimer(
      int seconds, String currentExName, String? nextExName) async {
    final notifier = ref.read(timerNotifierProvider.notifier);
    final hasPermission = await notifier.checkPermissions();

    if (!hasPermission && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Notifications are required for the rest timer to work in background.')),
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
    showDialog(
        context: context,
        builder: (context) => PlateCalculatorDialog(targetWeight: weight));
  }

  void _showExerciseMenu(ExerciseBlock block, entity.Exercise exercise) {
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
              title: const Text('Remove Exercise',
                  style: TextStyle(color: Colors.red)),
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

  Future<void> _changeSetType(ExerciseBlock block, db.SetType type) async {
    final database = ref.read(db.appDatabaseProvider);
    await (database.update(database.workoutSets)
          ..where((t) =>
              t.workoutId.equals(widget.workoutId) &
              t.exerciseOrder.equals(block.exerciseOrder)))
        .write(db.WorkoutSetsCompanion(setType: Value(type)));
  }

  void _addToSuperset(ExerciseBlock block) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExercisePickerOverlay(
        onSelect: (id) async {
          final database = ref.read(db.appDatabaseProvider);
          final groupId = block.sets.first.supersetGroupId ?? const Uuid().v4();

          if (block.sets.first.supersetGroupId == null) {
            await (database.update(database.workoutSets)
                  ..where((t) =>
                      t.workoutId.equals(widget.workoutId) &
                      t.exerciseOrder.equals(block.exerciseOrder)))
                .write(db.WorkoutSetsCompanion(supersetGroupId: Value(groupId)));
          }

          final existingSets = await (database.select(database.workoutSets)
                ..where((t) => t.workoutId.equals(widget.workoutId)))
              .get();
          final targetOrder = block.exerciseOrder + 1;

          await database.transaction(() async {
            final blocksToShift = existingSets
                .where((s) => s.exerciseOrder >= targetOrder)
                .map((s) => s.exerciseOrder)
                .toSet()
                .toList()
              ..sort((a, b) => b.compareTo(a));
            for (var order in blocksToShift) {
              await (database.update(database.workoutSets)
                    ..where((t) =>
                        t.workoutId.equals(widget.workoutId) &
                        t.exerciseOrder.equals(order)))
                  .write(db.WorkoutSetsCompanion(exerciseOrder: Value(order + 1)));
            }

            await database.into(database.workoutSets).insert(db.WorkoutSetsCompanion.insert(
                  workoutId: widget.workoutId,
                  exerciseId: id,
                  exerciseOrder: targetOrder,
                  setNumber: 1,
                  reps: 0,
                  weight: 0,
                  setType: Value(block.sets.first.setType),
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
          final database = ref.read(db.appDatabaseProvider);
          final existingSets = await (database.select(database.workoutSets)
                ..where((t) => t.workoutId.equals(widget.workoutId)))
              .get();
          final nextOrder = existingSets.isEmpty
              ? 0
              : existingSets
                      .map((s) => s.exerciseOrder)
                      .reduce((a, b) => a > b ? a : b) +
                  1;
          await database.into(database.workoutSets).insert(db.WorkoutSetsCompanion.insert(
                workoutId: widget.workoutId,
                exerciseId: id,
                exerciseOrder: nextOrder,
                setNumber: 1,
                reps: 0,
                weight: 0,
                setType: Value(db.SetType.straight),
              ));
        },
      ),
    );
  }

  Widget _buildSetTypeBadge(db.WorkoutSet set, int index) {
    String text = '$index';
    Color color = Theme.of(context).colorScheme.outline;

    switch (set.setType) {
      case db.SetType.warmup:
        text = 'W';
        color = Colors.orange;
        break;
      case db.SetType.dropSet:
        text = 'D';
        color = Colors.purple;
        break;
      case db.SetType.amrap:
        text = 'A';
        color = Colors.red;
        break;
      case db.SetType.timed:
        text = 'T';
        color = Colors.blue;
        break;
      case db.SetType.restPause:
        text = 'RP';
        color = Colors.cyan;
        break;
      case db.SetType.cluster:
        text = 'C';
        color = Colors.teal;
        break;
      case db.SetType.straight:
        break;
      case db.SetType.superset:
        text = 'S';
        color = Colors.indigo;
        break;
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

  void _showSummary(db.Workout workout) async {
    final database = ref.read(db.appDatabaseProvider);
    final sets = await (database.select(database.workoutSets)
          ..where((t) => t.workoutId.equals(widget.workoutId)))
        .get();

    final completedSetsCount = sets.where((s) => s.completed).length;
    if (completedSetsCount == 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Log at least one set before finishing!'),
            backgroundColor: Colors.orange),
      );
      return;
    }

    final exercises =
        await ref.read(exerciseRepositoryProvider).getAllExercises();
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

  Future<void> _finishWorkout(db.Workout workout, String notes) async {
    final database = ref.read(db.appDatabaseProvider);
    final duration = ref.read(workoutDurationProvider);
    await database.transaction(() async {
      await database.update(database.workouts).replace(workout.copyWith(
            status: 'completed',
            endTime: Value(DateTime.now()),
            duration: Value(duration),
            notes: Value(notes),
          ));
      await database.into(database.syncQueue).insert(db.SyncQueueCompanion.insert(
          workoutId: Value(workout.id),
          type: 'workout',
          createdAt: DateTime.now()));
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
        final suggestionAsync =
            ref.watch(exerciseSuggestionProvider(exerciseId));
        final settings =
            ref.watch(settingsProvider).value ?? const SettingsState();
        final unit = settings.weightUnit;
        return suggestionAsync.when(
          data: (suggestion) {
            if (suggestion == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () {
                  // Find first incomplete set and update its weight
                  final firstIncomplete = block.sets.firstWhere(
                      (s) => !s.completed,
                      orElse: () => block.sets.first);
                  _updateSet(firstIncomplete.id,
                      weight: suggestion.suggestedWeight);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        suggestion.trendArrow == 'up'
                            ? LucideIcons.trendingUp
                            : (suggestion.trendArrow == 'down'
                                ? LucideIcons.trendingDown
                                : LucideIcons.dot),
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
                      Icon(LucideIcons.mousePointerClick,
                          size: 10,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withValues(alpha: 0.5)),
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
    final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Discard Workout?'),
                content: const Text('All progress will be lost.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Discard',
                          style: TextStyle(color: Colors.red)))
                ]));
    if (confirm == true) {
    final database = ref.read(db.appDatabaseProvider);
    await (database.delete(database.workouts)
          ..where((t) => t.id.equals(widget.workoutId)))
        .go();
    await (database.delete(database.workoutSets)
          ..where((t) => t.workoutId.equals(widget.workoutId)))
        .go();
      if (mounted) context.go('/app');
    }
  }

  Future<void> _undoDelete() async {
    if (_lastDeletedSet != null) {
      final database = ref.read(db.appDatabaseProvider);
      await database.into(database.workoutSets).insert(_lastDeletedSet!.toCompanion(true));
      setState(() => _lastDeletedSet = null);
    }
  }
}

class _ActiveWorkoutHeader extends ConsumerWidget {
  final int workoutId;
  final bool isEditingTitle;
  final Function(bool) onEditTitle;
  final TextEditingController titleController;

  const _ActiveWorkoutHeader({
    required this.workoutId,
    required this.isEditingTitle,
    required this.onEditTitle,
    required this.titleController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(db.appDatabaseProvider);
    final workoutAsync = ref.watch(workoutUpdateProvider(workoutId));

    return workoutAsync.when(
      data: (workout) => GestureDetector(
        onTap: () => onEditTitle(true),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditingTitle)
              SizedBox(
                height: 32,
                child: TextField(
                  controller: titleController,
                  autofocus: true,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                  onSubmitted: (val) async {
                    await (database.update(database.workouts)
                          ..where((t) => t.id.equals(workoutId)))
                        .write(db.WorkoutsCompanion(name: Value(val)));
                    onEditTitle(false);
                  },
                ),
              )
            else
              Text(workout.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis),
            Row(
              children: [
                const _LiveWorkoutDurationText(),
                const SizedBox(width: 8),
                _WorkoutProgressBadge(workoutId: workoutId),
              ],
            ),
          ],
        ),
      ),
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _LiveWorkoutDurationText extends ConsumerWidget {
  const _LiveWorkoutDurationText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(workoutDurationProvider);
    return Text(_formatDuration(duration),
        style: const TextStyle(fontSize: 12));
  }

  String _formatDuration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    if (h > 0) {
      return '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}

class _WorkoutProgressBadge extends ConsumerWidget {
  final int workoutId;
  const _WorkoutProgressBadge({required this.workoutId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(db.appDatabaseProvider);
    return StreamBuilder<List<db.WorkoutSet>>(
      stream: (database.select(database.workoutSets)..where((t) => t.workoutId.equals(workoutId))).watch(),
      builder: (context, snapshot) {
        final sets = snapshot.data ?? [];
        final completedCount = sets.where((s) => s.completed).length;
        return Text(
          '• $completedCount/${sets.length} sets',
          style: TextStyle(
              fontSize: 12, color: Theme.of(context).colorScheme.primary),
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}

final workoutUpdateProvider = StreamProvider.family<db.Workout, int>((ref, id) {
  final database = ref.watch(db.appDatabaseProvider);
  return (database.select(database.workouts)..where((t) => t.id.equals(id)))
      .watchSingle();
});

class ExerciseBlock {
  final int exerciseOrder;
  final int exerciseId;
  final List<db.WorkoutSet> sets;

  ExerciseBlock(
      {required this.exerciseOrder,
      required this.exerciseId,
      required this.sets});
}
