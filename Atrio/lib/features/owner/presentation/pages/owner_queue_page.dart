import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer_list.dart';
import 'package:flutter_templates/core/widgets/states/app_empty_state.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking.dart';
import 'package:flutter_templates/features/booking/domain/entities/booking_status.dart';
import 'package:flutter_templates/features/owner/presentation/providers/dashboard_notifier.dart';
import 'package:flutter_templates/features/owner/presentation/providers/dashboard_state.dart';
import 'package:flutter_templates/features/owner/presentation/widgets/owner_queue_controls.dart';

/// Real-time queue management page with advance/skip controls.
class OwnerQueuePage extends ConsumerWidget {
  /// Creates an [OwnerQueuePage].
  const OwnerQueuePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Queue Management',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(dashboardNotifierProvider.notifier).refreshStats();
            },
          ),
        ],
      ),
      body: switch (dashboardState) {
        DashboardInitial() || DashboardLoading() => const AppShimmerList(),
        DashboardError(:final message) => AppErrorState(
            message: message,
            onRetry: () {
              ref.read(dashboardNotifierProvider.notifier).loadDashboard();
            },
          ),
        DashboardLoaded(:final salon, :final todayBookings, :final stats) =>
          () {
            final activeBookings = todayBookings
                .where(
                  (b) =>
                      b.status == BookingStatus.pending ||
                      b.status == BookingStatus.confirmed ||
                      b.status == BookingStatus.inProgress,
                )
                .toList();

            if (activeBookings.isEmpty) {
              return const AppEmptyState(
                icon: Icons.queue_outlined,
                title: 'Queue is empty',
                subtitle: 'No active bookings in the queue right now.',
              );
            }

            final currentEntry = activeBookings.firstOrNull;
            final currentlyServing = activeBookings
                .where((b) => b.status == BookingStatus.inProgress)
                .toList();
            final upNext = activeBookings
                .where((b) => b.status != BookingStatus.inProgress)
                .toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  Text(
                    'LIVE OPERATIONS',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                  AppSpacing.verticalSm,
                  Text(
                    'Master Queue',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  AppSpacing.verticalXs,
                  Text(
                    'Real-time control over your shop floor.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  AppSpacing.verticalXl,

                  // Queue controls
                  OwnerQueueControls(
                    salonId: salon.id,
                    currentEntryId: currentEntry?.id,
                    onActionCompleted: () {
                      ref
                          .read(dashboardNotifierProvider.notifier)
                          .refreshStats();
                    },
                  ),
                  AppSpacing.verticalXl,

                  // Currently Serving section
                  if (currentlyServing.isNotEmpty) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.emergency,
                          size: 18,
                          color: theme.colorScheme.tertiary,
                        ),
                        AppSpacing.horizontalSm,
                        Text(
                          'CURRENTLY SERVING',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalMd,
                    ...currentlyServing.map(
                      (booking) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: _ActiveServingCard(booking: booking),
                      ),
                    ),
                    AppSpacing.verticalLg,
                  ],

                  // Up Next section
                  if (upNext.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.groups,
                              size: 18,
                              color: theme.colorScheme.primary,
                            ),
                            AppSpacing.horizontalSm,
                            Text(
                              'UP NEXT',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHigh,
                            borderRadius: AppRadius.borderRadiusFull,
                          ),
                          child: Text(
                            '${upNext.length} in line',
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalMd,
                    ...upNext.asMap().entries.map(
                          (entry) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppSpacing.sm),
                            child: _QueueEntryTile(
                              booking: entry.value,
                              position: entry.key + 2,
                            ),
                          ),
                        ),
                  ],

                  AppSpacing.verticalXl,

                  // Shop Pulse card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: AppRadius.borderRadiusXl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SHOP PULSE',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white70,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                          ),
                        ),
                        AppSpacing.verticalLg,
                        Text(
                          '${stats.averageWaitMinutes.toStringAsFixed(0)} min',
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Avg. Wait Time',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        AppSpacing.verticalLg,
                        Divider(
                          color: Colors.white.withValues(alpha: 0.2),
                          height: 1,
                        ),
                        AppSpacing.verticalLg,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${stats.todayCompleted}',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Completed Today',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${stats.todayRevenue.toStringAsFixed(0)}',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Revenue So Far',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.verticalXxl,
                ],
              ),
            );
          }(),
      },
    );
  }
}

class _ActiveServingCard extends StatelessWidget {
  const _ActiveServingCard({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lgx),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: AppRadius.borderRadiusLg,
        boxShadow: isDark ? AppShadows.smDark : AppShadows.mdLight,
        border: Border.all(
          color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          // Avatar with ACTIVE badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer
                      .withValues(alpha: 0.15),
                  borderRadius: AppRadius.borderRadiusMd,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.person,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
              ),
              Positioned(
                top: -6,
                left: -6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: AppRadius.borderRadiusFull,
                    boxShadow: AppShadows.smLight,
                  ),
                  child: Text(
                    'ACTIVE',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.horizontalLg,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.serviceName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppSpacing.verticalXs,
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: AppRadius.borderRadiusSm,
                      ),
                      child: Text(
                        booking.serviceName,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    AppSpacing.horizontalSm,
                    Text(
                      booking.barberName ?? 'Any barber',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${booking.estimatedDurationMinutes}',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.primary,
                  letterSpacing: -1,
                ),
              ),
              Text(
                'MINS LEFT',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QueueEntryTile extends StatelessWidget {
  const _QueueEntryTile({
    required this.booking,
    required this.position,
  });

  final Booking booking;
  final int position;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: AppRadius.borderRadiusLg,
      ),
      child: Row(
        children: [
          // Position badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLowest,
              borderRadius: AppRadius.borderRadiusMd,
              boxShadow: AppShadows.smLight,
            ),
            alignment: Alignment.center,
            child: Text(
              position.toString().padLeft(2, '0'),
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          AppSpacing.horizontalLg,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.serviceName,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppSpacing.verticalXs,
                Text(
                  '${booking.barberName ?? "Any barber"} '
                  '${String.fromCharCode(0x2022)} '
                  '${booking.estimatedDurationMinutes}m',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLowest,
              borderRadius: AppRadius.borderRadiusMd,
              boxShadow: AppShadows.smLight,
            ),
            child: Text(
              _statusText(booking.status),
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: _statusColor(context, booking.status),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _statusText(BookingStatus status) {
    return switch (status) {
      BookingStatus.pending => 'Waiting',
      BookingStatus.confirmed => 'Scheduled',
      _ => 'Queued',
    };
  }

  Color _statusColor(BuildContext context, BookingStatus status) {
    final theme = Theme.of(context);
    return switch (status) {
      BookingStatus.confirmed => theme.colorScheme.primary,
      BookingStatus.pending => theme.colorScheme.onSurfaceVariant,
      _ => theme.colorScheme.onSurfaceVariant,
    };
  }
}
