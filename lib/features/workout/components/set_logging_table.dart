import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/core/database/database.dart' as db;
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart' as entity;
import 'package:ai_gym_mentor/features/workout/models/workout_models.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:ai_gym_mentor/core/utils/weight_converter.dart';

typedef SetUpdateCallback = void Function(int setId, {double? weight, double? reps, int? rir, double? rpe, String? notes});

class SetLoggingTable extends StatelessWidget {
  final ExerciseBlock block;
  final entity.ExerciseEntity exercise;
  final List<ExerciseBlock> allBlocks;
  final SettingsState settings;
  final Map<int, List<db.WorkoutSet>> previousSessionSets;
  
  final SetUpdateCallback onUpdateSet;
  final void Function(ExerciseBlock) onAddSet;
  final void Function(int) onRemoveSet;
  final void Function(db.WorkoutSet, entity.ExerciseEntity, ExerciseBlock, List<ExerciseBlock>) onToggleSet;
  final void Function(db.WorkoutSet, bool forRpe) onIntensityPicker;
  final void Function(int setId, String type, TextEditingController controller, Function(String) onChanged, double delta) onAdjustValue;
  final TextEditingController Function(int id, String type, String initialValue) getController;
  final FocusNode Function(int id, String type) getNode;
  final VoidCallback onUndoDelete;

  const SetLoggingTable({
    super.key,
    required this.block,
    required this.exercise,
    required this.allBlocks,
    required this.settings,
    required this.previousSessionSets,
    required this.onUpdateSet,
    required this.onAddSet,
    required this.onRemoveSet,
    required this.onToggleSet,
    required this.onIntensityPicker,
    required this.onAdjustValue,
    required this.getController,
    required this.getNode,
    required this.onUndoDelete,
  });

  @override
  Widget build(BuildContext context) {
    final unit = settings.weightUnit;
    return Column(
      children: [
        // Table Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              _buildTableHeaderLabel(context, 'SET', 40),
              Expanded(child: _buildTableHeaderLabel(context, 'WEIGHT (${unit == WeightUnit.kg ? 'KG' : 'LBS'})', 0)),
              Expanded(child: _buildTableHeaderLabel(context, exercise.setType == 'Timed' ? 'SECS' : 'REPS', 0)),
              _buildTableHeaderLabel(context, 'RPE', 50),
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
            child: _buildSetRow(context, entry.value, entry.key + 1),
          );
        }),
        const SizedBox(height: 12),
        // Add Set Button
        _buildAddSetButton(context),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTableHeaderLabel(BuildContext context, String label, double? width) {
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

  Widget _buildAddSetButton(BuildContext context) {
    return InkWell(
      onTap: () => onAddSet(block),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            style: BorderStyle.solid,
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

  Widget _buildSetRow(BuildContext context, db.WorkoutSet set, int index) {
    final isCompleted = set.completed;
    final unit = settings.weightUnit;
    
    final isActive = block.sets.firstWhere((s) => !s.completed, orElse: () => block.sets.first).id == set.id;

    return Slidable(
      key: ValueKey('set_${set.id}'),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(
            onPressed: (_) {
              onRemoveSet(set.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Set deleted'),
                  action: SnackBarAction(label: 'Undo', onPressed: onUndoDelete),
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
        child: Column(
          children: [
            Row(
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
                    context,
                    setId: set.id,
                    type: 'weight',
                    value: WeightConverter.toDisplay(set.weight, unit).toStringAsFixed(1),
                    onChanged: (val) => onUpdateSet(set.id, weight: WeightConverter.toStorage(double.tryParse(val) ?? 0, unit)),
                    isCompleted: isCompleted,
                  ),
                ),
                const SizedBox(width: 8),
                // Reps Input
                Expanded(
                  child: _buildRedesignedCellInput(
                    context,
                    setId: set.id,
                    type: exercise.setType == 'Timed' ? 'secs' : 'reps',
                    value: set.reps.toInt().toString(),
                    onChanged: (val) => onUpdateSet(set.id, reps: double.tryParse(val) ?? 0),
                    isCompleted: isCompleted,
                  ),
                ),
                const SizedBox(width: 8),
                _buildCompactIntensityInput(context, set, true, isCompleted),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => onToggleSet(set, exercise, block, allBlocks),
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
            _buildPreviousStatsRow(context, set, unit),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviousStatsRow(BuildContext context, db.WorkoutSet set, WeightUnit unit) {
    if (!previousSessionSets.containsKey(set.exerciseId)) return const SizedBox.shrink();
    
    final prevSets = previousSessionSets[set.exerciseId]!;
    final match = prevSets.where((s) => s.setNumber == set.setNumber).firstOrNull ?? prevSets.lastOrNull;
    
    if (match == null) return const SizedBox.shrink();
    
    final weightStr = WeightConverter.toDisplay(match.weight, unit).toStringAsFixed(1);
    final repsStr = match.reps.toInt().toString();

    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 2),
      child: Row(
        children: [
          Icon(LucideIcons.history, size: 10, color: Theme.of(context).colorScheme.outline.withOpacity(0.5)),
          const SizedBox(width: 4),
          Text(
            'Last: ${weightStr}${unit == WeightUnit.kg ? 'kg' : 'lbs'} x $repsStr',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Theme.of(context).colorScheme.outline.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRedesignedCellInput(
    BuildContext context, {
    required int setId,
    required String type,
    required String value,
    required Function(String) onChanged,
    bool isCompleted = false,
  }) {
    final controller = getController(setId, type, value);
    final focusNode = getNode(setId, type);

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
               focusNode.requestFocus();
               controller.selection = TextSelection(
                 baseOffset: 0,
                 extentOffset: controller.text.length,
               );
            },
          ),
        ),
        if (!isCompleted)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRoundIconButton(
                context,
                icon: LucideIcons.minus,
                onPressed: () => onAdjustValue(setId, type, controller, onChanged, -1),
              ),
              const SizedBox(width: 8),
              _buildRoundIconButton(
                context,
                icon: LucideIcons.plus,
                onPressed: () => onAdjustValue(setId, type, controller, onChanged, 1),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildRoundIconButton(BuildContext context, {required IconData icon, required VoidCallback onPressed}) {
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

  Widget _buildCompactIntensityInput(BuildContext context, db.WorkoutSet set, bool forRpe, bool isCompleted) {
    final value = forRpe ? set.rpe : set.rir;
    return GestureDetector(
      onTap: isCompleted ? null : () => onIntensityPicker(set, forRpe),
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
}
