import 'package:flutter/animation.dart';

/// Animation duration and curve tokens for the design system.
///
/// Use these constants for all animations, transitions, and
/// timed interactions throughout the app.
class AppDurations {
  const AppDurations._();

  // ── Durations ──────────────────────────────────────────────

  /// Instant – no visible animation (state switches).
  static const Duration instant = Duration.zero;

  /// Fast – micro-interactions (checkbox, button press feedback).
  static const Duration fast = Duration(milliseconds: 150);

  /// Normal – standard transitions (page, sheet, dialog).
  static const Duration normal = Duration(milliseconds: 300);

  /// Slow – complex or emphasized animations (carousel, onboarding).
  static const Duration slow = Duration(milliseconds: 500);

  /// Slower – pulsing indicators, live status animations.
  static const Duration slower = Duration(milliseconds: 1000);

  // ── Curves ─────────────────────────────────────────────────

  /// Default curve for most animations.
  static const Curve defaultCurve = Curves.easeOutCubic;

  /// Entering elements (slide in, fade in).
  static const Curve enterCurve = Curves.easeOut;

  /// Exiting elements (slide out, fade out).
  static const Curve exitCurve = Curves.easeIn;

  /// Emphasized transitions (scale, bounce).
  static const Curve emphasizedCurve = Curves.easeInOutCubic;

  /// Deceleration curve for elements coming to rest.
  static const Curve decelerateCurve = Curves.decelerate;
}
