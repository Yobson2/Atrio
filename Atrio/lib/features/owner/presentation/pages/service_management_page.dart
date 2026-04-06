import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/states/app_empty_state.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/owner/presentation/providers/service_management_notifier.dart';
import 'package:flutter_templates/features/owner/presentation/providers/service_management_state.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:go_router/go_router.dart';

/// Page listing all services with add/edit/delete functionality.
class ServiceManagementPage extends ConsumerWidget {
  /// Creates a [ServiceManagementPage].
  const ServiceManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(serviceManagementNotifierProvider);
    final theme = Theme.of(context);

    ref.listen<ServiceManagementState>(
      serviceManagementNotifierProvider,
      (_, state) {
        if (state is ServiceManagementSuccess) {
          context.showSnackBar(state.message);
          ref.read(serviceManagementNotifierProvider.notifier).loadServices();
        } else if (state is ServiceManagementError) {
          context.showSnackBar(state.message, isError: true);
        }
      },
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Services',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: FilledButton.icon(
              onPressed: () => context.push('/owner/services/new'),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add'),
              style: FilledButton.styleFrom(
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
        ServiceManagementInitial() ||
        ServiceManagementLoading() =>
          const Center(child: CircularProgressIndicator()),
        ServiceManagementError(:final message) => AppErrorState(
            message: message,
            onRetry: () {
              ref
                  .read(serviceManagementNotifierProvider.notifier)
                  .loadServices();
            },
          ),
        ServiceManagementSuccess() =>
          const Center(child: CircularProgressIndicator()),
        ServiceManagementLoaded(:final services) => services.isEmpty
            ? const AppEmptyState(
                icon: Icons.cut_outlined,
                title: 'No services yet',
                subtitle: 'Add your first service to get started.',
              )
            : ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: services.length,
                separatorBuilder: (_, __) => AppSpacing.verticalMd,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return _ServiceTile(
                    service: service,
                    onEdit: () =>
                        context.push('/owner/services/edit/${service.id}'),
                    onDelete: () => _confirmDelete(context, ref, service),
                  );
                },
              ),
      },
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    SalonService service,
  ) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Service'),
        content: Text('Are you sure you want to delete "${service.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref
                  .read(serviceManagementNotifierProvider.notifier)
                  .deleteService(service.id);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.service,
    this.onEdit,
    this.onDelete,
  });

  final SalonService service;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lgx),
      decoration: BoxDecoration(
        color: service.isActive
            ? theme.colorScheme.surfaceContainerLowest
            : theme.colorScheme.surfaceContainerLow,
        borderRadius: AppRadius.borderRadiusLg,
        boxShadow: isDark ? AppShadows.smDark : AppShadows.lgLight,
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Service icon placeholder
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: service.isActive
                      ? theme.colorScheme.surfaceContainerHigh
                      : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: AppRadius.borderRadiusMd,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.content_cut,
                  color: service.isActive
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
              AppSpacing.horizontalLg,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: service.isActive
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    AppSpacing.verticalXs,
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        AppSpacing.horizontalXs,
                        Text(
                          '${service.durationMinutes} min',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        AppSpacing.horizontalMd,
                        Icon(
                          Icons.payments_outlined,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        AppSpacing.horizontalXs,
                        Text(
                          '\$${service.price.toStringAsFixed(2)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.verticalMd,
          // Bottom row with toggle and actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Status + toggle
              Row(
                children: [
                  Text(
                    service.isActive ? 'ACTIVE' : 'INACTIVE',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: service.isActive
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                  AppSpacing.horizontalMd,
                  SizedBox(
                    height: 24,
                    child: Switch(
                      value: service.isActive,
                      onChanged: null,
                      activeColor: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              // Edit and delete actions
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    onPressed: onEdit,
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.surfaceContainerHigh,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                      ),
                    ),
                  ),
                  AppSpacing.horizontalSm,
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: theme.colorScheme.error,
                    ),
                    onPressed: onDelete,
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.errorContainer
                          .withValues(alpha: 0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.borderRadiusMd,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
