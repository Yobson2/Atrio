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

/// Page showing all of today's bookings with status filters.
///
/// Uses pill-shaped filter chips, tonal card backgrounds, and status-colored
/// pill chips following the Editorial Artisan design system.
class OwnerBookingsPage extends ConsumerStatefulWidget {
  /// Creates an [OwnerBookingsPage].
  const OwnerBookingsPage({super.key});

  @override
  ConsumerState<OwnerBookingsPage> createState() => _OwnerBookingsPageState();
}

class _OwnerBookingsPageState extends ConsumerState<OwnerBookingsPage> {
  BookingStatus? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'All Bookings',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: switch (dashboardState) {
        DashboardInitial() || DashboardLoading() => const AppShimmerList(),
        DashboardError(:final message) => AppErrorState(
            message: message,
            onRetry: () {
              ref.read(dashboardNotifierProvider.notifier).loadDashboard();
            },
          ),
        DashboardLoaded(:final todayBookings) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Editorial header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: Text(
                  "Manage your salon's daily schedule",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              AppSpacing.verticalLg,

              // Filter chips - horizontal scroll with pill shape
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: Row(
                  children: [
                    _FilterPill(
                      label: 'All',
                      isSelected: _selectedFilter == null,
                      onTap: () => setState(() => _selectedFilter = null),
                    ),
                    AppSpacing.horizontalSm,
                    ...BookingStatus.values.map(
                      (status) => Padding(
                        padding: const EdgeInsets.only(
                          right: AppSpacing.sm,
                        ),
                        child: _FilterPill(
                          label: _statusLabel(status),
                          isSelected: _selectedFilter == status,
                          onTap: () => setState(() => _selectedFilter = status),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalMd,

              // Sort info bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.sort,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        AppSpacing.horizontalXs,
                        Text(
                          'SORTED BY DATE',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${_filteredBookings(todayBookings).length} entries',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalMd,

              // Bookings list
              Expanded(
                child: () {
                  final filtered = _filteredBookings(todayBookings);

                  if (filtered.isEmpty) {
                    return const AppEmptyState(
                      icon: Icons.book_online_outlined,
                      title: 'No bookings found',
                      subtitle: 'Try changing the filter.',
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await ref
                          .read(dashboardNotifierProvider.notifier)
                          .refreshStats();
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => AppSpacing.verticalMd,
                      itemBuilder: (context, index) {
                        return _BookingDetailCard(
                          booking: filtered[index],
                        );
                      },
                    ),
                  );
                }(),
              ),
            ],
          ),
      },
    );
  }

  List<Booking> _filteredBookings(List<Booking> bookings) {
    if (_selectedFilter == null) return bookings;
    return bookings.where((b) => b.status == _selectedFilter).toList();
  }

  String _statusLabel(BookingStatus status) {
    return switch (status) {
      BookingStatus.pending => 'Pending',
      BookingStatus.confirmed => 'Confirmed',
      BookingStatus.inProgress => 'In Progress',
      BookingStatus.completed => 'Completed',
      BookingStatus.cancelled => 'Cancelled',
      BookingStatus.noShow => 'No Show',
    };
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lgx,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceContainerHigh,
          borderRadius: AppRadius.borderRadiusFull,
          boxShadow: isSelected ? AppShadows.smLight : null,
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _BookingDetailCard extends StatelessWidget {
  const _BookingDetailCard({required this.booking});

  final Booking booking;

  Color _statusColor(BuildContext context) {
    final theme = Theme.of(context);
    return switch (booking.status) {
      BookingStatus.pending => theme.colorScheme.surfaceContainerHighest,
      BookingStatus.confirmed => theme.colorScheme.secondaryContainer,
      BookingStatus.inProgress => const Color(0xFFDBEAFE),
      BookingStatus.completed => const Color(0xFF9CA3AF),
      BookingStatus.cancelled => theme.colorScheme.error,
      BookingStatus.noShow => const Color(0xFF6D7A77),
    };
  }

  Color _statusTextColor(BuildContext context) {
    final theme = Theme.of(context);
    return switch (booking.status) {
      BookingStatus.pending => theme.colorScheme.onSurfaceVariant,
      BookingStatus.confirmed => theme.colorScheme.onSecondaryContainer,
      BookingStatus.inProgress => const Color(0xFF1E40AF),
      BookingStatus.completed => Colors.white,
      BookingStatus.cancelled => theme.colorScheme.onError,
      BookingStatus.noShow => Colors.white,
    };
  }

  String _statusLabel() {
    return switch (booking.status) {
      BookingStatus.pending => 'Pending',
      BookingStatus.confirmed => 'Confirmed',
      BookingStatus.inProgress => 'In Progress',
      BookingStatus.completed => 'Completed',
      BookingStatus.cancelled => 'Cancelled',
      BookingStatus.noShow => 'No Show',
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isCompleted = booking.status == BookingStatus.completed ||
        booking.status == BookingStatus.cancelled;

    return Opacity(
      opacity: isCompleted ? 0.75 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lgx),
        decoration: BoxDecoration(
          color: isCompleted
              ? theme.colorScheme.surfaceContainerLow
              : theme.colorScheme.surfaceContainerLowest,
          borderRadius: AppRadius.borderRadiusLg,
          boxShadow: isDark ? AppShadows.smDark : AppShadows.smLight,
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Date column
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: booking.status == BookingStatus.confirmed
                        ? theme.colorScheme.primary.withValues(alpha: 0.08)
                        : theme.colorScheme.surfaceContainerHigh,
                    borderRadius: AppRadius.borderRadiusMd,
                  ),
                  child: Column(
                    children: [
                      if (booking.scheduledAt != null) ...[
                        Text(
                          '${booking.scheduledAt!.hour.toString().padLeft(2, '0')}:${booking.scheduledAt!.minute.toString().padLeft(2, '0')}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ] else
                        Icon(
                          Icons.schedule,
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 22,
                        ),
                    ],
                  ),
                ),
                AppSpacing.horizontalLg,
                // Service info
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
                      Row(
                        children: [
                          Icon(
                            Icons.content_cut,
                            size: 12,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          AppSpacing.horizontalXs,
                          Expanded(
                            child: Text(
                              booking.barberName ?? 'Any barber',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Price + Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${booking.price.toStringAsFixed(2)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    AppSpacing.verticalXs,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: _statusColor(context),
                        borderRadius: AppRadius.borderRadiusFull,
                      ),
                      child: Text(
                        _statusLabel().toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: _statusTextColor(context),
                          fontWeight: FontWeight.w800,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
