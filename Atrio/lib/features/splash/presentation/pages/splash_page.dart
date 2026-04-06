import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_gradients.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/splash/presentation/providers/splash_provider.dart';
import 'package:go_router/go_router.dart';

/// Splash page shown at app launch.
///
/// Runs init checks and navigates to the appropriate screen.
class SplashPage extends ConsumerWidget {
  /// Creates a [SplashPage].
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    ref.listen(splashInitProvider, (_, next) {
      if (!context.mounted) return;
      switch (next) {
        case AsyncData(:final value):
          // Hydrate auth state for router guards (safe here — widget layer,
          // not inside a provider build). Fire-and-forget is fine because
          // the router redirect already allows AuthInitial/AuthLoading.
          if (value != SplashResult.onboarding) {
            ref.read(authNotifierProvider.notifier).checkAuthStatus();
          }
          switch (value) {
            case SplashResult.onboarding:
              context.go('/onboarding');
            case SplashResult.authenticated:
              // Router redirect will send owners to /owner, clients to /discover
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

    final gradient =
        isDark ? AppGradients.primaryDark : AppGradients.primaryLight;
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      body: Stack(
        children: [
          // ── Decorative background blur circles ──
          Positioned(
            top: -MediaQuery.sizeOf(context).height * 0.1,
            right: -MediaQuery.sizeOf(context).width * 0.1,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isDark
                        ? AppColors.secondaryContainerDark
                        : AppColors.secondaryContainerLight)
                    .withValues(alpha: 0.1),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: const SizedBox.shrink(),
              ),
            ),
          ),
          Positioned(
            bottom: -MediaQuery.sizeOf(context).height * 0.05,
            left: -MediaQuery.sizeOf(context).width * 0.1,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isDark
                        ? AppColors.primaryContainerDark
                        : AppColors.primaryContainerLight)
                    .withValues(alpha: 0.05),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                child: const SizedBox.shrink(),
              ),
            ),
          ),

          // ── Centered content ──
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gradient icon container
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: isDark ? AppShadows.lgDark : AppShadows.lgLight,
                  ),
                  child: Icon(
                    Icons.content_cut,
                    size: 48,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                AppSpacing.verticalXxl,
                // Subtle spinner with primary color tint
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: primaryColor,
                    backgroundColor: primaryColor.withValues(alpha: 0.2),
                  ),
                ),
                AppSpacing.verticalLg,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
