import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/buttons/app_secondary_button.dart';
import 'package:flutter_templates/features/owner/presentation/providers/owner_queue_notifier.dart';

/// Queue control buttons for the owner to advance or skip queue entries.
///
/// Uses gradient primary button and tonal secondary button following
/// the Editorial Artisan design system.
class OwnerQueueControls extends ConsumerWidget {
  /// Creates an [OwnerQueueControls].
  const OwnerQueueControls({
    required this.salonId,
    super.key,
    this.currentEntryId,
    this.onActionCompleted,
  });

  /// The salon ID for queue operations.
  final String salonId;

  /// The current queue entry ID (for skip).
  final String? currentEntryId;

  /// Callback after a queue action completes.
  final VoidCallback? onActionCompleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queueState = ref.watch(ownerQueueNotifierProvider);
    final isLoading = queueState == OwnerQueueActionState.loading;

    ref.listen<OwnerQueueActionState>(ownerQueueNotifierProvider, (_, state) {
      if (state == OwnerQueueActionState.success) {
        context.showSnackBar('Queue updated');
        onActionCompleted?.call();
        ref.read(ownerQueueNotifierProvider.notifier).reset();
      } else if (state == OwnerQueueActionState.error) {
        final error = ref.read(ownerQueueNotifierProvider.notifier).lastError;
        context.showSnackBar(error, isError: true);
        ref.read(ownerQueueNotifierProvider.notifier).reset();
      }
    });

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lgx),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: AppRadius.borderRadiusXl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUEUE CONTROLS',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
          ),
          AppSpacing.verticalLg,
          Row(
            children: [
              if (currentEntryId != null) ...[
                Expanded(
                  child: AppSecondaryButton(
                    text: 'Skip',
                    icon: Icons.skip_next,
                    isLoading: isLoading,
                    onPressed: () {
                      ref
                          .read(ownerQueueNotifierProvider.notifier)
                          .skipEntry(currentEntryId!);
                    },
                  ),
                ),
                AppSpacing.horizontalMd,
              ],
              Expanded(
                flex: 2,
                child: AppPrimaryButton(
                  text: 'Advance Queue',
                  icon: Icons.play_arrow,
                  isLoading: isLoading,
                  onPressed: () {
                    ref
                        .read(ownerQueueNotifierProvider.notifier)
                        .advanceQueue(salonId);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
