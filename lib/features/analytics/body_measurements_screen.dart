import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/analytics/presentation/body_stats_log_screen.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_target.dart' as target;
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart' as ent;
import 'package:google_fonts/google_fonts.dart';

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

  final Map<String, ({String label, IconData icon, Color color})> _metrics = {
    'weight': (label: 'Weight', icon: LucideIcons.scale, color: Colors.blue),
    'bodyFat': (label: 'Body Fat', icon: LucideIcons.percent, color: Colors.orange),
    'chest': (label: 'Chest', icon: LucideIcons.ruler, color: Colors.teal),
    'waist': (label: 'Waist', icon: LucideIcons.ruler, color: Colors.red),
    'hips': (label: 'Hips', icon: LucideIcons.ruler, color: Colors.purple),
    'leftArm': (label: 'Left Arm', icon: LucideIcons.armchair, color: Colors.indigo),
    'rightArm': (label: 'Right Arm', icon: LucideIcons.armchair, color: Colors.indigo),
    'leftThigh': (label: 'Left Thigh', icon: LucideIcons.footprints, color: Colors.green),
    'rightThigh': (label: 'Right Thigh', icon: LucideIcons.footprints, color: Colors.green),
    'calves': (label: 'Calves', icon: LucideIcons.footprints, color: Colors.brown),
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
      body: Stack(
        children: [
          // Premium Background Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                    Theme.of(context).colorScheme.surface,
                  ],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                _PremiumHeader(
                  title: 'Body Performance',
                  controller: _tabController,
                  onAdd: () => _tabController.index == 0
                      ? _showAddDialog(context)
                      : _showAddTargetDialog(context),
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
          ),
        ],
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
              SizedBox(
                height: 280,
                child: measurementsAsync.when(
                  data: (data) => _MetricChart(
                      data: data,
                      metric: _selectedMetric,
                      label: _metrics[_selectedMetric]!.label),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Row(
                  children: [
                    Text('Timeline',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
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
      backgroundColor: Colors.transparent,
      builder: (context) => _AddTargetSheet(
        metric: _selectedMetric,
        metricLabel: _metrics[_selectedMetric]!.label,
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
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      Theme.of(context).colorScheme.secondary.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Target Progress',
                            style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('${(progress * 100).toInt()}%',
                            style: GoogleFonts.robotoMono(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.primary)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Start: $startVal',
                            style: GoogleFonts.outfit(
                                fontSize: 12, color: Colors.grey)),
                        Text('Goal: $targetVal',
                            style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary)),
                      ],
                    ),
                  ],
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
            (bodyTarget.deadline != null ? ' â€¢ Deadline: ${DateFormat('MMM d').format(bodyTarget.deadline!)}' : '')),
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(LucideIcons.target, color: Colors.orange, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Set Metric Goal',
                        style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Target for ${widget.metricLabel}',
                        style: GoogleFonts.outfit(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _targetValC,
            autofocus: true,
            keyboardType: TextInputType.number,
            style: GoogleFonts.robotoMono(fontSize: 18, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              labelText: 'Target Value',
              hintText: '0.0',
              prefixIcon: const Icon(LucideIcons.pencilLine),
              suffixText: widget.metricLabel.contains('Body Fat') ? '%' : (widget.metricLabel.contains('Weight') ? 'kg' : 'cm'),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () async {
              final d = await showDatePicker(
                context: context,
                initialDate: DateTime.now().add(const Duration(days: 30)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
              );
              if (d != null) setState(() => _deadline = d);
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.calendar, size: 20, color: Colors.grey),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _deadline == null ? 'Target Deadline (Optional)' : DateFormat('MMMM d, yyyy').format(_deadline!),
                      style: GoogleFonts.outfit(color: _deadline == null ? Colors.grey : Colors.black),
                    ),
                  ),
                  const Icon(LucideIcons.chevronRight, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: Text('Activate Goal', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

class _MetricSelector extends StatelessWidget {
  final String selected;
  final Map<String, ({String label, IconData icon, Color color})> metrics;
  final ValueChanged<String> onChanged;

  const _MetricSelector(
      {required this.selected, required this.metrics, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: metrics.entries.map((e) {
          final isSelected = selected == e.key;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () => onChanged(e.key),
              borderRadius: BorderRadius.circular(16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? e.value.color.withValues(alpha: 0.1)
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? e.value.color
                        : Theme.of(context).colorScheme.outlineVariant,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      e.value.icon,
                      size: 18,
                      color: isSelected ? e.value.color : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      e.value.label,
                      style: GoogleFonts.outfit(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? e.value.color : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
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

    final spots = filtered
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), _getValue(e.value, metric)!))
        .toList();

    return Consumer(
      builder: (context, ref, _) {
        final targetsAsync = ref.watch(bodyTargetsListProvider);
        final targetValue = targetsAsync.when(
          data: (targets) => targets.where((t) => t.metric == metric).firstOrNull?.targetValue,
          loading: () => null,
          error: (_, __) => null,
        );

        return Container(
          padding: const EdgeInsets.only(right: 32, left: 16, top: 12, bottom: 0),
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Theme.of(context).colorScheme.primary,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                      radius: index == spots.length - 1 ? 6 : 3,
                      color: Theme.of(context).colorScheme.primary,
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    ),
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                        Theme.of(context).colorScheme.primary.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (val, meta) {
                      if (val == meta.max || val == meta.min) return const SizedBox.shrink();
                      return Text(
                        val.toStringAsFixed(1),
                        style: GoogleFonts.robotoMono(fontSize: 10, color: Colors.grey),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (val, meta) {
                      if (val.toInt() >= filtered.length || (filtered.length > 5 && val.toInt() % (filtered.length ~/ 3 + 1) != 0)) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(DateFormat('MM/dd').format(filtered[val.toInt()].date),
                            style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey)),
                      );
                    },
                  ),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: 5,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.2),
                  strokeWidth: 1,
                  dashArray: [5, 5],
                ),
                getDrawingVerticalLine: (value) => FlLine(
                  color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.1),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(show: false),
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  if (targetValue != null)
                    HorizontalLine(
                      y: targetValue,
                      color: Colors.orange.withValues(alpha: 0.5),
                      strokeWidth: 2,
                      dashArray: [10, 5],
                      label: HorizontalLineLabel(
                        show: true,
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(right: 5, bottom: 5),
                        style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                        labelResolver: (line) => 'Goal',
                      ),
                    ),
                ],
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => Theme.of(context).colorScheme.surfaceContainerHigh,
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        '${spot.y}\n',
                        GoogleFonts.robotoMono(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: DateFormat('MMM d').format(filtered[spot.x.toInt()].date),
                            style: GoogleFonts.outfit(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.normal,
                                fontSize: 10),
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        );
      },
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
    final measurementsAsync = ref.watch(bodyMeasurementsListProvider);
    final allMeasurements = measurementsAsync.value ?? [];

    return Dismissible(
      key: Key(measurement.id.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(LucideIcons.trash2, color: Colors.white),
      ),
      onDismissed: (_) {
        ref.read(bodyMeasurementsListProvider.notifier).deleteMeasurement(measurement.id!);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Measurement deleted')));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(LucideIcons.scale, size: 16, color: Colors.blue),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('MMMM d, yyyy').format(measurement.date),
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            if (measurement.notes != null && measurement.notes!.isNotEmpty)
                              Text(
                                measurement.notes!,
                                style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey),
                              ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        '${measurement.weight ?? '--'} kg',
                        style: GoogleFonts.robotoMono(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _MeasurementGrid(
                  m: measurement,
                  previous: _findPrevious(allMeasurements, measurement),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ent.BodyMeasurement? _findPrevious(List<ent.BodyMeasurement> all, ent.BodyMeasurement current) {
    // Find the next available measurement in the list (since it's sorted desc, next is previous in time)
    final index = all.indexWhere((m) => m.id == current.id);
    if (index != -1 && index + 1 < all.length) {
      return all[index + 1];
    }
    return null;
  }
}

class _MeasurementGrid extends StatelessWidget {
  final ent.BodyMeasurement m;
  final ent.BodyMeasurement? previous;
  const _MeasurementGrid({required this.m, this.previous});

  @override
  Widget build(BuildContext context) {
    final metricsConfig = {
      'weight': (label: 'Weight', value: m.weight, prev: previous?.weight, lowerIsBetter: true),
      'bodyFat': (label: 'BF%', value: m.bodyFat, prev: previous?.bodyFat, lowerIsBetter: true),
      'waist': (label: 'Waist', value: m.waist, prev: previous?.waist, lowerIsBetter: true),
      'hips': (label: 'Hips', value: m.hips, prev: previous?.hips, lowerIsBetter: true),
      'chest': (label: 'Chest', value: m.chest, prev: previous?.chest, lowerIsBetter: false),
      'shoulders': (label: 'Shoulders', value: m.shoulders, prev: previous?.shoulders, lowerIsBetter: false),
      'neck': (label: 'Neck', value: m.neck, prev: previous?.neck, lowerIsBetter: false),
      'armLeft': (label: 'L-Arm', value: m.armLeft, prev: previous?.armLeft, lowerIsBetter: false),
      'armRight': (label: 'R-Arm', value: m.armRight, prev: previous?.armRight, lowerIsBetter: false),
      'height': (label: 'Height', value: m.height, prev: previous?.height, lowerIsBetter: false),
    };

    final activeMetrics = metricsConfig.values.where((v) => v.value != null).toList();
    
    // Add custom metrics to active list
    if (m.customValues != null) {
      m.customValues!.forEach((key, value) {
        final prevVal = previous?.customValues?[key];
        activeMetrics.add((label: key, value: value, prev: prevVal, lowerIsBetter: false));
      });
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 60,
      ),
      itemCount: activeMetrics.length,
      itemBuilder: (context, index) {
        final metric = activeMetrics[index];
        final delta = metric.prev != null ? metric.value! - metric.prev! : null;
        
        Color deltaColor = Colors.grey;
        String deltaPrefix = '';
        if (delta != null && delta.abs() > 0.01) {
          final isImprovement = metric.lowerIsBetter ? delta < 0 : delta > 0;
          deltaColor = isImprovement ? Colors.green : Colors.red;
          deltaPrefix = delta > 0 ? '+' : '';
        }

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(metric.label, style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey)),
                    Text('${metric.value}', style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ),
              if (delta != null && delta.abs() > 0.01)
                Text(
                  '$deltaPrefix${delta.toStringAsFixed(1)}',
                  style: GoogleFonts.robotoMono(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: deltaColor,
                  ),
                ),
            ],
          ),
        );
      },
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
  final _notesC = TextEditingController();

  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Logging Progress',
                    style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton.icon(
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (d != null) setState(() => _date = d);
                  },
                  icon: const Icon(LucideIcons.calendar, size: 16),
                  label: Text(DateFormat('MMM d').format(_date), style: GoogleFonts.outfit()),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _Field(controller: _weightC, label: 'Weight', suffix: 'kg', icon: LucideIcons.scale)),
                const SizedBox(width: 16),
                Expanded(child: _Field(controller: _bodyFatC, label: 'Body Fat', suffix: '%', icon: LucideIcons.percent)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _Field(controller: _chestC, label: 'Chest', suffix: 'cm', icon: LucideIcons.ruler)),
                const SizedBox(width: 16),
                Expanded(child: _Field(controller: _waistC, label: 'Waist', suffix: 'cm', icon: LucideIcons.ruler)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _Field(controller: _lArmC, label: 'L-Arm', suffix: 'cm', icon: LucideIcons.armchair)),
                const SizedBox(width: 16),
                Expanded(child: _Field(controller: _rArmC, label: 'R-Arm', suffix: 'cm', icon: LucideIcons.armchair)),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesC,
              decoration: InputDecoration(
                labelText: 'Notes (Optional)',
                prefixIcon: const Icon(LucideIcons.stickyNote),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
              ),
            ),
            const SizedBox(height: 32),
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
                  notes: _notesC.text.isEmpty ? null : _notesC.text,
                );
                widget.onAdd(m);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: Text('Complete Log', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? suffix;
  final IconData? icon;
  const _Field({required this.controller, required this.label, this.suffix, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, size: 16) : null,
        suffixText: suffix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
      ),
    );
  }
}

class _PremiumHeader extends StatelessWidget {
  final String title;
  final TabController controller;
  final VoidCallback onAdd;

  const _PremiumHeader({
    required this.title,
    required this.controller,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(LucideIcons.plus, color: Colors.white),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BodyStatsLogScreen()),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _PremiumTabSelector(controller: controller),
        ],
      ),
    );
  }
}

class _PremiumTabSelector extends StatefulWidget {
  final TabController controller;
  const _PremiumTabSelector({required this.controller});

  @override
  State<_PremiumTabSelector> createState() => _PremiumTabSelectorState();
}

class _PremiumTabSelectorState extends State<_PremiumTabSelector> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTabChange);
    super.dispose();
  }

  void _handleTabChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _TabItem(
              label: 'History',
              icon: LucideIcons.history,
              isSelected: widget.controller.index == 0,
              onTap: () => widget.controller.animateTo(0),
            ),
          ),
          Expanded(
            child: _TabItem(
              label: 'Targets',
              icon: LucideIcons.target,
              isSelected: widget.controller.index == 1,
              onTap: () => widget.controller.animateTo(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Theme.of(context).colorScheme.onSurface : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

