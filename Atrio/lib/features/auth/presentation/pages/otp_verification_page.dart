import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_opacity.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/inputs/app_otp_field.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';
import 'package:flutter_templates/features/auth/presentation/widgets/auth_header.dart';
import 'package:go_router/go_router.dart';

/// OTP verification page -- enter the 6-digit code sent to a phone number.
///
/// This page is kept as a deep-link / fallback target. The primary OTP flow
/// is handled inline within [LoginPage].
class OtpVerificationPage extends ConsumerStatefulWidget {
  /// Creates an [OtpVerificationPage].
  const OtpVerificationPage({required this.phone, super.key});

  /// Phone number the OTP was sent to.
  final String phone;

  @override
  ConsumerState<OtpVerificationPage> createState() =>
      _OtpVerificationPageState();
}

class _OtpVerificationPageState extends ConsumerState<OtpVerificationPage> {
  String _otpCode = '';

  Future<void> _onVerify() async {
    if (_otpCode.length < 6) return;
    context.unfocus();
    await ref.read(authNotifierProvider.notifier).verifyPhoneOtp(
          phone: widget.phone,
          code: _otpCode,
        );
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
        context.go('/');
      }
    });

    return Scaffold(
      body: AuthBackground(
        child: Column(
          children: [
            // Glassmorphic top bar with scissors icon and brand
            const SafeArea(
              bottom: false,
              child: AuthTopBar(),
            ),

            // Scrollable content
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: AppSpacing.paddingHorizontalXl,
                  child: Column(
                    children: [
                      // Main card container
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.xxl),
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
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Decorative blur circle
                            Positioned(
                              top: -48,
                              right: -48,
                              child: Container(
                                width: 128,
                                height: 128,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary
                                      .withValues(alpha: 0.05),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),

                            // Content
                            Column(
                              children: [
                                // Header
                                Text(
                                  context.l10n.authVerifyTitle,
                                  style:
                                      theme.textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.3,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                AppSpacing.verticalSm,
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                      height: 1.5,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text:
                                            'Enter the 6-digit code sent to ',
                                      ),
                                      TextSpan(
                                        text: widget.phone,
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
                                AppOtpField(
                                  onChanged: (code) =>
                                      setState(() => _otpCode = code),
                                  onCompleted: (_) => _onVerify(),
                                ),

                                const SizedBox(height: AppSpacing.xxxl),

                                // Done button
                                AppPrimaryButton(
                                  text: context.l10n.commonDone,
                                  onPressed: _onVerify,
                                  isLoading: isLoading,
                                  icon: Icons.arrow_forward,
                                  height: 56,
                                ),

                                const SizedBox(height: AppSpacing.xl),

                                // Resend section
                                Text(
                                  context.l10n.authOtpDidntReceive,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                AppSpacing.verticalSm,
                                TextButton(
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          ref
                                              .read(
                                                authNotifierProvider.notifier,
                                              )
                                              .sendOtp(
                                                phone: widget.phone,
                                              );
                                          context.showSnackBar(
                                            'OTP resent to ${widget.phone}',
                                          );
                                        },
                                  child: Text(
                                    context.l10n.authOtpResendCode,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.xxxl),

                      // Footer
                      Text(
                        '\u00a9 2024 Atrio Precision Grooming',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.6),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
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
