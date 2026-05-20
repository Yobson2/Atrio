import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_gradient_button.dart';
import 'package:go_router/go_router.dart';

/// Owner page: list of barbers with status and management actions.
class ManageBarbersPage extends StatelessWidget {
  const ManageBarbersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('Barbers'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () => context.showSnackBar('Notifications coming soon')),
          AppSpacing.horizontalSm,
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Team', style: theme.textTheme.labelSmall?.copyWith(color: AppColors.onSurfaceVariantLight, letterSpacing: 0.8)),
            AppSpacing.verticalXs,
            Text(context.l10n.ownerActiveBarbers(12), style: theme.textTheme.headlineSmall),
            AppSpacing.verticalXs,
            Text('• 91% availability today', style: theme.textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariantLight)),
            AppSpacing.verticalLg,
            AppGradientButton(text: context.l10n.ownerViewSchedule, icon: Icons.calendar_month_rounded, onPressed: () => context.showSnackBar('Schedule view coming soon'), height: 44),
            AppSpacing.verticalXl,

            ..._mockBarbers.map((b) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _BarberManageCard(name: b.$1, rating: b.$2, isOnline: b.$3, nextAppt: b.$4, bookings: b.$5),
            )),

            AppSpacing.verticalLg,
            Center(
              child: OutlinedButton.icon(
                onPressed: () => context.push('/barber-form'),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: Text(context.l10n.ownerAddBarber),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _mockBarbers = [
    ('Marcus Vance', 4.9, true, '11:30 AM', 85),
    ('Elena Rodriguez', 4.8, true, '1:00 PM', 72),
    ('Julian Silas', 4.7, false, null, 64),
    ('Leo Kash', 4.6, false, null, 58),
  ];
}

class _BarberManageCard extends StatelessWidget {
  const _BarberManageCard({required this.name, required this.rating, required this.isOnline, this.nextAppt, this.bookings});
  final String name;
  final double rating;
  final bool isOnline;
  final String? nextAppt;
  final int? bookings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(radius: 24, backgroundColor: AppColors.surfaceContainerHighLight, child: Text(name[0], style: theme.textTheme.titleMedium)),
              Positioned(
                bottom: 0, right: 0,
                child: Container(
                  width: 12, height: 12,
                  decoration: BoxDecoration(
                    color: isOnline ? AppColors.successLight : AppColors.onSurfaceVariantLight,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: theme.textTheme.titleSmall),
                    AppSpacing.horizontalSm,
                    Icon(Icons.star_rounded, size: 14, color: const Color(0xFFF59E0B)),
                    Text(' $rating', style: theme.textTheme.labelSmall),
                  ],
                ),
                AppSpacing.verticalXs,
                if (nextAppt != null)
                  Text('Next: $nextAppt', style: theme.textTheme.bodySmall)
                else
                  Text(isOnline ? 'Available' : 'Offline', style: theme.textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariantLight)),
                if (bookings != null)
                  Text('$bookings bookings', style: theme.textTheme.labelSmall?.copyWith(color: AppColors.onSurfaceVariantLight)),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.more_vert_rounded), onPressed: () => context.showSnackBar('More options coming soon')),
        ],
      ),
    );
  }
}
