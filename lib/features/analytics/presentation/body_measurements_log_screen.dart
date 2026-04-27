import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart' as ent;
import 'package:ai_gym_mentor/core/domain/entities/body_target.dart' as target_ent;
import 'package:ai_gym_mentor/features/analytics/measurements_repository.dart';
import 'package:intl/intl.dart';

class BodyMeasurementsLogScreen extends ConsumerStatefulWidget {
  const BodyMeasurementsLogScreen({super.key});

  @override
  ConsumerState<BodyMeasurementsLogScreen> createState() =>
      _BodyMeasurementsLogScreenState();
}

class _BodyMeasurementsLogScreenState
    extends ConsumerState<BodyMeasurementsLogScreen> {
  final Map<String, TextEditingController> _currentCtrl = {};
  final Map<String, TextEditingController> _targetCtrl = {};
  final _notesCtrl = TextEditingController();
  late DateTime _measurementDate;
  bool _isSaving = false;

  // Custom metrics list: {name, currentCtrl, targetCtrl}
  final List<Map<String, dynamic>> _customMetrics = [];

  @override
  void initState() {
    super.initState();
    _measurementDate = DateTime.now();
    for (var m in standardMetrics) {
      _currentCtrl[m.id] = TextEditingController();
      _targetCtrl[m.id] = TextEditingController();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _prePopulate());
  }

  Future<void> _prePopulate() async {
    // Pre-fill latest measurement values
    final measurements = ref.read(bodyMeasurementsListProvider).value ?? [];
    if (measurements.isNotEmpty) {
      // for (var m in standardMetrics) {
      //   final val = extractMetricValue(measurements.first, m.id);
      //   if (val != null && val > 0) _currentCtrl[m.id]!.text = val.toString();
      // }
      // Custom values from latest measurement
      final custom = measurements.first.customValues;
      if (custom != null) {
        for (final entry in custom.entries) {
          if (!_customMetrics.any((c) => c['name'] == entry.key)) {
            _addCustomRow(name: entry.key, currentValue: entry.value);
          }
        }
      }
    }

    // Pre-fill existing targets
    final repo = ref.read(measurementsRepositoryProvider);
    final allTargets = await repo.getAllTargets();
    for (final t in allTargets) {
      final isStandard = standardMetrics.any((m) => m.id == t.metric);
      if (isStandard) {
        _targetCtrl[t.metric]!.text = t.targetValue.toString();
      } else {
        // Custom target — add a custom row if not already present
        final existingIdx =
            _customMetrics.indexWhere((c) => c['name'] == t.metric);
        if (existingIdx >= 0) {
          (_customMetrics[existingIdx]['targetCtrl'] as TextEditingController)
              .text = t.targetValue.toString();
        } else {
          _addCustomRow(name: t.metric, targetValue: t.targetValue);
        }
      }
    }

    if (mounted) setState(() {});
  }

  void _addCustomRow(
      {String name = '', double? currentValue, double? targetValue}) {
    _customMetrics.add({
      'name': name,
      'nameCtrl': TextEditingController(text: name),
      'currentCtrl': TextEditingController(
          text: currentValue != null ? currentValue.toString() : ''),
      'targetCtrl': TextEditingController(
          text: targetValue != null ? targetValue.toString() : ''),
    });
  }

  @override
  void dispose() {
    for (var c in _currentCtrl.values) c.dispose();
    for (var c in _targetCtrl.values) c.dispose();
    _notesCtrl.dispose();
    for (final row in _customMetrics) {
      (row['nameCtrl'] as TextEditingController).dispose();
      (row['currentCtrl'] as TextEditingController).dispose();
      (row['targetCtrl'] as TextEditingController).dispose();
    }
    super.dispose();
  }

  Future<void> _onSave() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      // Build customValues map for measurement
      final customValues = <String, double>{};
      for (final row in _customMetrics) {
        final name = (row['nameCtrl'] as TextEditingController).text.trim();
        final val = double.tryParse(
            (row['currentCtrl'] as TextEditingController).text);
        if (name.isNotEmpty && val != null) customValues[name] = val;
      }

      final measurement = ent.BodyMeasurement(
        id: 0,
        date: _measurementDate,
        weight: double.tryParse(_currentCtrl['weight']!.text),
        bodyFat: double.tryParse(_currentCtrl['bodyFat']!.text),
        neck: double.tryParse(_currentCtrl['neck']!.text),
        chest: double.tryParse(_currentCtrl['chest']!.text),
        shoulders: double.tryParse(_currentCtrl['shoulders']!.text),
        armLeft: double.tryParse(_currentCtrl['armLeft']!.text),
        armRight: double.tryParse(_currentCtrl['armRight']!.text),
        forearmLeft: double.tryParse(_currentCtrl['forearmLeft']!.text),
        forearmRight: double.tryParse(_currentCtrl['forearmRight']!.text),
        waist: double.tryParse(_currentCtrl['waist']!.text),
        waistNaval: double.tryParse(_currentCtrl['waistNaval']!.text),
        hips: double.tryParse(_currentCtrl['hips']!.text),
        thighLeft: double.tryParse(_currentCtrl['thighLeft']!.text),
        thighRight: double.tryParse(_currentCtrl['thighRight']!.text),
        calfLeft: double.tryParse(_currentCtrl['calfLeft']!.text),
        calfRight: double.tryParse(_currentCtrl['calfRight']!.text),
        height: double.tryParse(_currentCtrl['height']!.text),
        subcutaneousFat: double.tryParse(_currentCtrl['subcutaneousFat']!.text),
        visceralFat: double.tryParse(_currentCtrl['visceralFat']!.text),
        notes: _notesCtrl.text.isEmpty ? null : _notesCtrl.text,
        customValues: customValues.isEmpty ? null : customValues,
      );

      final hasCurrent = _currentCtrl.values.any((c) => c.text.isNotEmpty) ||
          customValues.isNotEmpty;
      if (hasCurrent) {
        await ref
            .read(bodyMeasurementsListProvider.notifier)
            .addMeasurement(measurement);
      }

      // Upsert standard targets
      final repo = ref.read(measurementsRepositoryProvider);
      for (var m in standardMetrics) {
        final val = double.tryParse(_targetCtrl[m.id]!.text);
        if (val != null && val > 0) {
          await repo.upsertTarget(target_ent.BodyTarget(
            id: 0,
            metric: m.id,
            targetValue: val,
            deadline: _measurementDate.add(const Duration(days: 30)),
            createdAt: _measurementDate,
          ));
        }
      }

      // Upsert custom targets
      for (final row in _customMetrics) {
        final name = (row['nameCtrl'] as TextEditingController).text.trim();
        final val = double.tryParse(
            (row['targetCtrl'] as TextEditingController).text);
        if (name.isNotEmpty && val != null && val > 0) {
          await repo.upsertTarget(target_ent.BodyTarget(
            id: 0,
            metric: name,
            targetValue: val,
            deadline: _measurementDate.add(const Duration(days: 30)),
            createdAt: _measurementDate,
          ));
        }
      }

      ref.invalidate(bodyMeasurementsListProvider);
      ref.invalidate(bodyTargetsListProvider);
      ref.invalidate(physiqueAchievementProvider);
      ref.invalidate(overallAchievementTrendProvider);
      ref.invalidate(measurementDateRangeProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Measurements saved successfully!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save measurements: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Log Measurements',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        actions: [
          _isSaving
              ? const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                )
              : TextButton(
                  onPressed: _onSave,
                  child: Text('Save',
                      style: GoogleFonts.outfit(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Measurement date
          ListTile(
            leading: const Icon(LucideIcons.calendar, size: 20),
            title: Text('Measurement Date',
                style: GoogleFonts.outfit(fontSize: 16)),
            trailing: TextButton(
              onPressed: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _measurementDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (d != null) setState(() => _measurementDate = d);
              },
              child: Text(
                DateFormat('MMM d, yyyy').format(_measurementDate),
                style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(height: 1),
          _buildHeaderRow(),

          // Standard sections
          _buildSection('Body Metrics',
              ['weight', 'bodyFat']),
          _buildSection('Upper Body',
              ['neck', 'chest', 'shoulders', 'armLeft', 'armRight', 'forearmLeft', 'forearmRight']),
          _buildSection('Core & Lower Body',
              ['waist', 'waistNaval', 'hips', 'thighLeft', 'thighRight', 'calfLeft', 'calfRight']),
          _buildSection('Other',
              ['height', 'subcutaneousFat', 'visceralFat']),

          // ─── Custom metrics ───────────────────────────────────────────
          _buildSectionHeader('Custom Measurements'),
          ..._customMetrics.asMap().entries.map((e) =>
              _buildCustomRow(e.key, e.value)),

          // Add custom button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: OutlinedButton.icon(
              onPressed: _showAddCustomDialog,
              icon: const Icon(LucideIcons.plus, size: 16),
              label: Text('Add Custom Measurement',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                side: BorderSide(
                    color: Theme.of(context).colorScheme.primary
                        .withValues(alpha: 0.5)),
              ),
            ),
          ),

          _buildSectionHeader('Notes'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _notesCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Add notes...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  Widget _buildSection(String title, List<String> metricIds) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildSectionHeader(title),
      ...metricIds.map((id) {
        final config = standardMetrics.firstWhere((m) => m.id == id);
        return _buildMetricRow(config);
      }),
    ]);
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      color: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest
          .withValues(alpha: 0.1),
      child: Text(title.toUpperCase(),
          style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.outline,
              letterSpacing: 1.1)),
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest
          .withValues(alpha: 0.15),
      child: Row(children: [
        const Expanded(child: SizedBox()),
        SizedBox(
            width: 70,
            child: Text('CURRENT',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey))),
        const SizedBox(width: 16),
        SizedBox(
            width: 70,
            child: Text('TARGET',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey))),
      ]),
    );
  }

  Widget _buildMetricRow(MetricConfig config) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1))),
      ),
      child: Row(children: [
        config.assetPath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(config.assetPath!,
                    width: 28, height: 28, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Icon(config.icon, size: 20, color: Colors.grey[600])))
            : Icon(config.icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                config.label,
                style: GoogleFonts.outfit(
                    fontSize: 14, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                config.unit,
                style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        _numField(_currentCtrl[config.id]!, isTarget: false),
        const SizedBox(width: 16),
        _numField(_targetCtrl[config.id]!, isTarget: true),
      ]),
    );
  }

  Widget _buildCustomRow(int index, Map<String, dynamic> row) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1))),
      ),
      child: Row(children: [
        // Name field
        Expanded(
          child: TextField(
            controller: row['nameCtrl'] as TextEditingController,
            style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: 'Metric name',
              hintStyle: GoogleFonts.outfit(color: Colors.grey[400]),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
        _numField(row['currentCtrl'] as TextEditingController, isTarget: false),
        const SizedBox(width: 16),
        _numField(row['targetCtrl'] as TextEditingController, isTarget: true),
        // Delete button
        IconButton(
          icon: Icon(LucideIcons.x, size: 16, color: Colors.red[300]),
          onPressed: () => setState(() => _customMetrics.removeAt(index)),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          padding: EdgeInsets.zero,
        ),
      ]),
    );
  }

  Widget _numField(TextEditingController ctrl, {required bool isTarget}) {
    return SizedBox(
      width: 70,
      child: TextField(
        controller: ctrl,
        textAlign: TextAlign.center,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: GoogleFonts.robotoMono(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: isTarget ? Theme.of(context).colorScheme.primary : null,
        ),
        decoration: InputDecoration(
          hintText: '--',
          hintStyle:
              TextStyle(color: Colors.grey.withValues(alpha: 0.4)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          isDense: true,
        ),
      ),
    );
  }

  void _showAddCustomDialog() {
    final nameCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add Custom Measurement',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Enter a name for your custom measurement (e.g. "Neck Flexed", "Wrist")',
              style: GoogleFonts.outfit(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 16),
          TextField(
            controller: nameCtrl,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Measurement name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ]),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final name = nameCtrl.text.trim();
              if (name.isNotEmpty) {
                setState(() => _addCustomRow(name: name));
              }
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
