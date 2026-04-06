import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/owner/presentation/providers/barber_management_notifier.dart';
import 'package:flutter_templates/features/owner/presentation/providers/barber_management_state.dart';
import 'package:flutter_templates/features/owner/presentation/widgets/barber_form.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:go_router/go_router.dart';

/// Page for adding or editing a barber.
///
/// Uses surfaceContainerLow input fills, ghost borders, and a gradient
/// submit button following the Editorial Artisan design system.
class BarberFormPage extends ConsumerWidget {
  /// Creates a [BarberFormPage].
  const BarberFormPage({
    super.key,
    this.barber,
  });

  /// Existing barber to edit, or null for adding a new one.
  final Barber? barber;

  bool get _isEditing => barber != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(barberManagementNotifierProvider);
    final isLoading = state is BarberManagementLoading;
    final theme = Theme.of(context);

    ref.listen<BarberManagementState>(
      barberManagementNotifierProvider,
      (_, state) {
        if (state is BarberManagementSuccess) {
          context.showSnackBar(state.message);
          context.pop();
        } else if (state is BarberManagementError) {
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
          _isEditing ? 'Edit Barber' : 'Add Barber',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: BarberFormWidget(
          barber: barber,
          isLoading: isLoading,
          onSubmit: (formBarber) {
            if (_isEditing) {
              ref
                  .read(barberManagementNotifierProvider.notifier)
                  .updateBarber(formBarber);
            } else {
              ref
                  .read(barberManagementNotifierProvider.notifier)
                  .addBarber(formBarber);
            }
          },
        ),
      ),
    );
  }
}
