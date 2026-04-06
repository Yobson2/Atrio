/// Accessibility constants for the design system.
///
/// Ensures consistent touch targets, contrast ratios,
/// and accessibility standards throughout the app.
class AppAccessibility {
  const AppAccessibility._();

  /// Minimum touch target size (Material Design guideline: 48x48dp).
  static const double minTouchTarget = 48;

  /// Minimum contrast ratio for normal text (WCAG AA).
  static const double minContrastNormal = 4.5;

  /// Minimum contrast ratio for large text (WCAG AA).
  static const double minContrastLarge = 3;

  /// Focus indicator width.
  static const double focusIndicatorWidth = 2;

  /// Minimum recommended line height multiplier for readability.
  static const double minLineHeightMultiplier = 1.2;
}
