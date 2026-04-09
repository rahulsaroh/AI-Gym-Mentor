import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/features/exercises/exercises_provider.dart';
import 'package:gym_gemini_pro/features/exercises/components/exercise_picker_overlay.dart';
import 'package:gym_gemini_pro/features/programs/providers/programs_notifier.dart';
import 'package:drift/drift.dart' hide Column;

class CreateEditProgramScreen extends ConsumerStatefulWidget {
  final int? templateId;
  const CreateEditProgramScreen({super.key, this.templateId});

  @override
  ConsumerState<CreateEditProgramScreen> createState() =>
      _CreateEditProgramScreenState();
}

class _CreateEditProgramScreenState
    extends ConsumerState<CreateEditProgramScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<_DayData> _days = [];
  Set<int> _expandedIndices = {0}; // Default expand first day
  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.templateId != null;
    if (_isEditing) {
      _loadTemplate();
    }
  }

  Future<void> _loadTemplate() async {
    setState(() => _isLoading = true);
    final db = ref.read(appDatabaseProvider);
    final template = await (db.select(db.workoutTemplates)
          ..where((t) => t.id.equals(widget.templateId!)))
        .getSingleOrNull();
    if (template != null) {
      _nameController.text = template.name;
      _descriptionController.text = template.description ?? '';

      final days = await (db.select(db.templateDays)
            ..where((t) => t.templateId.equals(widget.templateId!))
            ..orderBy([(t) => OrderingTerm(expression: t.order)]))
          .get();

      final loadedDays = <_DayData>[];
      for (var day in days) {
        final exercises = await (db.select(db.templateExercises)
              ..where((t) => t.dayId.equals(day.id))
              ..orderBy([(t) => OrderingTerm(expression: t.order)]))
            .get();

        final exercisesData = <_ExerciseData>[];
        for (var ex in exercises) {
          exercisesData.add(_ExerciseData(
            exerciseId: ex.exerciseId,
            sets: ex.setsJson.isNotEmpty
                ? _parseSetsJson(ex.setsJson)
                : [const _SetData(3, 10, 90)],
          ));
        }

        loadedDays.add(_DayData(
          id: day.id,
          name: day.name,
          exercises: exercisesData,
        ));
      }

      setState(() {
        _days = loadedDays;
        _isLoading = false;
      });
    }
  }

  List<_SetData> _parseSetsJson(String json) {
    try {
      final List<dynamic> list =
          json.isNotEmpty ? List<dynamic>.from(jsonDecode(json)) : [];
      return list
          .map((e) => _SetData(
                e['sets'] ?? 3,
                e['reps'] ?? 10,
                e['rest'] ?? 90,
                e['type'] ?? 'Straight',
              ))
          .toList();
    } catch (_) {
      return [const _SetData(3, 10, 90)];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canSave = _nameController.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Program' : 'Create Program',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        leading: IconButton(
            icon: const Icon(LucideIcons.x), onPressed: () => context.pop()),
        actions: [
          TextButton(
            onPressed: canSave ? _saveProgram : null,
            child: Text('Save',
                style: TextStyle(
                    color: canSave
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextField(
                  controller: _nameController,
                  autofocus: !_isEditing,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: 'Program Name',
                    hintText: 'e.g., PPL Week 1',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description (optional)',
                    hintText: 'Describe your program...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Training Days',
                        style: GoogleFonts.outfit(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    TextButton.icon(
                      onPressed: _addDay,
                      icon: const Icon(LucideIcons.plus, size: 18),
                      label: const Text('Add Day'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (_days.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Icon(LucideIcons.calendar,
                            size: 48, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('No training days yet',
                            style: GoogleFonts.outfit(color: Colors.grey)),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: _addDay,
                          icon: const Icon(LucideIcons.plus),
                          label: const Text('Add Training Day'),
                        ),
                      ],
                    ),
                  )
                else
                  ReorderableListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _days.length,
                    buildDefaultDragHandles: false, // We'll use custom handles
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) newIndex--;
                        final item = _days.removeAt(oldIndex);
                        _days.insert(newIndex, item);

                        // Also update expanded indices (simple approach: clear or map them)
                        _expandedIndices.clear();
                        _expandedIndices.add(newIndex);
                      });
                    },
                    itemBuilder: (context, index) => _DayCard(
                      key: ValueKey(
                          'day_${_days[index].id ?? index}_${_days[index].name}'),
                      day: _days[index],
                      index: index,
                      isExpanded: _expandedIndices.contains(index),
                      onToggleExpansion: () {
                        setState(() {
                          if (_expandedIndices.contains(index)) {
                            _expandedIndices.remove(index);
                          } else {
                            _expandedIndices.add(index);
                          }
                        });
                      },
                      onNameChanged: (name) => setState(() =>
                          _days[index] = _days[index].copyWith(name: name)),
                      onAddExercise: () => _addExerciseToDay(index),
                      onRemoveExercise: (exIndex) {
                        final updatedExercises =
                            List<_ExerciseData>.from(_days[index].exercises)
                              ..removeAt(exIndex);
                        setState(() => _days[index] =
                            _days[index].copyWith(exercises: updatedExercises));
                      },
                      onUpdateExerciseSets: (exIndex, sets) {
                        final updatedExercises =
                            List<_ExerciseData>.from(_days[index].exercises);
                        updatedExercises[exIndex] =
                            updatedExercises[exIndex].copyWith(sets: sets);
                        setState(() => _days[index] =
                            _days[index].copyWith(exercises: updatedExercises));
                      },
                      onDelete: () => setState(() => _days.removeAt(index)),
                    ),
                  ),
                const SizedBox(height: 100),
              ],
            ),
    );
  }

  void _addDay() {
    setState(() {
      _days.add(_DayData(
        name: 'Day ${_days.length + 1}',
        exercises: [],
      ));
      _expandedIndices.clear();
      _expandedIndices.add(_days.length - 1);
    });
  }

  void _addExerciseToDay(int dayIndex) async {
    final exerciseId = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExercisePickerOverlay(
        onSelect: (id) => Navigator.pop(context, id),
      ),
    );

    if (exerciseId != null) {
      setState(() {
        _days[dayIndex].exercises.add(_ExerciseData(
              exerciseId: exerciseId,
              sets: [const _SetData(3, 10, 90)],
            ));
      });
    }
  }

  Future<void> _saveProgram() async {
    if (_nameController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);
    final db = ref.read(appDatabaseProvider);

    try {
      await db.transaction(() async {
        if (_isEditing) {
          await (db.update(db.workoutTemplates)
                ..where((t) => t.id.equals(widget.templateId!)))
              .write(
            WorkoutTemplatesCompanion(
              name: Value(_nameController.text.trim()),
              description: Value(_descriptionController.text.trim().isEmpty
                  ? null
                  : _descriptionController.text.trim()),
            ),
          );

          // Get all day IDs for this template to delete their exercises first
          final dayIds = await (db.select(db.templateDays)
                ..where((t) => t.templateId.equals(widget.templateId!)))
              .map((d) => d.id)
              .get();
          await (db.delete(db.templateExercises)
                ..where((t) => t.dayId.isIn(dayIds)))
              .go();
          await (db.delete(db.templateDays)
                ..where((t) => t.templateId.equals(widget.templateId!)))
              .go();

          for (int i = 0; i < _days.length; i++) {
            final dayId = await db
                .into(db.templateDays)
                .insert(TemplateDaysCompanion.insert(
                  templateId: widget.templateId!,
                  name: _days[i].name,
                  order: i,
                ));

            for (int j = 0; j < _days[i].exercises.length; j++) {
              final ex = _days[i].exercises[j];
              await db
                  .into(db.templateExercises)
                  .insert(TemplateExercisesCompanion.insert(
                    dayId: dayId,
                    exerciseId: ex.exerciseId,
                    order: j,
                    setsJson: jsonEncode(ex.sets
                        .map((s) => {
                              'sets': s.sets,
                              'reps': s.reps,
                              'rest': s.rest,
                              'type': s.type,
                            })
                        .toList()),
                  ));
            }
          }
        } else {
          final templateId = await db
              .into(db.workoutTemplates)
              .insert(WorkoutTemplatesCompanion.insert(
                name: _nameController.text.trim(),
                description: Value(_descriptionController.text.trim().isEmpty
                    ? null
                    : _descriptionController.text.trim()),
              ));

          for (int i = 0; i < _days.length; i++) {
            final dayId = await db
                .into(db.templateDays)
                .insert(TemplateDaysCompanion.insert(
                  templateId: templateId,
                  name: _days[i].name,
                  order: i,
                ));

            for (int j = 0; j < _days[i].exercises.length; j++) {
              final ex = _days[i].exercises[j];
              await db
                  .into(db.templateExercises)
                  .insert(TemplateExercisesCompanion.insert(
                    dayId: dayId,
                    exerciseId: ex.exerciseId,
                    order: j,
                    setsJson: jsonEncode(ex.sets
                        .map((s) => {
                              'sets': s.sets,
                              'reps': s.reps,
                              'rest': s.rest,
                              'type': s.type,
                            })
                        .toList()),
                  ));
            }
          }
        }
      });

      ref.invalidate(programsNotifierProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
        setState(() => _isLoading = false);
      }
    }
  }
}

