import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/data_display/section_label.dart';
import 'package:flutter_templates/core/widgets/data_display/stats_card.dart';

/// Referral program page with shareable code, how-it-works steps,
/// and referral statistics.
class ReferralPage extends StatelessWidget {
  /// Creates a [ReferralPage].
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.referralTitle),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero Card ──
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                boxShadow: AppShadows.smLight,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.card_giftcard_rounded,
                    color: theme.colorScheme.primary,
                    size: 48,
                  ),
                  AppSpacing.verticalMd,
                  Text(
                    'Earn 200 points for each friend!',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  AppSpacing.verticalLg,

                  // Referral code display
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'ATRIO-XK7M',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.copy_rounded),
                          onPressed: () {
                            Clipboard.setData(
                              const ClipboardData(text: 'ATRIO-XK7M'),
                            );
                            context.showSnackBar(
                              context.l10n.referralCodeCopied,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.verticalLg,
                  AppPrimaryButton(
                    text: context.l10n.referralShare,
                    icon: Icons.share_rounded,
                    onPressed: () => context.showSnackBar('Share feature coming soon'),
                  ),
                ],
              ),
            ),
            AppSpacing.verticalXxl,

            // ── How It Works ──
            SectionLabel(label: context.l10n.referralHowItWorks),
            AppSpacing.verticalMd,
            const _StepItem(
              number: '1',
              title: 'Share your code',
              description: 'Send your unique code to friends',
            ),
            AppSpacing.verticalMd,
            const _StepItem(
              number: '2',
              title: 'Friend signs up',
              description: 'They create an account using your code',
            ),
            AppSpacing.verticalMd,
            const _StepItem(
              number: '3',
              title: 'Both earn points',
              description: 'You both get 200 bonus points',
            ),
            AppSpacing.verticalXxl,

            // ── Stats ──
            SectionLabel(label: context.l10n.referralStats),
            AppSpacing.verticalMd,
            const Row(
              children: [
                Expanded(
                  child: StatsCard(label: 'INVITED', value: '12'),
                ),
                AppSpacing.horizontalMd,
                Expanded(
                  child: StatsCard(label: 'SUCCESSFUL', value: '8'),
                ),
              ],
            ),
            AppSpacing.verticalMd,
            const StatsCard(label: 'POINTS EARNED', value: '1,600'),
          ],
        ),
      ),
    );
  }
}

// ── Private Widgets ─────────────────────────────────────────────────────────

class _StepItem extends StatelessWidget {
  const _StepItem({
    required this.number,
    required this.title,
    required this.description,
  });

  final String number;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        AppSpacing.horizontalMd,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
