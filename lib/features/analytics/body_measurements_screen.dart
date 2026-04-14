import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_target.dart' as target;
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart' as ent;

class BodyMeasurementsScreen extends ConsumerStatefulWidget {
  const BodyMeasurementsScreen({super.key});

  @override
  ConsumerState<BodyMeasurementsScreen> createState() =>
      _BodyMeasurementsScreenState();
}

class _BodyMeasurementsScreenState
    extends ConsumerState<BodyMeasurementsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
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
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final measurementsAsync = ref.watch(bodyMeasurementsListProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Body Tracking'),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'History'),
              Tab(text: 'Targets'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildHistoryTab(measurementsAsync),
                _buildTargetsTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _tabController.index == 0
            ? _showAddDialog(context)
            : _showAddTargetDialog(context),
        icon: const Icon(LucideIcons.plus),
        label: Text(_tabController.index == 0 ? 'New Entry' : 'Set Target'),
      ),
    );
  }

  Widget _buildHistoryTab(AsyncValue<List<ent.BodyMeasurement>> measurementsAsync) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              _MetricSelector(
                selected: _selectedMetric,
                metrics: _metrics,
                onChanged: (v) => setState(() => _selectedMetric = v),
              ),
              // Target Progress at top if exists
              _TargetProgressHeader(metric: _selectedMetric),
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
    );
  }

  Widget _buildTargetsTab() {
    final targetsAsync = ref.watch(bodyTargetsListProvider);
    return targetsAsync.when(
      data: (targets) {
        if (targets.isEmpty) {
          return const Center(child: Text('No targets set yet. Let\'s go!'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: targets.length,
          itemBuilder: (context, index) {
            return _TargetTile(bodyTarget: targets[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
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

  void _showAddTargetDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _AddTargetSheet(
        metric: _selectedMetric,
        metricLabel: _metrics[_selectedMetric]!,
        onAdd: (t) => ref.read(bodyTargetsListProvider.notifier).addTarget(t),
      ),
    );
  }
}

class _TargetProgressHeader extends ConsumerWidget {
  final String metric;
  const _TargetProgressHeader({required this.metric});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetsAsync = ref.watch(bodyTargetsListProvider);
    final measurementsAsync = ref.watch(bodyMeasurementsListProvider);

    return targetsAsync.when(
      data: (targets) {
        final activeTarget = targets.where((t) => t.metric == metric).firstOrNull;
        if (activeTarget == null) return const SizedBox.shrink();

        return measurementsAsync.when(
          data: (measurements) {
            final lastVal = measurements.firstOrNull != null ? _getValue(measurements.first, metric) : null;
            if (lastVal == null) return const SizedBox.shrink();

            final targetVal = activeTarget.targetValue;
            final startVal = measurements.lastOrNull != null ? _getValue(measurements.last, metric) : lastVal;
            
            // Basic progress calculation: (current - start) / (target - start)
            double progress = 0;
            if ((targetVal - startVal!).abs() > 0.01) {
              progress = (lastVal - startVal) / (targetVal - startVal);
            }
            progress = progress.clamp(0.0, 1.0);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Progress to Target', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${(progress * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Start: $startVal'),
                          Text('Target: $targetVal', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  // Duplicate helper (minimalist approach)
  double? _getValue(ent.BodyMeasurement m, String key) {
    switch (key) {
      case 'weight': return m.weight;
      case 'bodyFat': return m.bodyFat;
      case 'chest': return m.chest;
      case 'waist': return m.waist;
      case 'hips': return m.hips;
      case 'leftArm': return m.armLeft;
      case 'rightArm': return m.armRight;
      case 'leftThigh': return m.thighLeft;
      case 'rightThigh': return m.thighRight;
      case 'calves': return m.calfLeft;
      default: return null;
    }
  }
}

class _TargetTile extends ConsumerWidget {
  final target.BodyTarget bodyTarget;
  const _TargetTile({required this.bodyTarget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text('${bodyTarget.metric.toUpperCase()} Target: ${bodyTarget.targetValue}', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Set on ${DateFormat('MMM d, yyyy').format(bodyTarget.createdAt)}' + 
            (bodyTarget.deadline != null ? ' • Deadline: ${DateFormat('MMM d').format(bodyTarget.deadline!)}' : '')),
        trailing: IconButton(
          icon: const Icon(LucideIcons.trash2, size: 18, color: Colors.grey),
          onPressed: () => ref.read(bodyTargetsListProvider.notifier).deleteTarget(bodyTarget.id),
        ),
      ),
    );
  }
}

class _AddTargetSheet extends StatefulWidget {
  final String metric;
  final String metricLabel;
  final Function(target.BodyTarget) onAdd;
  const _AddTargetSheet({required this.metric, required this.metricLabel, required this.onAdd});

  @override
  State<_AddTargetSheet> createState() => _AddTargetSheetState();
}

class _AddTargetSheetState extends State<_AddTargetSheet> {
  final _targetValC = TextEditingController();
  DateTime? _deadline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Set Target for ${widget.metricLabel}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(
            controller: _targetValC,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Target Value (${widget.metricLabel.contains('kg') ? 'kg' : 'cm/%'})',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            title: const Text('Deadline (Optional)'),
            subtitle: Text(_deadline == null ? 'None' : DateFormat('MMM d, yyyy').format(_deadline!)),
            trailing: const Icon(LucideIcons.calendar),
            onTap: () async {
              final d = await showDatePicker(
                context: context,
                initialDate: DateTime.now().add(const Duration(days: 30)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
              );
              if (d != null) setState(() => _deadline = d);
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final val = double.tryParse(_targetValC.text);
              if (val != null) {
                widget.onAdd(target.BodyTarget(
                  id: 0,
                  metric: widget.metric,
                  targetValue: val,
                  deadline: _deadline,
                  createdAt: DateTime.now(),
                ));
                Navigator.pop(context);
              }
            },
            child: const Text('Save Target'),
          ),
        ],
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
        return m.armLeft;
      case 'rightArm':
        return m.armRight;
      case 'leftThigh':
        return m.thighLeft;
      case 'rightThigh':
        return m.thighRight;
      case 'calves':
        return m.calfLeft;
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
      if (m.armLeft != null) 'L-Arm: ${m.armLeft}cm',
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
