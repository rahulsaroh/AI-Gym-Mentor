import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/services/import_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';

class ImportMappingScreen extends ConsumerStatefulWidget {
  final ExcelSchema schema;
  const ImportMappingScreen({super.key, required this.schema});

  @override
  ConsumerState<ImportMappingScreen> createState() => _ImportMappingScreenState();
}

class _ImportMappingScreenState extends ConsumerState<ImportMappingScreen> {
  String? _selectedRawLogSheet;
  String? _selectedMeasurementsSheet;
  final Map<String, int> _rawLogMapping = {};
  final Map<String, int> _measurementsMapping = {};
  bool _isImporting = false;

  final List<String> _requiredRawLogFields = [
    'Date', 'Workout Name', 'Exercise Name', 'Exercise ID', 'Set Number', 'Set Type', 'Weight', 'Reps', 'RPE', 'Is PR', 'Notes'
  ];

  final List<String> _requiredMeasurementFields = [
    'Date', 'Weight', 'Body Fat', 'Subcutaneous Fat', 'Visceral Fat', 'Neck', 'Chest', 'Shoulders', 'Left Bicep', 'Right Bicep', 'Left Forearm', 'Right Forearm', 'Waist', 'Naval Waist', 'Hips', 'Left Thigh', 'Right Thigh', 'Left Calf', 'Right Calf', 'Notes'
  ];

  @override
  void initState() {
    super.initState();
    _autoMatch();
  }

  void _autoMatch() {
    // Basic auto-matching based on name similarity
    for (final sheet in widget.schema.sheets.keys) {
      if (sheet.toLowerCase().contains('raw log')) _selectedRawLogSheet = sheet;
      if (sheet.toLowerCase().contains('measurement')) _selectedMeasurementsSheet = sheet;
    }

    if (_selectedRawLogSheet != null) {
      final headers = widget.schema.sheets[_selectedRawLogSheet]!;
      for (final field in _requiredRawLogFields) {
        final index = headers.indexWhere((h) => _isMatch(h, field));
        if (index != -1) _rawLogMapping[field] = index;
      }
    }

    if (_selectedMeasurementsSheet != null) {
      final headers = widget.schema.sheets[_selectedMeasurementsSheet]!;
      for (final field in _requiredMeasurementFields) {
        final index = headers.indexWhere((h) => _isMatch(h, field));
        if (index != -1) _measurementsMapping[field] = index;
      }
    }
  }

  bool _isMatch(String header, String field) {
    final h = header.toLowerCase().trim();
    final f = field.toLowerCase().trim();
    if (h == f) return true;
    if (h.contains(f) || f.contains(h)) return true;
    
    // Exact variants
    if (f == 'exercise name' && (h == 'exercise' || h == 'movement')) return true;
    if (f == 'set number' && (h == 'set' || h == 'set #')) return true;
    if (f == 'weight' && h.startsWith('weight')) return true;
    if (f == 'reps' && h.startsWith('reps')) return true;
    if (f == 'rpe' && h == 'rpe') return true;

    // Synonyms for body measurements
    if (f.contains('bicep') && h.contains('arm')) return true;
    if (f.contains('body fat') && h.contains('fat')) return true;
    if (f == 'naval waist' && (h.contains('naval') || h.contains('navel'))) return true;
    if (f.contains('waist') && !f.contains('naval') && h.contains('waist') && !h.contains('naval') && !h.contains('navel')) return true;
    
    return false;
  }

