import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_durations.dart';

/// Fade + slide-up entrance animation.
///
/// Animates a child from transparent + offset to fully visible.
/// Respects reduced-motion settings.
class AppFadeIn extends StatefulWidget {
  /// Creates an [AppFadeIn].
  const AppFadeIn({
    required this.child,
    super.key,
    this.delay = Duration.zero,
    this.duration = AppDurations.normal,
    this.offset = 16.0,
    this.curve = AppDurations.enterCurve,
  });

  /// The child widget to animate.
  final Widget child;

  /// Delay before the animation starts.
  final Duration delay;

  /// Animation duration.
  final Duration duration;

  /// Vertical offset to slide from (in pixels).
  final double offset;

  /// Animation curve.
  final Curve curve;

  @override
  State<AppFadeIn> createState() => _AppFadeInState();
}

class _AppFadeInState extends State<AppFadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curved = CurvedAnimation(parent: _controller, curve: widget.curve);
    _opacity = Tween<double>(begin: 0, end: 1).animate(curved);
    _position = Tween<Offset>(
      begin: Offset(0, widget.offset),
      end: Offset.zero,
    ).animate(curved);

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    if (reduceMotion) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _position.value,
          child: Opacity(
            opacity: _opacity.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
