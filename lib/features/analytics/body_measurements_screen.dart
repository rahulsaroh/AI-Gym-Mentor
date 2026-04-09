import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart' as ent;

class BodyMeasurementsScreen extends ConsumerStatefulWidget {
  const BodyMeasurementsScreen({super.key});

  @override
  ConsumerState<BodyMeasurementsScreen> createState() =>
      _BodyMeasurementsScreenState();
}

class _BodyMeasurementsScreenState
    extends ConsumerState<BodyMeasurementsScreen> {
  String _selectedMetric = 'weight';

  final Map<String, String> _metrics = {
    'weight': 'Weight (kg)',
    'bodyFat': 'Body Fat (%)',
    'chest': 'Chest (cm)',
    'waist': 'Waist (cm)',
    'hips': 'Hips (cm)',
    'leftArm': 'Left Arm (cm)',
    'rightArm': 'Right Arm (cm)',
    'leftThigh': 'Left Thigh (cm)',
    'rightThigh': 'Right Thigh (cm)',
    'calves': 'Calves (cm)',
  };

  @override
  Widget build(BuildContext context) {
    final measurementsAsync = ref.watch(bodyMeasurementsListProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Body Tracking'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _MetricSelector(
                  selected: _selectedMetric,
                  metrics: _metrics,
                  onChanged: (v) => setState(() => _selectedMetric = v),
                ),
                SizedBox(
                  height: 250,
                  child: measurementsAsync.when(
                    data: (data) => _MetricChart(
                        data: data,
                        metric: _selectedMetric,
                        label: _metrics[_selectedMetric]!),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('Error: $e')),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Row(
                    children: [
                      Text('History',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          measurementsAsync.when(
            data: (data) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _MeasurementTile(measurement: data[index]),
                childCount: data.length,
              ),
            ),
            loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator())),
            error: (e, _) =>
                SliverFillRemaining(child: Center(child: Text('Error: $e'))),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        icon: const Icon(LucideIcons.plus),
        label: const Text('New Entry'),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _AddMeasurementSheet(
        onAdd: (m) =>
            ref.read(bodyMeasurementsListProvider.notifier).addMeasurement(m),
      ),
    );
  }
}

class _MetricSelector extends StatelessWidget {
  final String selected;
  final Map<String, String> metrics;
  final ValueChanged<String> onChanged;

  const _MetricSelector(
      {required this.selected, required this.metrics, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: metrics.entries
            .map((e) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(e.value),
                    selected: selected == e.key,
                    onSelected: (_) => onChanged(e.key),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _MetricChart extends StatelessWidget {
  final List<ent.BodyMeasurement> data;
  final String metric;
  final String label;

  const _MetricChart(
      {required this.data, required this.metric, required this.label});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('No data yet. Get tracking!'));
    }

    final filtered = data
        .where((m) => _getValue(m, metric) != null)
        .toList()
        .reversed
        .toList();
    if (filtered.isEmpty) {
      return const Center(child: Text('No entries for this metric.'));
    }

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: filtered
                .asMap()
                .entries
                .map((e) =>
                    FlSpot(e.key.toDouble(), _getValue(e.value, metric)!))
                .toList(),
            isCurved: true,
            color: Theme.of(context).colorScheme.primary,
            barWidth: 3,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
                show: true,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (val, meta) {
                if (val.toInt() >= filtered.length ||
                    val.toInt() % (filtered.length ~/ 3 + 1) != 0) {
                  return const SizedBox.shrink();
                }
                return Text(
                    DateFormat('MM/dd').format(filtered[val.toInt()].date),
                    style: const TextStyle(fontSize: 10));
              },
            ),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  double? _getValue(ent.BodyMeasurement m, String key) {
    switch (key) {
      case 'weight':
        return m.weight;
      case 'bodyFat':
        return m.bodyFat;
      case 'chest':
        return m.chest;
      case 'waist':
        return m.waist;
      case 'hips':
        return m.hips;
      case 'leftArm':
        return m.leftArm;
      case 'rightArm':
        return m.rightArm;
      case 'leftThigh':
        return m.leftThigh;
      case 'rightThigh':
        return m.rightThigh;
      case 'calves':
        return m.calves;
      default:
        return null;
    }
  }
}

class _MeasurementTile extends ConsumerWidget {
  final ent.BodyMeasurement measurement;
  const _MeasurementTile({required this.measurement});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(measurement.id.toString()),
      background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(LucideIcons.trash2, color: Colors.white)),
      onDismissed: (_) {
        ref
            .read(bodyMeasurementsListProvider.notifier)
            .deleteMeasurement(measurement.id);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Measurement deleted')));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat('MMMM d, yyyy').format(measurement.date),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${measurement.weight ?? '--'}kg',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 8),
              _MeasurementGrid(m: measurement),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeasurementGrid extends StatelessWidget {
  final ent.BodyMeasurement m;
  const _MeasurementGrid({required this.m});

  @override
  Widget build(BuildContext context) {
    final values = [
      if (m.waist != null) 'Waist: ${m.waist}cm',
      if (m.chest != null) 'Chest: ${m.chest}cm',
      if (m.bodyFat != null) 'BF%: ${m.bodyFat}%',
      if (m.leftArm != null) 'L-Arm: ${m.leftArm}cm',
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 4,
      children: values
          .map((v) =>
              Text(v, style: const TextStyle(fontSize: 12, color: Colors.grey)))
          .toList(),
    );
  }
}

class _AddMeasurementSheet extends StatefulWidget {
  final Function(ent.BodyMeasurement) onAdd;
  const _AddMeasurementSheet({required this.onAdd});

  @override
  State<_AddMeasurementSheet> createState() => _AddMeasurementSheetState();
}

class _AddMeasurementSheetState extends State<_AddMeasurementSheet> {
  final _weightC = TextEditingController();
  final _waistC = TextEditingController();
  final _chestC = TextEditingController();
  final _hipsC = TextEditingController();
  final _lArmC = TextEditingController();
  final _rArmC = TextEditingController();
  final _bodyFatC = TextEditingController();

  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Add Body Entry',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (d != null) setState(() => _date = d);
                },
                child: Text(DateFormat('MMM d, yyyy').format(_date)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: _Field(controller: _weightC, label: 'Weight (kg)')),
              const SizedBox(width: 12),
              Expanded(
                  child: _Field(controller: _bodyFatC, label: 'Body Fat %')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _Field(controller: _chestC, label: 'Chest (cm)')),
              const SizedBox(width: 12),
              Expanded(child: _Field(controller: _waistC, label: 'Waist (cm)')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _Field(controller: _lArmC, label: 'L-Arm')),
              const SizedBox(width: 12),
              Expanded(child: _Field(controller: _rArmC, label: 'R-Arm')),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final m = ent.BodyMeasurement(
                id: 0,
                date: _date,
                weight: double.tryParse(_weightC.text),
                waist: double.tryParse(_waistC.text),
                chest: double.tryParse(_chestC.text),
                hips: double.tryParse(_hipsC.text),
                armLeft: double.tryParse(_lArmC.text),
                armRight: double.tryParse(_rArmC.text),
                bodyFat: double.tryParse(_bodyFatC.text),
              );
              widget.onAdd(m);
              Navigator.pop(context);
            },
            child: const Text('Save Entry'),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const _Field({required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
