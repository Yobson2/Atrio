import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_gradient_button.dart';
import 'package:flutter_templates/core/widgets/loading/app_progress.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_status.dart';
import 'package:flutter_templates/features/queue/presentation/providers/queue_notifier.dart';
import 'package:flutter_templates/features/queue/presentation/providers/queue_state.dart';
import 'package:go_router/go_router.dart';

/// Owner view: master queue management with skip/advance actions.
class QueueManagementPage extends ConsumerStatefulWidget {
  const QueueManagementPage({super.key});

  @override
  ConsumerState<QueueManagementPage> createState() =>
      _QueueManagementPageState();
}

class _QueueManagementPageState extends ConsumerState<QueueManagementPage> {
  static const _salonId = 'salon-001';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(queueNotifierProvider.notifier).loadQueue(_salonId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(queueNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('BarberBook'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.successLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.successLight,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  context.l10n.queueLive,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.successLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: switch (state) {
        QueueLoading() => const Center(child: AppProgress()),
        QueueError(:final message) => AppErrorState(
            message: message,
            onRetry: () =>
                ref.read(queueNotifierProvider.notifier).loadQueue(_salonId),
          ),
        QueueLoaded(:final status) => _OwnerQueueContent(
            status: status,
            onAdvance: () => ref
                .read(queueNotifierProvider.notifier)
                .advanceQueue(_salonId),
            onSkip: (entryId) => ref
                .read(queueNotifierProvider.notifier)
                .skipEntry(_salonId, entryId),
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _OwnerQueueContent extends StatelessWidget {
  const _OwnerQueueContent({
    required this.status,
    required this.onAdvance,
    required this.onSkip,
  });

  final QueueStatus status;
  final VoidCallback onAdvance;
  final ValueChanged<String> onSkip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final serving =
        status.entries.where((e) => e.status == QueueEntryStatus.serving);
    final waiting =
        status.entries.where((e) => e.status == QueueEntryStatus.waiting);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.ownerQueueLiveOperations,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceVariantLight,
                    letterSpacing: 0.8,
                  ),
                ),
                AppSpacing.verticalXs,
                Text(
                  context.l10n.ownerQueueTitle,
                  style: theme.textTheme.headlineSmall,
                ),
                AppSpacing.verticalXs,
                Text(
                  context.l10n.ownerQueueSubtitle,
                  style: theme.textTheme.bodySmall,
                  maxLines: 2,
                ),
                AppSpacing.verticalXl,

                // Action buttons row
                Row(
                  children: [
                    _ActionChip(
                      icon: Icons.skip_next_rounded,
                      label: context.l10n.ownerQueueSkip,
                      onTap: serving.isNotEmpty
                          ? () => onSkip(serving.first.id)
                          : null,
                    ),
                    AppSpacing.horizontalSm,
                    _ActionChip(
                      icon: Icons.fast_forward_rounded,
                      label: context.l10n.ownerQueueAdvance,
                      isPrimary: true,
                      onTap: onAdvance,
                    ),
                  ],
                ),
                AppSpacing.verticalXl,

                // Currently serving
                if (serving.isNotEmpty) ...[
                  Text(
                    context.l10n.ownerQueueCurrentlyServing,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.onSurfaceVariantLight,
                      letterSpacing: 0.8,
                    ),
                  ),
                  AppSpacing.verticalSm,
                  ...serving.map(
                    (entry) => _OwnerQueueCard(
                      entry: entry,
                      isServing: true,
                    ),
                  ),
                  AppSpacing.verticalXl,
                ],

                // Up next
                if (waiting.isNotEmpty) ...[
                  Text(
                    context.l10n.ownerQueueUpNext,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.onSurfaceVariantLight,
                      letterSpacing: 0.8,
                    ),
                  ),
                  AppSpacing.verticalSm,
                  ...waiting.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _OwnerQueueCard(entry: entry),
                    ),
                  ),
                ],

                AppSpacing.verticalXl,

                // Shop pulse
                Text(
                  context.l10n.ownerQueueShopPulse,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceVariantLight,
                    letterSpacing: 0.8,
                  ),
                ),
                AppSpacing.verticalSm,
                Row(
                  children: [
                    _PulseCard(
                      value: '${status.averageWaitMinutes}',
                      unit: 'min',
                      label: context.l10n.ownerQueueAvgWait,
                    ),
                    AppSpacing.horizontalMd,
                    _PulseCard(
                      value: '\$${status.dailyRevenue?.toStringAsFixed(0) ?? '0'}',
                      label: context.l10n.ownerQueueRevenue,
                    ),
                  ],
                ),
                AppSpacing.verticalXl,

                // No one in queue message
                if (status.entries.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.hourglass_empty_rounded,
                          size: 48,
                          color: AppColors.onSurfaceVariantLight
                              .withValues(alpha: 0.3),
                        ),
                        AppSpacing.verticalSm,
                        Text(
                          context.l10n.ownerQueueNoOneInQueue,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.onSurfaceVariantLight,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        // Manual entry button
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: SafeArea(
            top: false,
            child: AppGradientButton(
              text: context.l10n.ownerQueueManualEntry,
              icon: Icons.person_add_rounded,
              onPressed: () => context.showSnackBar('Manual entry coming soon'),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
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
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isPrimary
                ? AppColors.primaryLight
                : theme.colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isPrimary
                    ? AppColors.onPrimaryLight
                    : AppColors.onSurfaceVariantLight,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: isPrimary
                      ? AppColors.onPrimaryLight
                      : theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OwnerQueueCard extends StatelessWidget {
  const _OwnerQueueCard({
    required this.entry,
    this.isServing = false,
  });

  final QueueEntry entry;
  final bool isServing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isServing
            ? AppColors.primaryLight
            : theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: isServing
                ? AppColors.onPrimaryLight.withValues(alpha: 0.2)
                : AppColors.surfaceContainerHighLight,
            child: Text(
              entry.clientName[0],
              style: theme.textTheme.titleSmall?.copyWith(
                color: isServing ? AppColors.onPrimaryLight : null,
              ),
            ),
          ),
          AppSpacing.horizontalMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.clientName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: isServing ? AppColors.onPrimaryLight : null,
                  ),
                ),
                Text(
                  entry.serviceName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isServing
                        ? AppColors.onPrimaryLight.withValues(alpha: 0.7)
                        : null,
                  ),
                ),
              ],
            ),
          ),
          if (entry.estimatedWaitMinutes != null && !isServing)
            Text(
              '~${entry.estimatedWaitMinutes}m',
              style: theme.textTheme.labelMedium?.copyWith(
                color: AppColors.onSurfaceVariantLight,
              ),
            ),
        ],
      ),
    );
  }
}

class _PulseCard extends StatelessWidget {
  const _PulseCard({
    required this.value,
    required this.label,
    this.unit,
  });

  final String value;
  final String label;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (unit != null) ...[
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      unit!,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.onSurfaceVariantLight,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            AppSpacing.verticalXs,
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.onSurfaceVariantLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
