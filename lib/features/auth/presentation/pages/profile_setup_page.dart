import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/utils/validators.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:go_router/go_router.dart';

/// Profile setup page where users enter their name, email, and photo.
class ProfileSetupPage extends ConsumerStatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  ConsumerState<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_formKey.currentState?.validate() ?? false) {
      context.unfocus();
      // Navigate to role selection (step 2 of onboarding)
      context.go('/choose-role', extra: {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('BarberBook'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingHorizontalXl,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.verticalXl,
                Text(
                  'Set Up Your Profile',
                  style: context.textTheme.headlineMedium,
                ),
                AppSpacing.verticalSm,
                Text(
                  'Tell us a bit about yourself to get started.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariantLight,
                  ),
                ),
                AppSpacing.verticalXxl,

                // Avatar upload
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: AppColors.surfaceContainerLowLight,
                        child: Icon(
                          Icons.person_rounded,
                          size: 48,
                          color: AppColors.onSurfaceVariantLight,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => context.showSnackBar(
                            'Photo upload coming soon',
                          ),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.surfaceContainerLowestLight,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 16,
                              color: AppColors.onPrimaryLight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalSm,
                Center(
                  child: Text(
                    'Upload Photo',
                    style: context.textTheme.labelLarge?.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
                AppSpacing.verticalXxl,

                // Name field
                AppTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.name],
                  validator: Validators.required,
                ),
                AppSpacing.verticalLg,

                // Email field
                AppTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  hint: 'example@email.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.email],
                  validator: Validators.email,
                ),
                AppSpacing.verticalXxl,

                AppSpacing.verticalXxl,

                // Next button
                AppPrimaryButton(
                  text: 'Next',
                  onPressed: _onNext,
                  icon: Icons.arrow_forward_rounded,
                ),
                AppSpacing.verticalLg,

                // Step indicator
                Center(
                  child: Text(
                    'STEP 2 OF 3',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.onSurfaceVariantLight,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                AppSpacing.verticalXl,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
