import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/queue_position_card.dart';
import 'package:flutter_templates/core/widgets/loading/app_progress.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_entry.dart';
import 'package:flutter_templates/features/queue/domain/entities/queue_status.dart';
import 'package:flutter_templates/features/queue/presentation/providers/queue_notifier.dart';
import 'package:flutter_templates/features/queue/presentation/providers/queue_state.dart';

/// Client view: live queue status with position, wait time, and queue list.
class LiveQueuePage extends ConsumerStatefulWidget {
  const LiveQueuePage({super.key});

  @override
  ConsumerState<LiveQueuePage> createState() => _LiveQueuePageState();
}

class _LiveQueuePageState extends ConsumerState<LiveQueuePage> {
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
        title: Text(context.l10n.queueTitle),
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
        QueueLoaded(:final status) => _QueueContent(
            status: status,
            onImHere: () =>
                ref.read(queueNotifierProvider.notifier).markArrived(_salonId),
            onLeaveQueue: () =>
                ref.read(queueNotifierProvider.notifier).leaveQueue(_salonId),
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _QueueContent extends StatelessWidget {
  const _QueueContent({
    required this.status,
    required this.onImHere,
    required this.onLeaveQueue,
  });

  final QueueStatus status;
  final VoidCallback onImHere;
  final VoidCallback onLeaveQueue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats bar
          Row(
            children: [
              _StatChip(
                label: context.l10n.queueTotalInLine,
                value: '${status.totalInQueue}',
              ),
              AppSpacing.horizontalSm,
              _StatChip(
                label: context.l10n.queueServing,
                value: '${status.currentlyServing}',
              ),
              AppSpacing.horizontalSm,
              _StatChip(
                label: context.l10n.queueEstWait,
                value: '${status.averageWaitMinutes}m',
              ),
            ],
          ),
          AppSpacing.verticalXl,

          // Queue position card (if user is in queue)
          if (status.userPosition != null)
            QueuePositionCard(
              position: status.userPosition!,
              estimatedWaitMinutes: status.userEstimatedWait ?? 0,
              onImHere: onImHere,
              onLeaveQueue: onLeaveQueue,
            ),
          AppSpacing.verticalXxl,

          // Queue details
          Row(
            children: [
              Text(
                context.l10n.queueDetails,
                style: theme.textTheme.titleMedium,
              ),
              const Spacer(),
              Text(
                context.l10n.queueLiveUpdates,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.primaryLight,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          AppSpacing.verticalMd,

          // Queue list
          ...status.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _QueueEntryCard(entry: entry),
            ),
          ),
          AppSpacing.verticalXl,

          // Salon info card
          if (status.salonName != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHighLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.store_rounded,
                      color: AppColors.onSurfaceVariantLight,
                    ),
                  ),
                  AppSpacing.horizontalMd,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status.salonName!,
                          style: theme.textTheme.titleSmall,
                        ),
                        if (status.salonAddress != null)
                          Text(
                            status.salonAddress!,
                            style: theme.textTheme.bodySmall,
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.phone_rounded,
                      color: AppColors.primaryLight,
                    ),
                    onPressed: status.salonPhone != null
                        ? () => launchUrl(
                              Uri.parse('tel:${status.salonPhone}'),
                            )
                        : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.onSurfaceVariantLight,
                letterSpacing: 0.5,
                fontSize: 9,
              ),
            ),
            AppSpacing.verticalXs,
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QueueEntryCard extends StatelessWidget {
  const _QueueEntryCard({required this.entry});

  final QueueEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isServing = entry.status == QueueEntryStatus.serving;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isServing
            ? AppColors.primaryLight.withValues(alpha: 0.05)
            : theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: isServing
            ? Border.all(
                color: AppColors.primaryLight.withValues(alpha: 0.2),
              )
            : null,
      ),
      child: Row(
        children: [
          // Position number
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isServing
                  ? AppColors.primaryLight
                  : AppColors.surfaceContainerHighLight,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isServing
                  ? Icon(
                      Icons.content_cut_rounded,
                      size: 14,
                      color: AppColors.onPrimaryLight,
                    )
                  : Text(
                      '#${entry.position}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
            ),
          ),
          AppSpacing.horizontalMd,
          // Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.surfaceContainerHighLight,
            child: Text(
              entry.clientName[0],
              style: theme.textTheme.labelMedium,
            ),
          ),
          AppSpacing.horizontalMd,
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.clientName,
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  entry.serviceName,
                  style: theme.textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Status or wait time
          if (isServing)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'Serving',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.onPrimaryLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else if (entry.estimatedWaitMinutes != null)
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