class _DayData {
  final int? id;
  final String name;
  final List<_ExerciseData> exercises;
  _DayData({this.id, required this.name, required this.exercises});

  _DayData copyWith({String? name, List<_ExerciseData>? exercises}) {
    return _DayData(
      id: id,
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
    );
  }
}

class _ExerciseData {
  final int exerciseId;
  final List<_SetData> sets;
  _ExerciseData({required this.exerciseId, required this.sets});

  _ExerciseData copyWith({List<_SetData>? sets}) {
    return _ExerciseData(
      exerciseId: exerciseId,
      sets: sets ?? this.sets,
    );
  }
}

class _SetData {
  final int sets;
  final int reps;
  final int rest;
  final String type;
  const _SetData(this.sets, this.reps, this.rest, [this.type = 'Straight']);
}

class _DayCard extends ConsumerStatefulWidget {
  final _DayData day;
  final int index;
  final bool isExpanded;
  final VoidCallback onToggleExpansion;
  final Function(String) onNameChanged;
  final VoidCallback onAddExercise;
  final Function(int) onRemoveExercise;
  final Function(int, List<_SetData>) onUpdateExerciseSets;
  final VoidCallback onDelete;

  const _DayCard({
    super.key,
    required this.day,
    required this.index,
    required this.isExpanded,
    required this.onToggleExpansion,
    required this.onNameChanged,
    required this.onAddExercise,
    required this.onRemoveExercise,
    required this.onUpdateExerciseSets,
    required this.onDelete,
  });

