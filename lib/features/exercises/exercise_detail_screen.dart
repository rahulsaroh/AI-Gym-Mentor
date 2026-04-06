import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_gemini_pro/core/database/database.dart';
import 'package:gym_gemini_pro/features/exercises/exercises_provider.dart';
import 'package:gym_gemini_pro/services/progression_service.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:drift/drift.dart' show Value;

class ExerciseDetailScreen extends ConsumerStatefulWidget {
  final int exerciseId;
  const ExerciseDetailScreen({super.key, required this.exerciseId});

  @override
  ConsumerState<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends ConsumerState<ExerciseDetailScreen> {
  final TextEditingController _weightController = TextEditingController(text: '100');
  final TextEditingController _repsController = TextEditingController(text: '10');

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(allExercisesProvider);

    return exercisesAsync.when(
      data: (exercises) {
        final exercise = exercises.firstWhere((e) => e.id == widget.exerciseId);
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
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
    );
  }

  Widget _buildAppBar(Exercise exercise) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Center(
              child: Icon(LucideIcons.dumbbell, size: 80, color: Colors.white.withOpacity(0.2)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressionSettings(Exercise exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.trendingUp, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text('Progression Settings', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        _buildSettingsCard(exercise),
      ],
    );
  }

  Widget _buildSettingsCard(Exercise exercise) {
    // We would fetch settings from DB here. For brevity in this turn I'll use a FutureBuilder or similar.
    final db = ref.read(appDatabaseProvider);
    return StreamBuilder<ExerciseProgressionSetting?>(
      stream: (db.select(db.exerciseProgressionSettings)..where((t) => t.exerciseId.equals(widget.exerciseId))).watchSingleOrNull(),
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
                  () => _showNumberPicker('Target Reps', settings?.targetReps ?? 10, (val) => _updateSettings(targetReps: val)),
                ),
                const Divider(),
                _buildSettingRow(
                  'Target Sets',
                  '${settings?.targetSets ?? 3}',
                  () => _showNumberPicker('Target Sets', settings?.targetSets ?? 3, (val) => _updateSettings(targetSets: val)),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Auto-suggest weight', style: TextStyle(fontSize: 14)),
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
            Text(label, style: const TextStyle(fontSize: 14)),
            Row(
              children: [
                Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
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
            Icon(LucideIcons.calculator, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text('1RM Estimator', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
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
            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Training Max (90%)', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${(results['Epley']! * 0.9).toStringAsFixed(1)}kg', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...results.entries.map((e) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(e.key, style: const TextStyle(color: Colors.grey)),
              Text('${e.value.toStringAsFixed(1)}kg', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        )).toList(),
      ],
    );
  }

  void _updateSettings({double? incrementOverride, int? targetReps, int? targetSets, bool? autoSuggest}) async {
    final db = ref.read(appDatabaseProvider);
    final existing = await (db.select(db.exerciseProgressionSettings)..where((t) => t.exerciseId.equals(widget.exerciseId))).getSingleOrNull();

    if (existing == null) {
      await db.into(db.exerciseProgressionSettings).insert(ExerciseProgressionSettingsCompanion.insert(
        exerciseId: widget.exerciseId,
        incrementOverride: Value(incrementOverride),
        targetReps: Value(targetReps ?? 10),
        targetSets: Value(targetSets ?? 3),
        autoSuggest: Value(autoSuggest ?? true),
      ));
    } else {
      await (db.update(db.exerciseProgressionSettings)..where((t) => t.exerciseId.equals(widget.exerciseId))).write(
        ExerciseProgressionSettingsCompanion(
          incrementOverride: Value(incrementOverride ?? existing.incrementOverride),
          targetReps: Value(targetReps ?? existing.targetReps),
          targetSets: Value(targetSets ?? existing.targetSets),
          autoSuggest: Value(autoSuggest ?? existing.autoSuggest),
        ),
      );
    }
  }

  void _showIncrementPicker(ExerciseProgressionSetting? settings) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(16), child: Text('Select Increment', style: TextStyle(fontWeight: FontWeight.bold))),
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
      builder: (context) => Container(
        height: 300,
        child: Column(
          children: [
             Padding(padding: const EdgeInsets.all(16), child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
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
}
