import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer_list.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/owner/presentation/providers/dashboard_notifier.dart';
import 'package:flutter_templates/features/owner/presentation/providers/dashboard_state.dart';
import 'package:flutter_templates/features/owner/presentation/widgets/stats_summary_card.dart';
import 'package:flutter_templates/features/owner/presentation/widgets/today_bookings_list.dart';
import 'package:go_router/go_router.dart';

/// Owner dashboard page showing stats, today's bookings, and quick actions.
class OwnerDashboardPage extends ConsumerStatefulWidget {
  /// Creates an [OwnerDashboardPage].
  const OwnerDashboardPage({super.key});

  @override
  ConsumerState<OwnerDashboardPage> createState() => _OwnerDashboardPageState();
}

class _OwnerDashboardPageState extends ConsumerState<OwnerDashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(dashboardNotifierProvider.notifier).loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardNotifierProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Atrio',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: theme.colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/owner/salon-settings'),
          ),
        ],
      ),
      body: switch (state) {
        DashboardInitial() || DashboardLoading() => const AppShimmerList(),
        DashboardError(:final message) => AppErrorState(
            message: message,
            onRetry: () {
              ref.read(dashboardNotifierProvider.notifier).loadDashboard();
            },
          ),
        DashboardLoaded(:final salon, :final stats, :final todayBookings) =>
          RefreshIndicator(
            onRefresh: () async {
              await ref.read(dashboardNotifierProvider.notifier).refreshStats();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.verticalLg,

                  // Salon header with hero image style
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: AppRadius.borderRadiusXl,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primaryContainer,
                        ],
                      ),
                      boxShadow:
                          isDark ? AppShadows.mdDark : AppShadows.lgLight,
                    ),
                    child: Stack(
                      children: [
                        // Cover image if available
                        if (salon.coverImageUrl != null)
                          ClipRRect(
                            borderRadius: AppRadius.borderRadiusXl,
                            child: Image.network(
                              salon.coverImageUrl!,
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                        // Gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: AppRadius.borderRadiusXl,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                theme.colorScheme.primary
                                    .withValues(alpha: 0.85),
                              ],
                            ),
                          ),
                        ),
                        // Salon info
                        Positioned(
                          bottom: AppSpacing.lgx,
                          left: AppSpacing.lgx,
                          right: AppSpacing.lgx,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                salon.name,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              AppSpacing.verticalXs,
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.md,
                                      vertical: AppSpacing.xxs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: salon.isOpen
                                          ? theme.colorScheme.secondaryContainer
                                          : theme.colorScheme.errorContainer,
                                      borderRadius: AppRadius.borderRadiusFull,
                                    ),
                                    child: Text(
                                      salon.isOpen ? 'Open' : 'Closed',
                                      style:
                                          theme.textTheme.labelSmall?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: salon.isOpen
                                            ? theme.colorScheme
                                                .onSecondaryContainer
                                            : theme
                                                .colorScheme.onErrorContainer,
                                      ),
                                    ),
                                  ),
                                  if (salon.address.isNotEmpty) ...[
                                    AppSpacing.horizontalSm,
                                    Expanded(
                                      child: Text(
                                        salon.address,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: Colors.white70,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.verticalXl,

                  // Stats Grid (2x2 bento)
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    childAspectRatio: 1.3,
                    children: [
                      StatsSummaryCard(
                        label: "Today's Bookings",
                        value: stats.todayBookings.toString(),
                        subtitle: '${stats.todayCompleted} completed',
                        progress: stats.todayBookings > 0
                            ? stats.todayCompleted / stats.todayBookings
                            : 0,
                      ),
                      StatsSummaryCard(
                        label: "Today's Revenue",
                        value: '\$${stats.todayRevenue.toStringAsFixed(0)}',
                        iconColor: theme.colorScheme.secondary,
                        progress: 0.8,
                      ),
                      StatsSummaryCard(
                        label: 'Week Bookings',
                        value: stats.weekBookings.toString(),
                        progress: 0.65,
                      ),
                      StatsSummaryCard(
                        label: 'Avg. Wait',
                        value:
                            '${stats.averageWaitMinutes.toStringAsFixed(0)}m',
                        iconColor: theme.colorScheme.tertiary,
                        progress: stats.averageWaitMinutes / 60,
                      ),
                    ],
                  ),
                  AppSpacing.verticalXl,

                  // Quick Actions - horizontal scroll
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _QuickActionButton(
                          icon: Icons.format_list_numbered,
                          label: 'Queue',
                          isPrimary: true,
                          onTap: () => context.push('/owner/queue'),
                        ),
                        AppSpacing.horizontalMd,
                        _QuickActionButton(
                          icon: Icons.content_cut,
                          label: 'Services',
                          onTap: () => context.push('/owner/services'),
                        ),
                        AppSpacing.horizontalMd,
                        _QuickActionButton(
                          icon: Icons.people,
                          label: 'Barbers',
                          onTap: () => context.push('/owner/barbers'),
                        ),
                        AppSpacing.horizontalMd,
                        _QuickActionButton(
                          icon: Icons.calendar_today,
                          label: 'Bookings',
                          onTap: () => context.push('/owner/bookings'),
                        ),
                        AppSpacing.horizontalMd,
                        _QuickActionButton(
                          icon: Icons.bar_chart,
                          label: 'Stats',
                          onTap: () => context.push('/owner/stats'),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.verticalXl,

                  // Today's Bookings header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Bookings",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.push('/owner/bookings'),
                        child: Text(
                          'View All',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalSm,
                  TodayBookingsList(bookings: todayBookings),
                  AppSpacing.verticalXxl,
                ],
              ),
            ),
          ),
      },
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    this.isPrimary = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lgx,
          vertical: AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: isPrimary
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceContainerHigh,
          borderRadius: AppRadius.borderRadiusLg,
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isPrimary
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface,
              size: 22,
            ),
            AppSpacing.horizontalMd,
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: isPrimary
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
