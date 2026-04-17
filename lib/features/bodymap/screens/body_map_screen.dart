import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/heatmap_color_service.dart';
import '../providers/bodymap_provider.dart';
import '../widgets/body_map_painter.dart';
import '../widgets/heatmap_legend.dart';
import '../widgets/muscle_detail_sheet.dart';
import '../widgets/muscle_path_registry.dart';

class BodyMapScreen extends ConsumerStatefulWidget {
  const BodyMapScreen({super.key});

  @override
  ConsumerState<BodyMapScreen> createState() => _BodyMapScreenState();
}

class _BodyMapScreenState extends ConsumerState<BodyMapScreen> {
  bool _showFront = true;
  String? _selectedMuscle;

  @override
  Widget build(BuildContext context) {
    final heatAsync = ref.watch(muscleHeatDataProvider);
    final mode = ref.watch(bodymapModeProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Body Statistics'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_showFront ? Icons.flip : Icons.flip),
            onPressed: () => setState(() => _showFront = !_showFront),
            tooltip: 'Flip Body',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildToggles(context),
          Expanded(
            child: heatAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error loading data: $e')),
              data: (heatData) => GestureDetector(
                onTapDown: (details) => _onTap(details, heatData, mode),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 0.6,
                    child: CustomPaint(
                      painter: BodyMapPainter(
                        heatData: heatData,
                        musclePaths: _showFront
                            ? MusclePathRegistry.getFrontPaths()
                            : MusclePathRegistry.getBackPaths(),
                        mode: mode,
                        colorService: HeatmapColorService(),
                        selectedMuscle: _selectedMuscle,
                      ),
                      child: Container(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          HeatmapLegend(mode: mode),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildToggles(BuildContext context) {
    final mode = ref.watch(bodymapModeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildToggleButton(
              'Volume',
              mode == BodyMapMode.volume,
              () => ref.read(bodymapModeProvider.notifier).setMode(BodyMapMode.volume),
            ),
            _buildToggleButton(
              'Soreness',
              mode == BodyMapMode.doms,
              () => ref.read(bodymapModeProvider.notifier).setMode(BodyMapMode.doms),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white60,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(TapDownDetails details, List<dynamic> data, BodyMapMode mode) {
    final renderBox = context.findRenderObject() as RenderBox;
    final localPos = renderBox.globalToLocal(details.globalPosition);
    final size = renderBox.size;

    final painter = BodyMapPainter(
      heatData: data.cast(),
      musclePaths: _showFront
          ? MusclePathRegistry.getFrontPaths()
          : MusclePathRegistry.getBackPaths(),
      mode: mode,
      colorService: HeatmapColorService(),
    );

    final tapped = painter.muscleAtPoint(localPos, size);

    if (tapped != null) {
      setState(() => _selectedMuscle = tapped);
      final muscleData = data.firstWhere(
        (d) => d.muscleName == tapped,
        orElse: () => null,
      );

      if (muscleData != null) {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) => MuscleDetailSheet(muscle: tapped, data: muscleData),
        );
      }
    } else {
      setState(() => _selectedMuscle = null);
    }
  }
}
