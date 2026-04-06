import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_opacity.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/utils/validators.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/inputs/app_password_field.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';
import 'package:flutter_templates/features/auth/presentation/widgets/auth_header.dart';
import 'package:go_router/go_router.dart';

/// Registration page with name, email, password form.
class RegisterPage extends ConsumerStatefulWidget {
  /// Creates a [RegisterPage].
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _selectedRole = 'client';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      context.unfocus();
      ref.read(authNotifierProvider.notifier).register(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            role: _selectedRole,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AuthLoading;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    ref.listen<AuthState>(authNotifierProvider, (_, state) {
      if (state is AuthError) {
        context.showSnackBar(state.message, isError: true);
      }
      if (state is AuthAuthenticated) {
        context.go('/home');
      }
    });

    return Scaffold(
      body: AuthBackground(
        child: Column(
          children: [
            // Glassmorphic top bar
            SafeArea(
              bottom: false,
              child: AuthTopBar(
                showBackButton: true,
                onBack: () => context.pop(),
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.paddingHorizontalXl,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.xl),

                      // Editorial header
                      Text(
                        context.l10n.authRegister,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      AppSpacing.verticalSm,
                      Text(
                        context.l10n.authRegisterSubtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.xxl),

                      // Role selection
                      Row(
                        children: [
                          Expanded(
                            child: _RoleOption(
                              label: 'Client',
                              icon: Icons.person_outline,
                              isSelected: _selectedRole == 'client',
                              onTap: () =>
                                  setState(() => _selectedRole = 'client'),
                            ),
                          ),
                          AppSpacing.horizontalLg,
                          Expanded(
                            child: _RoleOption(
                              label: 'Salon Owner',
                              icon: Icons.store_outlined,
                              isSelected: _selectedRole == 'owner',
                              onTap: () =>
                                  setState(() => _selectedRole = 'owner'),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      // Form container card
                      Container(
                        padding: AppSpacing.paddingXl,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerLowest,
                          borderRadius: AppRadius.borderRadiusXl,
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant
                                .withValues(alpha: AppOpacity.ghostBorder),
                          ),
                          boxShadow:
                              isDark ? AppShadows.lgDark : AppShadows.lgLight,
                        ),
                        child: Column(
                          children: [
                            AppTextField(
                              controller: _nameController,
                              label: context.l10n.authName,
                              hint: 'John Doe',
                              textInputAction: TextInputAction.next,
                              autofillHints: const [AutofillHints.name],
                              validator: (v) =>
                                  Validators.required(v, fieldName: 'Name'),
                              prefixIcon: const Icon(Icons.person_outline),
                            ),
                            AppSpacing.verticalLg,
                            AppTextField(
                              controller: _emailController,
                              label: context.l10n.authEmail,
                              hint: 'name@example.com',
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autofillHints: const [AutofillHints.email],
                              validator: Validators.email,
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                            AppSpacing.verticalLg,
                            AppPasswordField(
                              controller: _passwordController,
                              label: context.l10n.authPassword,
                              validator: Validators.password,
                              textInputAction: TextInputAction.next,
                            ),
                            AppSpacing.verticalLg,
                            AppPasswordField(
                              controller: _confirmPasswordController,
                              label: context.l10n.authConfirmPassword,
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => _onRegister(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      // CTA button
                      AppPrimaryButton(
                        text: context.l10n.authRegister,
                        onPressed: _onRegister,
                        isLoading: isLoading,
                        height: 56,
                      ),

                      AppSpacing.verticalLg,

                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.l10n.authHaveAccount,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.pop(),
                            child: Text(
                              context.l10n.authLogin,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.verticalXl,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleOption extends StatelessWidget {
  const _RoleOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: AppSpacing.paddingLg,
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: AppOpacity.overlay)
              : theme.colorScheme.surfaceContainerLowest,
          borderRadius: AppRadius.borderRadiusMd,
          border: Border.all(
            color: isSelected
                ? primaryColor
                : theme.colorScheme.outlineVariant
                    .withValues(alpha: AppOpacity.ghostBorder),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isDark ? AppShadows.smDark : AppShadows.lgLight,
        ),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: AppSpacing.paddingMd,
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor.withValues(alpha: 0.1)
                    : theme.colorScheme.surfaceContainerLow,
                borderRadius: AppRadius.borderRadiusMd,
              ),
              child: Icon(
                icon,
                size: 32,
                color: primaryColor,
              ),
            ),
            AppSpacing.verticalSm,
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? primaryColor : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
