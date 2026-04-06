/// Named elevation scale for the design system.
///
/// Maps Material 3 elevation levels to semantic names
/// for consistent surface layering.
class AppElevation {
  const AppElevation._();

  /// Flat surfaces (no elevation).
  static const double none = 0;

  /// Cards, tiles.
  static const double low = 1;

  /// App bars, navigation rails.
  static const double medium = 3;

  /// FABs, snackbars.
  static const double high = 6;

  /// Dialogs, modals, bottom sheets.
  static const double highest = 8;
}
