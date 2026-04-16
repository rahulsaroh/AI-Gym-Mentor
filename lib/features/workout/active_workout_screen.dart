import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ai_gym_mentor/core/database/database.dart' as db;
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/exercise_providers.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';
import 'package:ai_gym_mentor/features/history/history_providers.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart'
    as entity;
import 'package:ai_gym_mentor/features/exercise_database/presentation/widgets/exercise_media_widget.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/widgets/exercise_picker_overlay.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  // Ghost text history
  Map<int, List<db.WorkoutSet>> _previousSessionSets = {}; // exerciseId -> sets

  late PageController _pageController;

  late ScrollController _scrollController;

  // Input management
  final TextEditingController _titleController = TextEditingController();
  bool _isEditingTitle = false;
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

    // Removed _shakeDetector as per scope control plan
    _scrollController = ScrollController();
    _pageController = PageController(initialPage: _currentExerciseIndex);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _glowController.dispose();
    // Removed _shakeDetector.dispose()
    _titleController.dispose();
    for (var c in _weightControllers.values) c.dispose();
    for (var c in _repsControllers.values) c.dispose();
    for (var c in _secsControllers.values) c.dispose();
    for (var c in _rpeControllers.values) c.dispose();
    for (var c in _noteControllers.values) c.dispose();
    for (var n in _weightNodes.values) n.dispose();
    for (var n in _repsNodes.values) n.dispose();
    for (var n in _secsNodes.values) n.dispose();
    for (var n in _rpeNodes.values) n.dispose();
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
        throw UnimplementedError('Type $type is not implemented in _getController');
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
        throw UnimplementedError('Type $type is not implemented in _getNode');
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

      if (dayId == null) {
        // Try to fetch it from the workout record in DB if not provided via constructor
        final workoutRow = await (database.select(database.workouts)
              ..where((t) => t.id.equals(widget.workoutId)))
            .getSingleOrNull();

        if (workoutRow?.dayId == null) {
          debugPrint(
              'ActiveWorkoutScreen: dayId is null in widget and database, skipping template init');
          if (mounted) setState(() => _isInitializing = false);
          return;
        }

        // Proceed with the fetched dayId
        await _processTemplate(database, workoutRow!.dayId!);
      } else {
        await _processTemplate(database, dayId);
      }
    } catch (e, stack) {
      debugPrint('ActiveWorkoutScreen ERROR during initialization: $e');
      debugPrint(stack.toString());
    } finally {
      if (mounted) setState(() => _isInitializing = false);
    }
  }

  Future<void> _processTemplate(db.AppDatabase database, int dayId) async {
    // Check if we already have sets for this workout to avoid duplicates
    final existingSets = await (database.select(database.workoutSets)
          ..where((t) => t.workoutId.equals(widget.workoutId)))
        .get();

    debugPrint(
        'ActiveWorkoutScreen: Found ${existingSets.length} existing sets for workout ${widget.workoutId}');

    if (existingSets.isNotEmpty) {
      debugPrint('ActiveWorkoutScreen: Workout already has sets, skipping initialization');
      return;
    }

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

        if (!_timerStarted) {
          _timerStarted = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            try {
              _startTimer(workout.startTime ?? workout.date);
            } catch (e) {
              debugPrint('ActiveWorkoutScreen: Error starting timer: $e');
            }
          });
        }

        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            leading: IconButton(
                icon: const Icon(LucideIcons.chevronLeft, size: 22),
                onPressed: () => context.pop()),
            title: StreamBuilder<List<db.WorkoutSet>>(
              stream: _watchSets(),
              builder: (context, snapshot) {
                final sets = snapshot.data ?? [];
                final completedCount = sets.where((s) => s.completed).length;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.name,
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
              // Call _discardWorkout which handles the confirmation dialog
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

                      final block = exerciseBlocks[_currentExerciseIndex];
                      
                      return Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
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
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  child: _buildExerciseBlock(
                                      block, exerciseBlocks, settings, exercisesAsync),
                                );
                              },
                            ),
                          ),
                          // Bottom Navigation Controls
                          _buildBottomNavigation(exerciseBlocks),
                        ],
                      );
                    }

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
            heroTagPrefix: 'active_workout',
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
        
        final bool isGlowing = _glowingExerciseId == exercise.id;

        final content = Column(
          children: [
            // ── Exercise Header Card ──
            _buildExerciseHeaderCard(exercise, block),
            
            const SizedBox(height: 12),
            
            // ── Progress Dots (Requirement 3) ──
            if (_isFocusMode) _buildExerciseProgressDots(allBlocks),
            
            if (_isFocusMode) const SizedBox(height: 16),
            
            // ── Notes Section (Requirement 4) ──
            _buildNotesSection(block),
            
            const SizedBox(height: 20),
            
            // ── Set Logging Table (Requirement 5) ──
            _buildSetTable(block, exercise, allBlocks, settings),
            
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

  Widget _buildExerciseHeaderCard(Exercise exercise, ExerciseBlock block) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               // Exercise Media
              SizedBox(
                height: 180,
                width: double.infinity,
                child: ExerciseMediaWidget(
                  animatedUrl: exercise.gifUrl,
                  staticUrl: exercise.imageUrls.isNotEmpty ? exercise.imageUrls.first : null,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise.name,
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              ...exercise.primaryMuscles.map((m) => _buildPillBadge(m, Colors.blue)),
                              ...exercise.secondaryMuscles.map((m) => _buildPillBadge(m, Colors.blue.withOpacity(0.5))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      children: [
                        Material(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => context.push('/exercises/${exercise.id}'),
                            child: Container(
                              width: 48,
                              height: 48,
                              alignment: Alignment.center,
                              child: const Icon(LucideIcons.info, color: Colors.white70, size: 24),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Info',
                          style: GoogleFonts.inter(fontSize: 10, color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 12,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white, size: 24),
              onPressed: () => _showExerciseMenu(block, exercise),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4), width: 0.5),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
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

  Widget _buildNotesSection(ExerciseBlock block) {
    final firstSet = block.sets.firstOrNull;
    if (firstSet == null) return const SizedBox.shrink();
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: const Icon(LucideIcons.pencil, size: 16),
          title: Text(
            'Add a note for this exercise...',
            style: GoogleFonts.inter(fontSize: 14, color: Theme.of(context).colorScheme.outline),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: TextField(
                controller: _getController(firstSet.id, 'note', firstSet.notes ?? ''),
                maxLines: 3,
                style: GoogleFonts.inter(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Type your note here...',
                  border: InputBorder.none,
                  fillColor: Theme.of(context).colorScheme.surface,
                  filled: true,
                  contentPadding: const EdgeInsets.all(12),
                ),
                onChanged: (val) => _updateSet(firstSet.id, notes: val),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSetTable(ExerciseBlock block, Exercise exercise, List<ExerciseBlock> allBlocks, SettingsState settings) {
    final unit = settings.weightUnit;
    return Column(
      children: [
        // Table Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              _buildTableHeaderLabel('SET', 40),
              Expanded(child: _buildTableHeaderLabel('WEIGHT (${unit == WeightUnit.kg ? 'KG' : 'LBS'})', 0)),
              Expanded(child: _buildTableHeaderLabel(exercise.setType == 'Timed' ? 'SECS' : 'REPS', 0)),
              _buildTableHeaderLabel('RPE', 50),
              _buildTableHeaderLabel('RIR', 50),
              const SizedBox(width: 44), // Action column
            ],
          ),
        ),
        const Divider(height: 1),
        const SizedBox(height: 12),
        // Set Rows
        ...block.sets.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: _buildSetRow(entry.value, entry.key + 1, exercise, block, allBlocks, settings),
          );
        }),
        const SizedBox(height: 12),
        // Add Set Button
        _buildAddSetButton(block),
      ],
    );
  }

  Widget _buildTableHeaderLabel(String label, double? width) {
    return Container(
      width: width,
      alignment: Alignment.center,
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.outline.withOpacity(0.6),
        ),
      ),
    );
  }

  Widget _buildAddSetButton(ExerciseBlock block) {
    return InkWell(
      onTap: () => _addSet(block),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            style: BorderStyle.solid, // Custom dashed border would need a painter
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.plus, size: 16, color: Theme.of(context).colorScheme.outline),
            const SizedBox(width: 8),
            Text(
              'Add Set',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(List<ExerciseBlock> exerciseBlocks) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _currentExerciseIndex > 0
                  ? () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
              icon: const Icon(LucideIcons.chevronLeft, size: 18),
              label: const Text('Previous'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(LucideIcons.plus, color: Colors.white),
              onPressed: _showExercisePicker,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _currentExerciseIndex < exerciseBlocks.length - 1
                  ? () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
              icon: const Text('Next'),
              label: const Icon(LucideIcons.chevronRight, size: 18),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetRow(
      db.WorkoutSet set,
      int index,
      entity.ExerciseEntity exercise,
      ExerciseBlock block,
      List<ExerciseBlock> allBlocks,
      SettingsState settings) {
    final isCompleted = set.completed;
    final unit = settings.weightUnit;
    
    // Check if this is the "active" set (first non-completed set)
    final isActive = block.sets.firstWhere((s) => !s.completed, orElse: () => block.sets.first).id == set.id;

    return Slidable(
      key: ValueKey('set_${set.id}'),
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
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isCompleted 
              ? Colors.green.withOpacity(0.08) 
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(
              color: isCompleted 
                  ? Colors.green 
                  : (isActive ? Theme.of(context).primaryColor : Colors.transparent),
              width: 4,
            ),
          ),
          boxShadow: [
            if (isActive && !isCompleted)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            // Set Number Badge
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isCompleted 
                    ? Colors.green 
                    : (isActive ? Theme.of(context).primaryColor : Colors.grey[200]),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                index.toString(),
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: (isCompleted || isActive) ? Colors.white : Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Weight Input
            Expanded(
              child: _buildRedesignedCellInput(
                setId: set.id,
                type: 'weight',
                value: WeightConverter.toDisplay(set.weight, unit).toStringAsFixed(1),
                onChanged: (val) => _updateSet(set.id, weight: WeightConverter.toStorage(double.tryParse(val) ?? 0, unit)),
                isCompleted: isCompleted,
              ),
            ),
            const SizedBox(width: 8),
            // Reps Input
            Expanded(
              child: _buildRedesignedCellInput(
                setId: set.id,
                type: exercise.setType == 'Timed' ? 'secs' : 'reps',
                value: set.reps.toInt().toString(),
                onChanged: (val) => _updateSet(set.id, reps: double.tryParse(val) ?? 0),
                isCompleted: isCompleted,
              ),
            ),
            const SizedBox(width: 8),
            // RPE
            _buildCompactIntensityInput(set, true, isCompleted),
            const SizedBox(width: 8),
            // RIR
            _buildCompactIntensityInput(set, false, isCompleted),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _toggleSet(set, exercise, block, allBlocks),
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 300),
                tween: Tween(begin: 0.0, end: isCompleted ? 1.0 : 0.0),
                builder: (context, value, child) {
                  return Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Color.lerp(Colors.transparent, Colors.green, value),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.lerp(Colors.grey[300]!, Colors.green, value)!,
                        width: 2,
                      ),
                      boxShadow: [
                        if (value > 0.5)
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3 * value),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                      ],
                    ),
                    child: value > 0.5 
                        ? const Icon(LucideIcons.check, size: 18, color: Colors.white) 
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRedesignedCellInput({
    required int setId,
    required String type,
    required String value,
    required Function(String) onChanged,
    bool isCompleted = false,
  }) {
    final controller = _getController(setId, type, value);
    final focusNode = _getNode(setId, type);

    // Sync controller text with value if it's different and not currently being edited
    if (!focusNode.hasFocus && controller.text != value) {
       controller.text = value;
    }

    return Column(
      children: [
        SizedBox(
          width: 70,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isCompleted ? Theme.of(context).colorScheme.outline : null,
            ),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 4),
              border: InputBorder.none,
              hintText: '0',
            ),
            onChanged: onChanged,
            onTap: () {
               // Focus is handled by TextField itself, adding onTap for clarity
               focusNode.requestFocus();
            },
          ),
        ),
        if (!isCompleted)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRoundIconButton(
                icon: LucideIcons.minus,
                onPressed: () => _adjustValue(setId, type, controller, onChanged, -1),
              ),
              const SizedBox(width: 8),
              _buildRoundIconButton(
                icon: LucideIcons.plus,
                onPressed: () => _adjustValue(setId, type, controller, onChanged, 1),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildRoundIconButton({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: Theme.of(context).primaryColor),
      ),
    );
  }

  Widget _buildCompactIntensityInput(db.WorkoutSet set, bool forRpe, bool isCompleted) {
    final value = forRpe ? set.rpe : set.rir;
    return GestureDetector(
      onTap: isCompleted ? null : () => _showIntensityPicker(set, forRpe),
      child: Container(
        width: 44,
        height: 32,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          value?.toString() ?? '—',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: value == null ? Colors.grey[400] : null,
          ),
        ),
      ),
    );
  }

  // Removed obsolete methods

  void _showSetNoteDialog(db.WorkoutSet set) {
    showDialog(
      context: context,
      builder: (context) {
        final controller = _getController(set.id, 'note', set.notes ?? '');
        return AlertDialog(
          title: const Text('Set Note'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter note for this set...'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                _updateSet(set.id, notes: controller.text);
                Navigator.pop(context);
                setState(() {}); // Refresh UI for icon color
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
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
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isCompleted
                          ? Theme.of(context).colorScheme.outline
                          : null,
                      decoration:
                          isCompleted ? TextDecoration.lineThrough : null,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 4),
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
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.4)),
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
                  onPressed: () =>
                      _adjustValue(setId, type, controller, onChanged, -1),
                ),
                const SizedBox(width: 8),
                _buildQuickButton(
                  icon: LucideIcons.plus,
                  onPressed: () =>
                      _adjustValue(setId, type, controller, onChanged, 1),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _adjustValue(int setId, String type, TextEditingController controller,
      Function(String) onChanged, double direction) {
    HapticFeedback.lightImpact();
    double current = double.tryParse(controller.text) ?? 0;

    double step = type == 'weight' ? 2.5 : 1.0;
    double next = current + (direction * step);

    if (next < 0) next = 0;

    String formatted =
        type == 'weight' ? next.toStringAsFixed(1) : next.toInt().toString();
    if (formatted.endsWith('.0'))
      formatted = formatted.substring(0, formatted.length - 2);

    controller.text = formatted;
    onChanged(formatted);
  }

  Widget _buildQuickButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surfaceContainerHighest
              .withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(6),
        ),
        child:
            Icon(icon, size: 14, color: Theme.of(context).colorScheme.primary),
      ),
    );
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

    _loadHistory();
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
      await database
          .into(database.workoutSets)
          .insert(db.WorkoutSetsCompanion.insert(
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
        await database
            .into(database.workoutSets)
            .insert(db.WorkoutSetsCompanion.insert(
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
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => RestTimerOverlay(
          nextExerciseName: nextExName,
          onClose: () {
            // Check if we are still mounted before popping
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      );
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
          final database = ref.read(db.appDatabaseProvider);
          final firstSet = block.sets.firstOrNull;
          if (firstSet == null) return;
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

            await database
                .into(database.workoutSets)
                .insert(db.WorkoutSetsCompanion.insert(
                  workoutId: widget.workoutId,
                  exerciseId: id,
                  exerciseOrder: targetOrder,
                  setNumber: 1,
                  reps: 0,
                  weight: 0,
                  setType: Value(
                      block.sets.firstOrNull?.setType ?? db.SetType.straight),
                  supersetGroupId: Value(groupId),
                ));
            if (context.mounted) Navigator.pop(context);
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
    });

    if (mounted) {
      // Close the summary bottom sheet first
      Navigator.of(context, rootNavigator: true).pop();
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
          error: (_, __) => const SizedBox.shrink(),
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

  Future<void> _undoDelete() async {
    if (_lastDeletedSet != null) {
      final database = ref.read(db.appDatabaseProvider);
      await database
          .into(database.workoutSets)
          .insert(_lastDeletedSet!.toCompanion(true));
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
      stream: (database.select(database.workoutSets)
            ..where((t) => t.workoutId.equals(workoutId)))
          .watch(),
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
      .watchSingleOrNull()
      .map((workout) =>
          workout ??
          db.Workout(
            id: id,
            name: 'Loading...',
            date: DateTime.now(),
            status: 'draft',
          ));
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

/// Collapsible exercise media widget — shows GIF or image at top of exercise card.
class _ExerciseMediaWidget extends StatefulWidget {
  final Exercise exercise;
  const _ExerciseMediaWidget({required this.exercise});

  @override
  State<_ExerciseMediaWidget> createState() => _ExerciseMediaWidgetState();
}

class _ExerciseMediaWidgetState extends State<_ExerciseMediaWidget> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final url = widget.exercise.gifUrl?.isNotEmpty == true
        ? widget.exercise.gifUrl
        : (widget.exercise.imageUrls.isNotEmpty
            ? widget.exercise.imageUrls.first
            : null);

    if (url == null || url.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _isExpanded ? 'Hide Demo' : 'Show Demo',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  _isExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.contain,
              placeholder: (_, __) => Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                  ),
                ),
              ),
              errorWidget: (_, err, ___) {
                debugPrint('Media error for $url: $err');
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.imageOff,
                          size: 32, color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5)),
                      const SizedBox(height: 8),
                      Text(
                        'Demo unavailable',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          secondChild: const SizedBox.shrink(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
