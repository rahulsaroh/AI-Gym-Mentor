import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/exercise_providers.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/widgets/exercise_picker_overlay.dart';
import 'package:ai_gym_mentor/features/programs/providers/programs_notifier.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;

const Map<String, ({Color color, String label})> sectionConfigs = {
  'Warm-Up': (color: Colors.amber, label: 'Warm-Up'),
  'Main Work': (color: Colors.blue, label: 'Main Work'),
  'Cool-Down': (color: Colors.green, label: 'Cool-Down'),
};

class CreateEditProgramScreen extends ConsumerStatefulWidget {
  final int? templateId;
  const CreateEditProgramScreen({super.key, this.templateId});

  @override
  ConsumerState<CreateEditProgramScreen> createState() =>
      _CreateEditProgramScreenState();
}

class _CreateEditProgramScreenState extends ConsumerState<CreateEditProgramScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<_DayData> _days = [];
  bool _isLoading = false;
  bool _isEditing = false;
  
  late PageController _pageController;
  int _currentDayIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _isEditing = widget.templateId != null;
    if (_isEditing) {
      _loadTemplate();
    } else {
      // Default to having 1 day initially
      _days.add(_DayData(name: 'Day 1', exercises: []));
    }
  }

  Future<void> _loadTemplate() async {
    setState(() => _isLoading = true);
    try {
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
            final section = (ex.notes != null && sectionConfigs.containsKey(ex.notes)) ? ex.notes! : 'Main Work';
            exercisesData.add(_ExerciseData(
              uniqueId: const Uuid().v4(),
              exerciseId: ex.exerciseId,
              sets: ex.setsJson.isNotEmpty
                  ? _parseSetsJson(ex.setsJson)
                  : [const _SetData(3, 10, 90)],
              section: section,
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
          if (_days.isEmpty) {
            _days.add(_DayData(name: 'Day 1', exercises: []));
          }
        });
      }
    } catch (e) {
      debugPrint('Error loading template: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
    _pageController.dispose();
    super.dispose();
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

          final dayIds = await (db.select(db.templateDays)
                ..where((t) => t.templateId.equals(widget.templateId!)))
              .map((d) => d.id)
              .get();

          await (db.update(db.workouts)..where((t) => t.dayId.isIn(dayIds)))
              .write(const WorkoutsCompanion(dayId: Value(null)));

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
                    notes: Value(ex.section),
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
                    notes: Value(ex.section),
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

      ref.invalidate(programsProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
        setState(() => _isLoading = false);
      }
    }
  }

  void _addDay() {
    setState(() {
      _days.add(_DayData(
        name: 'Day ${_days.length + 1}',
        exercises: [],
      ));
    });
    // Animate to new day
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _days.length - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _duplicateDay(int index) {
    if (index >= 0 && index < _days.length) {
      final source = _days[index];
      final duplicatedExercises = source.exercises.map((e) => e.copyWith(uniqueId: const Uuid().v4())).toList();
      setState(() {
        _days.insert(
          index + 1,
          _DayData(name: '${source.name} Copy', exercises: duplicatedExercises),
        );
      });
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            index + 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  void _clearExercises(int index) {
    setState(() {
      _days[index] = _days[index].copyWith(exercises: []);
    });
  }

  void _removeDay(int index) {
    setState(() {
      _days.removeAt(index);
      if (_days.isEmpty) {
        _days.add(_DayData(name: 'Day 1', exercises: [])); // enforce at least 1 day
      }
      if (_currentDayIndex >= _days.length) {
        _currentDayIndex = _days.length - 1;
      }
    });
  }

  Future<void> _renameProgram() async {
    final controller = TextEditingController(text: _nameController.text);
    final descController = TextEditingController(text: _descriptionController.text);
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Program Details', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Program Name'),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() {
                _nameController.text = controller.text;
                _descriptionController.text = descController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canSave = _nameController.text.trim().isNotEmpty && _days.isNotEmpty;
    final programName = _nameController.text.trim().isEmpty ? 'Unnamed Program' : _nameController.text.trim();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(LucideIcons.arrowLeft), onPressed: () => context.pop()),
        title: GestureDetector(
          onTap: _renameProgram,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                programName,
                style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(width: 8),
              Icon(LucideIcons.pencil, size: 14, color: Theme.of(context).colorScheme.primary),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilledButton(
              style: FilledButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              ),
              onPressed: canSave ? _saveProgram : null,
              child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1))),
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _days.length + 1,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                if (index == _days.length) {
                  return ActionChip(
                    label: const Text('+ Add Day', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: _addDay,
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)),
                  );
                }
                
                final isActive = index == _currentDayIndex;
                return ChoiceChip(
                  label: Text(
                    _days[index].name, 
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      color: isActive ? Theme.of(context).colorScheme.onPrimary : null,
                    ),
                  ),
                  selected: isActive,
                  onSelected: (selected) {
                    if (selected && _pageController.hasClients) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  showCheckmark: false,
                  selectedColor: Theme.of(context).colorScheme.primary,
                );
              },
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentDayIndex = index),
              itemCount: _days.length,
              itemBuilder: (context, index) {
                return _DayPageView(
                  key: ValueKey('dayView_${_days[index].id ?? index}'),
                  dayIndex: index,
                  dayData: _days[index],
                  onDayUpdated: (updatedDay) {
                    setState(() => _days[index] = updatedDay);
                  },
                  onDeleteDay: () => _removeDay(index),
                  onDuplicateDay: () => _duplicateDay(index),
                  onClearExercises: () => _clearExercises(index),
                );
              },
            ),
    );
  }
}

