import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/exercise_database/presentation/providers/exercise_providers.dart';
import 'package:ai_gym_mentor/features/settings/services/csv_service.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CsvExportScreen extends ConsumerStatefulWidget {
  const CsvExportScreen({super.key});

  @override
  ConsumerState<CsvExportScreen> createState() => _CsvExportScreenState();
}

class _CsvExportScreenState extends ConsumerState<CsvExportScreen> {
  DateTimeRange _dateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );

  final Set<String> _selectedColumns = {
    'Date',
    'Workout Name',
    'Exercise',
    'Set#',
    'Weight',
    'Reps'
  };

  final List<String> _allColumns = [
    'Date',
    'Day',
    'Workout Name',
    'Exercise',
    'Set#',
    'Set Type',
    'Weight',
    'Reps',
    'RPE',
    'Volume',
    'Is PR',
    'Notes'
  ];

  bool _includeWarmup = true;
  bool _isExporting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export CSV'),
        actions: [
          if (_isExporting)
            const Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2)))
          else
            IconButton(
                icon: const Icon(LucideIcons.share), onPressed: _handleExport),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSection(),
            const SizedBox(height: 24),
            _buildColumnSection(),
            const SizedBox(height: 24),
            const Text('Preview (First 5 rows)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            _buildPreviewSection(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: _isExporting ? null : _handleExport,
            icon: const Icon(LucideIcons.download),
            label: const Text('Export & Share CSV',
                style: TextStyle(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Date Range',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            InkWell(
              onTap: _selectDateRange,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.calendar,
                        size: 16, color: Colors.blue),
                    const SizedBox(width: 12),
                    Text(
                      '${DateFormat('MMM d, yyyy').format(_dateRange.start)} - ${DateFormat('MMM d, yyyy').format(_dateRange.end)}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(Icons.edit, size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumnSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Columns to Include',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 0,
          children: _allColumns.map((col) {
            final isSelected = _selectedColumns.contains(col);
            return FilterChip(
              label: Text(col, style: const TextStyle(fontSize: 12)),
              selected: isSelected,
              onSelected: (val) {
                setState(() {
                  if (val) {
                    _selectedColumns.add(col);
                  } else if (_selectedColumns.length > 1)
                    _selectedColumns.remove(col);
                });
              },
            );
          }).toList(),
        ),
        SwitchListTile(
          title:
              const Text('Include Warmup Sets', style: TextStyle(fontSize: 14)),
          value: _includeWarmup,
          onChanged: (val) => setState(() => _includeWarmup = val),
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildPreviewSection() {
    // Fetch limited data for preview
    return FutureBuilder(
      future: _fetchPreviewData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final rows = snapshot.data as List<List<dynamic>>;
        if (rows.isEmpty) {
          return const Center(child: Text('No data found for this range.'));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: rows.first
                .map((c) => DataColumn(
                    label: Text(c.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold))))
                .toList(),
            rows: rows
                .skip(1)
                .map((r) => DataRow(
                    cells: r.map((c) => DataCell(Text(c.toString()))).toList()))
                .toList(),
          ),
        );
      },
    );
  }

  Future<List<List<dynamic>>> _fetchPreviewData() async {
    final db = ref.read(appDatabaseProvider);
    final workouts = await (db.select(db.workouts)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(_dateRange.start) &
              t.date.isSmallerOrEqualValue(_dateRange.end))
          ..limit(5))
        .get();

    if (workouts.isEmpty) return [];

    final workoutIds = workouts.map((w) => w.id).toList();
    final sets = await (db.select(db.workoutSets)
          ..where((t) => t.workoutId.isIn(workoutIds))
          ..limit(10))
        .get();

    final exercises = await ref.read(allExercisesProvider.future);
    final exerciseMap = {for (var e in exercises) e.id: e.name};

    final csvContent = await ref
        .read(csvServiceProvider.notifier)
        .generateWorkoutCsv(
          workouts: workouts,
          sets: sets,
          exerciseNames: exerciseMap,
          selectedColumns: _selectedColumns,
          unit: ref.read(settingsProvider).value?.weightUnit ?? WeightUnit.kg,
          includeWarmup: _includeWarmup,
        );

    // Parse CSV back to list for DataTable (skipping BOM)
    final lines = csvContent.substring(1).split('\r\n');
    return lines
        .where((l) => l.isNotEmpty)
        .take(5)
        .map((l) => l.split(','))
        .toList();
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _dateRange,
    );
    if (picked != null) setState(() => _dateRange = picked);
  }

  Future<void> _handleExport() async {
    setState(() => _isExporting = true);
    try {
      final db = ref.read(appDatabaseProvider);
      final workouts = await (db.select(db.workouts)
            ..where((t) =>
                t.date.isBiggerOrEqualValue(_dateRange.start) &
                t.date.isSmallerOrEqualValue(_dateRange.end)))
          .get();

      final workoutIds = workouts.map((w) => w.id).toList();
      final sets = await (db.select(db.workoutSets)
            ..where((t) => t.workoutId.isIn(workoutIds)))
          .get();

      final exercises = await ref.read(allExercisesProvider.future);
      final exerciseMap = {for (var e in exercises) e.id: e.name};

      final csvContent = await ref
          .read(csvServiceProvider.notifier)
          .generateWorkoutCsv(
            workouts: workouts,
            sets: sets,
            exerciseNames: exerciseMap,
            selectedColumns: _selectedColumns,
            unit: ref.read(settingsProvider).value?.weightUnit ?? WeightUnit.kg,
            includeWarmup: _includeWarmup,
          );

      final directory = await getTemporaryDirectory();
      final file = File(
          '${directory.path}/gymlog_export_${DateTime.now().millisecondsSinceEpoch}.csv');
      await file.writeAsString(csvContent);

      await Share.shareXFiles([XFile(file.path)],
          subject: 'Workout Log Export');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }
}
