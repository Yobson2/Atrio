import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:flutter_templates/features/onboarding/presentation/widgets/onboarding_step.dart';
import 'package:go_router/go_router.dart';

/// Onboarding page with 3 swipeable steps.
class OnboardingPage extends ConsumerStatefulWidget {
  /// Creates an [OnboardingPage].
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onComplete() async {
    await ref.read(onboardingNotifierProvider.notifier).complete();
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(onboardingNotifierProvider);
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // ── Decorative background blur circles ──
          Positioned(
            top: -96,
            left: -96,
            child: Container(
              width: 384,
              height: 384,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withValues(alpha: 0.05),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: const SizedBox.shrink(),
              ),
            ),
          ),
          Positioned(
            bottom: -192,
            right: -192,
            child: Container(
              width: 512,
              height: 512,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isDark
                        ? AppColors.secondaryDark
                        : AppColors.secondaryLight)
                    .withValues(alpha: 0.05),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: const SizedBox.shrink(),
              ),
            ),
          ),

          // ── Main content ──
          SafeArea(
            child: Column(
              children: [
                // ── Fixed header with Skip button ──
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _onComplete,
                        style: TextButton.styleFrom(
                          foregroundColor: isDark
                              ? AppColors.onSurfaceVariantDark
                              : AppColors.onSurfaceVariantLight,
                          textStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: Text(l10n.commonSkip),
                      ),
                    ],
                  ),
                ),

                // ── Pages ──
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (page) {
                      ref
                          .read(onboardingNotifierProvider.notifier)
                          .setPage(page);
                    },
                    children: [
                      OnboardingStep(
                        icon: Icons.waving_hand,
                        title: l10n.onboardingTitle1,
                        description: l10n.onboardingDesc1,
                      ),
                      OnboardingStep(
                        icon: Icons.folder_open,
                        title: l10n.onboardingTitle2,
                        description: l10n.onboardingDesc2,
                      ),
                      OnboardingStep(
                        icon: Icons.rocket_launch,
                        title: l10n.onboardingTitle3,
                        description: l10n.onboardingDesc3,
                      ),
                    ],
                  ),
                ),

                // ── Fixed footer ──
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Dot indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          final isActive = index == currentPage;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.xs,
                            ),
                            width: isActive ? 32 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? theme.colorScheme.primary
                                  : (isDark
                                      ? AppColors.surfaceContainerHighestDark
                                      : AppColors.surfaceContainerHighestLight),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: AppSpacing.xxxl),

                      // Gradient button
                      AppPrimaryButton(
                        text: currentPage == 2
                            ? l10n.onboardingGetStarted
                            : l10n.commonNext,
                        height: 56,
                        onPressed: () {
                          if (currentPage < 2) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            _onComplete();
                          }
                        },
                      ),
                      AppSpacing.verticalMd,

                      // Step counter text
                      Text(
                        'Step ${currentPage + 1} of 3',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: (isDark
                                  ? AppColors.onSurfaceVariantDark
                                  : AppColors.onSurfaceVariantLight)
                              .withValues(alpha: 0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.paddingOf(context).bottom +
                            AppSpacing.xxl,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
