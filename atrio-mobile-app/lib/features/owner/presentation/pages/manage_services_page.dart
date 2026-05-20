import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:go_router/go_router.dart';

/// Owner page: manage salon services portfolio.
class ManageServicesPage extends StatelessWidget {
  const ManageServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('Services'),
        actions: [
          TextButton.icon(
            onPressed: () => context.push('/service-form'),
            icon: Icon(Icons.add_rounded, size: 18, color: AppColors.primaryLight),
            label: Text(context.l10n.ownerAddService, style: TextStyle(color: AppColors.primaryLight)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _InfoChip(label: context.l10n.ownerTotalServices, value: '12'),
                AppSpacing.horizontalMd,
                _InfoChip(label: '• +2 this month', value: ''),
              ],
            ),
            AppSpacing.verticalXl,

            Text(context.l10n.ownerMostBooked, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.onSurfaceVariantLight, letterSpacing: 0.8)),
            AppSpacing.verticalSm,
            _ServiceHighlight(name: 'Signature Fade', bookings: 48, tier: 'Premium Tier'),
            AppSpacing.verticalXl,

            Text(context.l10n.ownerActivePortfolio, style: theme.textTheme.titleMedium),
            AppSpacing.verticalMd,
            ..._mockServices.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _ServiceManageCard(name: s.$1, price: s.$2, isActive: s.$3, bookings: s.$4),
            )),
          ],
        ),
      ),
    );
  }

  static const _mockServices = [
    ('Signature Skin Fade', 45.0, true, 48),
    ('Luxury Beard Sculpt', 35.0, true, 36),
    ('Traditional Hot Towel Shave', 30.0, true, 28),
    ('Scalp Therapy & Wash', 25.0, false, 12),
  ];
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text('$label $value', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariantLight));
  }
}

class _ServiceHighlight extends StatelessWidget {
  const _ServiceHighlight({required this.name, required this.bookings, required this.tier});
  final String name;
  final int bookings;
  final String tier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: theme.textTheme.titleMedium),
          AppSpacing.verticalXs,
          Text('$bookings bookings / week', style: theme.textTheme.bodySmall),
          AppSpacing.verticalXs,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(999)),
            child: Text(tier, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.onPrimaryLight, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _ServiceManageCard extends StatelessWidget {
  const _ServiceManageCard({required this.name, required this.price, required this.isActive, this.bookings});
  final String name;
  final double price;
  final bool isActive;
  final int? bookings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLowest, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: AppColors.surfaceContainerHighLight, borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.content_cut_rounded, size: 20, color: AppColors.onSurfaceVariantLight),
          ),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textTheme.titleSmall),
                Text('\$${price.toStringAsFixed(0)}', style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? AppColors.successLight.withValues(alpha: 0.1) : AppColors.onSurfaceVariantLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              isActive ? 'ACTIVE' : 'INACTIVE',
              style: theme.textTheme.labelSmall?.copyWith(
                color: isActive ? AppColors.successLight : AppColors.onSurfaceVariantLight,
                fontWeight: FontWeight.w600, fontSize: 9, letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
