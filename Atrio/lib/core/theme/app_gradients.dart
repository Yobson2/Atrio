import 'package:flutter/material.dart';

import 'package:flutter_templates/core/theme/app_colors.dart';

/// Gradient tokens for the design system.
///
/// Provides consistent gradient styles for both light and dark themes.
class AppGradients {
  const AppGradients._();

  // ── Light Theme Gradients ──────────────────────────────────

  /// Primary brand gradient (hero banners, booking confirmation headers).
  static const LinearGradient primaryLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primaryLight,
      AppColors.primaryContainerLight,
    ],
  );

  /// Primary button gradient (CTA buttons).
  static const LinearGradient primaryButtonLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primaryLight,
      AppColors.primaryContainerLight,
    ],
  );

  /// Surface fade gradient (scroll edge fade-out).
  static LinearGradient surfaceFadeLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.backgroundLight.withValues(alpha: 0),
      AppColors.backgroundLight,
    ],
  );

  /// Open status gradient (salon open indicator).
  static const LinearGradient statusOpenLight = LinearGradient(
    colors: [
      AppColors.secondaryLight,
      Color(0xFF4EDEA3),
    ],
  );

  /// Busy status gradient (queue congestion indicator).
  static const LinearGradient statusBusyLight = LinearGradient(
    colors: [
      Color(0xFFF59E0B),
      Color(0xFFFBBF24),
    ],
  );

  // ── Dark Theme Gradients ───────────────────────────────────

  /// Primary brand gradient (dark).
  static const LinearGradient primaryDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primaryDark,
      Color(0xFF99F6E4),
    ],
  );

  /// Primary button gradient (dark).
  static const LinearGradient primaryButtonDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primaryDark,
      Color(0xFF99F6E4),
    ],
  );

  /// Surface fade gradient (dark).
  static LinearGradient surfaceFadeDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.backgroundDark.withValues(alpha: 0),
      AppColors.backgroundDark,
    ],
  );

  /// Open status gradient (dark).
  static const LinearGradient statusOpenDark = LinearGradient(
    colors: [
      AppColors.secondaryDark,
      Color(0xFF6EE7B7),
    ],
  );

  /// Busy status gradient (dark).
  static const LinearGradient statusBusyDark = LinearGradient(
    colors: [
      Color(0xFFFBBF24),
      Color(0xFFFDE68A),
    ],
  );
}
