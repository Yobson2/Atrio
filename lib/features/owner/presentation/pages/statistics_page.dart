import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_gradient_button.dart';
import 'package:flutter_templates/core/widgets/data_display/pill_chip.dart';
import 'package:flutter_templates/core/widgets/data_display/stats_card.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer_list.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/owner/domain/entities/revenue_data.dart';
import 'package:flutter_templates/features/owner/presentation/providers/statistics_notifier.dart';
import 'package:flutter_templates/features/owner/presentation/providers/statistics_state.dart';

/// Owner statistics page with charts, metrics, and leaderboard.
class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  bool _isMonthly = true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(statisticsNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('BarberBook', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        centerTitle: false,
        actions: [
          TextButton(onPressed: () => context.showSnackBar('Statistics coming soon'), child: Text(context.l10n.statisticsTitle, style: theme.textTheme.labelMedium?.copyWith(color: AppColors.primaryLight))),
        ],
      ),
      body: switch (state) {
        StatisticsLoading() => const AppShimmerList(),
        StatisticsError(:final message) => AppErrorState(message: message, onRetry: () => ref.read(statisticsNotifierProvider.notifier).loadStats()),
        StatisticsLoaded(:final stats) => _StatsContent(stats: stats, isMonthly: _isMonthly, onToggle: (v) => setState(() { _isMonthly = v; ref.read(statisticsNotifierProvider.notifier).loadStats(isMonthly: v); })),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _StatsContent extends StatelessWidget {
  const _StatsContent({required this.stats, required this.isMonthly, required this.onToggle});
  final PerformanceStats stats;
  final bool isMonthly;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = stats.completedBookings + stats.cancelledBookings;
    final completedPercent = total > 0 ? (stats.completedBookings / total * 100).round() : 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.statisticsPerformanceInsights, style: theme.textTheme.headlineSmall),
          AppSpacing.verticalXs,
          Text(context.l10n.statisticsPerformanceSubtitle, style: theme.textTheme.bodySmall),
          AppSpacing.verticalLg,

          // Period toggle
          Row(
            children: [
              PillChip(label: context.l10n.statisticsWeekly, isSelected: !isMonthly, onTap: () => onToggle(false)),
              AppSpacing.horizontalSm,
              PillChip(label: context.l10n.statisticsMonthly, isSelected: isMonthly, onTap: () => onToggle(true)),
            ],
          ),
          AppSpacing.verticalXl,

          // Stats grid
          Row(children: [
            Expanded(child: StatsCard(label: context.l10n.statisticsTotalBookings, value: '${stats.totalBookings}', trend: '+8%')),
            AppSpacing.horizontalMd,
            Expanded(child: StatsCard(label: context.l10n.statisticsAverageRating, value: stats.averageRating.toStringAsFixed(1), icon: Icons.star_rounded)),
          ]),
          AppSpacing.verticalMd,
          Row(children: [
            Expanded(child: StatsCard(label: context.l10n.statisticsRevenue, value: '\$${stats.totalRevenue.toStringAsFixed(0)}', trend: '+15%')),
            AppSpacing.horizontalMd,
            Expanded(child: StatsCard(label: context.l10n.statisticsTopService, value: 'Signature Fade', icon: Icons.content_cut_rounded)),
          ]),
          AppSpacing.verticalXxl,

          // Revenue chart placeholder
          Row(children: [
            Text(context.l10n.statisticsRevenueAnalytics, style: theme.textTheme.titleMedium),
            const Spacer(),
            TextButton(onPressed: () => context.showSnackBar('Report coming soon'), child: Text(context.l10n.statisticsOverviewReport)),
          ]),
          AppSpacing.verticalMd,
          Container(
            height: 160,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLowest, borderRadius: BorderRadius.circular(12)),
            child: CustomPaint(painter: _SimpleChartPainter(stats.revenueData)),
          ),
          AppSpacing.verticalXxl,

          // Booking integrity
          Text(context.l10n.statisticsBookingIntegrity, style: theme.textTheme.titleMedium),
          AppSpacing.verticalMd,
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLowest, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                // Donut chart placeholder
                SizedBox(
                  width: 100, height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: completedPercent / 100,
                        strokeWidth: 10,
                        backgroundColor: AppColors.errorLight.withValues(alpha: 0.15),
                        color: AppColors.primaryLight,
                      ),
                      Text('$completedPercent%', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                AppSpacing.horizontalXl,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LegendItem(color: AppColors.primaryLight, label: context.l10n.statisticsCompleted, value: '${stats.completedBookings}'),
                      AppSpacing.verticalSm,
                      _LegendItem(color: AppColors.errorLight, label: context.l10n.statisticsCancelled, value: '${stats.cancelledBookings}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalXxl,

          // Leaderboard
          Text(context.l10n.statisticsArtisanLeaderboard, style: theme.textTheme.titleMedium),
          AppSpacing.verticalXs,
          Text(context.l10n.statisticsLeaderboardSubtitle, style: theme.textTheme.bodySmall),
          AppSpacing.verticalMd,
          ...stats.leaderboard.asMap().entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _LeaderboardRow(rank: e.key + 1, entry: e.value),
          )),
          AppSpacing.verticalXxl,

          // Revenue target CTA
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  context.l10n.statisticsRevenueTarget(stats.revenueTargetPercent),
                  style: theme.textTheme.titleSmall?.copyWith(color: AppColors.onPrimaryLight),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.verticalXs,
                Text(
                  'Keep pushing! Only \$${stats.revenueTargetRemaining.toStringAsFixed(0)} more to reach your \$50k milestone.',
                  style: theme.textTheme.bodySmall?.copyWith(color: AppColors.onPrimaryLight.withValues(alpha: 0.7)),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.verticalLg,
                Row(children: [
                  Expanded(child: AppGradientButton(text: context.l10n.statisticsPromoteServices, onPressed: () => context.showSnackBar('Promotions coming soon'), height: 40)),
                  AppSpacing.horizontalMd,
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.showSnackBar('Forecast coming soon'),
                      style: OutlinedButton.styleFrom(foregroundColor: AppColors.onPrimaryLight, side: BorderSide(color: AppColors.onPrimaryLight.withValues(alpha: 0.3))),
                      child: Text(context.l10n.statisticsViewForecast),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label, required this.value});
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      AppSpacing.horizontalSm,
      Text(label, style: Theme.of(context).textTheme.bodySmall),
      const Spacer(),
      Text(value, style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
    ]);
  }
}

