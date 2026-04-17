import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyScanScreen extends StatefulWidget {
  const BodyScanScreen({super.key});

  @override
  State<BodyScanScreen> createState() => _BodyScanScreenState();
}

class _BodyScanScreenState extends State<BodyScanScreen> with SingleTickerProviderStateMixin {
  bool _isHeatmap = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final Map<String, String> _measurements = {
    'Chest': '98 cm',
    'Waist': '82 cm',
    'Hips': '94 cm',
    'Thighs': '58 cm',
    'Arms': '34 cm',
  };

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
    
    // Start initial fade-in animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _fadeController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _toggleView(bool heatmap) {
    if (_isHeatmap == heatmap) return;
    setState(() {
      _isHeatmap = heatmap;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Respect accessibility settings for animations
    final bool animationsDisabled = MediaQuery.of(context).disableAnimations;
    final Duration crossFadeDuration = animationsDisabled ? Duration.zero : const Duration(milliseconds: 400);

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
      body: FadeTransition(
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
            _buildMeasurementChips(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle() {
    final accentColor = const Color(0xFF01696F);
    
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
        minScale: 0.8,
        maxScale: 3.0,
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

  Widget _buildMeasurementChips() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _measurements.length,
        itemBuilder: (context, index) {
          final entry = _measurements.entries.elementAt(index);
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
                  entry.key,
                  style: GoogleFonts.dmSans(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.value,
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

