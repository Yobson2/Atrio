import 'package:flutter/material.dart';

/// Semantic color tokens for the design system.
///
/// All widgets reference these tokens instead of hardcoded colors.
/// Supports both light and dark themes.
class AppColors {
  const AppColors._();

  // ── Light Theme ──────────────────────────────────────────────

  /// Primary brand color.
  static const Color primaryLight = Color(0xFF00685F);

  /// Primary variant for containers/backgrounds.
  static const Color primaryContainerLight = Color(0xFF008378);

  /// Secondary accent color.
  static const Color secondaryLight = Color(0xFF006C49);

  /// Secondary container.
  static const Color secondaryContainerLight = Color(0xFF6CF8BB);

  /// Tertiary accent color.
  static const Color tertiaryLight = Color(0xFF924628);

  /// Tertiary container.
  static const Color tertiaryContainerLight = Color(0xFFFFDBCE);

  /// Error / destructive color.
  static const Color errorLight = Color(0xFFBA1A1A);

  /// Error container.
  static const Color errorContainerLight = Color(0xFFFFDAD6);

  /// Warning color.
  static const Color warningLight = Color(0xFFF59E0B);

  /// Success color.
  static const Color successLight = Color(0xFF006C49);

  /// Info color.
  static const Color infoLight = Color(0xFF3B82F6);

  /// Main background.
  static const Color backgroundLight = Color(0xFFF7F9FB);

  /// Surface (cards, sheets).
  static const Color surfaceLight = Color(0xFFF7F9FB);

  /// Surface container lowest (pure white, high-focus cards).
  static const Color surfaceContainerLowestLight = Color(0xFFFFFFFF);

  /// Surface container low (subtle recess).
  static const Color surfaceContainerLowLight = Color(0xFFF2F4F6);

  /// Surface container (mid-level).
  static const Color surfaceContainerMediumLight = Color(0xFFECEEF0);

  /// Surface container high.
  static const Color surfaceContainerHighLight = Color(0xFFE6E8EA);

  /// Surface container highest.
  static const Color surfaceContainerHighestLight = Color(0xFFE0E3E5);

  /// Surface bright.
  static const Color surfaceBrightLight = Color(0xFFF7F9FB);

  /// Surface dim.
  static const Color surfaceDimLight = Color(0xFFD8DADC);

  /// On-primary (text/icons on primary).
  static const Color onPrimaryLight = Color(0xFFFFFFFF);

  /// On-primary container.
  static const Color onPrimaryContainerLight = Color(0xFFF4FFFC);

  /// On-surface (text/icons on surface).
  static const Color onSurfaceLight = Color(0xFF191C1E);

  /// On-surface variant (secondary text on surface).
  static const Color onSurfaceVariantLight = Color(0xFF3D4947);

  /// On-secondary.
  static const Color onSecondaryLight = Color(0xFFFFFFFF);

  /// On-secondary container.
  static const Color onSecondaryContainerLight = Color(0xFF00714D);

  /// On-tertiary.
  static const Color onTertiaryLight = Color(0xFFFFFFFF);

  /// Outline (medium emphasis borders).
  static const Color outlineLight = Color(0xFF6D7A77);

  /// Outline variant (low emphasis borders).
  static const Color outlineVariantLight = Color(0xFFBCC9C6);

  /// Primary text color.
  static const Color textPrimaryLight = Color(0xFF191C1E);

  /// Secondary text color.
  static const Color textSecondaryLight = Color(0xFF3D4947);

  /// Disabled text / hint color.
  static const Color textDisabledLight = Color(0xFF94A3B8);

  /// Border color.
  static const Color borderLight = Color(0xFFBCC9C6);

  /// Divider color.
  static const Color dividerLight = Color(0xFFECEEF0);

  // ── Status Colors (Light) ──────────────────────────────────

  /// Open / available status.
  static const Color statusOpenLight = Color(0xFF006C49);
  static const Color statusOpenBgLight = Color(0xFF6CF8BB);
  static const Color onStatusOpenLight = Color(0xFF00714D);

  /// Closed / unavailable status.
  static const Color statusClosedLight = Color(0xFFBA1A1A);
  static const Color statusClosedBgLight = Color(0xFFFFDAD6);
  static const Color onStatusClosedLight = Color(0xFF93000A);

  /// Pending / awaiting action.
  static const Color statusPendingLight = Color(0xFFF59E0B);
  static const Color statusPendingBgLight = Color(0xFFFEF3C7);
  static const Color onStatusPendingLight = Color(0xFF92400E);

  /// In-progress / active.
  static const Color statusInProgressLight = Color(0xFF3B82F6);
  static const Color statusInProgressBgLight = Color(0xFFDBEAFE);
  static const Color onStatusInProgressLight = Color(0xFF1E40AF);

  /// Completed / done.
  static const Color statusCompletedLight = Color(0xFF006C49);
  static const Color statusCompletedBgLight = Color(0xFF6CF8BB);
  static const Color onStatusCompletedLight = Color(0xFF00714D);

  /// Cancelled / dismissed.
  static const Color statusCancelledLight = Color(0xFF6D7A77);
  static const Color statusCancelledBgLight = Color(0xFFE6E8EA);
  static const Color onStatusCancelledLight = Color(0xFF3D4947);

  // ── Semantic Containers (Light) ────────────────────────────

  /// Warning container background.
  static const Color warningContainerLight = Color(0xFFFEF3C7);

  /// Success container background.
  static const Color successContainerLight = Color(0xFF6CF8BB);

