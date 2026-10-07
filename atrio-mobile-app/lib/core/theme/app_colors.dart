import 'package:flutter/material.dart';

/// Semantic color tokens for the Atrio "Griot" palette.
///
/// Based on the "Editorial Artisan" design spec with deep teal primary,
/// kente gold secondary, terracotta tertiary, and warm ivory neutrals.
/// All widgets reference these tokens instead of hardcoded colors.
class AppColors {
  const AppColors._();

  // ── Light Theme ──────────────────────────────────────────────

  /// Primary brand color (deep teal).
  static const Color primaryLight = Color(0xFF00685F);

  /// Primary variant for containers/backgrounds.
  static const Color primaryContainerLight = Color(0xFF008378);

  /// On-primary (text/icons on primary).
  static const Color onPrimaryLight = Color(0xFFFFFFFF);

  /// On-primary container.
  static const Color onPrimaryContainerLight = Color(0xFFF4FFFC);

  /// Secondary accent (kente gold) -- premium, featured, ratings. Use sparingly.
  static const Color secondaryLight = Color(0xFF7A5900);

  /// Secondary container.
  static const Color secondaryContainerLight = Color(0xFFFFE08F);

  /// On-secondary.
  static const Color onSecondaryLight = Color(0xFFFFFFFF);

  /// On-secondary container.
  static const Color onSecondaryContainerLight = Color(0xFF2A1D00);

  /// Tertiary accent (terracotta for alerts/limited availability).
  static const Color tertiaryLight = Color(0xFF924628);

  /// Tertiary container.
  static const Color tertiaryContainerLight = Color(0xFFB05E3D);

  /// On-tertiary.
  static const Color onTertiaryLight = Color(0xFFFFFFFF);

  /// On-tertiary container.
  static const Color onTertiaryContainerLight = Color(0xFFFFFBFF);

  /// Error / destructive color.
  static const Color errorLight = Color(0xFFBA1A1A);

  /// Error container.
  static const Color errorContainerLight = Color(0xFFFFDAD6);

  /// On-error.
  static const Color onErrorLight = Color(0xFFFFFFFF);

  /// On-error container.
  static const Color onErrorContainerLight = Color(0xFF93000A);

  /// Main background.
  static const Color backgroundLight = Color(0xFFF8F7F4);

  /// On-background.
  static const Color onBackgroundLight = Color(0xFF1C1B19);

  /// Surface (the "desk" layer).
  static const Color surfaceLight = Color(0xFFF8F7F4);

  /// Surface container lowest (pure white -- the "card" layer).
  static const Color surfaceContainerLowestLight = Color(0xFFFFFFFF);

  /// Surface container low (subtle recess -- the "folder" layer).
  static const Color surfaceContainerLowLight = Color(0xFFF2F1ED);

  /// Surface container.
  static const Color surfaceContainerLight = Color(0xFFECEAE5);

  /// Surface container high (chips, inactive controls).
  static const Color surfaceContainerHighLight = Color(0xFFE6E4DE);

  /// Surface container highest.
  static const Color surfaceContainerHighestLight = Color(0xFFE0DED8);

  /// Surface bright.
  static const Color surfaceBrightLight = Color(0xFFF8F7F4);

  /// Surface dim.
  static const Color surfaceDimLight = Color(0xFFD9D6CF);

  /// Surface tint.
  static const Color surfaceTintLight = Color(0xFF006A61);

  /// Surface variant.
  static const Color surfaceVariantLight = Color(0xFFE0DED8);

  /// On-surface (text/icons on surface).
  static const Color onSurfaceLight = Color(0xFF1C1B19);

  /// On-surface variant (secondary text, labels, metadata).
  static const Color onSurfaceVariantLight = Color(0xFF4E4A43);

  /// Outline (functional borders).
  static const Color outlineLight = Color(0xFF7A756C);

  /// Outline variant (ghost borders, subtle edges).
  static const Color outlineVariantLight = Color(0xFFCBC6BC);

  /// Primary text color.
  static const Color textPrimaryLight = Color(0xFF1C1B19);

  /// Secondary text color.
  static const Color textSecondaryLight = Color(0xFF4E4A43);

  /// Disabled text / hint color.
  static const Color textDisabledLight = Color(0xFF7A756C);

  /// Border color (ghost borders, subtle).
  static const Color borderLight = Color(0xFFCBC6BC);

  /// Divider color.
  static const Color dividerLight = Color(0xFFF2F1ED);

  /// Inverse surface.
  static const Color inverseSurfaceLight = Color(0xFF31302D);

