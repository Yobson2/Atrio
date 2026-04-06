import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer.dart';

/// Skeleton placeholder shaped like a card.
///
/// Simulates a card with image, title, and subtitle areas.
class AppSkeletonCard extends StatelessWidget {
  /// Creates an [AppSkeletonCard].
  const AppSkeletonCard({
    super.key,
    this.height = 200,
    this.imageHeight = 120,
    this.padding,
  });

  /// Total card height.
  final double height;

  /// Height of the image placeholder area.
  final double imageHeight;

  /// Card padding.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: AppRadius.borderRadiusMd,
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppShimmer(height: imageHeight, borderRadius: BorderRadius.zero),
            Padding(
              padding: AppSpacing.paddingMd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    alignment: Alignment.centerLeft,
                    child: AppShimmer(
                      height: 14,
                      borderRadius: AppRadius.borderRadiusXs,
                    ),
                  ),
                  AppSpacing.verticalSm,
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    alignment: Alignment.centerLeft,
                    child: AppShimmer(
                      height: 12,
                      borderRadius: AppRadius.borderRadiusXs,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
