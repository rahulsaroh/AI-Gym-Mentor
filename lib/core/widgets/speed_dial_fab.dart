import 'package:flutter/material.dart';

/// A Speed Dial FAB that expands to show mini-FABs on long press.
/// Main FAB icon rotates 45° and mini-FABs slide up with stagger.
class SpeedDialFab extends StatefulWidget {
  final IconData icon;
  final List<SpeedDialChild> children;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const SpeedDialFab({
    super.key,
    required this.icon,
    required this.children,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  State<SpeedDialFab> createState() => _SpeedDialFabState();
}

class _SpeedDialFabState extends State<SpeedDialFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isOpen = !_isOpen);
    if (_isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Mini FABs
        ...widget.children
            .asMap()
            .entries
            .map((entry) {
              final index = entry.key;
              final child = entry.value;
              final delay = reduceMotion ? 0.0 : (index * 0.15).clamp(0.0, 0.9);
              final animation = CurvedAnimation(
                parent: _controller,
                curve: Interval(delay, 1.0, curve: Curves.easeOutBack),
              );

              return AnimatedBuilder(
                animation: animation,
                builder: (context, _) {
                  return Opacity(
                    opacity: animation.value.clamp(0.0, 1.0),
                    child: Transform.translate(
                      offset: Offset(0, (1 - animation.value) * 40),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12, right: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (child.label != null) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(child.label!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                              ),
                              const SizedBox(width: 8),
                            ],
                            FloatingActionButton.small(
                              heroTag: 'speed_dial_${child.label ?? index}',
                              onPressed: () {
                                _toggle();
                                child.onTap?.call();
                              },
                              backgroundColor: child.backgroundColor ??
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                              foregroundColor: child.foregroundColor ??
                                  Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                              child: Icon(child.icon),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            })
            .toList()
            .reversed
            .toList(),

        // Main FAB
        GestureDetector(
          onLongPress: _toggle,
          onTap: () {
            if (_isOpen) {
              _toggle();
            } else {
              widget.children.first.onTap?.call();
            }
          },
          child: FloatingActionButton(
            heroTag: 'speed_dial_main',
            onPressed: null,
            backgroundColor:
                widget.backgroundColor ?? Theme.of(context).colorScheme.primary,
            foregroundColor: widget.foregroundColor ??
                Theme.of(context).colorScheme.onPrimary,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) => Transform.rotate(
                angle: _controller.value * 0.785398, // 45 degrees in radians
                child: Icon(widget.icon),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SpeedDialChild {
  final IconData icon;
  final String? label;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const SpeedDialChild({
    required this.icon,
    this.label,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
  });
}
