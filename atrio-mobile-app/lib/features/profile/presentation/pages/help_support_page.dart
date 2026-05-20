import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/accordion_tile.dart';
import 'package:flutter_templates/core/widgets/data_display/section_label.dart';
import 'package:flutter_templates/core/widgets/data_display/settings_row.dart';
import 'package:flutter_templates/core/widgets/layout/settings_card_group.dart';

/// Help & Support page with FAQ accordion tiles and contact options.
class HelpSupportPage extends StatelessWidget {
  /// Creates a [HelpSupportPage].
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.helpSupportTitle),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── FAQ Section ──
            SectionLabel(label: context.l10n.helpFaqTitle),
            AppSpacing.verticalMd,
            const AccordionTile(
              question: 'How do I book an appointment?',
              answer:
                  'Browse salons near you, select a service and barber, '
                  'choose an available time slot, and confirm your booking. '
                  'You will receive a confirmation notification once booked.',
            ),
            AppSpacing.verticalSm,
            const AccordionTile(
              question: 'Can I cancel or reschedule?',
              answer:
                  'Yes, you can cancel or reschedule up to 2 hours before '
                  'your appointment. Go to your bookings, select the '
                  'appointment, and choose cancel or reschedule.',
            ),
            AppSpacing.verticalSm,
            const AccordionTile(
              question: 'How does the queue work?',
              answer:
                  'When you join a queue, you are placed in line at the '
                  'salon. You can track your position in real time and '
                  'receive a notification when it is almost your turn.',
            ),
            AppSpacing.verticalSm,
            const AccordionTile(
              question: 'Is my payment information secure?',
              answer:
                  'Absolutely. All payment data is encrypted and processed '
                  'through industry-standard secure payment gateways. '
                  'We never store your card details on our servers.',
            ),
            AppSpacing.verticalXxl,

            // ── Contact Us Section ──
            SectionLabel(label: context.l10n.helpContactUs),
            AppSpacing.verticalMd,
            SettingsCardGroup(
              children: [
                SettingsRow(
                  icon: Icons.email_outlined,
                  label: context.l10n.helpEmail,
                  onTap: () => context.showSnackBar('Email support coming soon'),
                ),
                SettingsRow(
                  icon: Icons.phone_outlined,
                  label: context.l10n.helpPhone,
                  onTap: () => context.showSnackBar('Phone support coming soon'),
                ),
                SettingsRow(
                  icon: Icons.chat_outlined,
                  label: context.l10n.helpChat,
                  onTap: () => context.showSnackBar('Live chat coming soon'),
                ),
              ],
            ),
            AppSpacing.verticalXxl,

            // ── App Version ──
            Center(
              child: Text(
                context.l10n.helpAppVersion,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
