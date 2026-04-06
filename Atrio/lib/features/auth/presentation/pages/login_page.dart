import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_opacity.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/utils/validators.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/inputs/app_otp_field.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';
import 'package:flutter_templates/features/auth/presentation/widgets/auth_header.dart';
import 'package:flutter_templates/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:go_router/go_router.dart';

/// Unified phone auth page — phone input + OTP verification on one screen.
class LoginPage extends ConsumerStatefulWidget {
  /// Creates a [LoginPage].
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isOtpStep = false;
  String _otpCode = '';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _onSendOtp() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.unfocus();
    final success = await ref
        .read(authNotifierProvider.notifier)
        .sendOtp(phone: _phoneController.text.trim());
    if (success && mounted) {
      setState(() => _isOtpStep = true);
    }
  }

  Future<void> _onVerifyOtp() async {
    if (_otpCode.length < 6) return;
    context.unfocus();
    await ref.read(authNotifierProvider.notifier).verifyPhoneOtp(
          phone: _phoneController.text.trim(),
          code: _otpCode,
        );
  }

  void _onBack() {
    setState(() {
      _isOtpStep = false;
      _otpCode = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AuthLoading;
    final l10n = context.l10n;

    ref.listen<AuthState>(authNotifierProvider, (_, state) {
      if (state is AuthError) {
        context.showSnackBar(state.message, isError: true);
      }
      if (state is AuthAuthenticated) {
        context.go('/');
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
                showBackButton: _isOtpStep,
                onBack: _onBack,
              ),
            ),

            // Content with animated transition
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: _isOtpStep
                    ? _OtpStepContent(
                        key: const ValueKey('otp'),
                        phone: _phoneController.text.trim(),
                        otpCode: _otpCode,
                        isLoading: isLoading,
                        onOtpChanged: (code) =>
                            setState(() => _otpCode = code),
                        onVerify: _onVerifyOtp,
                        onResend: _onSendOtp,
                        l10n: l10n,
                      )
                    : _PhoneStepContent(
                        key: const ValueKey('phone'),
                        formKey: _formKey,
                        phoneController: _phoneController,
                        isLoading: isLoading,
                        onContinue: _onSendOtp,
                        l10n: l10n,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Phone Input Step ──────────────────────────────────────────────

class _PhoneStepContent extends StatelessWidget {
  const _PhoneStepContent({
    required this.formKey,
    required this.phoneController,
    required this.isLoading,
    required this.onContinue,
    required this.l10n,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final bool isLoading;
  final VoidCallback onContinue;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: AppSpacing.paddingHorizontalXl,
      child: Form(
        key: formKey,
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
              l10n.authPhoneSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Phone field
            AppTextField(
              controller: phoneController,
              label: l10n.authPhoneLabel,
              hint: l10n.authPhoneHint,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.telephoneNumber],
              validator: Validators.phone,
              prefixIcon: const Icon(Icons.phone_outlined),
              onSubmitted: (_) => onContinue(),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Continue CTA
            AppPrimaryButton(
              text: l10n.authPhoneContinue,
              onPressed: onContinue,
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
                      l10n.commonOr.toUpperCase(),
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

            const SizedBox(height: AppSpacing.xxxl),

            // Footer legal text
            Center(
              child: Padding(
                padding: AppSpacing.paddingHorizontalLg,
                child: Text(
                  l10n.authTerms,
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
    );
  }
}

// ── OTP Verification Step ─────────────────────────────────────────

class _OtpStepContent extends StatelessWidget {
  const _OtpStepContent({
    required this.phone,
    required this.otpCode,
    required this.isLoading,
    required this.onOtpChanged,
    required this.onVerify,
    required this.onResend,
    required this.l10n,
    super.key,
  });

  final String phone;
  final String otpCode;
  final bool isLoading;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onVerify;
  final VoidCallback onResend;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: AppSpacing.paddingHorizontalXl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xxl),

          // Header
          Text(
            l10n.authVerifyTitle,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: theme.colorScheme.primary,
              height: 1.1,
            ),
          ),
          AppSpacing.verticalSm,
          RichText(
            text: TextSpan(
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              children: [
                const TextSpan(
                  text: 'Enter the 6-digit code sent to ',
                ),
                TextSpan(
                  text: phone,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xxxl),

          // OTP input
          Center(
            child: AppOtpField(
              onChanged: onOtpChanged,
              onCompleted: (_) => onVerify(),
            ),
          ),

          const SizedBox(height: AppSpacing.xxxl),

          // Verify button
          AppPrimaryButton(
            text: l10n.commonDone,
            onPressed: onVerify,
            isLoading: isLoading,
            icon: Icons.arrow_forward,
            height: 56,
          ),

          const SizedBox(height: AppSpacing.xl),

          // Resend section
          Center(
            child: Column(
              children: [
                Text(
                  l10n.authOtpDidntReceive,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                AppSpacing.verticalSm,
                TextButton(
                  onPressed: isLoading ? null : onResend,
                  child: Text(
                    l10n.authOtpResendCode,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          AppSpacing.verticalXl,
        ],
      ),
    );
  }
}