class _DayPageView extends ConsumerStatefulWidget {
  final int dayIndex;
  final _DayData dayData;
  final Function(_DayData) onDayUpdated;
  final VoidCallback onDeleteDay;
  final VoidCallback onDuplicateDay;
  final VoidCallback onClearExercises;

  const _DayPageView({
    super.key,
    required this.dayIndex,
    required this.dayData,
    required this.onDayUpdated,
    required this.onDeleteDay,
    required this.onDuplicateDay,
    required this.onClearExercises,
  });

  @override
  ConsumerState<_DayPageView> createState() => _DayPageViewState();
}

class _DayPageViewState extends ConsumerState<_DayPageView> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.dayData.name);
  }

  @override
  void didUpdateWidget(_DayPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dayData.name != widget.dayData.name &&
        _nameController.text != widget.dayData.name) {
      _nameController.text = widget.dayData.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addExercise([String? initialSection]) async {
    final exerciseId = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExercisePickerOverlay(
        onSelect: (id) => Navigator.pop(context, id),
      ),
    );

    if (exerciseId != null) {
      String sectionToAdd = initialSection ?? 'Main Work';
      if (initialSection == null && mounted) {
        final sec = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Add to which section?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            contentPadding: const EdgeInsets.only(top: 16, bottom: 8),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: sectionConfigs.keys.map((s) => 
                ListTile(
                  leading: Icon(Icons.circle, color: sectionConfigs[s]!.color, size: 12),
                  title: Text(s, style: const TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () => Navigator.pop(context, s),
                )
              ).toList(),
            ),
          )
        );
        if (sec != null) sectionToAdd = sec;
      }
      
      final newExercise = _ExerciseData(
        uniqueId: const Uuid().v4(),
        exerciseId: exerciseId,
        sets: [const _SetData(3, 10, 90)],
        section: sectionToAdd,
      );
      final updatedExercises = List<_ExerciseData>.from(widget.dayData.exercises)..add(newExercise);
      widget.onDayUpdated(widget.dayData.copyWith(exercises: updatedExercises));
    }
  }

  void _swapExercise(String uniqueId) async {
    final exIndex = widget.dayData.exercises.indexWhere((e) => e.uniqueId == uniqueId);
    if (exIndex == -1) return;

    final exerciseId = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExercisePickerOverlay(
        onSelect: (id) => Navigator.pop(context, id),
      ),
    );

    if (exerciseId != null) {
      final existing = widget.dayData.exercises[exIndex];
      final updatedExercises = List<_ExerciseData>.from(widget.dayData.exercises);
      updatedExercises[exIndex] = existing.copyWith(exerciseId: exerciseId);
      widget.onDayUpdated(widget.dayData.copyWith(exercises: updatedExercises));
    }
  }

  void _removeExercise(String uniqueId) {
    final updatedExercises = List<_ExerciseData>.from(widget.dayData.exercises)..removeWhere((e) => e.uniqueId == uniqueId);
    widget.onDayUpdated(widget.dayData.copyWith(exercises: updatedExercises));
  }

  void _duplicateExercise(String uniqueId) {
    final exIndex = widget.dayData.exercises.indexWhere((e) => e.uniqueId == uniqueId);
    if (exIndex == -1) return;
    
    final existing = widget.dayData.exercises[exIndex];
    final duplicated = existing.copyWith(uniqueId: const Uuid().v4());
    final updatedExercises = List<_ExerciseData>.from(widget.dayData.exercises)..insert(exIndex + 1, duplicated);
    widget.onDayUpdated(widget.dayData.copyWith(exercises: updatedExercises));
  }

  void _moveToSection(String uniqueId, String newSection) {
    final exIndex = widget.dayData.exercises.indexWhere((e) => e.uniqueId == uniqueId);
    if (exIndex == -1) return;
    
    final existing = widget.dayData.exercises[exIndex];
    final updatedExercises = List<_ExerciseData>.from(widget.dayData.exercises);
    updatedExercises[exIndex] = existing.copyWith(section: newSection);
    widget.onDayUpdated(widget.dayData.copyWith(exercises: updatedExercises));
  }

  void _onReorderSection(String section, int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    
    // Find absolute indices
    final sectionExercises = widget.dayData.exercises.where((e) => e.section == section).toList();
    if (oldIndex >= sectionExercises.length || newIndex >= sectionExercises.length) return;
    
    final itemToMove = sectionExercises[oldIndex];
    
    final updatedExercises = List<_ExerciseData>.from(widget.dayData.exercises);
    updatedExercises.removeWhere((e) => e.uniqueId == itemToMove.uniqueId);
    
    int insertAbsoluteIndex = 0;
    int sectionEncountered = 0;
    
    // Calculate new position
    for (int i = 0; i < updatedExercises.length; i++) {
      if (updatedExercises[i].section == section) {
        if (sectionEncountered == newIndex) {
          insertAbsoluteIndex = i;
          break;
        }
        sectionEncountered++;
      }
      insertAbsoluteIndex = i + 1; // if it goes to the end
    }
    
    updatedExercises.insert(insertAbsoluteIndex, itemToMove);
    widget.onDayUpdated(widget.dayData.copyWith(exercises: updatedExercises));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addExercise(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: const Icon(LucideIcons.plus, color: Colors.white),
        label: const Text('Add Exercise', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.menu, color: Colors.grey, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          onChanged: (val) => widget.onDayUpdated(widget.dayData.copyWith(name: val)),
                          style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Day Name (e.g. Push A)',
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      const Icon(LucideIcons.pencil, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(LucideIcons.trash2, color: Colors.redAccent, size: 20),
                        tooltip: 'Delete Day',
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Day'),
                              content: const Text('Are you sure you want to delete this day? All exercises in it will be removed.'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true), 
                                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            )
                          );
                          if (confirm == true) {
                            widget.onDeleteDay();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Render Sections
          ...sectionConfigs.keys.map((sectionKey) {
            final sectionExercises = widget.dayData.exercises.where((e) => e.section == sectionKey).toList();
            if (sectionExercises.isEmpty && sectionKey != 'Main Work') return const SliverToBoxAdapter(child: SizedBox.shrink());
            
            return SliverToBoxAdapter(
              child: _ExerciseSection(
                section: sectionKey,
                exercises: sectionExercises,
                onAddExercise: () => _addExercise(sectionKey),
                onReorder: (oldIdx, newIdx) => _onReorderSection(sectionKey, oldIdx, newIdx),
                onUpdateExercise: (uniqueId, sets) {
                  final exIndex = widget.dayData.exercises.indexWhere((e) => e.uniqueId == uniqueId);
                  if (exIndex != -1) {
                    final updatedExercises = List<_ExerciseData>.from(widget.dayData.exercises);
                    updatedExercises[exIndex] = updatedExercises[exIndex].copyWith(sets: sets);
                    widget.onDayUpdated(widget.dayData.copyWith(exercises: updatedExercises));
                  }
                },
                onSwap: _swapExercise,
                onRemove: _removeExercise,
                onDuplicate: _duplicateExercise,
                onMoveToSection: _moveToSection,
              ),
            );
          }),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: widget.onDuplicateDay,
                    icon: const Icon(LucideIcons.copy, size: 16),
                    label: const Text('Duplicate Day'),
                    style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  TextButton.icon(
                    onPressed: widget.onClearExercises,
                    icon: const Icon(LucideIcons.refreshCcw, size: 16),
                    label: const Text('Clear All'),
                    style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)), // FAB padding
        ],
      ),
    );
  }
}

