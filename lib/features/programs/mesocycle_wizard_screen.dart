import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_gym_mentor/core/domain/entities/mesocycle.dart' as ent;
import 'package:ai_gym_mentor/features/programs/providers/mesocycle_wizard_provider.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/widgets/exercise_picker_overlay.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/repository_provider.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';

class MesocycleWizardScreen extends ConsumerStatefulWidget {
  const MesocycleWizardScreen({super.key});

  @override
  ConsumerState<MesocycleWizardScreen> createState() => _MesocycleWizardScreenState();
}

class _MesocycleWizardScreenState extends ConsumerState<MesocycleWizardScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mesocycleWizardProvider);
    final notifier = ref.read(mesocycleWizardProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('New Mesocycle', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(LucideIcons.x),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          _buildProgressIndicator(state.currentStep),
          Expanded(
            child: _buildStepContent(state, notifier),
          ),
          _buildNavigation(state, notifier),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(int currentStep) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: List.generate(4, (index) {
          final isActive = index <= currentStep;
          final isCurrent = index == currentStep;
          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: index == 3 ? 0 : 8),
              decoration: BoxDecoration(
                color: isActive ? Colors.orange[700] : Colors.grey[200],
                borderRadius: BorderRadius.circular(2),
                boxShadow: isCurrent ? [BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 4)] : null,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent(MesocycleWizardState state, MesocycleWizardNotifier notifier) {
    switch (state.currentStep) {
      case 0: return _buildBasicsStep(state, notifier);
      case 1: return _buildStructureStep(state, notifier);
      case 2: return _buildExercisesStep(state, notifier);
      case 3: return _buildReviewStep(state, notifier);
      default: return const SizedBox.shrink();
    }
  }

  Widget _buildBasicsStep(MesocycleWizardState state, MesocycleWizardNotifier notifier) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('The Fundamentals', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Start by defining the purpose of this training block.', style: GoogleFonts.outfit(color: Colors.grey[600])),
        const SizedBox(height: 32),
        TextField(
          controller: _nameController..text = state.name,
          onChanged: (val) => notifier.updateBasics(name: val, goal: state.goal, experienceLevel: state.experienceLevel),
          decoration: InputDecoration(
            labelText: 'Mesocycle Name',
            hintText: 'e.g. Summer Shred PHAT',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(LucideIcons.pen),
          ),
        ),
        const SizedBox(height: 24),
        _buildDropdown<ent.MesocycleGoal>(
          label: 'Primary Goal',
          value: state.goal,
          items: ent.MesocycleGoal.values.map((g) => DropdownMenuItem(value: g, child: Text(g.label))).toList(),
          onChanged: (val) {
            if (val != null) notifier.updateBasics(name: state.name, goal: val, experienceLevel: state.experienceLevel);
          },
        ),
      ],
    );
  }

  Widget _buildStructureStep(MesocycleWizardState state, MesocycleWizardNotifier notifier) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Block Structure', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 32),
        _buildDropdown<String>(
          label: 'Split Type',
          value: state.splitType,
          items: ['PPL (Push/Pull/Legs)', 'Upper/Lower', 'Full Body', 'Custom']
              .map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
          onChanged: (val) {
            if (val != null) notifier.updateStructure(splitType: val, weeksCount: state.weeksCount, daysPerWeek: state.daysPerWeek);
          },
        ),
        const SizedBox(height: 24),
        _buildCounter('Duration (Weeks)', state.weeksCount, (val) {
          notifier.updateStructure(splitType: state.splitType, weeksCount: val, daysPerWeek: state.daysPerWeek);
        }, min: 4, max: 12),
        const SizedBox(height: 24),
        _buildCounter('Training Days Per Week', state.daysPerWeek, (val) {
          notifier.updateStructure(splitType: state.splitType, weeksCount: state.weeksCount, daysPerWeek: val);
        }, min: 1, max: 7),
      ],
    );
  }

  Widget _buildExercisesStep(MesocycleWizardState state, MesocycleWizardNotifier notifier) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: state.daysPerWeek,
      itemBuilder: (context, index) {
        final exercises = state.exercisesPerDay[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey[200]!),
          ),
          child: ExpansionTile(
            title: Text('Day ${index + 1}', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
            subtitle: Text('${exercises.length} Exercises selected', style: GoogleFonts.outfit(fontSize: 12)),
            children: [
              ...exercises.map((ex) => ListTile(
                title: Text(ex.name),
                trailing: IconButton(
                  icon: const Icon(LucideIcons.trash, size: 18, color: Colors.red),
                  onPressed: () {
                    final updated = List<ExerciseEntity>.from(exercises)..remove(ex);
                    notifier.updateExercisesForDay(index, updated);
                  },
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(16),
                child: OutlinedButton.icon(
                  onPressed: () => _pickExercise(context, index, (ex) {
                    final updated = List<ExerciseEntity>.from(exercises)..add(ex);
                    notifier.updateExercisesForDay(index, updated);
                  }),
                  icon: const Icon(LucideIcons.plus),
                  label: const Text('Add Exercise'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReviewStep(MesocycleWizardState state, MesocycleWizardNotifier notifier) {
    if (state.previewedMesocycle == null) return const Center(child: CircularProgressIndicator());
    final mes = state.previewedMesocycle!;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Preview & Review', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              _buildReviewRow('Total Workouts', '${mes.weeksCount * mes.daysPerWeek}'),
              const Divider(),
              _buildReviewRow('Deload Week', 'Week ${mes.weeksCount}'),
              const Divider(),
              _buildReviewRow('Progression', 'Dynamic Phase Multipliers'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text('Structure Preview', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...mes.weeks.take(2).map((w) => ListTile(
          leading: CircleAvatar(backgroundColor: Colors.orange[700], foregroundColor: Colors.white, child: Text('${w.weekNumber}')),
          title: Text(w.phaseName.label),
          subtitle: Text('Volume: x${w.volumeMultiplier.toStringAsFixed(1)} • Int: ${w.intensityMultiplier} RPE'),
        )),
        Text('...', textAlign: TextAlign.center, style: GoogleFonts.outfit(color: Colors.grey)),
      ],
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.outfit(color: Colors.grey[700])),
          Text(value, style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>({required String label, required T value, required List<DropdownMenuItem<T>> items, required ValueChanged<T?> onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[700])),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
      ],
    );
  }

  Widget _buildCounter(String label, int value, ValueChanged<int> onChanged, {int min = 1, int max = 10}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        Row(
          children: [
            IconButton(onPressed: value > min ? () => onChanged(value - 1) : null, icon: const Icon(LucideIcons.minus)),
            Text('$value', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(onPressed: value < max ? () => onChanged(value + 1) : null, icon: const Icon(LucideIcons.plus)),
          ],
        ),
      ],
    );
  }

  Widget _buildNavigation(MesocycleWizardState state, MesocycleWizardNotifier notifier) {
    final isLast = state.currentStep == 3;
    final isBasicsDone = state.name.isNotEmpty;
    final isExercisesDone = state.exercisesPerDay.every((day) => day.isNotEmpty);

    bool canNext = true;
    if (state.currentStep == 0) canNext = isBasicsDone;
    if (state.currentStep == 2) canNext = isExercisesDone;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
      child: Row(
        children: [
          if (state.currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: notifier.prevStep,
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('Back'),
              ),
            ),
          if (state.currentStep > 0) const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: canNext ? () async {
                if (isLast) {
                  await notifier.completeWizard();
                  if (mounted) context.pop();
                } else {
                  notifier.nextStep();
                }
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(isLast ? 'Create Block' : 'Continue'),
            ),
          ),
        ],
      ),
    );
  }

  void _pickExercise(BuildContext context, int dayIndex, Function(ExerciseEntity) onSelected) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => ExercisePickerOverlay(
          onSelect: (exId) async {
            final repo = ref.read(exerciseRepositoryProvider);
            final ex = await repo.getExerciseById(exId);
            if (ex != null) {
              onSelected(ex);
            }
            if (context.mounted) Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
