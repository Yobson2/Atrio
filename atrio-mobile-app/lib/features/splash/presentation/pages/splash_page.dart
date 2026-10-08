import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/splash/presentation/providers/splash_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// Splash page — Portal A mark + wordmark on the brand teal gradient.
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashInitProvider, (_, next) {
      if (!context.mounted) return;
      switch (next) {
        case AsyncData(:final value):
          if (value != SplashResult.onboarding) {
            ref.read(authNotifierProvider.notifier).checkAuthStatus();
          }
          switch (value) {
            case SplashResult.onboarding:
              context.go('/onboarding');
            case SplashResult.authenticated:
              context.go('/discover');
            case SplashResult.unauthenticated:
              context.go('/login');
          }
        case AsyncError():
          context.go('/login');
        case _:
          break;
      }
    });

    // Same size and position as the native splash image, so the hand-off
    // from the OS launch screen is seamless.
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryLight, AppColors.primaryContainerLight],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo_mark_white.svg',
                    width: 112,
                    height: 112,
                    semanticsLabel: 'Atrio',
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'atrio',
                    style: GoogleFonts.inter(
                      fontSize: 44,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.035 * 44,
                      height: 1,
                      color: AppColors.onPrimaryLight,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 56,
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.onPrimaryLight.withValues(alpha: 0.6),
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
