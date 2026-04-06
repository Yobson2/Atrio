import 'package:flutter/material.dart';

/// Breakpoint thresholds.
class Breakpoints {
  const Breakpoints._();

  /// Mobile max width.
  static const double mobile = 600;

  /// Tablet max width.
  static const double tablet = 1024;

  /// Desktop max width.
  static const double desktop = 1440;

  /// Maximum content width for large screens.
  static const double maxContentWidth = 1200;

  // ── Grid Constants ──────────────────────────────────────────

  /// Number of columns on mobile.
  static const int mobileColumns = 4;

  /// Number of columns on tablet.
  static const int tabletColumns = 8;

  /// Number of columns on desktop.
  static const int desktopColumns = 12;

  /// Gutter width on mobile.
  static const double gutterMobile = 16;

  /// Gutter width on tablet.
  static const double gutterTablet = 24;

  /// Gutter width on desktop.
  static const double gutterDesktop = 24;
}

/// Builds different layouts based on screen width breakpoints.
///
/// Provides [mobile] (< 600px), [tablet] (>= 600px), and
/// [desktop] (>= 1024px) layouts with fallback chain.
class ResponsiveBuilder extends StatelessWidget {
  /// Creates a [ResponsiveBuilder].
  const ResponsiveBuilder({
    required this.mobile,
    super.key,
    this.tablet,
    this.desktop,
  });

  /// Widget for mobile screens.
  final Widget mobile;

  /// Widget for tablet screens. Falls back to [mobile] if null.
  final Widget? tablet;

  /// Widget for desktop screens. Falls back to [tablet], then [mobile].
  final Widget? desktop;

  /// Whether the current screen is a tablet.
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= Breakpoints.mobile;

  /// Whether the current screen is a desktop.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= Breakpoints.tablet;

  /// Returns a value based on the current breakpoint.
  static T responsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= Breakpoints.tablet) return desktop ?? tablet ?? mobile;
    if (width >= Breakpoints.mobile) return tablet ?? mobile;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= Breakpoints.tablet && desktop != null) {
      return desktop!;
    }
    if (width >= Breakpoints.mobile && (tablet ?? desktop) != null) {
      return tablet ?? desktop!;
    }
    return mobile;
  }
}
