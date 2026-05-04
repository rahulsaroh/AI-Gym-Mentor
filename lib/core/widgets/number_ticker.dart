import 'package:flutter/material.dart';

/// Animates a number from 0 to [value] over [duration].
/// Respects system reduce-motion accessibility setting.
class NumberTicker extends StatefulWidget {
  final double value;
  final Duration duration;
  final Curve curve;
  final String prefix;
  final String suffix;
  final TextStyle? style;
  final int decimalPlaces;

  const NumberTicker({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutCubic,
    this.prefix = '',
    this.suffix = '',
    this.style,
    this.decimalPlaces = 0,
  });

  @override
  State<NumberTicker> createState() => _NumberTickerState();
}

class _NumberTickerState extends State<NumberTicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: widget.value)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    // Respect reduce-motion setting
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final reduceMotion = MediaQuery.of(context).disableAnimations;
      if (reduceMotion) {
        _controller.value = 1.0;
      } else {
        _controller.forward();
      }
    });
  }

  @override
  void didUpdateWidget(NumberTicker old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value) {
      _animation = Tween<double>(begin: 0, end: widget.value)
          .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final display = widget.decimalPlaces == 0
            ? _animation.value.toInt().toString()
            : _animation.value.toStringAsFixed(widget.decimalPlaces);
        return Text(
          '${widget.prefix}$display${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }
}
