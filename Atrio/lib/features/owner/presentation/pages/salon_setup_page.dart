import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/router/route_names.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/inputs/app_phone_field.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';
import 'package:flutter_templates/core/widgets/templates/step_flow_template.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';
import 'package:flutter_templates/features/owner/presentation/providers/salon_setup_notifier.dart';
import 'package:flutter_templates/features/owner/presentation/providers/salon_setup_state.dart';
import 'package:go_router/go_router.dart';

/// Multi-step salon setup page for new owners.
class SalonSetupPage extends ConsumerStatefulWidget {
  /// Creates a [SalonSetupPage].
  const SalonSetupPage({super.key});

  @override
  ConsumerState<SalonSetupPage> createState() => _SalonSetupPageState();
}

class _SalonSetupPageState extends ConsumerState<SalonSetupPage> {
  int _currentStep = 0;

  // Step 1: Basic Info
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();

  // Step 2: Location
  final _addressController = TextEditingController();

  // Keys for per-step validation
  final _step1Key = GlobalKey<FormState>();
  final _step2Key = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _next() {
    // Validate current step before advancing.
    final isValid = switch (_currentStep) {
      0 => _step1Key.currentState?.validate() ?? false,
      1 => _step2Key.currentState?.validate() ?? false,
      _ => true,
    };

    if (!isValid) return;

    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      _submit();
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _submit() {
    final authState = ref.read(authNotifierProvider);
    final ownerId = switch (authState) {
      AuthAuthenticated(:final user) => user.id,
      _ => '',
    };

    ref.read(salonSetupNotifierProvider.notifier).createSalon(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          address: _addressController.text.trim(),
          phone: _phoneController.text.trim(),
          latitude: 0,
          longitude: 0,
          ownerId: ownerId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(salonSetupNotifierProvider);
    final l10n = context.l10n;

    ref.listen(salonSetupNotifierProvider, (_, next) {
      if (next is SalonSetupSuccess) {
        context.go(RouteNames.ownerDashboard);
      } else if (next is SalonSetupError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    final isLoading = state is SalonSetupLoading;

    return StepFlowTemplate(
      appBar: const AppAppBar(title: 'Set Up Your Salon'),
      totalSteps: 3,
      currentStep: _currentStep,
      labels: const ['Basic Info', 'Location', 'Confirm'],
      nextText: l10n.commonNext,
      backText: l10n.commonBack,
      finishText: l10n.commonDone,
      onNext: isLoading ? null : _next,
      onBack: _currentStep > 0 ? _back : null,
      isNextLoading: isLoading,
      body: switch (_currentStep) {
        0 => _Step1BasicInfo(
            formKey: _step1Key,
            nameController: _nameController,
            descriptionController: _descriptionController,
            phoneController: _phoneController,
          ),
        1 => _Step2Location(
            formKey: _step2Key,
            addressController: _addressController,
          ),
        _ => _Step3Confirm(
            name: _nameController.text,
            description: _descriptionController.text,
            address: _addressController.text,
            phone: _phoneController.text,
          ),
      },
    );
  }
}

class _Step1BasicInfo extends StatelessWidget {
  const _Step1BasicInfo({
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.phoneController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: nameController,
            label: 'Salon Name',
            hint: 'Enter your salon name',
            prefixIcon: const Icon(Icons.store_outlined),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.validationRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: descriptionController,
            label: 'Description',
            hint: 'Describe your salon',
            prefixIcon: const Icon(Icons.description_outlined),
            maxLines: 3,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.validationRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          AppPhoneField(
            controller: phoneController,
            label: 'Phone Number',
            hint: 'Salon phone number',
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _Step2Location extends StatelessWidget {
  const _Step2Location({
    required this.formKey,
    required this.addressController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: addressController,
            label: 'Address',
            hint: 'Enter salon address',
            prefixIcon: const Icon(Icons.location_on_outlined),
            maxLines: 2,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.validationRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          // Placeholder for map picker
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 48,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Map picker coming soon',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _Step3Confirm extends StatelessWidget {
  const _Step3Confirm({
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
  });

  final String name;
  final String description;
  final String address;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Review your salon details',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _InfoRow(label: 'Name', value: name, colorScheme: colorScheme),
        const SizedBox(height: AppSpacing.md),
        _InfoRow(
          label: 'Description',
          value: description,
          colorScheme: colorScheme,
        ),
        const SizedBox(height: AppSpacing.md),
        _InfoRow(label: 'Address', value: address, colorScheme: colorScheme),
        const SizedBox(height: AppSpacing.md),
        _InfoRow(label: 'Phone', value: phone, colorScheme: colorScheme),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.colorScheme,
  });

  final String label;
  final String value;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: context.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value.isNotEmpty ? value : '—',
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
