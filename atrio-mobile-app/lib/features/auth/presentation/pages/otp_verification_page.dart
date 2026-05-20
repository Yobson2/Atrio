import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/providers/storage_providers.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/inputs/app_otp_field.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';
import 'package:flutter_templates/features/auth/presentation/widgets/auth_header.dart';
import 'package:go_router/go_router.dart';

/// OTP verification page — enter the 6-digit code sent to a phone number.
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
    await ref
        .read(authNotifierProvider.notifier)
        .verifyPhoneOtp(phone: widget.phone, code: _otpCode);
  }

  /// Masks the phone number for display (e.g., +1***...0000).
  String get _maskedPhone {
    final phone = widget.phone;
    if (phone.length <= 6) return phone;
    return '${phone.substring(0, 3)}***${phone.substring(phone.length - 4)}';
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
        // Check if this is a new user (no name set) → profile setup
        // or returning user → router redirect handles it
        final localStorage = ref.read(localStorageProvider);
        if (!localStorage.hasCompletedProfileSetup &&
            state.user.name.isEmpty) {
          context.go('/profile-setup');
        } else {
          // Returning user — router redirect will send to correct shell
          context.go('/discover');
        }
      }
    });

    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingHorizontalXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthHeader(
                title: 'Verify Phone',
                subtitle: 'Enter the 6-digit code sent to\n$_maskedPhone',
              ),
              AppOtpField(
                onChanged: (code) => setState(() => _otpCode = code),
                onCompleted: (_) => _onVerify(),
              ),
              AppSpacing.verticalXl,
              AppPrimaryButton(
                text: context.l10n.commonDone,
                onPressed: _onVerify,
                isLoading: isLoading,
              ),
              AppSpacing.verticalLg,
              Center(
                child: TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          ref
                              .read(authNotifierProvider.notifier)
                              .sendOtp(phone: widget.phone);
                          context.showSnackBar(
                            'OTP resent to $_maskedPhone',
                          );
                        },
                  child: Text(context.l10n.authOtpResend),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