class _ExerciseSection extends ConsumerWidget {
  final String section;
  final List<_ExerciseData> exercises;
  final VoidCallback onAddExercise;
  final Function(int, int) onReorder;
  final Function(String, List<_SetData>) onUpdateExercise;
  final Function(String) onSwap;
  final Function(String) onRemove;
  final Function(String) onDuplicate;
  final Function(String, String) onMoveToSection;

  const _ExerciseSection({
    required this.section,
    required this.exercises,
    required this.onAddExercise,
    required this.onReorder,
    required this.onUpdateExercise,
    required this.onSwap,
    required this.onRemove,
    required this.onDuplicate,
    required this.onMoveToSection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = sectionConfigs[section]!;
    final exercisesAsync = ref.watch(allExercisesProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: EdgeInsets.zero,
          title: Row(
            children: [
              Icon(Icons.circle, color: config.color, size: 10),
              const SizedBox(width: 8),
              Text(config.label, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Text('${exercises.length} exercises', style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(LucideIcons.plus, size: 20),
                onPressed: onAddExercise,
                style: IconButton.styleFrom(foregroundColor: config.color),
              ),
            ],
          ),
          children: [
            const SizedBox(height: 8),
            if (exercises.isEmpty)
               Container(
                 width: double.infinity,
                 margin: const EdgeInsets.only(bottom: 8),
                 decoration: BoxDecoration(
                   color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: CustomPaint(
                   painter: _DashedBorderPainter(color: Colors.grey.withValues(alpha: 0.3)),
                   child: Padding(
                     padding: const EdgeInsets.all(24),
                     child: Column(
                       children: [
                          Icon(Icons.layers_clear, color: Colors.grey.shade400, size: 32),
                          const SizedBox(height: 8),
                          Text('No exercises yet — tap + to add', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                       ]
                     ),
                   )
                 )
               )
            else
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: exercises.length,
                onReorder: onReorder,
                itemBuilder: (context, idx) {
                  final ex = exercises[idx];
                  return Container(
                    key: ValueKey(ex.uniqueId),
                    child: exercisesAsync.when(
                      data: (exercisesList) {
                        final exercise = exercisesList.firstWhere(
                          (e) => e.id == ex.exerciseId,
                          orElse: () => exercisesList.first,
                        );
                        return _ExerciseCard(
                          exercise: exercise,
                          data: ex,
                          onUpdateSets: (sets) => onUpdateExercise(ex.uniqueId, sets),
                          onSwap: () => onSwap(ex.uniqueId),
                          onRemove: () => onRemove(ex.uniqueId),
                          onDuplicate: () => onDuplicate(ex.uniqueId),
                          onMoveSection: (sec) => onMoveToSection(ex.uniqueId, sec),
                          idx: idx,
                        );
                      },
                      loading: () => const Card(child: ListTile(title: Text('Loading...'))),
                      error: (_, _) => const Card(child: ListTile(title: Text('Error loading exercise'))),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatefulWidget {
  final int idx;
  final ExerciseEntity exercise;
  final _ExerciseData data;
  final Function(List<_SetData>) onUpdateSets;
  final VoidCallback onSwap;
  final VoidCallback onRemove;
  final VoidCallback onDuplicate;
  final Function(String) onMoveSection;

  const _ExerciseCard({
    required this.idx,
    required this.exercise,
    required this.data,
    required this.onUpdateSets,
    required this.onSwap,
    required this.onRemove,
    required this.onDuplicate,
    required this.onMoveSection,
  });

  @override
  State<_ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<_ExerciseCard> {
  final ExpansibleController _controller = ExpansibleController();

  @override
  Widget build(BuildContext context) {
    final setConfig = widget.data.sets.first; 
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 3, color: sectionConfigs[widget.data.section]!.color),
            Expanded(
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  controller: _controller,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  leading: ReorderableDragStartListener(
                    index: widget.idx,
                    child: const Icon(LucideIcons.gripVertical, size: 20, color: Colors.grey),
                  ),
                  title: Text(
                    widget.exercise.name,
                    style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${setConfig.sets} × ${setConfig.reps} · ${setConfig.type} · ${setConfig.rest}s rest',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                  ),
                  trailing: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz, size: 20, color: Colors.grey),
                    onSelected: (val) {
                      if (val == 'edit') {
                        if (!_controller.isExpanded) _controller.expand();
                      }
                      if (val == 'swap') widget.onSwap();
                      if (val == 'duplicate') widget.onDuplicate();
                      if (val == 'delete') widget.onRemove();
                      if (sectionConfigs.keys.contains(val)) widget.onMoveSection(val);
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: ListTile(leading: Icon(LucideIcons.pencil, size: 18), title: Text('Edit Sets'), contentPadding: EdgeInsets.zero)),
                      const PopupMenuDivider(),
                      const PopupMenuItem(value: 'swap', child: ListTile(leading: Icon(LucideIcons.refreshCw, size: 18), title: Text('Swap Exercise'), contentPadding: EdgeInsets.zero)),
                      const PopupMenuItem(value: 'duplicate', child: ListTile(leading: Icon(LucideIcons.copy, size: 18), title: Text('Duplicate'), contentPadding: EdgeInsets.zero)),
                      const PopupMenuDivider(),
                      ...sectionConfigs.keys.where((k) => k != widget.data.section).map((k) => PopupMenuItem(value: k, child: ListTile(leading: Icon(LucideIcons.arrowRight, size: 18), title: Text('Move to $k'), contentPadding: EdgeInsets.zero))),
                      const PopupMenuDivider(),
                      const PopupMenuItem(value: 'delete', child: ListTile(leading: Icon(LucideIcons.trash2, size: 18, color: Colors.red), title: Text('Delete', style: TextStyle(color: Colors.red)), contentPadding: EdgeInsets.zero)),
                    ],
                  ),
                  children: [
                    const Divider(),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStepper(
                            label: 'Sets',
                            value: setConfig.sets,
                            onChanged: (val) => widget.onUpdateSets([_SetData(val.clamp(1, 10), setConfig.reps, setConfig.rest, setConfig.type)]),
                          ),
                        ),
                        Expanded(
                          child: _buildStepper(
                            label: 'Reps',
                            value: setConfig.reps,
                            onChanged: (val) => widget.onUpdateSets([_SetData(setConfig.sets, val.clamp(1, 50), setConfig.rest, setConfig.type)]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStepper(
                            label: 'Rest (s)',
                            value: setConfig.rest,
                            step: 15,
                            onChanged: (val) => widget.onUpdateSets([_SetData(setConfig.sets, setConfig.reps, val.clamp(0, 300), setConfig.type)]),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Type', style: TextStyle(fontSize: 12, color: Colors.grey)),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: setConfig.type,
                                    isExpanded: true,
                                    icon: const Icon(LucideIcons.chevronDown, size: 16),
                                    style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
                                    items: ['Straight', 'Superset', 'Drop Set', 'AMRAP', 'Timed']
                                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                                        .toList(),
                                    onChanged: (val) => widget.onUpdateSets([_SetData(setConfig.sets, setConfig.reps, setConfig.rest, val ?? 'Straight')]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper({required String label, required int value, required Function(int) onChanged, int step = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Row(
          children: [
            InkWell(
              onTap: () => onChanged(value - step),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                child: const Icon(LucideIcons.minus, size: 16),
              ),
            ),
            Expanded(
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            InkWell(
              onTap: () => onChanged(value + step),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                child: const Icon(LucideIcons.plus, size: 16),
              ),
            ),
          ],
        ),
      ],
    );
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
  final String uniqueId;
  final int exerciseId;
  final List<_SetData> sets;
  final String section;
  
  _ExerciseData({
    required this.uniqueId, 
    required this.exerciseId, 
    required this.sets,
    this.section = 'Main Work',
  });

  _ExerciseData copyWith({List<_SetData>? sets, String? section, int? exerciseId, String? uniqueId}) {
    return _ExerciseData(
      uniqueId: uniqueId ?? this.uniqueId,
      exerciseId: exerciseId ?? this.exerciseId,
      sets: sets ?? this.sets,
      section: section ?? this.section,
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

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  _DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 8;
    const double dashSpace = 4;
    
    _drawDashedLine(canvas, const Offset(12, 0), Offset(size.width - 12, 0), paint, dashWidth, dashSpace); // Top
    _drawDashedLine(canvas, Offset(size.width, 12), Offset(size.width, size.height - 12), paint, dashWidth, dashSpace); // Right
    _drawDashedLine(canvas, Offset(size.width - 12, size.height), Offset(12, size.height), paint, dashWidth, dashSpace); // Bottom
    _drawDashedLine(canvas, Offset(0, size.height - 12), const Offset(0, 12), paint, dashWidth, dashSpace); // Left
    
    canvas.drawArc(const Rect.fromLTWH(0, 0, 24, 24), 3.14159, 1.5708, false, paint);
    canvas.drawArc(Rect.fromLTWH(size.width - 24, 0, 24, 24), -1.5708, 1.5708, false, paint);
    canvas.drawArc(Rect.fromLTWH(size.width - 24, size.height - 24, 24, 24), 0, 1.5708, false, paint);
    canvas.drawArc(Rect.fromLTWH(0, size.height - 24, 24, 24), 1.5708, 1.5708, false, paint);
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint, double dashWidth, double dashSpace) {
    var distance = (end - start).distance;
    var direction = (end - start) / distance;
    var currentDistance = 0.0;
    while (currentDistance < distance) {
      canvas.drawLine(
        start + direction * currentDistance,
        start + direction * (currentDistance + dashWidth > distance ? distance : currentDistance + dashWidth),
        paint,
      );
      currentDistance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
