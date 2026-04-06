import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer_list.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';
import 'package:flutter_templates/features/owner/domain/usecases/update_salon_usecase.dart';
import 'package:flutter_templates/features/owner/presentation/providers/dashboard_notifier.dart';
import 'package:flutter_templates/features/owner/presentation/providers/dashboard_state.dart';
import 'package:flutter_templates/features/owner/presentation/providers/owner_providers.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon.dart';
import 'package:go_router/go_router.dart';

/// Page for editing salon information.
///
/// Features hero image section, info grid layout, and gradient save button
/// following the Editorial Artisan design system.
class SalonSettingsPage extends ConsumerStatefulWidget {
  /// Creates a [SalonSettingsPage].
  const SalonSettingsPage({super.key});

  @override
  ConsumerState<SalonSettingsPage> createState() => _SalonSettingsPageState();
}

class _SalonSettingsPageState extends ConsumerState<SalonSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  bool _isLoading = false;
  bool _initialized = false;

  void _initializeControllers(Salon salon) {
    if (_initialized) return;
    _nameController = TextEditingController(text: salon.name);
    _descriptionController = TextEditingController(text: salon.description);
    _addressController = TextEditingController(text: salon.address);
    _phoneController = TextEditingController(text: salon.phone);
    _initialized = true;
  }

  @override
  void dispose() {
    if (_initialized) {
      _nameController.dispose();
      _descriptionController.dispose();
      _addressController.dispose();
      _phoneController.dispose();
    }
    super.dispose();
  }

  Future<void> _onSave(Salon currentSalon) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.unfocus();

    setState(() => _isLoading = true);

    final updatedSalon = Salon(
      id: currentSalon.id,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      address: _addressController.text.trim(),
      latitude: currentSalon.latitude,
      longitude: currentSalon.longitude,
      phone: _phoneController.text.trim(),
      coverImageUrl: currentSalon.coverImageUrl,
      photoUrls: currentSalon.photoUrls,
      rating: currentSalon.rating,
      reviewCount: currentSalon.reviewCount,
      isOpen: currentSalon.isOpen,
      ownerId: currentSalon.ownerId,
      openingHours: currentSalon.openingHours,
    );

    final result = await ref
        .read(updateSalonUseCaseProvider)
        .call(UpdateSalonParams(salon: updatedSalon));

    setState(() => _isLoading = false);

    result.fold(
      (failure) => context.showSnackBar(failure.message, isError: true),
      (_) {
        context.showSnackBar('Salon updated');
        ref.read(dashboardNotifierProvider.notifier).loadDashboard();
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Salon Settings',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: switch (dashboardState) {
        DashboardInitial() || DashboardLoading() => const AppShimmerList(),
        DashboardError(:final message) => AppErrorState(message: message),
        DashboardLoaded(:final salon) => () {
            _initializeControllers(salon);
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Visual Identity section
                    Text(
                      'Visual Identity',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    AppSpacing.verticalLg,

                    // Cover photo hero
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        borderRadius: AppRadius.borderRadiusLg,
                        boxShadow:
                            isDark ? AppShadows.smDark : AppShadows.lgLight,
                      ),
                      child: ClipRRect(
                        borderRadius: AppRadius.borderRadiusLg,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (salon.coverImageUrl != null)
                              Image.network(
                                salon.coverImageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: theme.colorScheme.surfaceContainerHigh,
                                  child: Icon(
                                    Icons.image_outlined,
                                    size: 48,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              )
                            else
                              Container(
                                color: theme.colorScheme.surfaceContainerHigh,
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 48,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            // Overlay with upload button
                            Container(
                              color: Colors.black.withValues(alpha: 0.15),
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.lgx,
                                  vertical: AppSpacing.md,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: AppRadius.borderRadiusMd,
                                  boxShadow: AppShadows.mdLight,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.upload,
                                      size: 18,
                                      color: theme.colorScheme.primary,
                                    ),
                                    AppSpacing.horizontalSm,
                                    Text(
                                      'Change Cover Photo',
                                      style:
                                          theme.textTheme.labelLarge?.copyWith(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppSpacing.verticalXl,

                    // Salon name and description in a card
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lgx),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        borderRadius: AppRadius.borderRadiusLg,
                        boxShadow:
                            isDark ? AppShadows.smDark : AppShadows.lgLight,
                      ),
                      child: Column(
                        children: [
                          AppTextField(
                            controller: _nameController,
                            label: 'Salon Name',
                            hint: 'e.g., Elite Cuts Barbershop',
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(Icons.store_outlined),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Salon name is required';
                              }
                              return null;
                            },
                          ),
                          AppSpacing.verticalLg,
                          AppTextField(
                            controller: _descriptionController,
                            label: 'Description',
                            hint: 'Describe your salon...',
                            textInputAction: TextInputAction.next,
                            maxLines: 4,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Description is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.verticalXl,

                    // Contact Details section
                    Text(
                      'Contact Details',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    AppSpacing.verticalLg,

                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lgx),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        borderRadius: AppRadius.borderRadiusXl,
                        boxShadow:
                            isDark ? AppShadows.smDark : AppShadows.lgLight,
                      ),
                      child: Column(
                        children: [
                          // Phone field with icon
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary
                                      .withValues(alpha: 0.08),
                                  borderRadius: AppRadius.borderRadiusLg,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.call,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              AppSpacing.horizontalLg,
                              Expanded(
                                child: AppTextField(
                                  controller: _phoneController,
                                  label: 'Primary Phone',
                                  hint: '+1 555-0101',
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Phone is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          AppSpacing.verticalLg,
                          // Address field with icon
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary
                                      .withValues(alpha: 0.08),
                                  borderRadius: AppRadius.borderRadiusLg,
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.location_on,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              AppSpacing.horizontalLg,
                              Expanded(
                                child: AppTextField(
                                  controller: _addressController,
                                  label: 'Address',
                                  hint: '123 Main Street, City',
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Address is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.verticalXl,

                    // Save button
                    AppPrimaryButton(
                      text: 'Save Changes',
                      isLoading: _isLoading,
                      onPressed: () => _onSave(salon),
                    ),
                    AppSpacing.verticalXl,
                  ],
                ),
              ),
            );
          }(),
      },
    );
  }
}
