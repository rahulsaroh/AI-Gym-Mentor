import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;

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

  static const Map<String, String> muscleToSvgId = {
    'chest': 'pectoralis-major',
    'pectorals': 'pectoralis-major',
    'biceps': 'biceps-brachii',
    'biceps brachii': 'biceps-brachii',
    'triceps': 'triceps-brachii',
    'triceps brachii': 'triceps-brachii',
    'front shoulders': 'deltoid-anterior',
    'middle shoulders': 'deltoid-lateral',
    'rear shoulders': 'deltoid-posterior',
    'lats': 'latissimus-dorsi',
    'latissimus dorsi': 'latissimus-dorsi',
    'traps': 'trapezius',
    'trapezius': 'trapezius',
    'abs': 'rectus-abdominis',
    'abdominals': 'rectus-abdominis',
    'obliques': 'obliques',
    'quads': 'quadriceps',
    'quadriceps': 'quadriceps',
    'hamstrings': 'hamstrings',
    'glutes': 'gluteus-maximus',
    'calves': 'gastrocnemius',
    'lower back': 'erector-spinae',
    'erector spinae': 'erector-spinae',
    'forearms': 'brachioradialis',
    'hip flexors': 'iliopsoas',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showToggle) ...[
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(
                value: true,
                label: Text('Front'),
                icon: Icon(Icons.person),
              ),
              ButtonSegment(
                value: false,
                label: Text('Back'),
                icon: Icon(Icons.person_outline),
              ),
            ],
            selected: {_showFront},
            onSelectionChanged: (selection) {
              setState(() => _showFront = selection.first);
              widget.onFrontBackToggle?.call();
            },
          ),
          const SizedBox(height: 16),
        ],
        FutureBuilder<String>(
          future: _loadAndColorSvg(_showFront),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 300,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return SizedBox(
                height: 300,
                child: Center(
                  child: Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            }
            return SvgPicture.string(
              snapshot.data!,
              height: 300,
              placeholderBuilder: (context) => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildLegend(),
      ],
    );
  }

  Future<String> _loadAndColorSvg(bool isFront) async {
    final assetPath = isFront ? 'assets/svgs/body_front.svg' : 'assets/svgs/body_back.svg';
    String svgString = await rootBundle.loadString(assetPath);

    const primaryColor = '#E85D30'; // Coral Red
    const secondaryColor = '#EF9F27'; // Amber

    // Color all paths based on muscle groups
    final allMuscles = {...widget.primaryMuscles, ...widget.secondaryMuscles};
    
    for (final muscle in allMuscles) {
      final baseId = muscleToSvgId[muscle.toLowerCase()];
      if (baseId == null) continue;

      final isPrimary = widget.primaryMuscles.any((m) => m.toLowerCase() == muscle.toLowerCase());
      final color = isPrimary ? primaryColor : secondaryColor;

      // Replace main id
      svgString = _replaceFill(svgString, baseId, color);
      // Replace -right suffix if exists
      svgString = _replaceFill(svgString, '$baseId-right', color);
      // Special case for lateral/posterior/anterior deltoids if they are named slightly differently
      if (baseId == 'deltoid-anterior') svgString = _replaceFill(svgString, 'deltoids', color);
    }

    return svgString;
  }

  String _replaceFill(String svg, String id, String color) {
    // Look for id="[id]" and then find the nearest fill attribute before the end of the tag
    final regex = RegExp('id="$id"[^>]+fill="#[A-Fa-f0-9]{6}"');
    return svg.replaceAllMapped(regex, (match) {
      return match.group(0)!.replaceFirst(RegExp('fill="#[A-Fa-f0-9]{6}"'), 'fill="$color"');
    });
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendItem(color: const Color(0xFFE85D30), label: 'Primary'),
        const SizedBox(width: 16),
        _LegendItem(color: const Color(0xFFEF9F27), label: 'Secondary'),
        const SizedBox(width: 16),
        _LegendItem(color: const Color(0xFFD3D1C7), label: 'Inactive'),
      ],
    );
  }
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
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

