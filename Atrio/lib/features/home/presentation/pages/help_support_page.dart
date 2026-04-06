import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';
import 'package:flutter_templates/core/widgets/layout/app_expandable_section.dart';

/// Help & Support page with FAQ and contact information.
class HelpSupportPage extends StatelessWidget {
  /// Creates a [HelpSupportPage].
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const AppAppBar(title: 'Help & Support'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xl),

              // FAQ Section
              _SectionHeader(title: 'FREQUENTLY ASKED QUESTIONS'),
              const SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLowest,
                  borderRadius: AppRadius.borderRadiusXl,
                  boxShadow: isDark ? AppShadows.smDark : AppShadows.smLight,
                ),
                child: const Column(
                  children: [
                    AppExpandableSection(
                      title: 'How do I book an appointment?',
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: AppSpacing.lg,
                          right: AppSpacing.lg,
                          bottom: AppSpacing.lg,
                        ),
                        child: Text(
                          'Browse salons from the Discover tab, select a salon, '
                          'choose your service and preferred time slot, then '
                          'confirm your booking.',
                        ),
                      ),
                    ),
                    AppExpandableSection(
                      title: 'Can I cancel a booking?',
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: AppSpacing.lg,
                          right: AppSpacing.lg,
                          bottom: AppSpacing.lg,
                        ),
                        child: Text(
                          'Yes, you can cancel a booking from the My Bookings '
                          'tab. Open the booking details and tap "Cancel Booking". '
                          'Please note that cancellation policies may vary by salon.',
                        ),
                      ),
                    ),
                    AppExpandableSection(
                      title: 'How does the queue system work?',
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: AppSpacing.lg,
                          right: AppSpacing.lg,
                          bottom: AppSpacing.lg,
                        ),
                        child: Text(
                          'Some salons offer a virtual queue for walk-in customers. '
                          'Join the queue from the salon page and track your position '
                          'in real time. You will be notified when it is your turn.',
                        ),
                      ),
                    ),
                    AppExpandableSection(
                      title: 'How do I change my account details?',
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: AppSpacing.lg,
                          right: AppSpacing.lg,
                          bottom: AppSpacing.lg,
                        ),
                        child: Text(
                          'Go to your Profile tab and tap "Edit Profile" to update '
                          'your name, email, phone, or profile photo.',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Contact Section
              _SectionHeader(title: 'CONTACT US'),
              const SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLowest,
                  borderRadius: AppRadius.borderRadiusXl,
                  boxShadow: isDark ? AppShadows.smDark : AppShadows.smLight,
                ),
                child: Column(
                  children: [
                    _ContactRow(
                      icon: Icons.email_outlined,
                      label: 'Email Support',
                      subtitle: 'support@atrio.app',
                      colorScheme: colorScheme,
                    ),
                    _ContactRow(
                      icon: Icons.chat_outlined,
                      label: 'Live Chat',
                      subtitle: 'Available 9am - 6pm',
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.xxs),
      child: Text(
        title,
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.colorScheme,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lgx),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: AppRadius.borderRadiusMd,
            ),
            child: Icon(icon, size: 20, color: colorScheme.primary),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
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
