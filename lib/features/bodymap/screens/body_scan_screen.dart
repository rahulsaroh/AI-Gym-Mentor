import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ai_gym_mentor/features/analytics/analytics_providers.dart';

class BodyScanScreen extends ConsumerStatefulWidget {
  /// When [embedded] is true the widget renders without a Scaffold/AppBar,
  /// suitable for embedding inside a TabBarView. Defaults to false (full screen).
  final bool embedded;
  const BodyScanScreen({super.key, this.embedded = false});

  @override
  ConsumerState<BodyScanScreen> createState() => _BodyScanScreenState();
}

class _BodyScanScreenState extends ConsumerState<BodyScanScreen> with SingleTickerProviderStateMixin {
  bool _isHeatmap = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _toggleView(bool heatmap) {
    if (_isHeatmap == heatmap) return;
    setState(() => _isHeatmap = heatmap);
  }

  @override
  Widget build(BuildContext context) {
    final bool animationsDisabled = MediaQuery.of(context).disableAnimations;
    final Duration crossFadeDuration =
        animationsDisabled ? Duration.zero : const Duration(milliseconds: 400);

    final physiqueAsync = ref.watch(physiqueAchievementProvider);

    final bodyContent = physiqueAsync.when(
      data: (physique) {
        // Map of metric ID to its latest value
        final latestValues = <String, String>{};
        for (var a in physique.achievements) {
          if (a.currentValue > 0) {
            latestValues[a.metric] = '${a.currentValue.toStringAsFixed(1)}';
          }
        }

        // Define which metrics to show in the chips below the scan
        final displayMetrics = [
          {'label': 'Chest', 'id': 'chest'},
          {'label': 'Waist', 'id': 'waist'},
          {'label': 'Hips', 'id': 'hips'},
          {'label': 'Thighs', 'id': 'thighLeft'}, // using thighLeft as representative
          {'label': 'Arms', 'id': 'armLeft'},    // using armLeft as representative
        ];

        return Container(
          color: const Color(0xFF0E0E12),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildToggle(),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildTealGlow(),
                      _buildInteractiveBody(crossFadeDuration),
                    ],
                  ),
                ),
                _buildMeasurementChips(displayMetrics, latestValues),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
      loading: () => Container(
        color: const Color(0xFF0E0E12),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Container(
        color: const Color(0xFF0E0E12),
        child: Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white))),
      ),
    );

    // Embedded mode: no Scaffold/AppBar — used inside TabBarView
    if (widget.embedded) return bodyContent;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E12),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '3D BODY SCAN',
          style: GoogleFonts.rajdhani(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: bodyContent,
    );
  }

  Widget _buildToggle() {
    return Container(
      width: 240,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B19),
        borderRadius: BorderRadius.circular(22),
      ),
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: _isHeatmap ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 114,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _toggleView(false),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Text(
                      '3D Scan',
                      style: GoogleFonts.dmSans(
                        color: _isHeatmap ? Colors.white60 : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _toggleView(true),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Text(
                      'Heatmap',
                      style: GoogleFonts.dmSans(
                        color: _isHeatmap ? Colors.black : Colors.white60,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTealGlow() {
    return Container(
      width: 200,
      height: 400,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF01696F).withOpacity(0.15),
            spreadRadius: 20,
            blurRadius: 40,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveBody(Duration duration) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: InteractiveViewer(
        key: ValueKey(_isHeatmap),
        scaleEnabled: false,
        panEnabled: false,
        boundaryMargin: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final image = Image.asset(
              _isHeatmap
                  ? 'assets/images/body_heatmap_3d.png'
                  : 'assets/images/body_scan_3d with data.png',
              fit: BoxFit.contain,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            );

            if (!_isHeatmap) return image;

            return Stack(
              fit: StackFit.expand,
              children: [
                image,
                ..._buildHeatmapCallouts(constraints),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildHeatmapCallouts(BoxConstraints constraints) {
    const callouts = <_HeatmapCallout>[
      _HeatmapCallout(label: 'Shoulders', leftPct: 0.12, topPct: 0.28, color: Color(0xFFE53935)),
      _HeatmapCallout(label: 'Chest', leftPct: 0.38, topPct: 0.35, color: Color(0xFFFF7043)),
      _HeatmapCallout(label: 'Arms', leftPct: 0.78, topPct: 0.42, color: Color(0xFFFFB74D)),
      _HeatmapCallout(label: 'Abs', leftPct: 0.52, topPct: 0.48, color: Color(0xFFFFEB3B)),
      _HeatmapCallout(label: 'Quads', leftPct: 0.44, topPct: 0.65, color: Color(0xFF66BB6A)),
      _HeatmapCallout(label: 'Calves', leftPct: 0.46, topPct: 0.82, color: Color(0xFF42A5F5)),
    ];

    return callouts
        .map((c) => Positioned(
              left: constraints.maxWidth * c.leftPct,
              top: constraints.maxHeight * c.topPct,
              child: _buildCalloutChip(c),
            ))
        .toList();
  }

  Widget _buildCalloutChip(_HeatmapCallout callout) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF01696F).withOpacity(0.6),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: callout.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            callout.label,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementChips(List<Map<String, String>> metrics, Map<String, String> values) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: metrics.length,
        itemBuilder: (context, index) {
          final metric = metrics[index];
          final value = values[metric['id']!] ?? '--';
          
          return Container(
            width: 110,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1B19),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF01696F).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  metric['label']!,
                  style: GoogleFonts.dmSans(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value != '--' ? '$value cm' : value,
                  style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeatmapCallout {
  final String label;
  final double leftPct;
  final double topPct;
  final Color color;

  const _HeatmapCallout({
    required this.label,
    required this.leftPct,
    required this.topPct,
    required this.color,
  });
}
