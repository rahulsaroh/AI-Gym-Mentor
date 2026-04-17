import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/core/database/database.dart';

import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' hide Column, Table;
import 'package:ai_gym_mentor/features/history/history_providers.dart';
import 'package:ai_gym_mentor/features/workout/workout_repository.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/features/history/pdf_service.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';
import 'package:share_plus/share_plus.dart';

class WorkoutDetailScreen extends ConsumerStatefulWidget {
  final int workoutId;
  const WorkoutDetailScreen({super.key, required this.workoutId});

  @override
  ConsumerState<WorkoutDetailScreen> createState() =>
      _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends ConsumerState<WorkoutDetailScreen> {
  bool _isEditing = false;
  final Map<int, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final db = ref.watch(appDatabaseProvider);
    final workoutStream = db.select(db.workouts)
      ..where((t) => t.id.equals(widget.workoutId));
    final setsStream = db.select(db.workoutSets).join([
      innerJoin(
          db.exercises, db.exercises.id.equalsExp(db.workoutSets.exerciseId)),
    ])
      ..where(db.workoutSets.workoutId.equals(widget.workoutId));

    return StreamBuilder<List<Workout>>(
      stream: workoutStream.watch(),
      builder: (context, workoutSnapshot) {
        final workout = workoutSnapshot.data?.firstOrNull;
        if (workout == null)
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));

        final prsAsync = ref.watch(workoutPRsProvider(widget.workoutId));

        return Scaffold(
          appBar: AppBar(
            title: Hero(
              tag: 'workout_${widget.workoutId}',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  DateFormat('MMM d, yyyy').format(workout.date),
                  style: Theme.of(context).appBarTheme.titleTextStyle ??
                      Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            actions: [
              if (!_isEditing)
                IconButton(
                  icon: const Icon(LucideIcons.fileText),
                  onPressed: () => _exportPdf(workout),
                  tooltip: 'Export PDF',
                ),
              if (!_isEditing)
                IconButton(
                  icon: const Icon(LucideIcons.trash2, color: Colors.red),
                  onPressed: _confirmDelete,
                ),
              TextButton(
                onPressed: () => setState(() => _isEditing = !_isEditing),
                child: Text(_isEditing ? 'Done' : 'Edit'),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _isEditing
              ? null
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: FloatingActionButton.extended(
                      onPressed: _repeatWorkout,
                      label: const Text('Repeat Workout',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      icon: const Icon(LucideIcons.rotateCcw),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
          body: StreamBuilder<List<TypedResult>>(
            stream: setsStream.watch(),
            builder: (context, setsSnapshot) {
              final rows = setsSnapshot.data ?? [];
              final muscleVolume = _calculateMuscleVolume(rows);
              final exerciseRows = _groupRowsByExercise(rows);

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _WorkoutSummaryHeader(
                        workout: workout, 
                        muscleVolume: muscleVolume,
                        prsAchieved: prsAsync.when(data: (ids) => ids.length, loading: () => 0, error: (_,__) => 0),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final exerciseId = exerciseRows.keys.elementAt(index);
                          final exerciseSets = exerciseRows[exerciseId]!;
                          final exercise =
                              exerciseSets.first.readTable(db.exercises);
                          final setId =
                              exerciseSets.first.readTable(db.workoutSets).id;

                          return _ExerciseDetailBlock(
                            key: ValueKey('exercise_block_$setId'),
                            exercise: exercise,
                            rows: exerciseSets,
                            isEditing: _isEditing,
                            isPR: prsAsync.when(data: (ids) => ids.contains(exercise.id), loading: () => false, error: (_,__) => false),
                            onUpdate: (setId, weight, reps) =>
                                _updateSet(setId, weight, reps),
                          );
                        },
                        childCount: exerciseRows.length,
                      ),
                    ),
                  ),
                  const SliverPadding(padding: EdgeInsets.only(bottom: 50)),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Map<int, List<TypedResult>> _groupRowsByExercise(List<TypedResult> rows) {
    final Map<int, List<TypedResult>> groups = {};
    for (final row in rows) {
      final setId =
          row.readTable(ref.read(appDatabaseProvider).workoutSets).exerciseId;
      groups.putIfAbsent(setId, () => []).add(row);
    }
    return groups;
  }

  Map<String, double> _calculateMuscleVolume(List<TypedResult> rows) {
    final Map<String, double> volume = {};
    final db = ref.read(appDatabaseProvider);
    for (final row in rows) {
      final s = row.readTable(db.workoutSets);
      final e = row.readTable(db.exercises);
      final vol = s.weight * s.reps;
      volume[e.primaryMuscle] = (volume[e.primaryMuscle] ?? 0) + vol;
    }
    return volume;
  }

  Future<void> _updateSet(int setId, double weight, double reps) async {
    final db = ref.read(appDatabaseProvider);
    await (db.update(db.workoutSets)..where((t) => t.id.equals(setId))).write(
      WorkoutSetsCompanion(
        weight: Value(weight),
        reps: Value(reps),
      ),
    );
  }

  Future<void> _confirmDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Workout?'),
        content: const Text(
            'This will permanently remove this session from your history.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      final repo = ref.read(workoutRepositoryProvider);
      await repo.deleteWorkout(widget.workoutId);
      ref.invalidate(historyListProvider);
      if (mounted) context.pop();
    }
  }

  Future<void> _exportPdf(Workout workout) async {
    final db = ref.read(appDatabaseProvider);
    final sets = await (db.select(db.workoutSets)..where((t) => t.workoutId.equals(workout.id))).get();
    final exercises = await ref.read(exerciseRepositoryProvider).getAllExercises();
    final exNames = {for (var e in exercises) e.id: e.name};

    final pdfService = ref.read(pdfServiceProvider.notifier);
    final file = await pdfService.generateWorkoutPdf(
      workout: workout,
      sets: sets,
      exerciseNames: exNames,
    );

    await Share.shareXFiles([XFile(file.path)], text: 'Workout Summary: ${workout.name}');
  }

  Future<void> _repeatWorkout() async {
    final repo = ref.read(workoutRepositoryProvider);
    final newId = await repo.repeatWorkout(widget.workoutId);
    if (mounted) {
      context.push('/app/workout/active?id=$newId');
    }
  }
}

class _WorkoutSummaryHeader extends StatelessWidget {
  final Workout workout;
  final Map<String, double> muscleVolume;
  final int prsAchieved;

  const _WorkoutSummaryHeader(
      {required this.workout, required this.muscleVolume, required this.prsAchieved});

  @override
  Widget build(BuildContext context) {
    final totalVolume = muscleVolume.values.fold(0.0, (a, b) => a + b);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _SummaryStat(
                  label: 'Duration',
                  value: '${(workout.duration ?? 0) ~/ 60}m'),
              const SizedBox(width: 24),
              _SummaryStat(
                  label: 'Volume',
                  value: '${totalVolume.toStringAsFixed(0)}kg'),
              const SizedBox(width: 24),
              _SummaryStat(
                  label: 'PRs', 
                  value: '🏆 $prsAchieved', 
                  isHighlight: prsAchieved > 0),
            ],
          ),
          if (workout.notes != null && workout.notes!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Notes',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 12)),
            Text(workout.notes!),
          ],
          const SizedBox(height: 24),
          const Text('Muscle Distribution',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          ...muscleVolume.entries.map((e) {
            final percent = totalVolume > 0 ? e.value / totalVolume : 0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e.key, style: const TextStyle(fontSize: 12)),
                      Text('${(percent * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: percent.toDouble(),
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                    minHeight: 6,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlight;

  const _SummaryStat({required this.label, required this.value, this.isHighlight = false});

  @override
  Widget build(BuildContext context) {
    final color = isHighlight ? Colors.amber : Theme.of(context).colorScheme.outline;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                color: color, fontSize: 10, fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal)),
        Text(value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isHighlight ? Colors.amber : null)),
      ],
    );
  }
}

class _ExerciseDetailBlock extends ConsumerWidget {
  final ExerciseTable exercise;
  final List<TypedResult> rows;
  final bool isEditing;
  final bool isPR;
  final Function(int, double, double) onUpdate;

  const _ExerciseDetailBlock({
    super.key,
    required this.exercise,
    required this.rows,
    required this.isEditing,
    this.isPR = false,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.read(appDatabaseProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        InkWell(
          onTap: () => context.push('/exercises/history/${exercise.id}'),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  exercise.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(LucideIcons.externalLink,
                  size: 14, color: Colors.blue),
              if (isPR) ...[
                const SizedBox(width: 8),
                const Icon(LucideIcons.trophy, size: 14, color: Colors.amber),
                const SizedBox(width: 4),
                const Text('NEW PR!', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 10)),
              ],
            ],
          ),
        ),
        const SizedBox(height: 8),
        Table(
          columnWidths: const {
            0: FixedColumnWidth(40),
            4: FixedColumnWidth(60),
          },
          children: [
            const TableRow(
              children: [
                TableCell(child: Text('Set', style: _headerStyle)),
                TableCell(child: Text('Weight', style: _headerStyle)),
                TableCell(child: Text('Reps', style: _headerStyle)),
                TableCell(child: Text('RPE', style: _headerStyle)),
                TableCell(
                    child: Text('Volume',
                        style: _headerStyle, textAlign: TextAlign.right)),
              ],
            ),
            ...rows.map((row) {
              final s = row.readTable(db.workoutSets);
              return TableRow(
                children: [
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text('${s.setNumber}',
                              style: const TextStyle(fontSize: 12)))),
                  TableCell(
                      child: isEditing
                          ? _EditCell(
                              initialValue: '${s.weight}',
                              onChanged: (v) =>
                                  onUpdate(s.id, double.parse(v), s.reps))
                          : Text('${s.weight}kg',
                              style: const TextStyle(fontSize: 12))),
                  TableCell(
                      child: isEditing
                          ? _EditCell(
                              initialValue: '${s.reps.toInt()}',
                              onChanged: (v) =>
                                  onUpdate(s.id, s.weight, double.parse(v)))
                          : Text('${s.reps.toInt()}',
                              style: const TextStyle(fontSize: 12))),
                  TableCell(
                      child: Text('${s.rpe ?? '-'}',
                          style: const TextStyle(fontSize: 12))),
                  TableCell(
                      child: Text('${(s.weight * s.reps).toStringAsFixed(0)}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }

  static const _headerStyle =
      TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey);
}

class _EditCell extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;
  const _EditCell({required this.initialValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextField(
        controller: TextEditingController(text: initialValue),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: UnderlineInputBorder(),
        ),
        onSubmitted: onChanged,
      ),
    );
  }
}
