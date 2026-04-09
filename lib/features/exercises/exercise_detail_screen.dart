import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/core/database/database.dart' as db;
import 'package:ai_gym_mentor/features/exercises/exercises_provider.dart';
import 'package:ai_gym_mentor/services/progression_service.dart';
import 'package:ai_gym_mentor/features/exercises/exercise_repository.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:drift/drift.dart' show Value;
import 'package:ai_gym_mentor/core/domain/entities/exercise.dart' as entity;

class ExerciseDetailScreen extends ConsumerStatefulWidget {
  final int exerciseId;
  final bool isEditing;
  const ExerciseDetailScreen(
      {super.key, required this.exerciseId, this.isEditing = false});

  @override
  ConsumerState<ExerciseDetailScreen> createState() =>
      _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends ConsumerState<ExerciseDetailScreen> {
  final TextEditingController _weightController =
      TextEditingController(text: '100');
  final TextEditingController _repsController =
      TextEditingController(text: '10');

  String _selectedMuscle = 'Chest';
  String _selectedEquipment = 'Barbell';
  final TextEditingController _nameController = TextEditingController();
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(allExercisesProvider);

    return exercisesAsync.when(
      data: (exercises) {
        final entity.Exercise? exercise = widget.exerciseId > 0
            ? exercises.firstWhere((e) => e.id == widget.exerciseId,
                orElse: () => exercises.first)
            : null;

        if (exercise != null &&
            !_initialized &&
            (widget.isEditing || widget.exerciseId == 0)) {
          _nameController.text = exercise.name;
          _selectedMuscle = exercise.primaryMuscle;
          _selectedEquipment = exercise.equipment;
          _initialized = true;
        }

        if (widget.exerciseId == 0 || widget.isEditing) {
          return _buildFormScreen(exercise);
        }

        if (exercise == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Exercise Not Found')),
            body: const Center(child: Text('Could not find this exercise')),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _buildAppBar(exercise),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProgressionSettings(exercise),
                      const SizedBox(height: 24),
                      _build1RMEstimator(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
    );
  }

  Widget _buildAppBar(entity.Exercise exercise) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(exercise.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Center(
              child: Icon(LucideIcons.dumbbell,
                  size: 80, color: Colors.white.withValues(alpha: 0.2)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressionSettings(entity.Exercise exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.trendingUp,
                size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text('Progression Settings',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        _buildSettingsCard(exercise),
      ],
    );
  }

  Widget _buildSettingsCard(entity.Exercise exercise) {
    // We would fetch settings from DB here. For brevity in this turn I'll use a FutureBuilder or similar.
    final database = ref.read(db.appDatabaseProvider);
    return StreamBuilder<db.ExerciseProgressionSetting?>(
      stream: (database.select(database.exerciseProgressionSettings)
            ..where((t) => t.exerciseId.equals(widget.exerciseId)))
          .watchSingleOrNull(),
      builder: (context, snapshot) {
        final settings = snapshot.data;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSettingRow(
                  'Increment Override',
                  '${settings?.incrementOverride ?? 2.5}kg',
                  () => _showIncrementPicker(settings),
                ),
                const Divider(),
                _buildSettingRow(
                  'Target Reps',
                  '${settings?.targetReps ?? 10}',
                  () => _showNumberPicker(
                      'Target Reps',
                      settings?.targetReps ?? 10,
                      (val) => _updateSettings(targetReps: val)),
                ),
                const Divider(),
                _buildSettingRow(
                  'Target Sets',
                  '${settings?.targetSets ?? 3}',
                  () => _showNumberPicker(
                      'Target Sets',
                      settings?.targetSets ?? 3,
                      (val) => _updateSettings(targetSets: val)),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Auto-suggest weight',
                      style: TextStyle(fontSize: 14)),
                  value: settings?.autoSuggest ?? true,
                  onChanged: (val) => _updateSettings(autoSuggest: val),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingRow(String label, String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(label,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis)),
            Row(
              children: [
                Text(value,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary)),
                const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _build1RMEstimator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.calculator,
                size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text('1RM Estimator',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildInput('Weight', _weightController)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildInput('Reps', _repsController)),
                  ],
                ),
                const SizedBox(height: 24),
                _buildResultsTable(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _buildResultsTable() {
    final weight = double.tryParse(_weightController.text) ?? 0;
    final reps = double.tryParse(_repsController.text) ?? 0;
    final progression = ref.read(progressionServiceProvider.notifier);
    final results = progression.getAll1RMs(weight, reps);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Training Max (90%)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${(results['Epley']! * 0.9).toStringAsFixed(1)}kg',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...results.entries.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(e.key,
                              style: const TextStyle(color: Colors.grey),
                              overflow: TextOverflow.ellipsis)),
                      Text('${e.value.toStringAsFixed(1)}kg',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )),
      ],
    );
  }

  void _updateSettings(
      {double? incrementOverride,
      int? targetReps,
      int? targetSets,
      bool? autoSuggest}) async {
    final database = ref.read(db.appDatabaseProvider);
    final existing = await (database.select(database.exerciseProgressionSettings)
          ..where((t) => t.exerciseId.equals(widget.exerciseId)))
        .getSingleOrNull();

    if (existing == null) {
      await database
          .into(database.exerciseProgressionSettings)
          .insert(db.ExerciseProgressionSettingsCompanion.insert(
            exerciseId: widget.exerciseId,
            incrementOverride: Value(incrementOverride),
            targetReps: Value(targetReps ?? 10),
            targetSets: Value(targetSets ?? 3),
            autoSuggest: Value(autoSuggest ?? true),
          ));
    } else {
      await (database.update(database.exerciseProgressionSettings)
            ..where((t) => t.exerciseId.equals(widget.exerciseId)))
          .write(
        db.ExerciseProgressionSettingsCompanion(
          incrementOverride:
              Value(incrementOverride ?? existing.incrementOverride),
          targetReps: Value(targetReps ?? existing.targetReps),
          targetSets: Value(targetSets ?? existing.targetSets),
          autoSuggest: Value(autoSuggest ?? existing.autoSuggest),
        ),
      );
    }
  }

  void _showIncrementPicker(db.ExerciseProgressionSetting? settings) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 300,
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Select Increment',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  final val = (index + 1) * 0.5;
                  return ListTile(
                    title: Text('${val}kg'),
                    onTap: () {
                      _updateSettings(incrementOverride: val);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNumberPicker(String title, int current, Function(int) onSelect) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 300,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(16),
                child: Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  final val = index + 1;
                  return ListTile(
                    title: Text('$val'),
                    selected: val == current,
                    onTap: () {
                      onSelect(val);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormScreen(entity.Exercise? exercise) {
    final muscleGroups = [
      'Chest',
      'Back',
      'Shoulders',
      'Biceps',
      'Triceps',
      'Quads',
      'Hamstrings',
      'Glutes',
      'Calves',
      'Core',
      'Cardio',
      'Full Body'
    ];
    final equipmentTypes = [
      'Barbell',
      'Dumbbell',
      'Machine',
      'Cable',
      'Bodyweight',
      'Kettlebell',
      'Bands',
      'Other'
    ];

    final isNew = widget.exerciseId == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? 'Create Exercise' : 'Edit Exercise'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _nameController,
            autofocus: isNew,
            decoration: const InputDecoration(
              labelText: 'Exercise Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _selectedMuscle,
            decoration: const InputDecoration(
              labelText: 'Primary Muscle',
              border: OutlineInputBorder(),
            ),
            items: muscleGroups
                .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                .toList(),
            onChanged: (val) =>
                setState(() => _selectedMuscle = val ?? 'Chest'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _selectedEquipment,
            decoration: const InputDecoration(
              labelText: 'Equipment',
              border: OutlineInputBorder(),
            ),
            items: equipmentTypes
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) =>
                setState(() => _selectedEquipment = val ?? 'Barbell'),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () async {
              if (_nameController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Please enter an exercise name')),
                );
                return;
              }
              final repository = ref.read(exerciseRepositoryProvider);
              final companion = isNew
                  ? db.ExercisesCompanion.insert(
                      name: _nameController.text.trim(),
                      primaryMuscle: _selectedMuscle,
                      equipment: _selectedEquipment,
                      setType: 'Straight',
                      isCustom: const Value(true),
                    )
                  : db.ExercisesCompanion(
                      id: Value(widget.exerciseId),
                      name: Value(_nameController.text.trim()),
                      primaryMuscle: Value(_selectedMuscle),
                      equipment: Value(_selectedEquipment),
                    );

              await repository.saveExercise(companion);

              ref.invalidate(allExercisesProvider);
              if (mounted) context.pop();
            },
            child: Text(isNew ? 'Create Exercise' : 'Save Changes'),
          ),
        ],
      ),
    );
  }
}
