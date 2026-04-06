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
import 'package:flutter_templates/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:go_router/go_router.dart';

/// Login page with email/password form.
class LoginPage extends ConsumerStatefulWidget {
  /// Creates a [LoginPage].
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.unfocus();
      ref.read(authNotifierProvider.notifier).login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
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
                showCloseButton: true,
                onClose: () => Navigator.of(context).maybePop(),
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
                      const SizedBox(height: AppSpacing.xxl),

                      // Editorial hero headline
                      Text(
                        'Welcome to\nAtrio',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          color: theme.colorScheme.primary,
                          height: 1.1,
                        ),
                      ),
                      AppSpacing.verticalSm,
                      Text(
                        context.l10n.authLoginSubtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.xxl),

                      // Email field
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

                      // Password field
                      AppPasswordField(
                        controller: _passwordController,
                        label: context.l10n.authPassword,
                        validator: Validators.password,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _onLogin(),
                      ),
                      AppSpacing.verticalSm,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.push('/forgot-password'),
                          child: Text(
                            context.l10n.authForgotPassword,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      AppSpacing.verticalLg,

                      // Primary CTA
                      AppPrimaryButton(
                        text: context.l10n.authLogin,
                        onPressed: _onLogin,
                        isLoading: isLoading,
                        height: 56,
                      ),

                      // Divider
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.xxxl,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: theme.colorScheme.outlineVariant
                                    .withValues(alpha: AppOpacity.ghostBorder),
                              ),
                            ),
                            Padding(
                              padding: AppSpacing.paddingHorizontalLg,
                              child: Text(
                                context.l10n.commonOr.toUpperCase(),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2,
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: theme.colorScheme.outlineVariant
                                    .withValues(alpha: AppOpacity.ghostBorder),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Social login buttons
                      const SocialLoginButtons(),

                      const SizedBox(height: AppSpacing.xxl),

                      // Decorative image card
                      ClipRRect(
                        borderRadius: AppRadius.borderRadiusXl,
                        child: Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerLow,
                            borderRadius: AppRadius.borderRadiusXl,
                            boxShadow:
                                isDark ? AppShadows.mdDark : AppShadows.mdLight,
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Icon(
                                Icons.content_cut,
                                size: 64,
                                color: theme.colorScheme.onSurfaceVariant
                                    .withValues(alpha: 0.08),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: AppSpacing.paddingLg,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        theme.colorScheme.onSurface
                                            .withValues(alpha: 0.6),
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PRECISION GROOMING',
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      AppSpacing.verticalXs,
                                      Text(
                                        'The Editorial Experience.',
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
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

                      const SizedBox(height: AppSpacing.xxxl),

                      // Footer legal text
                      Center(
                        child: Padding(
                          padding: AppSpacing.paddingHorizontalLg,
                          child: Text(
                            'By continuing, you agree to our Terms and Privacy Policy.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.7),
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                        ),
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
