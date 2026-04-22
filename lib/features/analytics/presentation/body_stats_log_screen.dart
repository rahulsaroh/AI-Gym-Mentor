import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart'
    as ent;

class BodyStatsLogScreen extends ConsumerStatefulWidget {
  const BodyStatsLogScreen({super.key});

  @override
  ConsumerState<BodyStatsLogScreen> createState() => _BodyStatsLogScreenState();
}

class _BodyStatsLogScreenState extends ConsumerState<BodyStatsLogScreen> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, TextEditingController> _customControllers = {};
  late DateTime _date;
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _date = DateTime.now();
    for (var m in standardMetrics) {
      _controllers[m.id] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    _notesController.dispose();
    for (var c in _customControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _onSave() async {
    final customValues = <String, double>{};
    _customControllers.forEach((key, controller) {
      final value = double.tryParse(controller.text);
      if (value != null) customValues[key] = value;
    });

    final measurement = ent.BodyMeasurement(
      id: 0,
      date: _date,
      weight: double.tryParse(_controllers['weight']!.text),
      bodyFat: double.tryParse(_controllers['bodyFat']!.text),
      neck: double.tryParse(_controllers['neck']!.text),
      chest: double.tryParse(_controllers['chest']!.text),
      shoulders: double.tryParse(_controllers['shoulders']!.text),
      armLeft: double.tryParse(_controllers['armLeft']!.text),
      armRight: double.tryParse(_controllers['armRight']!.text),
      forearmLeft: double.tryParse(_controllers['forearmLeft']!.text),
      forearmRight: double.tryParse(_controllers['forearmRight']!.text),
      waist: double.tryParse(_controllers['waist']!.text),
      hips: double.tryParse(_controllers['hips']!.text),
      thighLeft: double.tryParse(_controllers['thighLeft']!.text),
      thighRight: double.tryParse(_controllers['thighRight']!.text),
      calfLeft: double.tryParse(_controllers['calfLeft']!.text),
      calfRight: double.tryParse(_controllers['calfRight']!.text),
      height: double.tryParse(_controllers['height']!.text),
      customValues: customValues.isEmpty ? null : customValues,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
    );

    await ref
        .read(bodyMeasurementsListProvider.notifier)
        .addMeasurement(measurement);
    if (mounted) Navigator.pop(context);
  }

  void _addCustomMetric() {
    showDialog(
      context: context,
      builder: (context) {
        final nameC = TextEditingController();
        return AlertDialog(
          title: Text('New Custom Metric', style: GoogleFonts.outfit()),
          content: TextField(
            controller: nameC,
            decoration: const InputDecoration(hintText: 'e.g. Wrist, Ankle'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameC.text.isNotEmpty) {
                  setState(() {
                    _customControllers[nameC.text] = TextEditingController();
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Body Stats',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _onSave,
            child: Text(
              'Save',
              style: GoogleFonts.outfit(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildDatePicker(),
            const Divider(height: 1),
            _buildSectionHeader('Body Metrics'),
            _buildMetricRow(standardMetrics.firstWhere((m) => m.id == 'weight')),
            _buildMetricRow(standardMetrics.firstWhere((m) => m.id == 'bodyFat')),
            
            _buildSectionHeader('Upper Body'),
            _buildMetricRow(standardMetrics.firstWhere((m) => m.id == 'chest')),
            _buildMetricRow(standardMetrics.firstWhere((m) => m.id == 'shoulders')),
            _buildMetricRow(standardMetrics.firstWhere((m) => m.id == 'armLeft')),
            _buildMetricRow(standardMetrics.firstWhere((m) => m.id == 'armRight')),
            
            _buildSectionHeader('Lower Body'),
            _buildMetricRow(standardMetrics.firstWhere((m) => m.id == 'waist')),
            _buildMetricRow(standardMetrics.firstWhere((m) => m.id == 'hips')),
            _buildMetricRow(standardMetrics.firstWhere((m) => m.id == 'thighLeft')),
            _buildMetricRow(standardMetrics.firstWhere((m) => m.id == 'thighRight')),
            _buildMetricRow(standardMetrics.firstWhere((m) => m.id == 'calfLeft')),
            _buildMetricRow(standardMetrics.firstWhere((m) => m.id == 'calfRight')),

            _buildSectionHeader('Notes'),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Add notes about your physique...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
                  ),
                ),
              ),
            ),

            if (_customControllers.isNotEmpty) ...[
               _buildSectionHeader('Custom Metrics'),
               ..._customControllers.keys.map(
                (name) => _buildMetricRow(
                  MetricConfig(
                    id: name,
                    label: name,
                    icon: LucideIcons.plus,
                    unit: 'cm',
                  ),
                  isCustom: true,
                ),
              ),
            ],
            const SizedBox(height: 16),
            _buildAddCustomButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.outline,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return ListTile(
      leading: const Icon(LucideIcons.calendar, size: 20),
      title: Text('Date', style: GoogleFonts.outfit(fontSize: 16)),
      trailing: TextButton(
        onPressed: () async {
          final d = await showDatePicker(
            context: context,
            initialDate: _date,
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );
          if (d != null) setState(() => _date = d);
        },
        child: Text(
          '${_date.day}/${_date.month}/${_date.year}',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildMetricRow(MetricConfig config, {bool isCustom = false}) {
    final controller = isCustom
        ? _customControllers[config.id]!
        : _controllers[config.id]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          config.assetPath != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    config.assetPath!,
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(config.icon, size: 22, color: Colors.grey[600]),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              config.label,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    textAlign: TextAlign.end,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: GoogleFonts.robotoMono(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: '--',
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  config.unit,
                  style: GoogleFonts.outfit(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(width: 8),
                const Icon(
                  LucideIcons.chevronRight,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCustomButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: _addCustomMetric,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.plus,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Add Custom Metric',
                style: GoogleFonts.outfit(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
