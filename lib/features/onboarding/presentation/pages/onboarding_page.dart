import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _onComplete,
                child: Text(l10n.commonSkip),
              ),
            ),
            // Pages
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  ref.read(onboardingNotifierProvider.notifier).setPage(page);
                },
                children: [
                  OnboardingStep(
                    icon: Icons.content_cut_rounded,
                    title: l10n.onboardingTitle1,
                    description: l10n.onboardingDesc1,
                  ),
                  OnboardingStep(
                    icon: Icons.explore_rounded,
                    title: l10n.onboardingTitle2,
                    description: l10n.onboardingDesc2,
                  ),
                  OnboardingStep(
                    icon: Icons.calendar_month_rounded,
                    title: l10n.onboardingTitle3,
                    description: l10n.onboardingDesc3,
                  ),
                ],
              ),
            ),
            // Dots indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final isActive = index == currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            AppSpacing.verticalXl,
            // Next / Get Started button
            Padding(
              padding: AppSpacing.paddingHorizontalXl,
              child: AppPrimaryButton(
                text: currentPage == 2
                    ? l10n.onboardingGetStarted
                    : l10n.commonNext,
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
            ),
            AppSpacing.verticalXxl,
          ],
        ),
      ),
    );
  }
}
