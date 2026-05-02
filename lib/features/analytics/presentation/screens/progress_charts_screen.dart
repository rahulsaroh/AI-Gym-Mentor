import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ai_gym_mentor/features/analytics/data/strength_repository.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';
import 'package:ai_gym_mentor/features/analytics/stats_repository.dart';
import 'package:ai_gym_mentor/features/analytics/measurements_repository.dart';
import 'package:ai_gym_mentor/core/domain/entities/body_measurement.dart' as ent;
import 'package:ai_gym_mentor/features/settings/models/settings_state.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/core/utils/weight_converter.dart';
import 'package:ai_gym_mentor/core/database/database.dart';

// ─── Design tokens ────────────────────────────────────────────────────────────
const _kBg      = Color(0xFFF6F6F4);
const _kSurface = Colors.white;
const _kText    = Color(0xFF111111);
const _kMuted   = Color(0xFF8A8A8E);
const _kBorder  = Color(0xFFE5E5EA);
const _kPrimary = Color(0xFF141414);
const _kGreen   = Color(0xFF34C759);
const _kBlue    = Color(0xFF007AFF);
const _kOrange  = Color(0xFFFF9500);
const _kRed     = Color(0xFFFF3B30);
const _kPurple  = Color(0xFF5856D6);
// ─────────────────────────────────────────────────────────────────────────────

class ProgressChartsScreen extends ConsumerStatefulWidget {
  const ProgressChartsScreen({super.key});

  @override
  ConsumerState<ProgressChartsScreen> createState() => _ProgressChartsScreenState();
}