  /// Info container background.
  static const Color infoContainerLight = Color(0xFFDBEAFE);

  // ── Dark Theme ───────────────────────────────────────────────

  /// Primary brand color (dark).
  static const Color primaryDark = Color(0xFF5EEAD4);

  /// Primary container (dark).
  static const Color primaryContainerDark = Color(0xFF005048);

  /// Secondary accent (dark).
  static const Color secondaryDark = Color(0xFF4EDEA3);

  /// Secondary container (dark).
  static const Color secondaryContainerDark = Color(0xFF005236);

  /// Tertiary accent (dark).
  static const Color tertiaryDark = Color(0xFFFFB59A);

  /// Tertiary container (dark).
  static const Color tertiaryContainerDark = Color(0xFF73331A);

  /// Error (dark).
  static const Color errorDark = Color(0xFFFFB4AB);

  /// Error container (dark).
  static const Color errorContainerDark = Color(0xFF93000A);

  /// Warning (dark).
  static const Color warningDark = Color(0xFFFBBF24);

  /// Success (dark).
  static const Color successDark = Color(0xFF4EDEA3);

  /// Info (dark).
  static const Color infoDark = Color(0xFF60A5FA);

  /// Background (dark).
  static const Color backgroundDark = Color(0xFF0F1416);

  /// Surface (dark).
  static const Color surfaceDark = Color(0xFF0F1416);

  /// Surface container lowest (dark).
  static const Color surfaceContainerLowestDark = Color(0xFF0A0F11);

  /// Surface container low (dark).
  static const Color surfaceContainerLowDark = Color(0xFF171C1E);

  /// Surface container medium (dark).
  static const Color surfaceContainerMediumDark = Color(0xFF1B2022);

  /// Surface container high (dark).
  static const Color surfaceContainerHighDark = Color(0xFF262B2D);

  /// Surface container highest (dark).
  static const Color surfaceContainerHighestDark = Color(0xFF303538);

  /// Surface bright (dark).
  static const Color surfaceBrightDark = Color(0xFF353A3C);

  /// Surface dim (dark).
  static const Color surfaceDimDark = Color(0xFF0F1416);

  /// On-primary (dark).
  static const Color onPrimaryDark = Color(0xFF003731);

  /// On-primary container (dark).
  static const Color onPrimaryContainerDark = Color(0xFF89F5E7);

  /// On-surface (dark).
  static const Color onSurfaceDark = Color(0xFFE1E3E5);

  /// On-surface variant (dark).
  static const Color onSurfaceVariantDark = Color(0xFFBCC9C6);

  /// On-secondary (dark).
  static const Color onSecondaryDark = Color(0xFF00391F);

  /// On-secondary container (dark).
  static const Color onSecondaryContainerDark = Color(0xFF6CF8BB);

  /// On-tertiary (dark).
  static const Color onTertiaryDark = Color(0xFF552008);

  /// Outline (dark).
  static const Color outlineDark = Color(0xFF879390);

  /// Outline variant (dark).
  static const Color outlineVariantDark = Color(0xFF3D4947);

  /// Primary text (dark).
  static const Color textPrimaryDark = Color(0xFFE1E3E5);

  /// Secondary text (dark).
  static const Color textSecondaryDark = Color(0xFFBCC9C6);

  /// Disabled text (dark).
  static const Color textDisabledDark = Color(0xFF475569);

  /// Border (dark).
  static const Color borderDark = Color(0xFF3D4947);

  /// Divider (dark).
  static const Color dividerDark = Color(0xFF1B2022);

  // ── Status Colors (Dark) ───────────────────────────────────

  /// Open / available status (dark).
  static const Color statusOpenDark = Color(0xFF4EDEA3);
  static const Color statusOpenBgDark = Color(0xFF005236);
  static const Color onStatusOpenDark = Color(0xFF6CF8BB);

  /// Closed / unavailable status (dark).
  static const Color statusClosedDark = Color(0xFFFFB4AB);
  static const Color statusClosedBgDark = Color(0xFF93000A);
  static const Color onStatusClosedDark = Color(0xFFFFDAD6);

  /// Pending / awaiting action (dark).
  static const Color statusPendingDark = Color(0xFFFBBF24);
  static const Color statusPendingBgDark = Color(0xFF78350F);
  static const Color onStatusPendingDark = Color(0xFFFEF3C7);

  /// In-progress / active (dark).
  static const Color statusInProgressDark = Color(0xFF60A5FA);
  static const Color statusInProgressBgDark = Color(0xFF1E3A5F);
  static const Color onStatusInProgressDark = Color(0xFFDBEAFE);

  /// Completed / done (dark).
  static const Color statusCompletedDark = Color(0xFF4EDEA3);
  static const Color statusCompletedBgDark = Color(0xFF005236);
  static const Color onStatusCompletedDark = Color(0xFF6CF8BB);

  /// Cancelled / dismissed (dark).
  static const Color statusCancelledDark = Color(0xFFBCC9C6);
  static const Color statusCancelledBgDark = Color(0xFF3D4947);
  static const Color onStatusCancelledDark = Color(0xFFE1E3E5);

  // ── Semantic Containers (Dark) ─────────────────────────────

  /// Warning container background (dark).
  static const Color warningContainerDark = Color(0xFF78350F);

  /// Success container background (dark).
  static const Color successContainerDark = Color(0xFF005236);

  /// Info container background (dark).
  static const Color infoContainerDark = Color(0xFF1E3A5F);
}