  @override
  ConsumerState<_DayCard> createState() => _DayCardState();
}

class _DayCardState extends ConsumerState<_DayCard> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.day.name);
  }

  @override
  void didUpdateWidget(_DayCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.day.name != widget.day.name &&
        _nameController.text != widget.day.name) {
      _nameController.text = widget.day.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(allExercisesProvider);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: widget.isExpanded ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: widget.isExpanded
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: widget.onToggleExpansion,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ReorderableDragStartListener(
                    index: widget.index,
                    child: const Icon(LucideIcons.menu, color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      onChanged: widget.onNameChanged,
                      style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Day Name',
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Icon(
                    widget.isExpanded
                        ? LucideIcons.chevronUp
                        : LucideIcons.chevronDown,
                    size: 20,
                    color: Colors.grey,
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.trash2,
                        size: 18, color: Colors.red),
                    onPressed: widget.onDelete,
                  ),
                ],
              ),
            ),
          ),
          if (widget.isExpanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.day.exercises.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text('No exercises added',
                            style: TextStyle(color: Colors.grey[600])),
                      ),
                    )
                  else
                    ...widget.day.exercises.asMap().entries.map((entry) {
                      final exIndex = entry.key;
                      final ex = entry.value;

                      return exercisesAsync.when(
                        data: (exercises) {
                          final exercise = exercises.firstWhere(
                            (e) => e.id == ex.exerciseId,
                            orElse: () => exercises.first,
                          );
                          return _ExerciseConfigRow(
                            exercise: exercise,
                            config: ex.sets.first,
                            onUpdate: (newConfig) => widget
                                .onUpdateExerciseSets(exIndex, [newConfig]),
                            onRemove: () => widget.onRemoveExercise(exIndex),
                          );
                        },
                        loading: () =>
                            const ListTile(title: Text('Loading...')),
                        error: (_, __) => const ListTile(title: Text('Error')),
                      );
                    }),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: widget.onAddExercise,
                      icon: const Icon(LucideIcons.plus, size: 18),
                      label: const Text('Add Exercise'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ExerciseConfigRow extends StatelessWidget {
  final Exercise exercise;
  final _SetData config;
  final Function(_SetData) onUpdate;
  final VoidCallback onRemove;

  const _ExerciseConfigRow({
    required this.exercise,
    required this.config,
    required this.onUpdate,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
        childrenPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        leading: const Icon(LucideIcons.dumbbell, size: 18),
        title: Text(exercise.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
        subtitle: Text(
          '${config.sets} × ${config.reps} • ${config.type} • ${config.rest}s rest',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(LucideIcons.trash2, size: 16, color: Colors.grey),
          onPressed: onRemove,
        ),
        children: [
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildStepper(
                  label: 'Sets',
                  value: config.sets,
                  onChanged: (val) => onUpdate(_SetData(
                      val.clamp(1, 10), config.reps, config.rest, config.type)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStepper(
                  label: 'Reps',
                  value: config.reps,
                  onChanged: (val) => onUpdate(_SetData(
                      config.sets, val.clamp(1, 50), config.rest, config.type)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildStepper(
                  label: 'Rest (s)',
                  value: config.rest,
                  step: 15,
                  onChanged: (val) => onUpdate(_SetData(config.sets,
                      config.reps, val.clamp(0, 300), config.type)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Type',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                    DropdownButton<String>(
                      value: config.type,
                      isDense: true,
                      isExpanded: true,
                      underline: const SizedBox(),
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w600),
                      items: [
                        'Straight',
                        'Superset',
                        'Drop Set',
                        'AMRAP',
                        'Timed'
                      ]
                          .map(
                              (t) => DropdownMenuItem(value: t, child: Text(t)))
                          .toList(),
                      onChanged: (val) => onUpdate(_SetData(config.sets,
                          config.reps, config.rest, val ?? 'Straight')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepper(
      {required String label,
      required int value,
      required Function(int) onChanged,
      int step = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Row(
          children: [
            IconButton(
              icon: const Icon(LucideIcons.minus, size: 16),
              onPressed: () => onChanged(value - step),
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(4),
            ),
            SizedBox(
              width: 30,
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            IconButton(
              icon: const Icon(LucideIcons.plus, size: 16),
              onPressed: () => onChanged(value + step),
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(4),
            ),
          ],
        ),
      ],
    );
  }
}
