import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/app_avatar.dart';
import 'package:flutter_templates/core/widgets/states/app_empty_state.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/owner/presentation/providers/barber_management_notifier.dart';
import 'package:flutter_templates/features/owner/presentation/providers/barber_management_state.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:go_router/go_router.dart';

/// Page listing all barbers with add/edit/remove functionality.
class BarberManagementPage extends ConsumerWidget {
  /// Creates a [BarberManagementPage].
  const BarberManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(barberManagementNotifierProvider);
    final theme = Theme.of(context);

    ref.listen<BarberManagementState>(
      barberManagementNotifierProvider,
      (_, state) {
        if (state is BarberManagementSuccess) {
          context.showSnackBar(state.message);
        } else if (state is BarberManagementError) {
          context.showSnackBar(state.message, isError: true);
        }
      },
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Barbers',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: IconButton(
              onPressed: () => context.push('/owner/barbers/new'),
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.borderRadiusMd,
                ),
              ),
            ),
          ),
        ],
      ),
      body: switch (state) {
        BarberManagementInitial() ||
        BarberManagementLoading() =>
          const Center(child: CircularProgressIndicator()),
        BarberManagementError(:final message) => AppErrorState(
            message: message,
          ),
        BarberManagementSuccess() =>
          const Center(child: CircularProgressIndicator()),
        BarberManagementLoaded(:final barbers) => barbers.isEmpty
            ? const AppEmptyState(
                icon: Icons.people_outline,
                title: 'No barbers yet',
                subtitle: 'Add your first barber to get started.',
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header stats card
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
                            'Total Staff',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          AppSpacing.verticalXs,
                          Text(
                            '${barbers.length} Active Barber${barbers.length != 1 ? 's' : ''}',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          AppSpacing.verticalSm,
                          Row(
                            children: [
                              const Icon(
                                Icons.trending_up,
                                size: 16,
                                color: Colors.white70,
                              ),
                              AppSpacing.horizontalXs,
                              Text(
                                '${barbers.where((b) => b.isAvailable).length} available now',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.verticalXl,

                    // Barber cards grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppSpacing.md,
                        mainAxisSpacing: AppSpacing.md,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: barbers.length,
                      itemBuilder: (context, index) {
                        final barber = barbers[index];
                        return _BarberCard(
                          barber: barber,
                          onEdit: () =>
                              context.push('/owner/barbers/edit/${barber.id}'),
                          onRemove: () => _confirmRemove(context, ref, barber),
                        );
                      },
                    ),
                  ],
                ),
              ),
      },
    );
  }

  void _confirmRemove(
    BuildContext context,
    WidgetRef ref,
    Barber barber,
  ) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Barber'),
        content: Text('Are you sure you want to remove "${barber.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref
                  .read(barberManagementNotifierProvider.notifier)
                  .removeBarber(barber.id);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}

class _BarberCard extends StatelessWidget {
  const _BarberCard({
    required this.barber,
    this.onEdit,
    this.onRemove,
  });

  final Barber barber;
  final VoidCallback? onEdit;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.xl + 8),
        boxShadow: isDark ? AppShadows.smDark : AppShadows.lgLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: avatar + actions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with status indicator
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AppAvatar(
                    imageUrl: barber.avatarUrl,
                    name: barber.name,
                    radius: 28,
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: barber.isAvailable
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.error,
                        border: Border.all(
                          color: theme.colorScheme.surfaceContainerLowest,
                          width: 2.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Action buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: onEdit,
                    borderRadius: AppRadius.borderRadiusMd,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      child: Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onRemove,
                    borderRadius: AppRadius.borderRadiusMd,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      child: Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppSpacing.verticalMd,

          // Name
          Text(
            barber.name,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          // Rating
          AppSpacing.verticalXs,
          Row(
            children: [
              Icon(
                Icons.star,
                size: 14,
                color: theme.colorScheme.tertiary,
              ),
              AppSpacing.horizontalXs,
              Text(
                barber.rating.toStringAsFixed(1),
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const Spacer(),

          // Bottom status cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLow,
                    borderRadius: AppRadius.borderRadiusMd,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STATUS',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w800,
                          fontSize: 8,
                          letterSpacing: 1,
                        ),
                      ),
                      AppSpacing.verticalXs,
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: barber.isAvailable
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.error,
                            ),
                          ),
                          AppSpacing.horizontalXs,
                          Expanded(
                            child: Text(
                              barber.isAvailable ? 'Available' : 'Busy',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: barber.isAvailable
                                    ? theme.colorScheme.secondary
                                    : theme.colorScheme.error,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
