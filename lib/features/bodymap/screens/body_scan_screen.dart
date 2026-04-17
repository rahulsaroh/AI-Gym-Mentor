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
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          alignment: Alignment.center,
          child: Image.asset(
            _isHeatmap 
                ? 'assets/images/body_heatmap_3d.png' 
                : 'assets/images/body_scan_3d.png',
            fit: BoxFit.contain,
          ),
        ),
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
