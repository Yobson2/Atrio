import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Card displaying a redeemable reward with icon, description, and cost.
class RewardCard extends StatelessWidget {
  /// Creates a [RewardCard].
  const RewardCard({
    required this.title,
    required this.description,
    required this.pointsCost,
    required this.type,
    super.key,
    this.isAvailable = true,
    this.onRedeem,
  });

  /// Reward title.
  final String title;

  /// Reward description.
  final String description;

  /// Points required to redeem.
  final int pointsCost;

  /// Reward type — "discount", "freeService", or "product".
  final String type;

  /// Whether the reward is currently available.
  final bool isAvailable;

  /// Called when the redeem button is pressed.
  final VoidCallback? onRedeem;

  IconData _iconForType() {
    switch (type) {
      case 'freeService':
        return Icons.content_cut;
      case 'discount':
        return Icons.percent;
      case 'product':
        return Icons.card_giftcard;
      default:
        return Icons.card_giftcard;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: AppRadius.borderRadiusLg,
        boxShadow: AppShadows.smLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon area
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.lg),
                topRight: Radius.circular(AppRadius.lg),
              ),
            ),
            child: Center(
              child: Icon(
                _iconForType(),
                size: 36,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          // Content area
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppSpacing.verticalXs,
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.verticalMd,
                Row(
                  children: [
                    Text(
                      '$pointsCost pts',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    if (isAvailable)
                      GestureDetector(
                        onTap: onRedeem,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: AppRadius.borderRadiusFull,
                          ),
                          child: Text(
                            'Redeem',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
