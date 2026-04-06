import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_icon_sizes.dart';
import 'package:flutter_templates/core/theme/app_icons.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Static map preview card with address text.
///
/// Displays a placeholder map area with location pin and address,
/// and opens a map action on tap.
class AppMapCard extends StatelessWidget {
  /// Creates an [AppMapCard].
  const AppMapCard({
    required this.address,
    super.key,
    this.onTap,
    this.height = 150,
    this.mapWidget,
  });

  /// Address text to display.
  final String address;

  /// Callback when the card is tapped (e.g., open in maps).
  final VoidCallback? onTap;

  /// Height of the map area.
  final double height;

  /// Optional actual map widget (e.g., GoogleMap).
  /// Shows a placeholder if null.
  final Widget? mapWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: onTap != null,
      label: 'Location: $address',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.borderRadiusMd,
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: height,
                child: mapWidget ??
                    ColoredBox(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Icon(
                        AppIcons.map,
                        size: AppIconSizes.xxl,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
              ),
              Padding(
                padding: AppSpacing.paddingMd,
                child: Row(
                  children: [
                    Icon(
                      AppIcons.location,
                      size: AppIconSizes.md,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    AppSpacing.horizontalSm,
                    Expanded(
                      child: Text(
                        address,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (onTap != null)
                      Icon(
                        AppIcons.chevronRight,
                        size: AppIconSizes.md,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
