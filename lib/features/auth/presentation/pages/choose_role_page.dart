import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/providers/storage_providers.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/features/auth/domain/entities/user.dart';
import 'package:go_router/go_router.dart';

/// Page where new users choose their role: Client or Salon Owner.
///
/// This is the final step of the first-time onboarding flow:
/// Phone → OTP → Profile Setup → **Choose Role** → App
class ChooseRolePage extends ConsumerStatefulWidget {
  const ChooseRolePage({super.key});

  @override
  ConsumerState<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends ConsumerState<ChooseRolePage> {
  UserRole? _selectedRole;

  Future<void> _onComplete() async {
    if (_selectedRole == null) return;

    // Mark profile setup as complete
    final localStorage = ref.read(localStorageProvider);
    await localStorage.setProfileSetupComplete();

    if (!mounted) return;

    // Navigate to the correct shell based on role
    if (_selectedRole == UserRole.owner) {
      context.go('/dashboard');
    } else {
      context.go('/discover');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.paddingHorizontalXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.verticalXxl,
              Text(
                'Choose Your\nExperience',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              AppSpacing.verticalSm,
              Text(
                'How will you be using Atrio?',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariantLight,
                ),
              ),
              AppSpacing.verticalXxl,
              _RoleCard(
                icon: Icons.content_cut_rounded,
                title: 'Client',
                description:
                    'I want to discover and book professional grooming services.',
                isSelected: _selectedRole == UserRole.client,
                onTap: () => setState(() => _selectedRole = UserRole.client),
              ),
              AppSpacing.verticalLg,
              _RoleCard(
                icon: Icons.store_rounded,
                title: 'Salon Owner',
                description:
                    'I want to manage my salon, staff, and appointments.',
                isSelected: _selectedRole == UserRole.owner,
                onTap: () => setState(() => _selectedRole = UserRole.owner),
              ),
              const Spacer(),
              AppPrimaryButton(
                text: 'Complete Setup',
                onPressed: _selectedRole != null ? _onComplete : null,
              ),
              AppSpacing.verticalLg,
              Center(
                child: TextButton(
                  onPressed: () => context.showSnackBar(
                    'Contact us at support@atrio.com',
                  ),
                  child: Text(
                    'Need help? Contact support',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.onSurfaceVariantLight,
                    ),
                  ),
                ),
              ),
              AppSpacing.verticalMd,
              Center(
                child: Text(
                  'STEP 3 OF 3',
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
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.surfaceContainerLowestLight
              : AppColors.surfaceContainerLowLight,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? AppShadows.mdLight : null,
          border: isSelected
              ? Border.all(
                  color: AppColors.primaryLight.withValues(alpha: 0.3),
                  width: 1.5,
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryLight
                    : AppColors.surfaceContainerHighLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? AppColors.onPrimaryLight
                    : AppColors.onSurfaceVariantLight,
              ),
            ),
            AppSpacing.horizontalLg,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium,
                  ),
                  AppSpacing.verticalXs,
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.onSurfaceVariantLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
