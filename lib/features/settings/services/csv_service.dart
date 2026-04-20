import 'package:csv/csv.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/core/utils/weight_converter.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'csv_service.g.dart';

@riverpod
class CsvService extends _$CsvService {
  @override
  void build() {}

  Future<String> generateWorkoutCsv({
    required List<Workout> workouts,
    required List<WorkoutSet> sets,
    required Map<int, String> exerciseNames,
    required Set<String> selectedColumns,
    required WeightUnit unit,
    bool includeWarmup = true,
  }) async {
    final List<List<dynamic>> rows = [];

    // Header
    final List<String> header = [];
    if (selectedColumns.contains('Date')) header.add('Date');
    if (selectedColumns.contains('Day')) header.add('Day');
    if (selectedColumns.contains('Workout Name')) header.add('Workout Name');
    if (selectedColumns.contains('Exercise')) header.add('Exercise');
    if (selectedColumns.contains('Set#')) header.add('Set#');
    if (selectedColumns.contains('Set Type')) header.add('Set Type');
    final unitStr = unit == WeightUnit.kg ? 'kg' : 'lbs';
    if (selectedColumns.contains('Weight')) header.add('Weight($unitStr)');
    if (selectedColumns.contains('Reps')) header.add('Reps');
    if (selectedColumns.contains('RPE')) header.add('RPE');
    if (selectedColumns.contains('Volume')) header.add('Volume($unitStr)');
    if (selectedColumns.contains('Est. 1RM')) header.add('Est. 1RM($unitStr)');
    if (selectedColumns.contains('Is PR')) header.add('Is PR');
    if (selectedColumns.contains('Notes')) header.add('Notes');
    rows.add(header);

    final workoutMap = {for (var w in workouts) w.id: w};

    for (var s in sets) {
      if (!includeWarmup && s.setType == SetType.warmup) continue;

      final workout = workoutMap[s.workoutId];
      if (workout == null) continue;

      final List<dynamic> row = [];
      if (selectedColumns.contains('Date'))
        row.add(DateFormat('yyyy-MM-dd').format(workout.date));
      if (selectedColumns.contains('Day'))
        row.add(DateFormat('EEEE').format(workout.date));
      if (selectedColumns.contains('Workout Name')) row.add(workout.name);
      if (selectedColumns.contains('Exercise'))
        row.add(exerciseNames[s.exerciseId] ?? 'Unknown');
      if (selectedColumns.contains('Set#')) row.add(s.setNumber);
      if (selectedColumns.contains('Set Type')) row.add(s.setType.name);
      if (selectedColumns.contains('Weight'))
        row.add(WeightConverter.toDisplay(s.weight, unit).toStringAsFixed(1));
      if (selectedColumns.contains('Reps')) row.add(s.reps);
      if (selectedColumns.contains('RPE')) row.add(s.rpe ?? '');
      if (selectedColumns.contains('Volume'))
        row.add(WeightConverter.toDisplay(s.weight * s.reps, unit)
            .toStringAsFixed(1));
      if (selectedColumns.contains('Est. 1RM')) {
        final rm = s.weight * (1 + s.reps / 30);
        row.add(WeightConverter.toDisplay(rm, unit).toStringAsFixed(1));
      }
      if (selectedColumns.contains('Is PR')) row.add(s.isPr ? 'TRUE' : 'FALSE');
      if (selectedColumns.contains('Notes')) row.add(s.notes ?? '');
      rows.add(row);
    }

    final csvString = const ListToCsvConverter().convert(rows);
    // Add BOM for Excel compatibility
    return '\uFEFF$csvString';
  }
}
