/// Opacity scale tokens for the design system.
///
/// Use these constants instead of hardcoded opacity values
/// to ensure visual consistency across the app.
class AppOpacity {
  const AppOpacity._();

  /// Overlay tint (selected states, hover backgrounds).
  static const double overlay = 0.08;

  /// Scrim behind modals.
  static const double scrim = 0.32;

  /// Disabled content (Material 3 standard).
  static const double disabled = 0.38;

  /// Hint / secondary content.
  static const double hint = 0.5;

  /// Dialog barrier.
  static const double barrier = 0.54;

  /// Medium emphasis (labels, meta text).
  static const double medium = 0.6;

  /// High emphasis (non-primary but visible).
  static const double high = 0.87;

  /// Ghost border (subtle outline for inputs and accessibility).
  static const double ghostBorder = 0.15;

  /// Glassmorphic surface (floating nav, app bar).
  static const double glass = 0.8;
}
