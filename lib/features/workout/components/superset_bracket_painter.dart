import 'package:flutter/material.dart';

class SupersetBracketPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double padding;

  SupersetBracketPainter({
    required this.color,
    this.thickness = 2.0,
    this.padding = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Draw top horizontal line
    path.moveTo(size.width, 0);
    path.lineTo(padding, 0);

    // Draw vertical line
    path.lineTo(padding, size.height);

    // Draw bottom horizontal line
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SupersetConnector extends StatelessWidget {
  final Widget child;
  final bool isFirst;
  final bool isLast;
  final bool isMiddle;
  final Color color;

  const SupersetConnector({
    super.key,
    required this.child,
    this.isFirst = false,
    this.isLast = false,
    this.isMiddle = false,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    if (!isFirst && !isLast && !isMiddle) return child;

    return Stack(
      children: [
        Positioned(
          left: 0,
          top: isFirst ? 20 : 0,
          bottom: isLast ? 20 : 0,
          width: 20,
          child: CustomPaint(
            painter: _BracketSegmentPainter(
              color: color,
              isFirst: isFirst,
              isLast: isLast,
              isMiddle: isMiddle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: child,
        ),
      ],
    );
  }
}

class _BracketSegmentPainter extends CustomPainter {
  final Color color;
  final bool isFirst;
  final bool isLast;
  final bool isMiddle;

  _BracketSegmentPainter({
    required this.color,
    required this.isFirst,
    required this.isLast,
    required this.isMiddle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final double x = 8.0;

    if (isFirst) {
      // Top corner and down
      canvas.drawLine(Offset(size.width, 0), Offset(x, 0), paint);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    } else if (isLast) {
      // Up and bottom corner
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      canvas.drawLine(
          Offset(x, size.height), Offset(size.width, size.height), paint);
    } else if (isMiddle) {
      // Straight vertical line
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
