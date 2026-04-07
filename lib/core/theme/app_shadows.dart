import 'package:flutter/material.dart';

/// Box shadow tokens using the "Ambient Shadow" spec from DESIGN.md.
///
/// Shadows use a tinted version of on-surface (rgba(25, 28, 30, ...))
/// at ultra-low opacity to mimic natural studio lighting.
/// Pure black shadows are prohibited -- they look dated.
class AppShadows {
  const AppShadows._();

  /// Tinted shadow color (on-surface at 4% opacity).
  static const Color _shadowColorLight = Color(0x0A191C1E);

  /// Tinted shadow color (on-surface at 6% opacity).
  static const Color _shadowColorMdLight = Color(0x0F191C1E);

  // ── Light Theme Shadows ──────────────────────────────────────

  /// Small shadow for subtle elevation (cards, list items).
  static List<BoxShadow> get smLight => const [
        BoxShadow(
          color: _shadowColorLight,
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ];

  /// Medium shadow for elevated components (hovering buttons, dropdowns).
  static List<BoxShadow> get mdLight => const [
        BoxShadow(
          color: _shadowColorMdLight,
          blurRadius: 24,
          offset: Offset(0, 8),
        ),
      ];

  /// Large shadow for floating components (modals, sheets, FABs).
  /// This is the signature ambient shadow from the design spec.
  static List<BoxShadow> get lgLight => const [
        BoxShadow(
          color: _shadowColorMdLight,
          blurRadius: 32,
          offset: Offset(0, 12),
        ),
      ];

  // ── Dark Theme Shadows ───────────────────────────────────────

  /// Small shadow (dark).
  static List<BoxShadow> get smDark => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  /// Medium shadow (dark).
  static List<BoxShadow> get mdDark => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  /// Large shadow (dark).
  static List<BoxShadow> get lgDark => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ];
}
