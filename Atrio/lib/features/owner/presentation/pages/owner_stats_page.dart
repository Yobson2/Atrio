import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer_list.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/owner/presentation/providers/dashboard_notifier.dart';
import 'package:flutter_templates/features/owner/presentation/providers/dashboard_state.dart';

/// Detailed statistics page for the salon owner.
///
/// Uses KPI cards with large numbers, primary accent icons, and bento grid
/// layout following the Editorial Artisan design system.
class OwnerStatsPage extends ConsumerWidget {
  /// Creates an [OwnerStatsPage].
  const OwnerStatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Statistics',
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
        DashboardLoaded(:final stats) => SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Performance Insights',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                AppSpacing.verticalXs,
                Text(
                  "Reviewing your salon's growth and engagement.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                AppSpacing.verticalXl,

                // Key Metrics Bento Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: 0.95,
                  children: [
                    // Total Bookings
                    _MetricCard(
                      icon: Icons.event_note,
                      iconBgColor:
                          theme.colorScheme.primary.withValues(alpha: 0.1),
                      iconColor: theme.colorScheme.primary,
                      label: 'Total Bookings',
                      value: stats.todayBookings.toString(),
                      footer: 'Today',
                    ),
                    // Average Rating
                    _MetricCard(
                      icon: Icons.star,
                      iconBgColor:
                          theme.colorScheme.tertiary.withValues(alpha: 0.1),
                      iconColor: theme.colorScheme.tertiary,
                      label: 'Average Rating',
                      value: stats.averageRating.toStringAsFixed(1),
                      footer: '${stats.totalReviews} reviews',
                      filledIcon: true,
                    ),
                    // Revenue
                    _MetricCard(
                      icon: Icons.payments,
                      iconBgColor:
                          theme.colorScheme.secondary.withValues(alpha: 0.1),
                      iconColor: theme.colorScheme.secondary,
                      label: 'Revenue',
                      value: '\$${stats.todayRevenue.toStringAsFixed(0)}',
                      footer: 'Today',
                    ),
                    // Completed
                    _MetricCard(
                      icon: Icons.check_circle_outline,
                      iconBgColor:
                          theme.colorScheme.primary.withValues(alpha: 0.1),
                      iconColor: theme.colorScheme.primary,
                      label: 'Completed',
                      value: stats.todayCompleted.toString(),
                      footer: 'Today',
                    ),
                  ],
                ),
                AppSpacing.verticalXl,

                // Week Section
                Text(
                  'This Week',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                AppSpacing.verticalMd,
                Row(
                  children: [
                    Expanded(
                      child: _MetricCard(
                        icon: Icons.date_range,
                        iconBgColor:
                            theme.colorScheme.primary.withValues(alpha: 0.1),
                        iconColor: theme.colorScheme.primary,
                        label: 'Bookings',
                        value: stats.weekBookings.toString(),
                        footer: 'This week',
                      ),
                    ),
                    AppSpacing.horizontalMd,
                    Expanded(
                      child: _MetricCard(
                        icon: Icons.trending_up,
                        iconBgColor:
                            theme.colorScheme.secondary.withValues(alpha: 0.1),
                        iconColor: theme.colorScheme.secondary,
                        label: 'Revenue',
                        value: '\$${stats.weekRevenue.toStringAsFixed(0)}',
                        footer: 'This week',
                      ),
                    ),
                  ],
                ),
                AppSpacing.verticalXl,

                // Booking Integrity Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(AppRadius.xl + 8),
                    boxShadow: isDark ? AppShadows.smDark : AppShadows.lgLight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking Integrity',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      AppSpacing.verticalXl,
                      // Circular indicator
                      Center(
                        child: SizedBox(
                          width: 160,
                          height: 160,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 160,
                                height: 160,
                                child: CircularProgressIndicator(
                                  value: stats.todayBookings > 0
                                      ? stats.todayCompleted /
                                          stats.todayBookings
                                      : 0,
                                  strokeWidth: 12,
                                  backgroundColor:
                                      theme.colorScheme.surfaceContainerHigh,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.colorScheme.primary,
                                  ),
                                  strokeCap: StrokeCap.round,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    stats.todayBookings > 0
                                        ? '${((stats.todayCompleted / stats.todayBookings) * 100).toStringAsFixed(0)}%'
                                        : '0%',
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    'COMPLETED',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.5,
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppSpacing.verticalXl,
                      // Legend
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              AppSpacing.horizontalSm,
                              Text(
                                'Completed',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${stats.todayCompleted}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.verticalSm,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.surfaceContainerHigh,
                                ),
                              ),
                              AppSpacing.horizontalSm,
                              Text(
                                'Remaining',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${stats.todayBookings - stats.todayCompleted}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalXl,

                // Goal Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primaryContainer,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.xl + 8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: AppRadius.borderRadiusFull,
                        ),
                        child: Text(
                          'WEEKLY OVERVIEW',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                            fontSize: 9,
                          ),
                        ),
                      ),
                      AppSpacing.verticalLg,
                      Text(
                        '${stats.weekBookings} bookings this week',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      AppSpacing.verticalSm,
                      Text(
                        '\$${stats.weekRevenue.toStringAsFixed(0)} total revenue',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      AppSpacing.verticalXl,
                      // Wait time info
                      Text(
                        'Avg. wait time: ${stats.averageWaitMinutes.toStringAsFixed(0)} min',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalXxl,
              ],
            ),
          ),
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.label,
    required this.value,
    this.footer,
    this.filledIcon = false,
  });

  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String label;
  final String value;
  final String? footer;
  final bool filledIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lgx),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: AppRadius.borderRadiusXl,
        boxShadow: isDark ? AppShadows.smDark : AppShadows.lgLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon badge
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: AppRadius.borderRadiusLg,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ),
          AppSpacing.verticalMd,
          // Label
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          AppSpacing.verticalXs,
          // Value
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          if (footer != null) ...[
            const Spacer(),
            Text(
              footer!.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                fontSize: 9,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
