import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
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

    ref.listen<AuthState>(authNotifierProvider, (_, state) {
      if (state is AuthError) {
        context.showSnackBar(state.message, isError: true);
      }
      if (state is AuthAuthenticated) {
        context.go('/home');
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingHorizontalXl,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  title: 'Welcome to\nBarberBook',
                  subtitle: context.l10n.authLoginSubtitle,
                ),
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
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _onLogin(),
                ),
                AppSpacing.verticalSm,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push('/forgot-password'),
                    child: Text(context.l10n.authForgotPassword),
                  ),
                ),
                AppSpacing.verticalLg,
                AppPrimaryButton(
                  text: context.l10n.authLogin,
                  onPressed: _onLogin,
                  isLoading: isLoading,
                ),
                AppSpacing.verticalXl,
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: AppSpacing.paddingHorizontalLg,
                      child: Text(
                        context.l10n.commonOr,
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                AppSpacing.verticalXl,
                const SocialLoginButtons(),
                AppSpacing.verticalXl,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.l10n.authNoAccount),
                    TextButton(
                      onPressed: () => context.push('/register'),
                      child: Text(context.l10n.authRegister),
                    ),
                  ],
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