  Future<void> _startImport() async {
    setState(() => _isImporting = true);
    try {
      final mappingResult = ImportMappingResult(
        rawLogMapping: _selectedRawLogSheet != null ? WorksheetMapping(sheetName: _selectedRawLogSheet!, fieldToColumnIndex: _rawLogMapping) : null,
        bodyMeasurementsMapping: _selectedMeasurementsSheet != null ? WorksheetMapping(sheetName: _selectedMeasurementsSheet!, fieldToColumnIndex: _measurementsMapping) : null,
      );

      final results = await ref.read(importServiceProvider).importFromXlsx(widget.schema.file, mapping: mappingResult);
      
      if (mounted) {
        context.pop(); // Close mapping screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Imported ${results['workouts']} workouts and ${results['measurements']} measurements!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Import failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isImporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Import Mapping'),
        actions: [
          if (!_isImporting)
            TextButton(
              onPressed: _startImport,
              child: const Text('Import', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
        ],
      ),
      body: _isImporting 
        ? const Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Processing Import...'),
            ],
          ))
        : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSection(
                title: 'Workout Log Sheet',
                sheetSelector: _buildSheetSelector(
                  value: _selectedRawLogSheet,
                  onChanged: (val) => setState(() {
                    _selectedRawLogSheet = val;
                    if (val != null) {
                       final headers = widget.schema.sheets[val]!;
                       _rawLogMapping.clear();
                       for (final field in _requiredRawLogFields) {
                         final index = headers.indexWhere((h) => h.toLowerCase().contains(field.toLowerCase()));
                         if (index != -1) _rawLogMapping[field] = index;
                       }
                    }
                  }),
                ),
                mappingFields: _selectedRawLogSheet == null ? [] : _requiredRawLogFields.map((f) => 
                  _buildMappingRow(f, _rawLogMapping, widget.schema.sheets[_selectedRawLogSheet]!)
                ).toList(),
              ),
              const SizedBox(height: 24),
              _buildSection(
                title: 'Body Measurements Sheet',
                sheetSelector: _buildSheetSelector(
                  value: _selectedMeasurementsSheet,
                  onChanged: (val) => setState(() {
                    _selectedMeasurementsSheet = val;
                    if (val != null) {
                       final headers = widget.schema.sheets[val]!;
                       _measurementsMapping.clear();
                       for (final field in _requiredMeasurementFields) {
                         final index = headers.indexWhere((h) => h.toLowerCase().contains(field.toLowerCase()));
                         if (index != -1) _measurementsMapping[field] = index;
                       }
                    }
                  }),
                ),
                mappingFields: _selectedMeasurementsSheet == null ? [] : _requiredMeasurementFields.map((f) => 
                  _buildMappingRow(f, _measurementsMapping, widget.schema.sheets[_selectedMeasurementsSheet]!)
                ).toList(),
              ),
            ],
          ),
    );
  }

  Widget _buildSection({required String title, required Widget sheetSelector, required List<Widget> mappingFields}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            sheetSelector,
            if (mappingFields.isNotEmpty) ...[
              const Divider(height: 32),
              const Text('Field Mapping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
              const SizedBox(height: 8),
              ...mappingFields,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSheetSelector({required String? value, required Function(String?) onChanged}) {
    final sheets = widget.schema.sheets.keys.toList();
    return DropdownButtonFormField<String>(
      value: value,
      decoration: const InputDecoration(
        labelText: 'Select Sheet',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: [
        const DropdownMenuItem(value: null, child: Text('Skip this sheet')),
        ...sheets.map((s) => DropdownMenuItem(value: s, child: Text(s))),
      ],
      onChanged: onChanged,
    );
  }

  Widget _buildMappingRow(String field, Map<String, int> mapping, List<String> headers) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(field, style: const TextStyle(fontWeight: FontWeight.w500))),
          const Icon(LucideIcons.arrowRight, size: 14, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: DropdownButton<int>(
              value: mapping[field],
              isExpanded: true,
              hint: const Text('Select Column', style: TextStyle(fontSize: 12)),
              style: const TextStyle(fontSize: 13, color: Colors.black),
              underline: Container(height: 1, color: Colors.grey.withValues(alpha: 0.3)),
              items: [
                for (int i = 0; i < headers.length; i++)
                  DropdownMenuItem(value: i, child: Text(headers[i].isEmpty ? 'Column ${i + 1}' : headers[i], overflow: TextOverflow.ellipsis)),
              ],
              onChanged: (val) => setState(() => mapping[field] = val!),
            ),
          ),
        ],
      ),
    );
  }
}
