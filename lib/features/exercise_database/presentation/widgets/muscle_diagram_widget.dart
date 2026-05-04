import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Advanced muscle diagram widget with dynamic color injection.
///
/// Features:
/// - Front and back view toggle with AnimatedSwitcher
/// - Dynamic color injection based on primary/secondary muscles
/// - Color scheme:
///   - Primary muscles: #E84545 (red)
///   - Secondary muscles: #F5A623 (orange)
///   - Inactive muscles: #D0D0D0 (light grey)
/// - Legend showing color meanings
/// - Muscle name chips below the diagram
///
/// Usage:
/// ```dart
/// MuscleDiagramWidget(
///   primaryMuscles: exercise.primaryMuscles,
///   secondaryMuscles: exercise.secondaryMuscles,
/// )
/// ```
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

  /// Mapping of exercise muscle names to SVG path IDs
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
    'shoulders': 'deltoid-anterior',
    'lats': 'latissimus-dorsi',
    'latissimus dorsi': 'latissimus-dorsi',
    'traps': 'trapezius',
    'trapezius': 'trapezius',
    'abs': 'rectus-abdominis',
    'abdominals': 'rectus-abdominis',
    'abdominis': 'rectus-abdominis',
    'obliques': 'obliques',
    'quads': 'quadriceps',
    'quadriceps': 'quadriceps',
    'hamstrings': 'hamstrings',
    'glutes': 'gluteus-maximus',
    'gluteus maximus': 'gluteus-maximus',
    'calves': 'gastrocnemius',
    'gastrocnemius': 'gastrocnemius',
    'lower back': 'erector-spinae',
    'erector spinae': 'erector-spinae',
    'forearms': 'brachioradialis',
    'brachioradialis': 'brachioradialis',
    'hip flexors': 'iliopsoas',
    'iliopsoas': 'iliopsoas',
  };

  // Exact color codes as specified
  static const String _primaryMuscleColor = '#E84545';    // Red
  static const String _secondaryMuscleColor = '#F5A623';  // Orange
  static const String _inactiveMuscleColor = '#D0D0D0';   // Light grey

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Front/Back toggle
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

        // Animated SVG display with fade transition
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: FutureBuilder<String>(
            key: ValueKey(_showFront),
            future: _loadAndColorSvg(_showFront),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 40,
                          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Could not load muscle diagram',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SvgPicture.string(
                snapshot.data!,
                height: 300,
                fit: BoxFit.contain,
                placeholderBuilder: (context) => const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        // Legend
        _buildLegend(context),
        const SizedBox(height: 16),

        // Muscle chips
        _buildMuscleChips(context),
      ],
    );
  }

  /// Load SVG and inject colors for muscles
  Future<String> _loadAndColorSvg(bool isFront) async {
    final assetPath = isFront ? 'assets/svgs/body_front.svg' : 'assets/svgs/body_back.svg';
    String svgString = await rootBundle.loadString(assetPath);

    // Color injector: replace fill colors based on muscle classification
    svgString = _injectMuscleColors(
      svgString,
      widget.primaryMuscles,
      widget.secondaryMuscles,
    );

    return svgString;
  }

  /// Inject fill colors into SVG string based on primary/secondary muscle classification
  ///
  /// Strategy:
  /// 1. For each muscle, find its SVG ID
  /// 2. Locate the path element with that ID
  /// 3. Update or insert the fill attribute with the appropriate color
  /// 4. Return the modified SVG string
  String _injectMuscleColors(
    String svgString,
    List<String> primaryMuscles,
    List<String> secondaryMuscles,
  ) {
    var result = svgString;

    // Process primary muscles
    for (final muscle in primaryMuscles) {
      final svgId = muscleToSvgId[muscle.toLowerCase()];
      if (svgId != null) {
        result = _replaceMuscleColor(result, svgId, _primaryMuscleColor);
      }
    }

    // Process secondary muscles
    for (final muscle in secondaryMuscles) {
      final svgId = muscleToSvgId[muscle.toLowerCase()];
      if (svgId != null) {
        result = _replaceMuscleColor(result, svgId, _secondaryMuscleColor);
      }
    }

    // All other muscles get the inactive color (light grey)
    // Replace any remaining unfilled or default-colored paths
    final muscleIds = muscleToSvgId.values.toSet();
    for (final id in muscleIds) {
      // Only color if not already colored
      if (!result.contains('id="$id" style="fill:$_primaryMuscleColor') &&
          !result.contains('id="$id" style="fill:$_secondaryMuscleColor')) {
        result = _replaceMuscleColor(result, id, _inactiveMuscleColor);
      }
    }

    return result;
  }

  /// Replace or insert fill color for a specific muscle ID in SVG
  ///
  /// Handles:
  /// - Paths with existing fill attributes
  /// - Paths without fill attributes
  /// - Multiple variations of the same muscle
  String _replaceMuscleColor(String svg, String muscleId, String color) {
    // Pattern 1: id="muscleId" with fill already present
    var regex = RegExp(r'id="' + muscleId + r'"([^>]*)fill="#[A-Fa-f0-9]{6}"');
    if (regex.hasMatch(svg)) {
      return svg.replaceAllMapped(regex, (match) {
        return 'id="$muscleId"${match.group(1)!}fill="$color"';
      });
    }

    // Pattern 2: id="muscleId" without fill or with style attribute
    regex = RegExp(r'id="' + muscleId + r'"([^/>]*)');
    if (regex.hasMatch(svg)) {
      return svg.replaceAllMapped(regex, (match) {
        final tag = match.group(0)!;
        // Check if there's already a fill in the style
        if (tag.contains('fill=')) {
          return tag.replaceFirst(RegExp(r'fill="#[A-Fa-f0-9]{6}"'), 'fill="$color"');
        }
        // Add fill attribute before closing >
        return tag.replaceFirst(RegExp(r'>$'), ' fill="$color">');
      });
    }

    return svg;
  }

  /// Build color legend row
  Widget _buildLegend(BuildContext context) {
    const legend = [
      ('Primary', _primaryMuscleColor),
      ('Secondary', _secondaryMuscleColor),
      ('Inactive', _inactiveMuscleColor),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: legend.asMap().entries.map((entry) {
        final isLast = entry.key == legend.length - 1;
        final (label, colorHex) = entry.value;
        final color = Color(int.parse('FF${colorHex.replaceAll('#', '')}', radix: 16));

        return Padding(
          padding: EdgeInsets.only(right: isLast ? 0 : 24),
          child: Row(
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
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Build muscle name chips
  Widget _buildMuscleChips(BuildContext context) {
    final allMuscles = [...widget.primaryMuscles, ...widget.secondaryMuscles];
    if (allMuscles.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: allMuscles.map((muscle) {
        final isPrimary = widget.primaryMuscles.contains(muscle);
        return _MuscleChip(
          label: muscle,
          isPrimary: isPrimary,
        );
      }).toList(),
    );
  }
}

/// Single muscle chip widget
class _MuscleChip extends StatelessWidget {
  final String label;
  final bool isPrimary;

  const _MuscleChip({
    required this.label,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      // Filled chip for primary muscles
      return Chip(
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFE84545), // Primary red
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      );
    } else {
      // Outlined chip for secondary muscles
      return Chip(
        label: Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: const Color(0xFFF5A623), // Secondary orange
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      );
    }
  }
}

