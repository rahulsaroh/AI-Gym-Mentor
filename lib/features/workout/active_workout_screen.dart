import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/core/database/database.dart' as db;
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/exercise_providers.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';
import 'package:ai_gym_mentor/features/history/history_providers.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart'
    as entity;
import 'package:ai_gym_mentor/features/exercise_database/presentation/widgets/exercise_picker_overlay.dart';
import 'package:confetti/confetti.dart';
import 'package:ai_gym_mentor/features/workout/components/pr_banner.dart';
import 'package:ai_gym_mentor/features/workout/components/set_type_selector.dart';
import 'package:ai_gym_mentor/services/progression_service.dart';
import 'package:ai_gym_mentor/features/workout/providers/workout_home_notifier.dart';
import 'package:ai_gym_mentor/features/workout/components/workout_summary_overlay.dart';
import 'package:ai_gym_mentor/features/workout/components/superset_bracket_painter.dart';
import 'package:ai_gym_mentor/features/workout/providers/timer_notifier.dart';
import 'package:ai_gym_mentor/features/workout/components/floating_rest_timer.dart';
import 'package:ai_gym_mentor/features/analytics/data/strength_repository.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/core/utils/weight_converter.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:ai_gym_mentor/features/workout/providers/workout_duration_provider.dart';
import 'package:ai_gym_mentor/features/workout/components/exercise_header_card.dart';
import 'package:ai_gym_mentor/features/workout/components/ai_coach_cue.dart';
import 'package:ai_gym_mentor/features/workout/components/plate_calculator_dialog.dart';
import 'package:ai_gym_mentor/features/workout/components/set_logging_table.dart';
import 'package:ai_gym_mentor/features/workout/components/pr_victory_overlay.dart';
import 'package:ai_gym_mentor/features/workout/models/workout_models.dart';
import 'package:ai_gym_mentor/features/analytics/data/strength_repository.dart';

