import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer.dart';

/// Skeleton placeholder shaped like a list tile.
///
/// Simulates a list tile with leading avatar, title, and subtitle.
class AppSkeletonListTile extends StatelessWidget {
  /// Creates an [AppSkeletonListTile].
  const AppSkeletonListTile({
    super.key,
    this.hasLeading = true,
    this.hasTrailing = false,
    this.leadingSize = 48,
  });

  /// Whether to show the leading circle.
  final bool hasLeading;

  /// Whether to show a trailing shimmer.
  final bool hasTrailing;

  /// Size of the leading circle.
  final double leadingSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          if (hasLeading) ...[
            AppShimmer(
              width: leadingSize,
              height: leadingSize,
              borderRadius: BorderRadius.circular(leadingSize / 2),
            ),
            AppSpacing.horizontalMd,
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  height: 14,
                  borderRadius: AppRadius.borderRadiusXs,
                ),
                AppSpacing.verticalSm,
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: AppShimmer(
                    height: 12,
                    borderRadius: AppRadius.borderRadiusXs,
                  ),
                ),
              ],
            ),
          ),
          if (hasTrailing) ...[
            AppSpacing.horizontalMd,
            AppShimmer(
              width: 40,
              height: 14,
              borderRadius: AppRadius.borderRadiusXs,
            ),
          ],
        ],
      ),
    );
  }
}
