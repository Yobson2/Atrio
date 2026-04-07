import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/pill_chip.dart';
import 'package:flutter_templates/core/widgets/data_display/stats_card.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer_list.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/owner/domain/entities/dashboard_stats.dart';
import 'package:flutter_templates/features/owner/presentation/providers/owner_dashboard_notifier.dart';
import 'package:flutter_templates/features/owner/presentation/providers/owner_dashboard_state.dart';
import 'package:go_router/go_router.dart';

/// Owner dashboard with revenue stats, staff availability, and today's bookings.
class OwnerDashboardPage extends ConsumerWidget {
  const OwnerDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ownerDashboardNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BarberBook',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.showSnackBar(
              'Notifications coming soon',
            ),
          ),
          AppSpacing.horizontalSm,
        ],
      ),
      body: switch (state) {
        OwnerDashboardLoading() => const AppShimmerList(),
        OwnerDashboardError(:final message) => AppErrorState(
            message: message,
            onRetry: () => ref.read(ownerDashboardNotifierProvider.notifier).loadDashboard(),
          ),
        OwnerDashboardLoaded(:final stats) => _DashboardContent(stats: stats),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _DashboardContent extends StatefulWidget {
  const _DashboardContent({required this.stats});
  final DashboardStats stats;

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stats = widget.stats;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Salon name
          Text('Precision Grooming Studio', style: theme.textTheme.titleMedium),
          AppSpacing.verticalXs,
          Text(
            'Mayfair, London • Premium Tier',
            style: theme.textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariantLight),
          ),
          AppSpacing.verticalXl,

          // Stats row
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  label: context.l10n.ownerTodaysBookings,
                  value: '${stats.todaysBookings}',
                  suffix: '/day',
                ),
              ),
              AppSpacing.horizontalMd,
              Expanded(
                child: StatsCard(
                  label: context.l10n.ownerTodaysRevenue,
                  value: '\$${stats.todaysRevenue.toStringAsFixed(0)}',
                  trend: '+12%',
                ),
              ),
            ],
          ),
          AppSpacing.verticalMd,
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  label: 'AVG. WAIT TIME',
                  value: '${stats.avgWaitMinutes}',
                  suffix: 'min',
                ),
              ),
              AppSpacing.horizontalMd,
              Expanded(
                child: StatsCard(
                  label: 'STAFF ONLINE',
                  value: '${stats.staffOnline}',
                  suffix: '/${stats.totalBarbers}',
                ),
              ),
            ],
          ),
          AppSpacing.verticalXl,

          // Queue / Services toggle
          Row(
            children: [
              PillChip(
                label: context.l10n.ownerQueue,
                isSelected: _tabIndex == 0,
                onTap: () => setState(() => _tabIndex = 0),
              ),
              AppSpacing.horizontalSm,
              PillChip(
                label: context.l10n.ownerServices,
                isSelected: _tabIndex == 1,
                onTap: () => setState(() => _tabIndex = 1),
              ),
            ],
          ),
          AppSpacing.verticalLg,

          if (_tabIndex == 0) ...[
            // Today's bookings list
            Text(context.l10n.ownerTodaysBookings, style: theme.textTheme.titleMedium),
            AppSpacing.verticalXs,
            Row(
              children: [
                Text('View All', style: theme.textTheme.labelMedium?.copyWith(color: AppColors.primaryLight)),
              ],
            ),
            AppSpacing.verticalMd,
            ..._mockTodayBookings.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _BookingRow(name: b.$1, time: b.$2, service: b.$3),
              ),
            ),
          ] else ...[
            // Quick links
            _QuickLink(icon: Icons.groups_rounded, label: context.l10n.ownerBarbersTitle, onTap: () => context.push('/manage-barbers')),
            AppSpacing.verticalSm,
            _QuickLink(icon: Icons.spa_rounded, label: context.l10n.ownerServicesTitle, onTap: () => context.push('/manage-services')),
            AppSpacing.verticalSm,
            _QuickLink(icon: Icons.queue_rounded, label: context.l10n.ownerQueueTitle, onTap: () => context.push('/queue-management')),
          ],

          AppSpacing.verticalXxl,

          // Staff availability
          Row(
            children: [
              Text(context.l10n.ownerStaffAvailability, style: theme.textTheme.titleMedium),
              const Spacer(),
              Text('${stats.availabilityPercent}%', style: theme.textTheme.labelMedium?.copyWith(color: AppColors.primaryLight)),
            ],
          ),
          AppSpacing.verticalMd,
          ..._mockStaff.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _StaffRow(name: s.$1, status: s.$2),
            ),
          ),
          AppSpacing.verticalMd,
          Center(
            child: TextButton(
              onPressed: () => context.push('/manage-barbers'),
              child: Text(context.l10n.ownerManageRoster),
            ),
          ),
        ],
      ),
    );
  }

  static const _mockTodayBookings = [
    ('Julian Rossi', '14:30', 'Signature Sculpt'),
    ('Liam Henderson', '15:00', 'Beard Sculpt & Trim'),
    ('Ethan Wright', '16:00', 'Staff Cut'),
  ];

  static const _mockStaff = [
    ('Marcus V.', true),
    ('Julian S.', true),
    ('Elena R.', false),
    ('Leo Zhang', true),
  ];
}

class _BookingRow extends StatelessWidget {
  const _BookingRow({required this.name, required this.time, required this.service});
  final String name;
  final String time;
  final String service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.surfaceContainerHighLight,
            child: Text(name[0], style: theme.textTheme.labelMedium),
          ),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textTheme.titleSmall),
                Text(service, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          Text(time, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}

class _StaffRow extends StatelessWidget {
  const _StaffRow({required this.name, required this.status});
  final String name;
  final bool status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 8, height: 8,
          decoration: BoxDecoration(
            color: status ? AppColors.successLight : AppColors.onSurfaceVariantLight,
            shape: BoxShape.circle,
          ),
        ),
        AppSpacing.horizontalSm,
        Text(name, style: theme.textTheme.bodyMedium),
        const Spacer(),
        Text(
          status ? 'Online' : 'Offline',
          style: theme.textTheme.labelSmall?.copyWith(
            color: status ? AppColors.successLight : AppColors.onSurfaceVariantLight,
          ),
        ),
      ],
    );
  }
}

class _QuickLink extends StatelessWidget {
  const _QuickLink({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primaryLight),
            AppSpacing.horizontalMd,
            Expanded(child: Text(label, style: theme.textTheme.titleSmall)),
            Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariantLight),
          ],
        ),
      ),
    );
  }
}
