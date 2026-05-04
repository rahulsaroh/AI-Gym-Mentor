import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/settings/services/csv_import_service.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/exercise_providers.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:intl/intl.dart';

class CsvImportWizard extends ConsumerStatefulWidget {
  const CsvImportWizard({super.key});

  @override
  ConsumerState<CsvImportWizard> createState() => _CsvImportWizardState();
}

enum ImportStep { select, validate, resolve, progress, done }

class _CsvImportWizardState extends ConsumerState<CsvImportWizard> {
  ImportStep _currentStep = ImportStep.select;
  List<Map<String, dynamic>>? _parsedData;
  Map<String, String>? _headerMapping;
  int _duplicateCount = 0;
  double _progress = 0;
  String _conflictResolution = 'skip'; // skip, replace, all
  String _importType = 'workout'; // workout, measurement

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import CSV Data')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _getStepIndex(),
        controlsBuilder: (context, details) => const SizedBox.shrink(),
        steps: [
          Step(
            title: const Text('File'),
            isActive: _currentStep == ImportStep.select,
            state: _getStepState(ImportStep.select),
            content: _buildFileSelect(),
          ),
          Step(
            title: const Text('Validate'),
            isActive: _currentStep == ImportStep.validate,
            state: _getStepState(ImportStep.validate),
            content: _buildValidation(),
          ),
          Step(
            title: const Text('Resolve'),
            isActive: _currentStep == ImportStep.resolve,
            state: _getStepState(ImportStep.resolve),
            content: _buildConflictResolution(),
          ),
          Step(
            title: const Text('Import'),
            isActive: _currentStep == ImportStep.progress || _currentStep == ImportStep.done,
            state: _getStepState(ImportStep.progress),
            content: _buildProgress(),
          ),
        ],
      ),
    );
  }

  int _getStepIndex() {
    switch (_currentStep) {
      case ImportStep.select: return 0;
      case ImportStep.validate: return 1;
      case ImportStep.resolve: return 2;
      case ImportStep.progress: 
      case ImportStep.done: return 3;
    }
  }

  StepState _getStepState(ImportStep step) {
    if (_currentStep == step) return StepState.editing;
    if (_getStepIndex() > _getStepIndexFor(step)) return StepState.complete;
    return StepState.indexed;
  }

  int _getStepIndexFor(ImportStep step) {
    switch (step) {
      case ImportStep.select: return 0;
      case ImportStep.validate: return 1;
      case ImportStep.resolve: return 2;
      case ImportStep.progress: return 3;
      case ImportStep.done: return 4;
    }
  }

  Widget _buildFileSelect() {
    return Column(
      children: [
        const Icon(LucideIcons.fileSpreadsheet, size: 64, color: Colors.blue),
        const SizedBox(height: 24),
        const Text(
          'Upload a CSV file with your workout history or body measurements.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 12),
        Text(
          'Make sure the file has a header row like "Date, Exercise, Weight, Reps".',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
        ),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          onPressed: _pickFile,
          icon: const Icon(LucideIcons.upload),
          label: const Text('Pick CSV File'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      final service = ref.read(csvImportServiceProvider.notifier);
      
      final data = await service.parseCsv(content);
      if (data.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('CSV file is empty or invalid.')),
          );
        }
        return;
      }

      final headers = data.first.keys.toList();
      final mapping = service.identifyHeaders(headers);

      setState(() {
        _parsedData = data;
        _headerMapping = mapping;
        // Detect type (if it has "exercise" column, it's workout)
        _importType = mapping.containsValue('exercise') ? 'workout' : 'measurement';
        _currentStep = ImportStep.validate;
      });
    }
  }

  Widget _buildValidation() {
    if (_parsedData == null || _headerMapping == null) return const SizedBox.shrink();

    final mappedColumns = _headerMapping!.values.toSet();
    final missingWorkouts = ['date', 'exercise', 'weight', 'reps'].where((c) => !mappedColumns.contains(c)).toList();
    final isWorkout = _importType == 'workout';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detected ${isWorkout ? 'Workout History' : 'Body Measurements'}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 12),
        Text('Records to import: ${_parsedData!.length}'),
        const SizedBox(height: 24),
        const Text('Column Mapping found:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ..._headerMapping!.entries.map((e) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              const Icon(LucideIcons.circleCheck, size: 14, color: Colors.green),
              const SizedBox(width: 8),
              Text('${e.key} → ', style: const TextStyle(color: Colors.grey)),
              Text(e.value.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        )),
        if (isWorkout && missingWorkouts.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'Warning: Missing columns ${missingWorkouts.join(', ')}',
            style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
          ),
        ],
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => setState(() => _currentStep = ImportStep.select),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: _checkConflicts,
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _checkConflicts() async {
    final db = ref.read(appDatabaseProvider);
    final service = ref.read(csvImportServiceProvider.notifier);
    
    int duplicates = 0;
    final Set<String> processedDates = {};

    for (var row in _parsedData!) {
      final dateVal = row[_headerMapping!.entries.firstWhere((e) => e.value == 'date').key];
      final date = service.parseDate(dateVal);
      if (date == null) continue;

      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      if (processedDates.contains(dateStr)) continue;
      processedDates.add(dateStr);

      if (_importType == 'workout') {
        final existing = await (db.select(db.workouts)
              ..where((t) => t.date.equals(DateTime(date.year, date.month, date.day))))
            .get();
        if (existing.isNotEmpty) duplicates++;
      } else {
        final existing = await (db.select(db.bodyMeasurements)
              ..where((t) => t.date.equals(DateTime(date.year, date.month, date.day))))
            .get();
        if (existing.isNotEmpty) duplicates++;
      }
    }

    setState(() {
      _duplicateCount = duplicates;
      _currentStep = duplicates > 0 ? ImportStep.resolve : ImportStep.progress;
    });

    if (duplicates == 0) {
      _startImport();
    }
  }

  Widget _buildConflictResolution() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Found $_duplicateCount dates that already have data.',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
        ),
        const SizedBox(height: 12),
        const Text('How would you like to handle these?'),
        const SizedBox(height: 16),
        RadioListTile<String>(
          title: const Text('Skip duplicates'),
          subtitle: const Text('Only import data for new dates'),
          value: 'skip',
          groupValue: _conflictResolution,
          onChanged: (v) => setState(() => _conflictResolution = v!),
        ),
        RadioListTile<String>(
          title: const Text('Import all'),
          subtitle: const Text('Import everything (may create duplicates)'),
          value: 'all',
          groupValue: _conflictResolution,
          onChanged: (v) => setState(() => _conflictResolution = v!),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => setState(() => _currentStep = ImportStep.validate),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: _startImport,
              child: const Text('Start Import'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgress() {
    return Column(
      children: [
        const SizedBox(height: 40),
        LinearProgressIndicator(value: _progress, minHeight: 8, borderRadius: BorderRadius.circular(4)),
        const SizedBox(height: 16),
        Text(
          _currentStep == ImportStep.done
              ? 'Import Complete!'
              : 'Importing data... ${(_progress * 100).toInt()}%',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        if (_currentStep == ImportStep.done) ...[
          const SizedBox(height: 40),
          const Icon(LucideIcons.circleCheck, color: Colors.green, size: 64),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
            child: const Text('Back to Settings'),
          ),
        ],
      ],
    );
  }

  Future<void> _startImport() async {
    setState(() => _currentStep = ImportStep.progress);
    final db = ref.read(appDatabaseProvider);
    final service = ref.read(csvImportServiceProvider.notifier);
    
    final exercises = await ref.read(allExercisesProvider.future);
    final exerciseCache = {for (var e in exercises) e.name.toLowerCase(): e.id};

    await db.transaction(() async {
      if (_importType == 'workout') {
        // Group rows by Date + Workout Name
        final Map<String, List<Map<String, dynamic>>> workoutGroups = {};
        for (var row in _parsedData!) {
          final dateVal = row[_headerMapping!.entries.firstWhere((e) => e.value == 'date').key];
          final date = service.parseDate(dateVal);
          if (date == null) continue;

          final nameKey = row[_headerMapping!.entries.where((e) => e.value == 'workout_name').firstOrNull?.key] ?? 'Imported Workout';
          final key = '${DateFormat('yyyy-MM-dd').format(date)}|$nameKey';
          workoutGroups.putIfAbsent(key, () => []).add(row);
        }

        int processed = 0;
        final total = workoutGroups.length;

        for (var entry in workoutGroups.entries) {
          final parts = entry.key.split('|');
          final date = DateTime.parse(parts[0]);
          final name = parts[1];

          // Check duplicate
          if (_conflictResolution == 'skip') {
            final existing = await (db.select(db.workouts)
                  ..where((t) => t.date.equals(date)))
                .get();
            if (existing.isNotEmpty) {
              processed++;
              continue;
            }
          }

          final workoutId = await db.into(db.workouts).insert(WorkoutsCompanion.insert(
            name: name,
            date: date,
            status: const Value('completed'),
            startTime: Value(date),
            endTime: Value(date.add(const Duration(hours: 1))),
          ));

          // Import sets
          final rows = entry.value;
          for (var i = 0; i < rows.length; i++) {
            final row = rows[i];
            final exName = row[_headerMapping!.entries.firstWhere((e) => e.value == 'exercise').key]?.toString() ?? 'Unknown';
            
            // Resolve exercise or create custom
            int? exerciseId = exerciseCache[exName.toLowerCase()];
            if (exerciseId == null) {
              exerciseId = await db.into(db.exercises).insert(ExercisesCompanion.insert(
                name: exName,
                primaryMuscle: 'Unknown',
                equipment: 'Barbell',
                setType: 'Straight',
                isCustom: const Value(true),
                source: const Value('csv_import'),
              ));
              exerciseCache[exName.toLowerCase()] = exerciseId;
            }

            final weight = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'weight').firstOrNull?.key]?.toString() ?? '0') ?? 0.0;
            final reps = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'reps').firstOrNull?.key]?.toString() ?? '0') ?? 0.0;
            final rpe = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'rpe').firstOrNull?.key]?.toString() ?? '');

            await db.into(db.workoutSets).insert(WorkoutSetsCompanion.insert(
              workoutId: workoutId,
              exerciseId: exerciseId,
              exerciseOrder: i,
              setNumber: i + 1,
              reps: reps,
              weight: weight,
              rpe: Value(rpe),
              completed: const Value(true),
              completedAt: Value(date),
            ));
          }

          processed++;
          setState(() => _progress = processed / total);
        }
      } else {
        // Body Measurements
        int processed = 0;
        final total = _parsedData!.length;

        for (var row in _parsedData!) {
          final dateVal = row[_headerMapping!.entries.firstWhere((e) => e.value == 'date').key];
          final date = service.parseDate(dateVal);
          if (date == null) {
             processed++; continue;
          }

          if (_conflictResolution == 'skip') {
             final existing = await (db.select(db.bodyMeasurements)
                  ..where((t) => t.date.equals(DateTime(date.year, date.month, date.day))))
                .get();
            if (existing.isNotEmpty) {
              processed++; continue;
            }
          }

          final double? weight = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'weight').firstOrNull?.key]?.toString() ?? '');
          final double? bodyFat = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'body_fat').firstOrNull?.key]?.toString() ?? '');
          
          final double? neck = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'neck').firstOrNull?.key]?.toString() ?? '');
          final double? chest = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'chest').firstOrNull?.key]?.toString() ?? '');
          final double? shoulders = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'shoulders').firstOrNull?.key]?.toString() ?? '');
          final double? armLeft = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'arm_left').firstOrNull?.key]?.toString() ?? '');
          final double? armRight = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'arm_right').firstOrNull?.key]?.toString() ?? '');
          final double? forearmLeft = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'forearm_left').firstOrNull?.key]?.toString() ?? '');
          final double? forearmRight = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'forearm_right').firstOrNull?.key]?.toString() ?? '');
          final double? waist = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'waist').firstOrNull?.key]?.toString() ?? '');
          final double? waistNaval = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'waist_naval').firstOrNull?.key]?.toString() ?? '');
          final double? hips = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'hips').firstOrNull?.key]?.toString() ?? '');
          final double? thighLeft = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'thigh_left').firstOrNull?.key]?.toString() ?? '');
          final double? thighRight = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'thigh_right').firstOrNull?.key]?.toString() ?? '');
          final double? calfLeft = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'calf_left').firstOrNull?.key]?.toString() ?? '');
          final double? calfRight = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'calf_right').firstOrNull?.key]?.toString() ?? '');
          final double? subFat = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'subcutaneous_fat').firstOrNull?.key]?.toString() ?? '');
          final double? viscFat = double.tryParse(row[_headerMapping!.entries.where((e) => e.value == 'visceral_fat').firstOrNull?.key]?.toString() ?? '');
          final String? notes = row[_headerMapping!.entries.where((e) => e.value == 'notes').firstOrNull?.key]?.toString();

          await db.into(db.bodyMeasurements).insert(BodyMeasurementsCompanion.insert(
            date: date,
            weight: Value(weight),
            bodyFat: Value(bodyFat),
            subcutaneousFat: Value(subFat),
            visceralFat: Value(viscFat),
            neck: Value(neck),
            chest: Value(chest),
            shoulders: Value(shoulders),
            armLeft: Value(armLeft),
            armRight: Value(armRight),
            forearmLeft: Value(forearmLeft),
            forearmRight: Value(forearmRight),
            waist: Value(waist),
            waistNaval: Value(waistNaval),
            hips: Value(hips),
            thighLeft: Value(thighLeft),
            thighRight: Value(thighRight),
            calfLeft: Value(calfLeft),
            calfRight: Value(calfRight),
            notes: Value(notes),
          ), mode: InsertMode.insertOrReplace);

          processed++;
          setState(() => _progress = processed / total);
        }
      }
    });

    setState(() {
      _progress = 1.0;
      _currentStep = ImportStep.done;
    });
    
    // Refresh relevant streams
    ref.invalidate(allExercisesProvider);
  }
}
