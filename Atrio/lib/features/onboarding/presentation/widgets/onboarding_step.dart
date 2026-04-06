import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Single onboarding step with icon, title, and description.
class OnboardingStep extends StatelessWidget {
  /// Creates an [OnboardingStep].
  const OnboardingStep({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
  });

  /// Large icon displayed in the center.
  final IconData icon;

  /// Step title.
  final String title;

  /// Step description.
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;
    final primaryContainerColor = isDark
        ? AppColors.primaryContainerDark
        : AppColors.primaryContainerLight;

    return Padding(
      padding: AppSpacing.paddingHorizontalXl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // Gradient overlay icon container (96x96, rounded-3xl)
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: primaryContainerColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                // Gradient overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primaryColor.withValues(alpha: 0.1),
                          primaryContainerColor.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                  ),
                ),
                // Icon
                Center(
                  child: Icon(
                    icon,
                    size: 48,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalLg,
          SizedBox(
            width: 280,
            child: Text(
              description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDark
                    ? AppColors.onSurfaceVariantDark
                    : AppColors.onSurfaceVariantLight,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
