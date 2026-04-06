import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' hide Column, Table;

class WorkoutDetailScreen extends ConsumerStatefulWidget {
  final int workoutId;
  const WorkoutDetailScreen({super.key, required this.workoutId});

  @override
  ConsumerState<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
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

  TextEditingController _getController(int id, String initialValue) {
    if (!_controllers.containsKey(id)) {
      _controllers[id] = TextEditingController(text: initialValue);
    }
    return _controllers[id]!;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(appDatabaseProvider);
    final workoutStream = db.select(db.workouts)..where((t) => t.id.equals(widget.workoutId));
    final setsStream = db.select(db.workoutSets).join([
      innerJoin(db.exercises, db.exercises.id.equalsExp(db.workoutSets.exerciseId)),
    ])..where(db.workoutSets.workoutId.equals(widget.workoutId));

    return StreamBuilder<List<Workout>>(
      stream: workoutStream.watch(),
      builder: (context, workoutSnapshot) {
        final workout = workoutSnapshot.data?.firstOrNull;
        if (workout == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

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
              TextButton(
                onPressed: () => setState(() => _isEditing = !_isEditing),
                child: Text(_isEditing ? 'Done' : 'Edit'),
              ),
            ],
          ),
          body: StreamBuilder<List<TypedResult>>(
            stream: setsStream.watch(),
            builder: (context, setsSnapshot) {
              final rows = setsSnapshot.data ?? [];
              final muscleVolume = _calculateMuscleVolume(rows);

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _WorkoutSummaryHeader(workout: workout, muscleVolume: muscleVolume),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final exerciseRows = _groupRowsByExercise(rows);
                          final exerciseId = exerciseRows.keys.elementAt(index);
                          final exerciseSets = exerciseRows[exerciseId]!;
                          final exercise = exerciseSets.first.readTable(db.exercises);
                          
                          return _ExerciseDetailBlock(
                            exercise: exercise,
                            rows: exerciseSets,
                            isEditing: _isEditing,
                            onUpdate: (setId, weight, reps) => _updateSet(setId, weight, reps),
                          );
                        },
                        childCount: _groupRowsByExercise(rows).length,
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
      final setId = row.readTable(ref.read(appDatabaseProvider).workoutSets).exerciseId;
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
}

class _WorkoutSummaryHeader extends StatelessWidget {
  final Workout workout;
  final Map<String, double> muscleVolume;

  const _WorkoutSummaryHeader({required this.workout, required this.muscleVolume});

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
              _SummaryStat(label: 'Duration', value: '${(workout.duration ?? 0) ~/ 60}m'),
              const SizedBox(width: 24),
              _SummaryStat(label: 'Volume', value: '${totalVolume.toStringAsFixed(0)}kg'),
              const SizedBox(width: 24),
              const _SummaryStat(label: 'PRs', value: '🏆 2'), // Placeholder for logic
            ],
          ),
          if (workout.notes != null && workout.notes!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Notes', style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 12)),
            Text(workout.notes!),
          ],
          const SizedBox(height: 24),
          const Text('Muscle Distribution', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
                      Text('${(percent * 100).toStringAsFixed(0)}%', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: percent.toDouble(),
                    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
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
  const _SummaryStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 10)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}

class _ExerciseDetailBlock extends StatelessWidget {
  final Exercise exercise;
  final List<TypedResult> rows;
  final bool isEditing;
  final Function(int, double, double) onUpdate;

  const _ExerciseDetailBlock({
    required this.exercise,
    required this.rows,
    required this.isEditing,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final db = ProviderScope.containerOf(context).read(appDatabaseProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        InkWell(
          onTap: () => context.push('/exercises/history/${exercise.id}'),
          child: Row(
            children: [
              Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(width: 4),
              const Icon(LucideIcons.externalLink, size: 14, color: Colors.blue),
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
                TableCell(child: Text('Volume', style: _headerStyle, textAlign: TextAlign.right)),
              ],
            ),
            ...rows.map((row) {
              final s = row.readTable(db.workoutSets);
              return TableRow(
                children: [
                  TableCell(child: Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text('${s.setNumber}', style: const TextStyle(fontSize: 12)))),
                  TableCell(child: isEditing 
                      ? _EditCell(initialValue: '${s.weight}', onChanged: (v) => onUpdate(s.id, double.parse(v), s.reps))
                      : Text('${s.weight}kg', style: const TextStyle(fontSize: 12))),
                  TableCell(child: isEditing 
                      ? _EditCell(initialValue: '${s.reps.toInt()}', onChanged: (v) => onUpdate(s.id, s.weight, double.parse(v)))
                      : Text('${s.reps.toInt()}', style: const TextStyle(fontSize: 12))),
                  TableCell(child: Text('${s.rpe ?? '-'}', style: const TextStyle(fontSize: 12))),
                  TableCell(child: Text('${(s.weight * s.reps).toStringAsFixed(0)}', textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }

  static const _headerStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey);
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
