import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';
import 'package:flutter_templates/features/queue/presentation/providers/my_queue_notifier.dart';
import 'package:flutter_templates/features/queue/presentation/providers/my_queue_state.dart';
import 'package:flutter_templates/features/queue/presentation/providers/queue_notifier.dart';
import 'package:flutter_templates/features/queue/presentation/providers/queue_state.dart';
import 'package:flutter_templates/features/queue/presentation/widgets/estimated_wait_indicator.dart';
import 'package:flutter_templates/features/queue/presentation/widgets/live_indicator.dart';
import 'package:flutter_templates/features/queue/presentation/widgets/queue_entry_tile.dart';
import 'package:flutter_templates/features/queue/presentation/widgets/queue_position_card.dart';

/// Page displaying the live queue for a salon.
class QueueStatusPage extends ConsumerStatefulWidget {
  /// Creates a [QueueStatusPage].
  const QueueStatusPage({
    required this.salonId,
    this.salonName,
    super.key,
  });

  /// The salon to display the queue for.
  final String salonId;

  /// Optional salon name for the app bar title.
  final String? salonName;

  @override
  ConsumerState<QueueStatusPage> createState() => _QueueStatusPageState();
}

class _QueueStatusPageState extends ConsumerState<QueueStatusPage> {
  @override
  void initState() {
    super.initState();

    // Start watching the queue and check user's position after the first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(queueNotifierProvider.notifier).startWatching(widget.salonId);
      ref.read(myQueueNotifierProvider.notifier).checkPosition(widget.salonId);
    });
  }

  @override
  void dispose() {
    // Notifier cleanup is handled by Riverpod's auto-dispose.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final queueState = ref.watch(queueNotifierProvider);
    final myQueueState = ref.watch(myQueueNotifierProvider);

    // Listen for my queue state changes to show snackbars.
    ref.listen<MyQueueState>(myQueueNotifierProvider, (_, state) {
      switch (state) {
        case MyQueueNotInQueue():
          context.showSnackBar('You left the queue');
        case MyQueueError(:final message):
          context.showSnackBar(message, isError: true);
        default:
          break;
      }
    });

    return Scaffold(
      appBar: AppAppBar(
        title: widget.salonName ?? 'Queue Status',
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.md),
            child: LiveIndicator(),
          ),
        ],
      ),
      body: switch (queueState) {
        QueueInitial() || QueueLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        QueueError(:final message) => _ErrorView(
            message: message,
            onRetry: () => ref
                .read(queueNotifierProvider.notifier)
                .startWatching(widget.salonId),
          ),
        QueueLive(:final status) => RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(queueNotifierProvider.notifier)
                  .loadQueue(widget.salonId);
              await ref
                  .read(myQueueNotifierProvider.notifier)
                  .checkPosition(widget.salonId);
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xl,
              ),
              children: [
                // Stats row - 3 column grid
                _QueueSummary(
                  totalWaiting: status.totalWaiting,
                  currentlyServing: status.currentlyServing,
                  estimatedWaitMinutes: status.estimatedWaitMinutes,
                ),
                const SizedBox(height: AppSpacing.xl),

                // My position card (if in queue).
                if (myQueueState is MyQueueInQueue) ...[
                  QueuePositionCard(
                    entry: myQueueState.entry,
                    onLeave: () => ref
                        .read(myQueueNotifierProvider.notifier)
                        .leaveQueue(myQueueState.entry.id),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],

                // Queue entries list.
                if (status.entries.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxs,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Queue Details',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          'LIVE UPDATES',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ...status.entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: QueueEntryTile(
                        entry: entry,
                        isCurrentUser: myQueueState is MyQueueInQueue &&
                            myQueueState.entry.id == entry.id,
                      ),
                    ),
                  ),
                ] else
                  _EmptyQueue(),
              ],
            ),
          ),
      },
    );
  }
}

class _QueueSummary extends StatelessWidget {
  const _QueueSummary({
    required this.totalWaiting,
    required this.currentlyServing,
    required this.estimatedWaitMinutes,
  });

  final int totalWaiting;
  final int currentlyServing;
  final int estimatedWaitMinutes;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'TOTAL WAITING',
            value: '$totalWaiting',
            colorScheme: colorScheme,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatCard(
            label: 'SERVING',
            value: '$currentlyServing',
            colorScheme: colorScheme,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: EstimatedWaitIndicator(
            estimatedMinutes: estimatedWaitMinutes,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.colorScheme,
  });

  final String label;
  final String value;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.lg,
        horizontal: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: AppRadius.borderRadiusLg,
      ),
      child: Column(
        children: [
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyQueue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.queue_outlined,
                size: 32,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Queue is empty',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'No one is currently waiting',
              style: context.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Center(
      child: Padding(
        padding: AppSpacing.paddingXl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 28,
                color: colorScheme.error,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton.tonalIcon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
