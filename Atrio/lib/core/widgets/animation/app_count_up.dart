import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_durations.dart';

/// Animated number counting from 0 to [end].
///
/// Useful for dashboard statistics and metric displays.
/// Respects reduced-motion settings.
class AppCountUp extends StatefulWidget {
  /// Creates an [AppCountUp].
  const AppCountUp({
    required this.end,
    super.key,
    this.begin = 0,
    this.duration = AppDurations.slow,
    this.curve = AppDurations.defaultCurve,
    this.style,
    this.prefix = '',
    this.suffix = '',
    this.decimalPlaces = 0,
  });

  /// Starting value.
  final double begin;

  /// Target value to count up to.
  final double end;

  /// Animation duration.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  /// Text style.
  final TextStyle? style;

  /// Text prefix (e.g., currency symbol).
  final String prefix;

  /// Text suffix (e.g., unit).
  final String suffix;

  /// Number of decimal places to show.
  final int decimalPlaces;

  @override
  State<AppCountUp> createState() => _AppCountUpState();
}

class _AppCountUpState extends State<AppCountUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(
      begin: widget.begin,
      end: widget.end,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AppCountUp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.end != widget.end || oldWidget.begin != widget.begin) {
      _animation = Tween<double>(
        begin: widget.begin,
        end: widget.end,
      ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
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

  String _formatValue(double value) {
    final formatted = value.toStringAsFixed(widget.decimalPlaces);
    return '${widget.prefix}$formatted${widget.suffix}';
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    if (reduceMotion) {
      return Text(_formatValue(widget.end), style: widget.style);
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          _formatValue(_animation.value),
          style: widget.style,
        );
      },
    );
  }
}
