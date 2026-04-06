import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Row of social login buttons (Google & Apple) in editorial card style.
class SocialLoginButtons extends StatelessWidget {
  /// Creates [SocialLoginButtons].
  const SocialLoginButtons({
    super.key,
    this.onGooglePressed,
    this.onApplePressed,
    this.googleLabel = 'Google',
    this.appleLabel = 'Apple',
  });

  /// Callback for Google sign-in.
  final VoidCallback? onGooglePressed;

  /// Callback for Apple sign-in.
  final VoidCallback? onApplePressed;

  /// Google button label. Override for i18n.
  final String googleLabel;

  /// Apple button label. Override for i18n.
  final String appleLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SocialCard(
            onPressed: onGooglePressed,
            icon: Icons.g_mobiledata,
            label: googleLabel,
          ),
        ),
        AppSpacing.horizontalLg,
        Expanded(
          child: _SocialCard(
            onPressed: onApplePressed,
            icon: Icons.apple,
            label: appleLabel,
          ),
        ),
      ],
    );
  }
}

class _SocialCard extends StatelessWidget {
  const _SocialCard({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: AppRadius.borderRadiusMd,
          boxShadow: isDark ? AppShadows.smDark : AppShadows.lgLight,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            AppSpacing.horizontalSm,
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