class _LeaderboardRow extends StatelessWidget {
  const _LeaderboardRow({required this.rank, required this.entry});
  final int rank;
  final LeaderboardEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLowest, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Text('#$rank', style: theme.textTheme.titleSmall?.copyWith(color: AppColors.primaryLight)),
        AppSpacing.horizontalMd,
        CircleAvatar(radius: 18, backgroundColor: AppColors.surfaceContainerHighLight, child: Text(entry.name[0], style: theme.textTheme.labelMedium)),
        AppSpacing.horizontalMd,
        Expanded(child: Text(entry.name, style: theme.textTheme.titleSmall)),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('${entry.bookings}', style: theme.textTheme.titleSmall),
          Text('\$${entry.revenue.toStringAsFixed(0)}', style: theme.textTheme.labelSmall?.copyWith(color: AppColors.onSurfaceVariantLight)),
        ]),
      ]),
    );
  }
}

/// Simple line chart painter for revenue data.
class _SimpleChartPainter extends CustomPainter {
  _SimpleChartPainter(this.data);
  final List<RevenueDataPoint> data;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    final maxVal = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);
    final paint = Paint()..color = AppColors.primaryLight..strokeWidth = 2..style = PaintingStyle.stroke;
    final fillPaint = Paint()..color = AppColors.primaryLight.withValues(alpha: 0.08)..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();
    final stepX = size.width / (data.length - 1);

    for (var i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - (data[i].value / maxVal * size.height * 0.8) - size.height * 0.1;
      if (i == 0) { path.moveTo(x, y); fillPath.moveTo(x, size.height); fillPath.lineTo(x, y); }
      else { path.lineTo(x, y); fillPath.lineTo(x, y); }
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
