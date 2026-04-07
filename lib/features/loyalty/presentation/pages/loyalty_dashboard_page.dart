import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/pill_chip.dart';
import 'package:flutter_templates/core/widgets/data_display/points_progress_bar.dart';
import 'package:flutter_templates/core/widgets/data_display/section_label.dart';
import 'package:flutter_templates/core/widgets/data_display/stats_card.dart';
import 'package:go_router/go_router.dart';

/// Main loyalty dashboard showing points balance, tier progress,
/// quick actions, and recent activity.
class LoyaltyDashboardPage extends StatelessWidget {
  /// Creates a [LoyaltyDashboardPage].
  const LoyaltyDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.loyaltyTitle),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero Points Card ──
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                boxShadow: AppShadows.smLight,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: theme.colorScheme.primary,
                    size: 32,
                  ),
                  AppSpacing.horizontalMd,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2,450',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        context.l10n.loyaltyPointsBalance,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const PillChip(label: 'GOLD', isSelected: true),
                ],
              ),
            ),
            AppSpacing.verticalLg,

            // ── Progress Bar ──
            PointsProgressBar(
              currentPoints: 2450,
              targetPoints: 3000,
              label: context.l10n.loyaltyPointsToNext,
            ),
            AppSpacing.verticalXl,

            // ── Stats Row ──
            const Row(
              children: [
                Expanded(child: StatsCard(label: 'EARNED', value: '3,200')),
                AppSpacing.horizontalMd,
                Expanded(child: StatsCard(label: 'REDEEMED', value: '750')),
              ],
            ),
            AppSpacing.verticalXxl,

            // ── Quick Actions ──
            const SectionLabel(label: 'QUICK ACTIONS'),
            AppSpacing.verticalMd,
            Row(
              children: [
                Expanded(
                  child: _ActionCard(
                    icon: Icons.card_giftcard_rounded,
                    label: 'View Rewards',
                    onTap: () =>
                        context.push('/client-settings/loyalty/rewards'),
                  ),
                ),
                AppSpacing.horizontalMd,
                Expanded(
                  child: _ActionCard(
                    icon: Icons.people_rounded,
                    label: 'Refer Friend',
                    onTap: () =>
                        context.push('/client-settings/loyalty/referral'),
                  ),
                ),
                AppSpacing.horizontalMd,
                Expanded(
                  child: _ActionCard(
                    icon: Icons.history_rounded,
                    label: 'History',
                    onTap: () => context
                        .push('/client-settings/loyalty/points-history'),
                  ),
                ),
              ],
            ),
            AppSpacing.verticalXxl,

            // ── Recent Activity ──
            SectionLabel(label: context.l10n.loyaltyRecentActivity),
            AppSpacing.verticalMd,
            ..._mockActivities.map(
              (a) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _ActivityItem(
                  description: a.description,
                  date: a.date,
                  points: a.points,
                  isEarned: a.isEarned,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private Widgets ─────────────────────────────────────────────────────────

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppShadows.smLight,
        ),
        child: Column(
          children: [
            Icon(icon, color: theme.colorScheme.primary, size: 24),
            AppSpacing.verticalSm,
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
    required this.description,
    required this.date,
    required this.points,
    required this.isEarned,
  });

  final String description;
  final String date;
  final int points;
  final bool isEarned;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pointsColor = isEarned
        ? theme.colorScheme.secondary
        : theme.colorScheme.tertiary;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: pointsColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isEarned
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              size: 18,
              color: pointsColor,
            ),
          ),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  date,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isEarned ? "+" : "-"}$points pts',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: pointsColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mock Data ───────────────────────────────────────────────────────────────

class _MockActivity {
  const _MockActivity({
    required this.description,
    required this.date,
    required this.points,
    required this.isEarned,
  });

  final String description;
  final String date;
  final int points;
  final bool isEarned;
}

const _mockActivities = [
  _MockActivity(
    description: 'Haircut at Prestige Barbers',
    date: 'Today, 2:30 PM',
    points: 50,
    isEarned: true,
  ),
  _MockActivity(
    description: 'Redeemed: Free Beard Trim',
    date: 'Yesterday, 11:00 AM',
    points: 200,
    isEarned: false,
  ),
  _MockActivity(
    description: 'Referral bonus - John D.',
    date: 'Apr 5, 9:15 AM',
    points: 200,
    isEarned: true,
  ),
  _MockActivity(
    description: 'Hot Towel Shave',
    date: 'Apr 3, 4:00 PM',
    points: 75,
    isEarned: true,
  ),
  _MockActivity(
    description: 'Redeemed: 20% Off Service',
    date: 'Apr 1, 10:30 AM',
    points: 300,
    isEarned: false,
  ),
];