typedef Exercise = entity.ExerciseEntity;

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
  String? _initError; // Fix #3: track init errors for UI feedback
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

  // Focus Mode State
  bool _isFocusMode = true; // Default to focus mode as requested
  int _currentExerciseIndex = 0;
  
  // Timer Overlay State
  bool _isTimerOverlayVisible = false;
  String? _timerNextExName;

  // Ghost text history
  Map<int, List<db.WorkoutSet>> _previousSessionSets = {}; // exerciseId -> sets

  late PageController _pageController;
  late ScrollController _scrollController;

  // Fix #7: Cache the sets stream to avoid creating 3 duplicate Drift watchers per build()
  late Stream<List<db.WorkoutSet>> _setsStream;

  // Input management
  final TextEditingController _titleController = TextEditingController();
  final bool _isEditingTitle = false;
  final Map<int, TextEditingController> _weightControllers = {};
  final Map<int, TextEditingController> _repsControllers = {};
  final Map<int, TextEditingController> _secsControllers = {};
  final Map<int, TextEditingController> _rpeControllers = {};
  final Map<int, TextEditingController> _noteControllers = {};
  final Map<int, FocusNode> _weightNodes = {};
  final Map<int, FocusNode> _repsNodes = {};
  final Map<int, FocusNode> _secsNodes = {};
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

    _scrollController = ScrollController();
    _pageController = PageController(initialPage: _currentExerciseIndex);

    // Fix #7: Initialize the single sets stream here so all StreamBuilders share one watcher
    final database = ref.read(db.appDatabaseProvider);
    _setsStream = (database.select(database.workoutSets)
          ..where((t) => t.workoutId.equals(widget.workoutId)))
        .watch();

    // Fix #4: Start timer once, safely after first frame, outside StreamBuilder.build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || _timerStarted) return;
      _timerStarted = true;
      try {
        final database = ref.read(db.appDatabaseProvider);
        final workoutRow = await (database.select(database.workouts)
              ..where((t) => t.id.equals(widget.workoutId)))
            .getSingleOrNull();
        if (workoutRow != null && mounted) {
          _startTimer(workoutRow.startTime ?? workoutRow.date);
        }
      } catch (e) {
        debugPrint('ActiveWorkoutScreen: Error starting timer: $e');
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _glowController.dispose();
    // Removed _shakeDetector.dispose()
    _titleController.dispose();
    for (var c in _weightControllers.values) {
      c.dispose();
    }
    for (var c in _repsControllers.values) {
      c.dispose();
    }
    for (var c in _secsControllers.values) {
      c.dispose();
    }
    for (var c in _rpeControllers.values) {
      c.dispose();
    }
    for (var c in _noteControllers.values) {
      c.dispose();
    }
    for (var n in _weightNodes.values) {
      n.dispose();
    }
    for (var n in _repsNodes.values) {
      n.dispose();
    }
    for (var n in _secsNodes.values) {
      n.dispose();
    }
    for (var n in _rpeNodes.values) {
      n.dispose();
    }
    _scrollController.dispose();
    _pageController.dispose();
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
      case 'secs':
        map = _secsControllers;
        break;
      case 'rpe':
        map = _rpeControllers;
        break;
      case 'note':
        map = _noteControllers;
        break;
      default:
        // production-ready safety: log and fallback instead of crashing
        debugPrint('ActiveWorkoutScreen: Unknown type $type in _getController. Defaulting to note.');
        map = _noteControllers;
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
      case 'secs':
        map = _secsNodes;
        break;
      case 'rpe':
        map = _rpeNodes;
        break;
      default:
        // production-ready safety: log and fallback instead of crashing
        debugPrint('ActiveWorkoutScreen: Unknown type $type in _getNode. Defaulting to weight.');
        map = _weightNodes;
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
    try {
      final database = ref.read(db.appDatabaseProvider);
      final int? dayId = widget.dayId;

      debugPrint(
          'ActiveWorkoutScreen: Starting init for workout ${widget.workoutId}, dayId=$dayId');

      // 1. Fetch workout record first to see what kind of workout it is
      final workoutRow = await (database.select(database.workouts)
            ..where((t) => t.id.equals(widget.workoutId)))
          .getSingleOrNull();

      if (workoutRow == null) {
        if (mounted) {
          setState(() {
          _isInitializing = false;
          _initError = 'Workout not found.';
        });
        }
        return;
      }

      // 2. Check if we already have sets for this workout (e.g. Resume or Mesocycle)
      final existingSets = await (database.select(database.workoutSets)
            ..where((t) => t.workoutId.equals(widget.workoutId)))
          .get();

      if (existingSets.isNotEmpty) {
        debugPrint('ActiveWorkoutScreen: Workout already has ${existingSets.length} sets, skipping initialization');
        return;
      }

      // 3. If no sets, we must initialize from a template (dayId)
      final effectiveDayId = dayId ?? workoutRow.dayId;

      if (effectiveDayId == null) {
        debugPrint(
            'ActiveWorkoutScreen: No dayId found and no sets exist. Cannot initialize.');
        if (mounted) {
          setState(() {
          _isInitializing = false;
          _initError = 'Could not find workout data to initialize.';
        });
        }
        return;
      }

      await _processTemplate(database, effectiveDayId);
    } catch (e, stack) {
      // Fix #3: Surface errors to UI instead of silently swallowing them
      debugPrint('ActiveWorkoutScreen ERROR during initialization: $e');
      debugPrint(stack.toString());
      if (mounted) setState(() => _initError = 'Failed to load workout: ${e.toString().split('\n').first}');
    } finally {
      if (mounted) setState(() => _isInitializing = false);
    }
  }

  Future<void> _processTemplate(db.AppDatabase database, int dayId) async {
    final templateExercises = await (database.select(database.templateExercises)
          ..where((t) => t.dayId.equals(dayId))
          ..orderBy([(t) => OrderingTerm(expression: t.order)]))
        .get();

    debugPrint(
        'ActiveWorkoutScreen: Initializing with ${templateExercises.length} exercises for day $dayId');

    if (templateExercises.isEmpty) {
      debugPrint('ActiveWorkoutScreen: WARNING - No template exercises found for day $dayId!');
      return;
    }

    await database.transaction(() async {
      for (var i = 0; i < templateExercises.length; i++) {
        final te = templateExercises[i];
        
        // Parse sets from JSON if available, otherwise default to a single set
        List<dynamic> setsData = [];
        try {
          if (te.setsJson.isNotEmpty) {
            setsData = jsonDecode(te.setsJson);
          }
        } catch (e) {
          debugPrint('Error parsing setsJson for exercise ${te.exerciseId}: $e');
        }

        if (setsData.isEmpty) {
          // Fallback: Add at least one default set if no sets defined
          await database.into(database.workoutSets).insert(
                db.WorkoutSetsCompanion.insert(
                  workoutId: widget.workoutId,
                  exerciseId: te.exerciseId,
                  exerciseOrder: i,
                  setNumber: 1,
                  reps: 10,
                  weight: 0,
                  setType: Value(te.setType),
                  supersetGroupId: Value(te.supersetGroupId),
                ),
              );
        } else {
          // Insert each set defined in the template
          for (var j = 0; j < setsData.length; j++) {
            final setData = setsData[j];
            final double reps = (setData['reps'] as num?)?.toDouble() ?? 10.0;
            final double weight = (setData['weight'] as num?)?.toDouble() ?? 0.0;
            
            await database.into(database.workoutSets).insert(
                  db.WorkoutSetsCompanion.insert(
                    workoutId: widget.workoutId,
                    exerciseId: te.exerciseId,
                    exerciseOrder: i,
                    setNumber: j + 1,
                    reps: reps,
                    weight: weight,
                    setType: Value(te.setType),
                    supersetGroupId: Value(te.supersetGroupId),
                  ),
                );
          }
        }
      }
    });

    debugPrint('ActiveWorkoutScreen: Successully initialized workout from template');
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

    // Fix #3: Show error UI when initialization fails
    if (_initError != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(_initError!, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    setState(() { _initError = null; _isInitializing = true; });
                    _initializeFromTemplate();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final settings = ref.watch(settingsProvider).value ?? const SettingsState();
    final exercisesAsync = ref.watch(allExercisesProvider);
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

        // Fix #4: Timer is now started safely in initState; removed race-prone block from here.

        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            leading: IconButton(
                icon: const Icon(LucideIcons.chevronLeft, size: 22),
                onPressed: () async {
                  if (workout.mesocycleId != null) {
                    context.go('/programs/programs/mesocycle/${workout.mesocycleId}');
                    return;
                  }
                  
                  if (widget.dayId != null || workout.dayId != null) {
                    final dId = widget.dayId ?? workout.dayId;
                    final database = ref.read(db.appDatabaseProvider);
                    final day = await (database.select(database.templateDays)
                          ..where((t) => t.id.equals(dId!)))
                        .getSingleOrNull();
                    if (day != null && context.mounted) {
                      context.go('/programs/details/${day.templateId}');
                      return;
                    }
                  }
                  if (context.mounted) context.pop();
                }),
            title: StreamBuilder<List<db.WorkoutSet>>(
              stream: _watchSets(),
              builder: (context, snapshot) {
                final sets = snapshot.data ?? [];
                final completedCount = sets.where((s) => s.completed).length;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.name ?? 'Workout',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Consumer(
                          builder: (context, ref, _) {
                            final duration = ref.watch(workoutDurationProvider);
                            return Text(
                              _formatDuration(duration),
                              style: GoogleFonts.robotoMono(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            );
                          },
                        ),
                        Text(
                          ' • $completedCount/${sets.length} sets',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(LucideIcons.trash2, color: Colors.red, size: 20),
                onPressed: _discardWorkout,
              ),
              IconButton(
                icon: const Icon(LucideIcons.listOrdered, size: 20),
                onPressed: () => setState(() => _isFocusMode = !_isFocusMode),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 8),
                child: FilledButton(
                  onPressed: () => _showSummary(workout),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    minimumSize: const Size(0, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Finish',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4),
              child: StreamBuilder<List<db.WorkoutSet>>(
                stream: _watchSets(),
                builder: (context, snapshot) {
                  final sets = snapshot.data ?? [];
                  final completedCount = sets.where((s) => s.completed).length;
                  final progress = sets.isEmpty ? 0.0 : completedCount / sets.length;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: 4,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          body: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;
              
              if (workout.mesocycleId != null) {
                context.go('/programs/programs/mesocycle/${workout.mesocycleId}');
                return;
              }

              if (widget.dayId != null || workout.dayId != null) {
                final dId = widget.dayId ?? workout.dayId;
                final database = ref.read(db.appDatabaseProvider);
                final day = await (database.select(database.templateDays)
                      ..where((t) => t.id.equals(dId!)))
                    .getSingleOrNull();
                if (day != null && context.mounted) {
                  context.go('/programs/details/${day.templateId}');
                  return;
                }
              }
              
              // Fallback to discard confirmation if no specific program to return to
              _discardWorkout(showConfirm: true);
            },
            child: Stack(
              children: [
                StreamBuilder<List<db.WorkoutSet>>(
                  stream: _watchSets(),
                  builder: (context, setsSnapshot) {
                    final sets = setsSnapshot.data ?? [];
                    final exerciseBlocks = _groupSetsByExercise(sets);

                    if (_isFocusMode && exerciseBlocks.isNotEmpty) {
                      // Adjust index if out of bounds (can happen if exercise is deleted)
                      if (_currentExerciseIndex >= exerciseBlocks.length) {
                        _currentExerciseIndex = exerciseBlocks.length - 1;
                      }
                      if (_currentExerciseIndex < 0) _currentExerciseIndex = 0;
                      
                      return PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentExerciseIndex = index;
                          });
                        },
                        itemCount: exerciseBlocks.length,
                        itemBuilder: (context, index) {
                          final block = exerciseBlocks[index];
                          return SingleChildScrollView(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 120),
                            child: _buildExerciseBlock(
                                block, exerciseBlocks, settings, exercisesAsync),
                          );
                        },
                      );
                    }

                    return ReorderableListView.builder(
                      scrollController: _scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
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

                        final firstSet = block.sets.firstOrNull;
                        if (firstSet == null) {
                          return const SizedBox(
                              height: 100, key: ValueKey('empty_block'));
                        }
                        final currentGroupId = firstSet.supersetGroupId;
                        bool isFirst = false;
                        bool isLast = false;
                        bool isMiddle = false;

                        if (currentGroupId != null) {
                          final groupBlocks = exerciseBlocks
                              .where((b) =>
                                  b.sets.isNotEmpty &&
                                  b.sets.first.supersetGroupId ==
                                      currentGroupId)
                              .toList();
                          if (groupBlocks.length > 1) {
                            final idxInGroup = groupBlocks.indexOf(block);
                            isFirst = idxInGroup == 0;
                            isLast = idxInGroup == groupBlocks.length - 1;
                            isMiddle = !isFirst && !isLast;
                          }
                        }

                        return RepaintBoundary(
                          key: ValueKey('ex_block_${firstSet.id}'),
                          child: SupersetConnector(
                            isFirst: isFirst,
                            isLast: isLast,
                            isMiddle: isMiddle,
                            color: Theme.of(context).primaryColor,
                            child: _buildExerciseBlock(
                                block, exerciseBlocks, settings, exercisesAsync),
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
                // Fix #1: Guard both fields — _prAchievement can theoretically be null
                // if a race condition sets _prExerciseName but not _prAchievement yet.
                if (_prExerciseName != null && _prAchievement != null)
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
                
                // Floating Rest Timer
                if (_isTimerOverlayVisible)
                  Positioned(
                    bottom: 0,
                    left: 20,
                    right: 20,
                    child: FloatingRestTimer(
                      nextExerciseName: _timerNextExName,
                      onClose: () => setState(() => _isTimerOverlayVisible = false),
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: StreamBuilder<List<db.WorkoutSet>>(
            stream: _watchSets(),
            builder: (context, snapshot) {
              final sets = snapshot.data ?? [];
              final blocks = _groupSetsByExercise(sets);
              return _buildBottomNavigation(context, blocks, workout);
            },
          ),
        );
      },
    );
  }

  // Fix #7: Returns the cached stream (initialized in initState) instead of
  // creating a new Drift watcher on each call. Previously called 3 times per build().
  Stream<List<db.WorkoutSet>> _watchSets() => _setsStream;


  List<ExerciseBlock> _groupSetsByExercise(List<db.WorkoutSet> sets) {
    final Map<String, ExerciseBlock> groups = {};
    for (final set in sets) {
      final key = '${set.exerciseId}_${set.exerciseOrder}';
      groups
          .putIfAbsent(
              key,
              () => ExerciseBlock(
                  exerciseOrder: set.exerciseOrder,
                  exerciseId: set.exerciseId,
                  supersetGroupId: set.supersetGroupId,
                  sets: []))
          .sets
          .add(set);
    }
    return groups.values.toList()
      ..sort((a, b) => a.exerciseOrder.compareTo(b.exerciseOrder));
  }

  Widget _buildExerciseBlock(
      ExerciseBlock block,
      List<ExerciseBlock> allBlocks,
      SettingsState settings,
      AsyncValue<List<entity.ExerciseEntity>> exercisesAsync) {
    return exercisesAsync.when(
      data: (exercises) {
        if (exercises.isEmpty) {
          return const Center(child: Text('No exercises found in library'));
        }
        final Exercise exercise = exercises.firstWhere(
          (e) => e.id == block.exerciseId,
          orElse: () => exercises.first,
        );
        
        // Fix #22: use isGlowing
        final bool isGlowing = _glowingExerciseId == exercise.id;

        final content = Column(
          children: [
            // ── Exercise Header Card ──
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  if (isGlowing)
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                      blurRadius: 20 * _glowController.value,
                      spreadRadius: 4 * _glowController.value,
                    ),
                ],
              ),
              child: ExerciseHeaderCard(
                exercise: exercise,
                onMenuTap: () => _showExerciseMenu(block, exercise),
                isGlowing: isGlowing,
                glowValue: _glowController.value,
                hideMedia: block.sets.any((s) => s.completed),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // ── Progress Dots (Requirement 3) ──
            if (_isFocusMode) _buildExerciseProgressDots(allBlocks),
            
            if (_isFocusMode) const SizedBox(height: 16),

            // ── AI Coach Cues (Beat Hevy Phase 3) ──
            AICoachCue(block: block, exerciseName: exercise.name),
            
            const SizedBox(height: 12),
            
            // ── Set Logging Table (Requirement 5) ──
            SetLoggingTable(
                block: block,
                exercise: exercise,
                allBlocks: allBlocks,
                settings: settings,
                previousSessionSets: _previousSessionSets,
                onUpdateSet: _updateSet,
                onAddSet: _addSet,
                onRemoveSet: _removeSet,
                onToggleSet: _toggleSet,
                onAdjustValue: _adjustValue,
                getController: _getController,
                getNode: _getNode,
                onUndoDelete: () => _handleShake(),
              ),
            
            const SizedBox(height: 24),
          ],
        );

        if (!_isFocusMode) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: content,
            ),
          );
        }

        return content;
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }



  Widget _buildExerciseProgressDots(List<ExerciseBlock> allBlocks) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(allBlocks.length, (index) {
              final isCurrent = index == _currentExerciseIndex;
              final block = allBlocks[index];
              final isCompleted = block.sets.isNotEmpty && block.sets.every((s) => s.completed);
              
              return Container(
                width: isCurrent ? 16 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isCurrent 
                      ? Theme.of(context).primaryColor 
                      : (isCompleted ? Colors.green : Colors.grey[300]),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${(_currentExerciseIndex + 1) / allBlocks.length * 100 ~/ 1}% Complete',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  // Notes moved to bottom icon dialog
  void _showNotesDialog(ExerciseBlock block) {
    if (block.sets.isEmpty) return;
    final firstSet = block.sets.first;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(LucideIcons.pencil, size: 20),
            const SizedBox(width: 12),
            const Text('Exercise Note'),
          ],
        ),
        content: TextField(
          controller: _getController(firstSet.id, 'note', firstSet.notes ?? ''),
          maxLines: 5,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Type your note here...',
            border: OutlineInputBorder(),
          ),
          onChanged: (val) => _updateSet(firstSet.id, notes: val),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showMoreMenu(ExerciseBlock? block, db.Workout workout) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(LucideIcons.plus),
              title: const Text('Add Exercise'),
              onTap: () {
                Navigator.pop(context);
                _showExercisePicker();
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.circlePlus),
              title: const Text('New Library Exercise'),
              onTap: () {
                Navigator.pop(context);
                context.push('/exercises/create');
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.layers),
              title: const Text('Add Superset'),
              onTap: () {
                Navigator.pop(context);
                _showSupersetFlow();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(LucideIcons.trash2, color: Colors.red),
              title: const Text('Discard Workout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _discardWorkout();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Removed obsolete methods

  void _adjustValue(int setId, String type, TextEditingController controller,
      Function(String) onChanged, double direction) {
    HapticFeedback.lightImpact();
    double current = double.tryParse(controller.text) ?? 0;

    // Fix #23: Step size based on unit
    final userSettings = ref.read(settingsProvider).value;
    final unit = userSettings?.weightUnit ?? WeightUnit.kg;
    double step = type == 'weight' ? (unit == WeightUnit.kg ? 2.5 : 5.0) : 1.0;
    double next = current + (direction * step);

    if (next < 0) next = 0;

    // Fix #12: Clean formatting
    String formatted =
        type == 'weight' ? next.toStringAsFixed(1) : next.toInt().toString();
    if (formatted.endsWith('.0')) {
      formatted = formatted.substring(0, formatted.length - 2);
    }

    controller.text = formatted;
    onChanged(formatted);
  }


  Future<void> _addSet(ExerciseBlock block) async {
    final database = ref.read(db.appDatabaseProvider);
    if (block.sets.isEmpty) return;
    final lastSet = block.sets.last;
    await database
        .into(database.workoutSets)
        .insert(db.WorkoutSetsCompanion.insert(
          workoutId: widget.workoutId,
          exerciseId: block.exerciseId,
          exerciseOrder: block.exerciseOrder,
          setNumber: lastSet.setNumber + 1,
          reps: lastSet.reps,
          weight: lastSet.weight,
          setType: Value(lastSet.setType),
        ));
    // Fix #8: Removed _loadHistory() here — history from previous sessions
    // doesn't change during a workout; it's loaded once in initState.

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


  Future<void> _updateSet(int setId,
      {double? weight,
      double? reps,
      double? rpe,
      int? rir,
      String? notes}) async {
    final database = ref.read(db.appDatabaseProvider);
    await (database.update(database.workoutSets)
          ..where((t) => t.id.equals(setId)))
        .write(
      db.WorkoutSetsCompanion(
        weight: weight != null ? Value(weight) : const Value.absent(),
        reps: reps != null ? Value(reps) : const Value.absent(),
        rpe: rpe != null ? Value(rpe) : const Value.absent(),
        rir: rir != null ? Value(rir) : const Value.absent(),
        notes: notes != null ? Value(notes) : const Value.absent(),
      ),
    );
  }

  Future<void> _toggleSet(db.WorkoutSet set, entity.ExerciseEntity exercise,
      ExerciseBlock block, List<ExerciseBlock> allBlocks) async {
    final database = ref.read(db.appDatabaseProvider);
    final newCompleted = !set.completed;

    await (database.update(database.workoutSets)
          ..where((t) => t.id.equals(set.id)))
        .write(
      db.WorkoutSetsCompanion(
        completed: Value(newCompleted),
        completedAt: Value(newCompleted ? DateTime.now() : null),
      ),
    );

    if (newCompleted) {
      HapticFeedback.mediumImpact();
      _autoAdvance(set, block, allBlocks);
      _checkPR(set, exercise);
      _startAutoTimer(set, exercise, block, allBlocks);
    }

    // Fix #8: _loadHistory() removed here — re-querying all history on every set
    // toggle is wasteful; history was already loaded in initState.
    if (mounted) setState(() {});
  }

  Future<void> _startAutoTimer(
      db.WorkoutSet set,
      entity.ExerciseEntity exercise,
      ExerciseBlock block,
      List<ExerciseBlock> allBlocks) async {
    final settings = ref.read(settingsProvider).value;
    if (settings == null || !settings.autoStartRestTimer) return;

    // Determine rest time: Exercise specific > Set Type specific > Default 90s
    int restTime = exercise.restTime > 0 ? exercise.restTime : 90;

    if (set.setType == db.SetType.superset) {
      restTime = settings.restTimeSuperset;
    } else if (set.setType == db.SetType.dropSet) {
      restTime = settings.restTimeDropset;
    } else if (set.setType == db.SetType.straight) {
      restTime = settings.restTimeStraight;
    }

    String? nextExName;
    final currentIdx = allBlocks.indexOf(block);
    final lastSet = block.sets.lastOrNull;
    if (lastSet != null &&
        lastSet.id == set.id &&
        currentIdx < allBlocks.length - 1) {
      final nextBlock = allBlocks[currentIdx + 1];
      final exercises =
          await ref.read(exerciseRepositoryProvider).getAllExercises();
      final nextEx =
          exercises.where((e) => e.id == nextBlock.exerciseId).firstOrNull;
      nextExName = nextEx?.name;
    }

    _showRestTimer(restTime, exercise.name, nextExName);
  }

  Widget _build1RMBadge(List<db.WorkoutSet> sets) {
    double max1RM = 0;
    final settings = ref.watch(settingsProvider).value;
    final unit = settings?.weightUnit ?? WeightUnit.kg;

    for (var s in sets) {
      if (s.weight > 0 && s.reps > 0) {
        // Epley formula: weight * (1 + reps/30)
        final current1RM = s.weight * (1 + (s.reps / 30));
        if (current1RM > max1RM) max1RM = current1RM;
      }
    }

    if (max1RM <= 0) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('1RM',
              style: TextStyle(
                  fontSize: 8, fontWeight: FontWeight.bold, height: 1)),
          Text(
            '${WeightConverter.toDisplay(max1RM, unit).toStringAsFixed(1)}${unit == WeightUnit.kg ? 'kg' : 'lbs'}',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              height: 1,
            ),
          ),
        ],
      ),
    );
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

  // Fix #6: _isReordering prevents concurrent reorder operations that cause index conflicts.
  bool _isReordering = false;

  Future<void> _reorderExercises(
      List<ExerciseBlock> blocks, int oldIndex, int newIndex) async {
    if (_isReordering) return;
    // ReorderableListView includes the trailing fab_space item, so we must
    // clamp indices to the valid exercise block range first.
    if (oldIndex >= blocks.length || newIndex > blocks.length) return;
    if (newIndex > oldIndex) newIndex -= 1;

    // Capture the original exerciseOrder values BEFORE mutating the list.
    // Mutating the snapshot first, then reading .exerciseOrder from it causes
    // stale-order writes since exerciseOrder hasn't been updated in DB yet.
    final originalOrders = blocks.map((b) => b.exerciseOrder).toList();

    final item = blocks.removeAt(oldIndex);
    blocks.insert(newIndex, item);

    setState(() => _isReordering = true);
    try {
      final database = ref.read(db.appDatabaseProvider);
      await database.transaction(() async {
        for (int i = 0; i < blocks.length; i++) {
          // Use the captured original order to identify which sets to update.
          await (database.update(database.workoutSets)
                ..where((t) =>
                    t.workoutId.equals(widget.workoutId) &
                    t.exerciseOrder.equals(originalOrders[blocks.indexOf(blocks[i])])))
              .write(db.WorkoutSetsCompanion(exerciseOrder: Value(i)));
        }
      });
    } finally {
      if (mounted) setState(() => _isReordering = false);
    }
  }

  Future<void> _duplicateSet(db.WorkoutSet set) async {
    final database = ref.read(db.appDatabaseProvider);
    final setsInExercise = await (database.select(database.workoutSets)
          ..where((t) =>
              t.workoutId.equals(widget.workoutId) &
              t.exerciseOrder.equals(set.exerciseOrder)))
        .get();
    final maxSetNum = setsInExercise.isEmpty
        ? 0
        : setsInExercise
            .map((s) => s.setNumber)
            .reduce((a, b) => a > b ? a : b);
    await database
        .into(database.workoutSets)
        .insert(db.WorkoutSetsCompanion.insert(
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

  Future<void> _checkPR(
      db.WorkoutSet set, entity.ExerciseEntity exercise) async {
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
        // Fix #2: Use the user's display unit for the PR achievement string
        final userSettings = ref.read(settingsProvider).value;
        final unit = userSettings?.weightUnit ?? WeightUnit.kg;
        final displayWeight = WeightConverter.toDisplay(set.weight, unit);
        final unitLabel = unit == WeightUnit.kg ? 'kg' : 'lbs';
        setState(() {
          _prExerciseName = exercise.name;
          _prAchievement = '${displayWeight.toStringAsFixed(1)}$unitLabel x ${set.reps.toInt()}';
          _prsAchieved++;
          _glowingExerciseId = exercise.id;
        });
        _confettiController.play();
        _glowController.forward();
        SystemSound.play(SystemSoundType.click);
        HapticFeedback.heavyImpact();

        // Show Full Screen Victory Overlay (Beat Hevy Phase 5)
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => PRVictoryOverlay(
              exerciseName: exercise.name,
              achievement: '${displayWeight.toStringAsFixed(1)}$unitLabel x ${set.reps.toInt()}',
              onDismiss: () => Navigator.pop(context),
            ),
          );
        }

        await (database.update(database.workoutSets)
              ..where((t) => t.id.equals(set.id)))
            .write(
          db.WorkoutSetsCompanion(isPr: Value(true)),
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
    _undoLastDeletion();
  }

  void _undoLastDeletion() async {
    final database = ref.read(db.appDatabaseProvider);
    if (_lastDeletedSet != null) {
      final s = _lastDeletedSet!;
      await database
          .into(database.workoutSets)
          .insert(s.toCompanion(true));
      
      _lastDeletedSet = null; // Clear after undo
      
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Set restored')));
      }
    } else if (_lastDeletedExercise != null) {
      final e = _lastDeletedExercise!;
      // Batch insert all sets of the exercise
      await database.transaction(() async {
        for (final s in e.sets) {
          await database
              .into(database.workoutSets)
              .insert(s.toCompanion(true));
        }
      });
      
      _lastDeletedExercise = null; // Clear after undo
      
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Exercise restored')));
      }
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
    await (database.delete(database.workoutSets)
          ..where((t) => t.id.equals(setId)))
        .go();
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
              child: Text('Remove', style: TextStyle(color: Colors.red))),
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
    final notifier = ref.read(timerProvider.notifier);
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
      setState(() {
        _isTimerOverlayVisible = true;
        _timerNextExName = nextExName;
      });
    }
  }

  void _showPlateCalculator(double weight) {
    showDialog(
        context: context,
        builder: (context) => PlateCalculatorDialog(targetWeight: weight));
  }

  void _showExerciseMenu(ExerciseBlock block, entity.ExerciseEntity exercise) {
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
              leading: const Icon(LucideIcons.refreshCw),
              title: const Text('Replace Exercise'),
              subtitle: const Text('Swap with a different exercise'),
              onTap: () {
                Navigator.pop(context);
                _replaceExercise(block);
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.activity),
              title: const Text('Change Set Type'),
              subtitle: Text(
                  'Current: ${block.sets.firstOrNull?.setType.name ?? "straight"}'),
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => SetTypeSelector(
                    currentType:
                        block.sets.firstOrNull?.setType ?? db.SetType.straight,
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
          // Fix #19: Guard self-superset
          if (id == block.exerciseId) {
            if (context.mounted) Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cannot superset an exercise with itself')),
            );
            return;
          }

          final database = ref.read(db.appDatabaseProvider);
          final firstSet = block.sets.firstOrNull;
          if (firstSet == null) {
            if (context.mounted) Navigator.pop(context);
            return;
          }
          final groupId = firstSet.supersetGroupId ?? const Uuid().v4();

          if (firstSet.supersetGroupId == null) {
            await (database.update(database.workoutSets)
                  ..where((t) =>
                      t.workoutId.equals(widget.workoutId) &
                      t.exerciseOrder.equals(block.exerciseOrder)))
                .write(
                    db.WorkoutSetsCompanion(supersetGroupId: Value(groupId)));
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
                  .write(
                      db.WorkoutSetsCompanion(exerciseOrder: Value(order + 1)));
            }

            final companion = db.WorkoutSetsCompanion.insert(
              workoutId: widget.workoutId,
              exerciseId: id,
              exerciseOrder: targetOrder,
              setNumber: 1,
              reps: 10,
              weight: 0,
              setType: Value(db.SetType.superset),
              supersetGroupId: Value(groupId),
            );
            await database.into(database.workoutSets).insert(companion);
          });
          if (context.mounted) Navigator.pop(context);
        },
      ),
    );
  }

  void _showSupersetFlow() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExercisePickerOverlay(
        onSelect: (firstExId) {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => ExercisePickerOverlay(
              onSelect: (secondExId) {
                Navigator.pop(context);
                _createSupersetPair(firstExId, secondExId);
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _createSupersetPair(int firstExId, int secondExId) async {
    final database = ref.read(db.appDatabaseProvider);
    final sets = await (database.select(database.workoutSets)
          ..where((t) => t.workoutId.equals(widget.workoutId)))
        .get();
    final maxOrder = sets.isEmpty
        ? 0
        : sets.map((s) => s.exerciseOrder).reduce((a, b) => a > b ? a : b);

    final groupId = const Uuid().v4();

    await database.transaction(() async {
      // Add first exercise
      await database.into(database.workoutSets).insert(
            db.WorkoutSetsCompanion.insert(
              workoutId: widget.workoutId,
              exerciseId: firstExId,
              exerciseOrder: maxOrder + 1,
              setNumber: 1,
              reps: 10,
              weight: 0,
              setType: Value(db.SetType.superset),
              supersetGroupId: Value(groupId),
            ),
          );
      // Add second exercise
      await database.into(database.workoutSets).insert(
            db.WorkoutSetsCompanion.insert(
              workoutId: widget.workoutId,
              exerciseId: secondExId,
              exerciseOrder: maxOrder + 2,
              setNumber: 1,
              reps: 10,
              weight: 0,
              setType: Value(db.SetType.superset),
              supersetGroupId: Value(groupId),
            ),
          );
    });
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
          await database
              .into(database.workoutSets)
              .insert(db.WorkoutSetsCompanion.insert(
                workoutId: widget.workoutId,
                exerciseId: id,
                exerciseOrder: nextOrder,
                setNumber: 1,
                reps: 0,
                weight: 0,
                setType: Value(db.SetType.straight),
              ));
          if (context.mounted) Navigator.pop(context);

          // Fix: Show feedback and scroll to the end in Focus Mode
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Exercise added to workout')),
            );

            if (_isFocusMode) {
              Future.delayed(const Duration(milliseconds: 300), () {
                if (_pageController.hasClients) {
                  _pageController.animateToPage(
                    nextOrder,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              });
            }
          }
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
      case db.SetType.superset:
        text = 'S';
        color = Colors.indigo;
        break;
      case db.SetType.straight:
        break;
      case db.SetType.failure:
        text = 'F';
        color = Colors.red.shade700;
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
    
    final sets = await (database.select(database.workoutSets)
          ..where((t) => t.workoutId.equals(widget.workoutId)))
        .get();
    final exerciseIds = sets.map((s) => s.exerciseId).toSet().toList();

    await database.transaction(() async {
      await database.update(database.workouts).replace(workout.copyWith(
            status: 'completed',
            endTime: Value(DateTime.now()),
            duration: Value(duration),
            notes: Value(notes),
          ));
      
      // Increment usage count for each exercise
      final repo = ref.read(exerciseRepositoryProvider);
      for (final id in exerciseIds) {
        await repo.incrementUsageCount(id);
      }

      // Generate 1RM snapshots (Beat Hevy Phase 5: Advanced Analytics)
      final settings = await ref.read(settingsProvider.future);
      final strengthRepo = ref.read(strengthRepositoryProvider);
      await strengthRepo.processWorkout(workout.id, settings.oneRmFormula);
    });

    if (mounted) {
      // Close the summary bottom sheet first
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      ref.invalidate(workoutHomeProvider);
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
          error: (_, _) => const SizedBox.shrink(),
        );
      },
    );
  }

  Future<void> _discardWorkout({bool showConfirm = true}) async {
    bool? confirm = true;
    if (showConfirm) {
      confirm = await showDialog<bool>(
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
    }
    if (confirm == true) {
      final database = ref.read(db.appDatabaseProvider);
      
      try {
        await database.transaction(() async {
          await (database.delete(database.workoutSets)
                ..where((t) => t.workoutId.equals(widget.workoutId)))
              .go();
          await (database.delete(database.workouts)
                ..where((t) => t.id.equals(widget.workoutId)))
              .go();
        });

        if (mounted) {
          ref.invalidate(workoutHomeProvider);
          // Also invalidate history if they are viewing it
          ref.invalidate(historyListProvider);
          
          Navigator.of(context, rootNavigator: true).popUntil(
              (route) => route.isFirst || route.settings.name == '/app');
          
          if (context.mounted) {
            context.go('/app');
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error discarding workout: $e')),
          );
        }
      }
    }
  }

  void _replaceExercise(ExerciseBlock block) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExercisePickerOverlay(
        onSelect: (newExerciseId) async {
          final database = ref.read(db.appDatabaseProvider);
          // Update all sets of this exercise block to the new exercise
          await (database.update(database.workoutSets)
                ..where((t) =>
                    t.workoutId.equals(widget.workoutId) &
                    t.exerciseOrder.equals(block.exerciseOrder)))
              .write(db.WorkoutSetsCompanion(
            exerciseId: Value(newExerciseId),
          ));
          if (context.mounted) Navigator.pop(context);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Exercise replaced')),
            );
          }
        },
      ),
    );
  }

  Widget _buildBottomNavigation(
      BuildContext context, List<ExerciseBlock> exerciseBlocks, db.Workout? workout) {
    final currentBlock =
        exerciseBlocks.isNotEmpty && _currentExerciseIndex < exerciseBlocks.length
            ? exerciseBlocks[_currentExerciseIndex]
            : null;
    final hasNote =
        currentBlock?.sets.any((s) => s.notes != null && s.notes!.isNotEmpty) ??
            false;

    return Material(
      color: Theme.of(context).cardColor,
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: SafeArea(
          bottom: true,
          top: false,
          child: Row(
            children: [
              // Navigation Controls
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(LucideIcons.chevronLeft, size: 20),
                      onPressed: _currentExerciseIndex > 0
                          ? () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                    ),
                    Text(
                      '${_currentExerciseIndex + 1} of ${exerciseBlocks.length}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.chevronRight, size: 20),
                      onPressed:
                          _currentExerciseIndex < exerciseBlocks.length - 1
                              ? () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              : null,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Action Icons
              IconButton(
                icon: const Icon(LucideIcons.plus, size: 22),
                color: Theme.of(context).primaryColor,
                onPressed: _showExercisePicker,
                tooltip: 'Add Exercise',
              ),

              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      hasNote ? LucideIcons.fileText : LucideIcons.pencil,
                      color: hasNote
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.outline,
                      size: 22,
                    ),
                    onPressed: currentBlock != null
                        ? () => _showNotesDialog(currentBlock)
                        : null,
                  ),
                  if (hasNote)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                ],
              ),

              IconButton(
                icon: const Icon(LucideIcons.ellipsisVertical, size: 22),
                onPressed: workout != null
                    ? () => _showMoreMenu(currentBlock, workout)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Removed redundant local classes: _ActiveWorkoutHeader, _LiveWorkoutDurationText, _WorkoutProgressBadge, _ExerciseMediaWidget
// These are either handled by the main Scaffold AppBar or available as shared components.

