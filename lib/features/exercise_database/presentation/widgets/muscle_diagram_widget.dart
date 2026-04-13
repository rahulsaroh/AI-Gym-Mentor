import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MuscleDiagramWidget extends StatefulWidget {
  final List<String> primaryMuscles;
  final List<String> secondaryMuscles;
  final bool showToggle;
  final VoidCallback? onFrontBackToggle;

  const MuscleDiagramWidget({
    super.key,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    this.showToggle = true,
    this.onFrontBackToggle,
  });

  @override
  State<MuscleDiagramWidget> createState() => _MuscleDiagramWidgetState();
}

class _MuscleDiagramWidgetState extends State<MuscleDiagramWidget> {
  bool _showFront = true;

  @override
  Widget build(BuildContext context) {
    final activeMuscles = {
      ...widget.primaryMuscles.map((m) => m.toLowerCase()),
      ...widget.secondaryMuscles.map((m) => m.toLowerCase()),
    };

    return Column(
      children: [
        if (widget.showToggle) ...[
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Front')),
              ButtonSegment(value: false, label: Text('Back')),
            ],
            selected: {_showFront},
            onSelectionChanged: (selection) {
              setState(() => _showFront = selection.first);
              widget.onFrontBackToggle?.call();
            },
          ),
          const SizedBox(height: 16),
        ],
        SizedBox(
          height: 300,
          child: _showFront
              ? _buildBodyDiagram(true, activeMuscles)
              : _buildBodyDiagram(false, activeMuscles),
        ),
        const SizedBox(height: 12),
        _buildLegend(),
      ],
    );
  }

  Widget _buildBodyDiagram(bool isFront, Set<String> activeMuscles) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          isFront ? 'assets/svgs/body_front.svg' : 'assets/svgs/body_back.svg',
          height: 280,
          colorFilter: ColorFilter.mode(
            Colors.grey.shade400,
            BlendMode.srcIn,
          ),
        ),
        ...activeMuscles.map((muscle) {
          final svgId = muscleToSvgId[muscle];
          if (svgId == null) return const SizedBox.shrink();
          return _buildMuscleHighlight(svgId, isFront);
        }),
      ],
    );
  }

  Widget _buildMuscleHighlight(String svgId, bool isFront) {
    return Positioned.fill(
      child: CustomPaint(
        painter: _MuscleHighlightPainter(svgId),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendItem(color: Colors.red.shade400, label: 'Primary'),
        const SizedBox(width: 16),
        _LegendItem(color: Colors.amber, label: 'Secondary'),
        const SizedBox(width: 16),
        _LegendItem(color: Colors.grey.shade300, label: 'Inactive'),
      ],
    );
  }
}

class _MuscleHighlightPainter extends CustomPainter {
  final String muscleId;

  _MuscleHighlightPainter(this.muscleId);

  @override
  void paint(Canvas canvas, Size size) {
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
