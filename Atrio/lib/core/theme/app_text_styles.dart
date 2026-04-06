import 'package:flutter/material.dart';

/// Domain-specific text style extensions on [BuildContext].
///
/// These extend the Material 3 TextTheme with styles commonly
/// repeated across the barber/salon booking UI.
extension BuildContextTextStylesX on BuildContext {
  TextTheme get _textTheme => Theme.of(this).textTheme;
  ColorScheme get _colorScheme => Theme.of(this).colorScheme;

  /// Price text – bold primary color (service tiles, booking cards).
  TextStyle get priceText => _textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w700,
        color: _colorScheme.primary,
      );

  /// Large price text – prominent price display (booking total).
  TextStyle get priceLargeText => _textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w700,
        color: _colorScheme.primary,
      );

  /// Section header – bold title for content sections.
  TextStyle get sectionHeaderText => _textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );

  /// Meta text – subdued text for addresses, dates, barber names.
  TextStyle get metaText => _textTheme.bodySmall!.copyWith(
        color: _colorScheme.onSurfaceVariant,
      );

  /// Badge text – small bold text for status chips and indicators.
  TextStyle get badgeText => _textTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.w700,
      );

  /// Timer text – monospace bold for queue countdown displays.
  TextStyle get timerText => _textTheme.headlineLarge!.copyWith(
        fontWeight: FontWeight.w700,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  /// Stat value – bold number for dashboard statistics.
  TextStyle get statValueText => _textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w700,
      );

  /// Stat label – subdued text beneath stat values.
  TextStyle get statLabelText => _textTheme.bodySmall!.copyWith(
        color: _colorScheme.onSurfaceVariant,
      );
}