class _ProgressChartsScreenState extends ConsumerState<ProgressChartsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kBg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 20,
        title: Text(
          'Progress Charts',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            fontSize: 26,
            color: _kText,
            letterSpacing: -0.7,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: _kBorder)),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: _kPrimary,
              indicatorWeight: 2,
              labelColor: _kText,
              unselectedLabelColor: _kMuted,
              labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 14),
              unselectedLabelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 14),
              tabs: const [
                Tab(text: '1RM Progression'),
                Tab(text: 'Volume Heatmap'),
                Tab(text: 'Body Composition'),
                Tab(text: 'Strength Level'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _OneRmProgressionTab(),
          _VolumeHeatmapTab(),
          _BodyCompositionTab(),
          _StrengthStandardsTab(),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// TAB 1 — 1RM PROGRESSION
// ══════════════════════════════════════════════════════════════════════════════

class _OneRmProgressionTab extends ConsumerStatefulWidget {
  const _OneRmProgressionTab();

  @override
  ConsumerState<_OneRmProgressionTab> createState() => _OneRmProgressionTabState();
}

class _OneRmProgressionTabState extends ConsumerState<_OneRmProgressionTab> {
  int? _selectedExerciseId;
  String _selectedExerciseName = '';
  String _timeRange = '3M';

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(strengthRepositoryProvider);
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: repo.getAllTrackedExercises(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        final exercises = snap.data!;
        if (exercises.isEmpty) {
          return _emptyState(
            icon: LucideIcons.trendingUp,
            title: 'No strength data yet',
            subtitle: 'Complete workouts with weighted exercises to see your 1RM progress here.',
          );
        }

        _selectedExerciseId ??= exercises.first['exerciseId'] as int;
        _selectedExerciseName = exercises
            .firstWhere((e) => e['exerciseId'] == _selectedExerciseId,
                orElse: () => exercises.first)['name'] as String? ?? '';

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            // Exercise picker
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Exercise', style: GoogleFonts.outfit(fontSize: 12, color: _kMuted, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    value: _selectedExerciseId,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: _kBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: _kBorder),
                      ),
                    ),
                    items: exercises.map((e) {
                      return DropdownMenuItem<int>(
                        value: e['exerciseId'] as int,
                        child: Text(e['name'] as String? ?? '', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedExerciseId = val),
                    style: GoogleFonts.outfit(color: _kText, fontSize: 15),
                    dropdownColor: _kSurface,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Time range pills
            _TimeRangePills(
              selected: _timeRange,
              options: const ['1M', '3M', '6M', '1Y', 'All'],
              onChanged: (v) => setState(() => _timeRange = v),
            ),
            const SizedBox(height: 12),
            // Chart
            if (_selectedExerciseId != null)
              FutureBuilder<List<Exercise1RmSnapshot>>(
                future: repo.getExerciseHistory(_selectedExerciseId!),
                builder: (context, histSnap) {
                  if (!histSnap.hasData) return const _ChartSkeleton();
                  final raw = histSnap.data!;
                  final filtered = _filterByRange(raw, _timeRange);
                  if (filtered.isEmpty) {
                    return _emptyState(
                      icon: LucideIcons.trendingUp,
                      title: 'No data in range',
                      subtitle: 'Try a wider time range.',
                    );
                  }

                  final unit = settings.weightUnit;
                  final spots = filtered.asMap().entries.map((e) {
                    final w = unit == WeightUnit.lbs
                        ? WeightConverter.kgToLbs(e.value.estimated1Rm)
                        : e.value.estimated1Rm;
                    return FlSpot(e.key.toDouble(), w);
                  }).toList();

                  final maxY = spots.map((s) => s.y).reduce(math.max);
                  final minY = spots.map((s) => s.y).reduce(math.min);
                  final allTimeBest = raw.isNotEmpty
                      ? raw.map((s) => unit == WeightUnit.lbs
                          ? WeightConverter.kgToLbs(s.estimated1Rm)
                          : s.estimated1Rm).reduce(math.max)
                      : 0.0;

                  return Column(
                    children: [
                      // KPI row
                      Row(
                        children: [
                          Expanded(child: _KpiChip(
                            label: 'Current 1RM',
                            value: '${spots.last.y.toStringAsFixed(1)} ${unit == WeightUnit.lbs ? "lbs" : "kg"}',
                            color: _kBlue,
                          )),
                          const SizedBox(width: 8),
                          Expanded(child: _KpiChip(
                            label: 'All-Time Best',
                            value: '${allTimeBest.toStringAsFixed(1)} ${unit == WeightUnit.lbs ? "lbs" : "kg"}',
                            color: _kGreen,
                          )),
                          const SizedBox(width: 8),
                          Expanded(child: _KpiChip(
                            label: 'Sessions',
                            value: '${filtered.length}',
                            color: _kOrange,
                          )),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _SectionCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$_selectedExerciseName — Estimated 1RM',
                              style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Calculated using Epley formula from your best set each session',
                              style: GoogleFonts.outfit(fontSize: 12, color: _kMuted),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 220,
                              child: LineChart(
                                LineChartData(
                                  gridData: FlGridData(
                                    show: true,
                                    drawVerticalLine: false,
                                    getDrawingHorizontalLine: (_) => const FlLine(
                                      color: Color(0xFFEEEEEE),
                                      strokeWidth: 1,
                                    ),
                                  ),
                                  borderData: FlBorderData(show: false),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 44,
                                        getTitlesWidget: (v, _) => Text(
                                          v.toStringAsFixed(0),
                                          style: GoogleFonts.outfit(fontSize: 11, color: _kMuted),
                                        ),
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: math.max(1, (spots.length / 5).roundToDouble()),
                                        getTitlesWidget: (v, _) {
                                          final idx = v.toInt();
                                          if (idx < 0 || idx >= filtered.length) return const SizedBox.shrink();
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                              DateFormat('MMM d').format(filtered[idx].date),
                                              style: GoogleFonts.outfit(fontSize: 10, color: _kMuted),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  ),
                                  minY: (minY * 0.92).floorToDouble(),
                                  maxY: (maxY * 1.08).ceilToDouble(),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: spots,
                                      isCurved: true,
                                      curveSmoothness: 0.3,
                                      color: _kBlue,
                                      barWidth: 2.5,
                                      dotData: FlDotData(
                                        show: true,
                                        getDotPainter: (spot, _, __, ___) {
                                          final isPR = spot.y == spots.map((s) => s.y).reduce(math.max);
                                          return FlDotCirclePainter(
                                            radius: isPR ? 5 : 3,
                                            color: isPR ? _kGreen : _kBlue,
                                            strokeColor: Colors.white,
                                            strokeWidth: 1.5,
                                          );
                                        },
                                      ),
                                      belowBarData: BarAreaData(
                                        show: true,
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [_kBlue.withOpacity(0.15), _kBlue.withOpacity(0.0)],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _LegendDot(color: _kGreen, label: 'PR'),
                                const SizedBox(width: 16),
                                _LegendDot(color: _kBlue, label: 'Session best'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // History table
                      _SectionCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Session History', style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 15)),
                            const SizedBox(height: 12),
                            ...filtered.reversed.take(10).map((s) {
                              final w = unit == WeightUnit.lbs
                                  ? WeightConverter.kgToLbs(s.estimated1Rm)
                                  : s.estimated1Rm;
                              final isPR = s.isPr;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  children: [
                                    Text(
                                      DateFormat('MMM d, yyyy').format(s.date),
                                      style: GoogleFonts.outfit(fontSize: 13, color: _kMuted),
                                    ),
                                    const Spacer(),
                                    if (isPR)
                                      Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _kGreen.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(999),
                                        ),
                                        child: Text('PR', style: GoogleFonts.outfit(fontSize: 11, color: _kGreen, fontWeight: FontWeight.w700)),
                                      ),
                                    Text(
                                      '${w.toStringAsFixed(1)} ${unit == WeightUnit.lbs ? "lbs" : "kg"}',
                                      style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 14),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        );
      },
    );
  }

  List<Exercise1RmSnapshot> _filterByRange(List<Exercise1RmSnapshot> data, String range) {
    final now = DateTime.now();
    DateTime? cutoff;
    switch (range) {
      case '1M': cutoff = now.subtract(const Duration(days: 30)); break;
      case '3M': cutoff = now.subtract(const Duration(days: 90)); break;
      case '6M': cutoff = now.subtract(const Duration(days: 180)); break;
      case '1Y': cutoff = now.subtract(const Duration(days: 365)); break;
      default: cutoff = null;
    }
    if (cutoff == null) return data;
    return data.where((s) => s.date.isAfter(cutoff!)).toList();
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// TAB 2 — VOLUME HEATMAP BY MUSCLE GROUP
// ══════════════════════════════════════════════════════════════════════════════

class _VolumeHeatmapTab extends ConsumerStatefulWidget {
  const _VolumeHeatmapTab();

  @override
  ConsumerState<_VolumeHeatmapTab> createState() => _VolumeHeatmapTabState();
}

class _VolumeHeatmapTabState extends ConsumerState<_VolumeHeatmapTab> {
  String _timeRange = '4W';

  static const _muscles = [
    'Chest', 'Back', 'Shoulders', 'Biceps', 'Triceps',
    'Abs', 'Quads', 'Hamstrings', 'Glutes', 'Calves'
  ];

  // muscle → weeks column index → volume
  static Map<String, Map<int, double>> _buildHeatmap(
      List<Map<String, dynamic>> data, int weeks) {
    final now = DateTime.now();
    final Map<String, Map<int, double>> result = {};
    for (final m in _muscles) result[m] = {};

    for (final row in data) {
      final date = row['date'] as DateTime?;
      final muscle = row['muscle'] as String?;
      final volume = (row['volume'] as num?)?.toDouble() ?? 0;
      if (date == null || muscle == null) continue;

      final diff = now.difference(date).inDays;
      if (diff > weeks * 7) continue;

      final weekIdx = weeks - 1 - (diff ~/ 7);
      if (weekIdx < 0) continue;

      final key = _muscles.firstWhere(
        (m) => muscle.toLowerCase().contains(m.toLowerCase()),
        orElse: () => '',
      );
      if (key.isEmpty) continue;
      result[key]![weekIdx] = (result[key]![weekIdx] ?? 0) + volume;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(statsRepositoryProvider);
    final weeks = _timeRange == '4W' ? 4 : _timeRange == '8W' ? 8 : 12;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: repo.getMuscleVolumeByWeek(weeks),
      builder: (context, snap) {
        final heatmap = snap.hasData ? _buildHeatmap(snap.data!, weeks) : <String, Map<int, double>>{};

        // Find global max for colour scaling
        double globalMax = 1;
        for (final muscle in heatmap.values) {
          for (final v in muscle.values) {
            if (v > globalMax) globalMax = v;
          }
        }

        final weekLabels = List.generate(weeks, (i) {
          final d = DateTime.now().subtract(Duration(days: (weeks - 1 - i) * 7));
          return DateFormat('MMM d').format(d);
        });

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            _TimeRangePills(
              selected: _timeRange,
              options: const ['4W', '8W', '12W'],
              onChanged: (v) => setState(() => _timeRange = v),
            ),
            const SizedBox(height: 12),
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Volume per Muscle Group', style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text('Darker = more total volume (kg × reps)', style: GoogleFonts.outfit(fontSize: 12, color: _kMuted)),
                  const SizedBox(height: 16),
                  // Week labels header
                  Row(
                    children: [
                      const SizedBox(width: 88),
                      ...weekLabels.map((lbl) => Expanded(
                        child: Text(
                          lbl,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(fontSize: 10, color: _kMuted, fontWeight: FontWeight.w600),
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (!snap.hasData)
                    const Center(child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(),
                    ))
                  else
                    ...(_muscles.map((muscle) {
                      final row = heatmap[muscle] ?? {};
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 88,
                              child: Text(
                                muscle,
                                style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600, color: _kText),
                              ),
                            ),
                            ...List.generate(weeks, (wi) {
                              final v = row[wi] ?? 0.0;
                              final intensity = globalMax > 0 ? v / globalMax : 0.0;
                              final cellColor = v == 0
                                  ? const Color(0xFFF0F0F0)
                                  : Color.lerp(const Color(0xFFD1F0FF), const Color(0xFF0055CC), intensity)!;
                              return Expanded(
                                child: Tooltip(
                                  message: v > 0 ? '${v.toStringAsFixed(0)} kg·reps' : 'No data',
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 2),
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: cellColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    })),
                  const SizedBox(height: 16),
                  // Legend
                  Row(
                    children: [
                      Text('Low', style: GoogleFonts.outfit(fontSize: 11, color: _kMuted)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD1F0FF), Color(0xFF0055CC)],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('High', style: GoogleFonts.outfit(fontSize: 11, color: _kMuted)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// TAB 3 — BODY COMPOSITION TIMELINE
// ══════════════════════════════════════════════════════════════════════════════

class _BodyCompositionTab extends ConsumerStatefulWidget {
  const _BodyCompositionTab();

  @override
  ConsumerState<_BodyCompositionTab> createState() => _BodyCompositionTabState();
}

class _BodyCompositionTabState extends ConsumerState<_BodyCompositionTab> {
  String _timeRange = '3M';
  final _metrics = ['Weight', 'Body Fat %', 'Waist', 'Chest', 'Arms'];
  final _colors = [_kBlue, _kOrange, _kRed, _kGreen, _kPurple];
  final Set<String> _activeMetrics = {'Weight', 'Body Fat %'};

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();
    final unit = settings.weightUnit;
    final measAsync = ref.watch(bodyMeasurementsListProvider);

    return measAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (measurements) {
        final filtered = _filterMeasurements(measurements, _timeRange);
        filtered.sort((a, b) => a.date.compareTo(b.date));

        if (filtered.isEmpty) {
          return _emptyState(
            icon: LucideIcons.activity,
            title: 'No measurements yet',
            subtitle: 'Log your body measurements to see your composition trend.',
          );
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            _TimeRangePills(
              selected: _timeRange,
              options: const ['1M', '3M', '6M', '1Y', 'All'],
              onChanged: (v) => setState(() => _timeRange = v),
            ),
            const SizedBox(height: 12),
            // Metric toggles
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _metrics.asMap().entries.map((entry) {
                final m = entry.value;
                final c = _colors[entry.key];
                final isOn = _activeMetrics.contains(m);
                return GestureDetector(
                  onTap: () => setState(() {
                    if (isOn && _activeMetrics.length > 1) _activeMetrics.remove(m);
                    else _activeMetrics.add(m);
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isOn ? c.withOpacity(0.12) : const Color(0xFFF4F4F5),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: isOn ? c : _kBorder),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Text(m, style: GoogleFonts.outfit(
                          fontSize: 13, fontWeight: FontWeight.w700,
                          color: isOn ? c : _kMuted,
                        )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Body Composition Trend', style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text('Tap metrics above to show/hide', style: GoogleFonts.outfit(fontSize: 12, color: _kMuted)),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 240,
                    child: _buildCompositionChart(filtered, unit),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Stats cards
            ..._activeMetrics.map((metric) {
              final values = _extractValues(filtered, metric, unit);
              if (values.isEmpty) return const SizedBox.shrink();
              final color = _colors[_metrics.indexOf(metric)];
              final first = values.first;
              final last = values.last;
              final diff = last - first;
              final pct = first != 0 ? (diff / first) * 100 : 0.0;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _SectionCard(
                  child: Row(
                    children: [
                      Container(width: 3, height: 48, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999))),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(metric, style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 14)),
                            Text('${first.toStringAsFixed(1)} → ${last.toStringAsFixed(1)}',
                                style: GoogleFonts.outfit(fontSize: 13, color: _kMuted)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${diff >= 0 ? "+" : ""}${diff.toStringAsFixed(1)}',
                            style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 16, color: diff < 0 ? _kGreen : _kOrange),
                          ),
                          Text(
                            '${pct >= 0 ? "+" : ""}${pct.toStringAsFixed(1)}%',
                            style: GoogleFonts.outfit(fontSize: 12, color: _kMuted),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildCompositionChart(List<ent.BodyMeasurement> data, WeightUnit unit) {
    final allLineBars = <LineChartBarData>[];
    double globalMin = double.infinity, globalMax = double.negativeInfinity;

    for (int mi = 0; mi < _metrics.length; mi++) {
      final m = _metrics[mi];
      if (!_activeMetrics.contains(m)) continue;
      final values = _extractValues(data, m, unit);
      if (values.isEmpty) continue;
      final spots = values.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList();
      for (final s in spots) {
        if (s.y < globalMin) globalMin = s.y;
        if (s.y > globalMax) globalMax = s.y;
      }
      allLineBars.add(LineChartBarData(
        spots: spots,
        isCurved: true,
        curveSmoothness: 0.25,
        color: _colors[mi],
        barWidth: 2,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ));
    }

    if (allLineBars.isEmpty) return const Center(child: Text('No data'));

    final padding = (globalMax - globalMin) * 0.15;
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) => const FlLine(color: Color(0xFFEEEEEE), strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 44,
              getTitlesWidget: (v, _) => Text(v.toStringAsFixed(0), style: GoogleFonts.outfit(fontSize: 11, color: _kMuted)),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: math.max(1, (data.length / 4).roundToDouble()),
              getTitlesWidget: (v, _) {
                final idx = v.toInt();
                if (idx < 0 || idx >= data.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(DateFormat('MMM d').format(data[idx].date), style: GoogleFonts.outfit(fontSize: 10, color: _kMuted)),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        minY: (globalMin - padding).floorToDouble(),
        maxY: (globalMax + padding).ceilToDouble(),
        lineBarsData: allLineBars,
      ),
    );
  }

  List<double> _extractValues(List<ent.BodyMeasurement> data, String metric, WeightUnit unit) {
    return data.map((m) {
      switch (metric) {
        case 'Weight':
          if (m.weight == null) return null;
          return unit == WeightUnit.lbs ? WeightConverter.kgToLbs(m.weight!) : m.weight!;
        case 'Body Fat %': return m.bodyFat;
        case 'Waist': return m.waist;
        case 'Chest': return m.chest;
        case 'Arms':
          if (m.armLeft != null && m.armRight != null) return (m.armLeft! + m.armRight!) / 2;
          return m.armLeft ?? m.armRight;
        default: return null;
      }
    }).whereType<double>().toList();
  }

  List<ent.BodyMeasurement> _filterMeasurements(List<ent.BodyMeasurement> data, String range) {
    final now = DateTime.now();
    DateTime? cutoff;
    switch (range) {
      case '1M': cutoff = now.subtract(const Duration(days: 30)); break;
      case '3M': cutoff = now.subtract(const Duration(days: 90)); break;
      case '6M': cutoff = now.subtract(const Duration(days: 180)); break;
      case '1Y': cutoff = now.subtract(const Duration(days: 365)); break;
      default: cutoff = null;
    }
    if (cutoff == null) return data;
    return data.where((m) => m.date.isAfter(cutoff!)).toList();
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// TAB 4 — STRENGTH STANDARDS
// ══════════════════════════════════════════════════════════════════════════════

class _StrengthStandardsTab extends ConsumerWidget {
  const _StrengthStandardsTab();

  // Strength standards: exercise → bodyweight ratios [beginner, novice, intermediate, advanced, elite]
  // Based on Symmetric Strength standards (kg)
  static const Map<String, List<double>> _standards = {
    'Bench Press':       [0.50, 0.75, 1.00, 1.25, 1.50],
    'Squat':             [0.75, 1.00, 1.25, 1.50, 1.75],
    'Deadlift':          [0.75, 1.00, 1.50, 1.75, 2.00],
    'Overhead Press':    [0.35, 0.50, 0.65, 0.80, 1.00],
    'Barbell Row':       [0.50, 0.65, 0.85, 1.00, 1.25],
    'Pull-Up':           [0.10, 0.20, 0.35, 0.50, 0.75],
    'Dumbbell Press':    [0.25, 0.35, 0.45, 0.55, 0.70],
    'Incline Press':     [0.40, 0.60, 0.80, 1.00, 1.20],
  };

  static const _levelLabels = ['Beginner', 'Novice', 'Intermediate', 'Advanced', 'Elite'];
  static const _levelColors = [_kMuted, _kOrange, _kBlue, _kGreen, _kPurple];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value ?? const SettingsState();
    final repo = ref.watch(strengthRepositoryProvider);
    final unit = settings.weightUnit;
    final bwKg = settings.weight ?? 75.0;
    final bw = unit == WeightUnit.lbs ? WeightConverter.kgToLbs(bwKg) : bwKg;

    return FutureBuilder<Map<String, double>>(
      future: repo.getLatest1RMForStandardExercises(_standards.keys.toList()),
      builder: (context, snap) {
        final current1RMs = snap.data ?? {};

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            _SectionCard(
              child: Row(
                children: [
                  const Icon(LucideIcons.user, size: 18, color: _kMuted),
                  const SizedBox(width: 8),
                  Text(
                    'Based on ${bw.toStringAsFixed(0)} ${unit == WeightUnit.lbs ? "lbs" : "kg"} bodyweight',
                    style: GoogleFonts.outfit(fontSize: 13, color: _kMuted, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Text('Update in Settings', style: GoogleFonts.outfit(fontSize: 12, color: _kBlue, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Legend
            _SectionCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _levelLabels.asMap().entries.map((e) =>
                  Column(
                    children: [
                      Container(width: 12, height: 12, decoration: BoxDecoration(color: _levelColors[e.key], shape: BoxShape.circle)),
                      const SizedBox(height: 4),
                      Text(e.value, style: GoogleFonts.outfit(fontSize: 10, color: _kText, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ).toList(),
              ),
            ),
            const SizedBox(height: 8),
            ..._standards.entries.map((entry) {
              final exerciseName = entry.key;
              final ratios = entry.value;
              final thresholds = ratios.map((r) => r * bwKg).toList();
              // Convert to display unit
              final thresholdsDisplay = thresholds.map((t) => unit == WeightUnit.lbs ? WeightConverter.kgToLbs(t) : t).toList();

              final current1rmKg = current1RMs[exerciseName] ?? 0.0;
              final current1rmDisplay = unit == WeightUnit.lbs ? WeightConverter.kgToLbs(current1rmKg) : current1rmKg;

              // Determine level (0 = below beginner)
              int level = -1;
              for (int i = thresholds.length - 1; i >= 0; i--) {
                if (current1rmKg >= thresholds[i]) { level = i; break; }
              }

              final hasData = current1rmKg > 0;
              final levelLabel = !hasData ? 'Not tracked' : (level == -1 ? 'Sub-Beginner' : _levelLabels[level]);
              final levelColor = !hasData ? _kMuted : (level == -1 ? const Color(0xFFDDDDDD) : _levelColors[level]);

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(exerciseName, style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 15)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: levelColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: levelColor.withOpacity(0.3)),
                            ),
                            child: Text(levelLabel, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w700, color: levelColor)),
                          ),
                        ],
                      ),
                      if (hasData) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Your 1RM: ${current1rmDisplay.toStringAsFixed(1)} ${unit == WeightUnit.lbs ? "lbs" : "kg"}',
                          style: GoogleFonts.outfit(fontSize: 13, color: _kMuted),
                        ),
                      ],
                      const SizedBox(height: 12),
                      // Progress bar with threshold markers
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final maxVal = thresholdsDisplay.last * 1.15;
                          final progress = hasData ? (current1rmDisplay / maxVal).clamp(0.0, 1.0) : 0.0;
                          final barWidth = constraints.maxWidth;

                          return Stack(
                            children: [
                              // Background
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F0F0),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              // Filled portion
                              if (hasData)
                                Container(
                                  height: 10,
                                  width: barWidth * progress,
                                  decoration: BoxDecoration(
                                    color: levelColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              // Threshold ticks
                              ...thresholdsDisplay.asMap().entries.map((e) {
                                final xPos = (e.value / maxVal).clamp(0.0, 1.0) * barWidth;
                                return Positioned(
                                  left: xPos - 1,
                                  child: Container(
                                    width: 2,
                                    height: 10,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                );
                              }),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      // Threshold labels
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: thresholdsDisplay.asMap().entries.map((e) => Text(
                          e.value.toStringAsFixed(0),
                          style: GoogleFonts.outfit(fontSize: 10, color: _levelColors[e.key], fontWeight: FontWeight.w700),
                        )).toList(),
                      ),
                      // Next level hint
                      if (hasData && level < _levelLabels.length - 1) ...[
                        const SizedBox(height: 8),
                        () {
                          final nextThreshold = thresholdsDisplay[level + 1];
                          final gap = nextThreshold - current1rmDisplay;
                          final nextLabel = _levelLabels[level + 1];
                          return Text(
                            '${gap.toStringAsFixed(1)} ${unit == WeightUnit.lbs ? "lbs" : "kg"} to $nextLabel',
                            style: GoogleFonts.outfit(fontSize: 12, color: _kMuted, fontWeight: FontWeight.w600),
                          );
                        }(),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SHARED WIDGETS
// ══════════════════════════════════════════════════════════════════════════════

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorder),
      ),
      child: child,
    );
  }
}

class _TimeRangePills extends StatelessWidget {
  final String selected;
  final List<String> options;
  final ValueChanged<String> onChanged;
  const _TimeRangePills({required this.selected, required this.options, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((opt) {
          final isSelected = opt == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onChanged(opt),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? _kPrimary : _kSurface,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: isSelected ? _kPrimary : _kBorder),
                ),
                child: Text(opt, style: GoogleFonts.outfit(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : _kText,
                )),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _KpiChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _KpiChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.outfit(fontSize: 11, color: _kMuted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Text(label, style: GoogleFonts.outfit(fontSize: 12, color: _kMuted, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _ChartSkeleton extends StatelessWidget {
  const _ChartSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(color: const Color(0xFFF4F4F5), borderRadius: BorderRadius.circular(18)),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

Widget _emptyState({required IconData icon, required String title, required String subtitle}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 52, color: _kBorder),
          const SizedBox(height: 16),
          Text(title, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: _kText)),
          const SizedBox(height: 8),
          Text(subtitle, textAlign: TextAlign.center, style: GoogleFonts.outfit(fontSize: 14, color: _kMuted)),
        ],
      ),
    ),
  );
}
