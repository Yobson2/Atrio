import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Themed card with optional header and footer.
///
/// Uses tonal differentiation (surfaceContainerLowest on surface background)
/// instead of borders per the "No-Line" principle. Sections are separated
/// by generous spacing rather than divider lines.
class AppCard extends StatelessWidget {
  /// Creates an [AppCard].
  const AppCard({
    required this.child,
    super.key,
    this.header,
    this.footer,
    this.padding,
    this.onTap,
    this.borderColor,
    this.showShadow = false,
  });

  /// Card body content.
  final Widget child;

  /// Optional header widget above body.
  final Widget? header;

  /// Optional footer widget below body.
  final Widget? footer;

  /// Content padding. Defaults to [AppSpacing.paddingLg].
  final EdgeInsetsGeometry? padding;

  /// Optional tap callback.
  final VoidCallback? onTap;

  /// Optional border color override (only for active/selected states).
  final Color? borderColor;

  /// Whether to show ambient shadow.
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color:
              theme.cardTheme.color ?? theme.colorScheme.surfaceContainerLowest,
          borderRadius: AppRadius.borderRadiusMd,
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          boxShadow: showShadow
              ? (isDark ? AppShadows.smDark : AppShadows.smLight)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (header != null) ...[
              Padding(
                padding: AppSpacing.paddingLg,
                child: header,
              ),
              AppSpacing.verticalMd,
            ],
            Padding(
              padding: padding ?? AppSpacing.paddingLg,
              child: child,
            ),
            if (footer != null) ...[
              AppSpacing.verticalMd,
              Padding(
                padding: AppSpacing.paddingLg,
                child: footer,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
