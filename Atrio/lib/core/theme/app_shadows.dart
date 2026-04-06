import 'package:flutter/material.dart';

/// Box shadow tokens for elevation effects.
///
/// Uses ambient shadows with tinted on-surface color for natural studio
/// lighting. Never uses pure black shadows.
class AppShadows {
  const AppShadows._();

  // Tinted shadow color from on-surface (#191C1E).
  static const Color _shadowColorLight = Color(0xFF191C1E);
  static const Color _shadowColorDark = Color(0xFF000000);

  // ── Light Theme Shadows ──────────────────────────────────────

  /// Small shadow for subtle elevation (cards, chips).
  static List<BoxShadow> get smLight => [
        BoxShadow(
          color: _shadowColorLight.withValues(alpha: 0.04),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  /// Medium shadow for elevated components (hover, pressed).
  static List<BoxShadow> get mdLight => [
        BoxShadow(
          color: _shadowColorLight.withValues(alpha: 0.06),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  /// Large shadow for floating components (dialogs, sheets, nav).
  static List<BoxShadow> get lgLight => [
        BoxShadow(
          color: _shadowColorLight.withValues(alpha: 0.06),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ];

  // ── Dark Theme Shadows ───────────────────────────────────────

  /// Small shadow (dark).
  static List<BoxShadow> get smDark => [
        BoxShadow(
          color: _shadowColorDark.withValues(alpha: 0.2),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  /// Medium shadow (dark).
  static List<BoxShadow> get mdDark => [
        BoxShadow(
          color: _shadowColorDark.withValues(alpha: 0.3),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  /// Large shadow (dark).
  static List<BoxShadow> get lgDark => [
        BoxShadow(
          color: _shadowColorDark.withValues(alpha: 0.4),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ];
}