  /// Inverse on-surface.
  static const Color inverseOnSurfaceLight = Color(0xFFF3F0EA);

  /// Inverse primary.
  static const Color inversePrimaryLight = Color(0xFF6BD8CB);

  /// Warning color.
  static const Color warningLight = Color(0xFF9A5B00);

  /// Success color.
  static const Color successLight = Color(0xFF2D7A3F);

  /// Info color.
  static const Color infoLight = Color(0xFF3E5C8A);

  // ── Dark Theme ───────────────────────────────────────────────

  /// Primary brand color (dark -- teal tint).
  static const Color primaryDark = Color(0xFF6BD8CB);

  /// Primary container (dark).
  static const Color primaryContainerDark = Color(0xFF005049);

  /// On-primary (dark).
  static const Color onPrimaryDark = Color(0xFF003732);

  /// On-primary container (dark).
  static const Color onPrimaryContainerDark = Color(0xFF89F5E7);

  /// Secondary accent (dark).
  static const Color secondaryDark = Color(0xFFF0C060);

  /// Secondary container (dark).
  static const Color secondaryContainerDark = Color(0xFF5C4300);

  /// On-secondary (dark).
  static const Color onSecondaryDark = Color(0xFF2A1D00);

  /// On-secondary container (dark).
  static const Color onSecondaryContainerDark = Color(0xFFFFE08F);

  /// Tertiary (dark).
  static const Color tertiaryDark = Color(0xFFFFB59A);

  /// Tertiary container (dark).
  static const Color tertiaryContainerDark = Color(0xFF773215);

  /// On-tertiary (dark).
  static const Color onTertiaryDark = Color(0xFF552008);

  /// On-tertiary container (dark).
  static const Color onTertiaryContainerDark = Color(0xFFFFDBCE);

  /// Error (dark).
  static const Color errorDark = Color(0xFFFFB4AB);

  /// Error container (dark).
  static const Color errorContainerDark = Color(0xFF93000A);

  /// On-error (dark).
  static const Color onErrorDark = Color(0xFF690005);

  /// On-error container (dark).
  static const Color onErrorContainerDark = Color(0xFFFFDAD6);

  /// Background (dark).
  static const Color backgroundDark = Color(0xFF171614);

  /// On-background (dark).
  static const Color onBackgroundDark = Color(0xFFE7E3DC);

  /// Surface (dark).
  static const Color surfaceDark = Color(0xFF171614);

  /// Surface container lowest (dark).
  static const Color surfaceContainerLowestDark = Color(0xFF0F0E0D);

  /// Surface container low (dark).
  static const Color surfaceContainerLowDark = Color(0xFF1F1E1B);

  /// Surface container (dark).
  static const Color surfaceContainerDark = Color(0xFF262522);

  /// Surface container high (dark).
  static const Color surfaceContainerHighDark = Color(0xFF2E2D29);

  /// Surface container highest (dark).
  static const Color surfaceContainerHighestDark = Color(0xFF393733);

  /// Surface variant (dark).
  static const Color surfaceVariantDark = Color(0xFF4A463F);

  /// On-surface (dark).
  static const Color onSurfaceDark = Color(0xFFE7E3DC);

  /// On-surface variant (dark).
  static const Color onSurfaceVariantDark = Color(0xFFCBC5BA);

  /// Outline (dark).
  static const Color outlineDark = Color(0xFF959086);

  /// Outline variant (dark).
  static const Color outlineVariantDark = Color(0xFF4A463F);

  /// Primary text (dark).
  static const Color textPrimaryDark = Color(0xFFE7E3DC);

  /// Secondary text (dark).
  static const Color textSecondaryDark = Color(0xFFCBC5BA);

  /// Disabled text (dark).
  static const Color textDisabledDark = Color(0xFF959086);

  /// Border (dark).
  static const Color borderDark = Color(0xFF4A463F);

  /// Divider (dark).
  static const Color dividerDark = Color(0xFF262522);

  /// Inverse surface (dark).
  static const Color inverseSurfaceDark = Color(0xFFE7E3DC);

  /// Inverse on-surface (dark).
  static const Color inverseOnSurfaceDark = Color(0xFF31302D);

  /// Inverse primary (dark).
  static const Color inversePrimaryDark = Color(0xFF00685F);

  /// Warning (dark).
  static const Color warningDark = Color(0xFFFFB870);

  /// Success (dark).
  static const Color successDark = Color(0xFF8BD69C);

  /// Info (dark).
  static const Color infoDark = Color(0xFFA9C4F5);
}
