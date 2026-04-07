import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/reward_card.dart';

/// Grid page displaying redeemable rewards with current points balance.
class AvailableRewardsPage extends StatelessWidget {
  /// Creates an [AvailableRewardsPage].
  const AvailableRewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.rewardsTitle),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          // ── Balance Header ──
          Container(
            margin: const EdgeInsets.only(
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              top: AppSpacing.lg,
            ),
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  color: theme.colorScheme.primary,
                ),
                AppSpacing.horizontalSm,
                Text(
                  '2,450 points available',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  context.l10n.rewardsAvailable,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalLg,

          // ── Rewards Grid ──
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.xl),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: _mockRewards.length,
              itemBuilder: (context, index) {
                final reward = _mockRewards[index];
                return RewardCard(
                  title: reward.title,
                  description: reward.description,
                  pointsCost: reward.pointsCost,
                  type: reward.type,
                  isAvailable: reward.isAvailable,
                  onRedeem: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mock Data ───────────────────────────────────────────────────────────────

class _MockReward {
  const _MockReward({
    required this.title,
    required this.description,
    required this.pointsCost,
    required this.type,
    this.isAvailable = true,
  });

  final String title;
  final String description;
  final int pointsCost;
  final String type;
  final bool isAvailable;
}

const _mockRewards = [
  _MockReward(
    title: 'Free Haircut',
    description: 'Complimentary classic haircut at any partner salon',
    pointsCost: 500,
    type: 'freeService',
  ),
  _MockReward(
    title: '20% Off',
    description: '20% discount on your next service booking',
    pointsCost: 300,
    type: 'discount',
  ),
  _MockReward(
    title: 'Hot Towel Shave',
    description: 'Premium hot towel shave experience',
    pointsCost: 400,
    type: 'freeService',
  ),
  _MockReward(
    title: 'Premium Product',
    description: 'Choose any styling product from our collection',
    pointsCost: 800,
    type: 'product',
  ),
  _MockReward(
    title: 'Beard Trim',
    description: 'Free beard trim and shaping session',
    pointsCost: 250,
    type: 'freeService',
  ),
  _MockReward(
    title: 'VIP Package',
    description: 'Full grooming package with premium products',
    pointsCost: 1500,
    type: 'freeService',
    isAvailable: false,
  ),
];
