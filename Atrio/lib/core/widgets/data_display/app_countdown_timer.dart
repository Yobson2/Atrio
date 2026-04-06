import 'dart:async';

import 'package:flutter/material.dart';

/// Live countdown timer display.
///
/// Counts down to [targetTime] and calls [onComplete] when finished.
class AppCountdownTimer extends StatefulWidget {
  /// Creates an [AppCountdownTimer].
  const AppCountdownTimer({
    required this.targetTime,
    super.key,
    this.onComplete,
    this.style,
    this.showHours = true,
    this.builder,
  });

  /// The target time to count down to.
  final DateTime targetTime;

  /// Called when the countdown reaches zero.
  final VoidCallback? onComplete;

  /// Text style for the timer. Defaults to headlineMedium bold.
  final TextStyle? style;

  /// Whether to show hours in the display.
  final bool showHours;

  /// Optional custom builder. Receives remaining [Duration].
  final Widget Function(BuildContext context, Duration remaining)? builder;

  @override
  State<AppCountdownTimer> createState() => _AppCountdownTimerState();
}

class _AppCountdownTimerState extends State<AppCountdownTimer> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemaining();
    });
  }

  @override
  void didUpdateWidget(covariant AppCountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.targetTime != widget.targetTime) {
      _updateRemaining();
    }
  }

  void _updateRemaining() {
    final now = DateTime.now();
    final diff = widget.targetTime.difference(now);
    setState(() {
      _remaining = diff.isNegative ? Duration.zero : diff;
    });
    if (_remaining == Duration.zero) {
      _timer?.cancel();
      widget.onComplete?.call();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _format(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (widget.showHours && hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builder != null) {
      return widget.builder!(context, _remaining);
    }

    final theme = Theme.of(context);
    final timerStyle = widget.style ??
        theme.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontFeatures: const [FontFeature.tabularFigures()],
        );

    return Semantics(
      label: 'Time remaining: ${_format(_remaining)}',
      liveRegion: true,
      child: Text(_format(_remaining), style: timerStyle),
    );
  }
}
