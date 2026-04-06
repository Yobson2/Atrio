import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/owner/presentation/providers/service_management_notifier.dart';
import 'package:flutter_templates/features/owner/presentation/providers/service_management_state.dart';
import 'package:flutter_templates/features/owner/presentation/widgets/service_form.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:go_router/go_router.dart';

/// Page for creating or editing a salon service.
///
/// Uses surfaceContainerLow input fills, ghost borders, and a gradient
/// submit button following the Editorial Artisan design system.
class ServiceFormPage extends ConsumerWidget {
  /// Creates a [ServiceFormPage].
  const ServiceFormPage({
    super.key,
    this.service,
  });

  /// Existing service to edit, or null for creating a new one.
  final SalonService? service;

  bool get _isEditing => service != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(serviceManagementNotifierProvider);
    final isLoading = state is ServiceManagementLoading;
    final theme = Theme.of(context);

    ref.listen<ServiceManagementState>(
      serviceManagementNotifierProvider,
      (_, state) {
        if (state is ServiceManagementSuccess) {
          context.showSnackBar(state.message);
          context.pop();
        } else if (state is ServiceManagementError) {
          context.showSnackBar(state.message, isError: true);
        }
      },
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _isEditing ? 'Edit Service' : 'Add Service',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: ServiceFormWidget(
          service: service,
          isLoading: isLoading,
          onSubmit: (formService) {
            if (_isEditing) {
              ref
                  .read(serviceManagementNotifierProvider.notifier)
                  .updateService(formService);
            } else {
              ref
                  .read(serviceManagementNotifierProvider.notifier)
                  .createService(formService);
            }
          },
        ),
      ),
    );
  }
}
