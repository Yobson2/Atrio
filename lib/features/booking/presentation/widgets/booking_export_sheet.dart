import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/data_display/section_label.dart';
import 'package:flutter_templates/core/widgets/data_display/settings_row.dart';

/// Bottom sheet for exporting booking history as PDF or via email.
class BookingExportSheet extends StatefulWidget {
  /// Creates a [BookingExportSheet].
  const BookingExportSheet({super.key});

  /// Shows the [BookingExportSheet] as a modal bottom sheet.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const BookingExportSheet(),
    );
  }

  @override
  State<BookingExportSheet> createState() => _BookingExportSheetState();
}

class _BookingExportSheetState extends State<BookingExportSheet> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppRadius.xl),
          topRight: Radius.circular(AppRadius.xl),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ──
            Row(
              children: [
                Text(
                  context.l10n.bookingExportTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            AppSpacing.verticalXl,

            // ── Format section ──
            SectionLabel(label: context.l10n.bookingExportFormat),
            AppSpacing.verticalMd,
            SettingsRow(
              icon: Icons.picture_as_pdf_outlined,
              label: context.l10n.bookingExportPdf,
              onTap: () => context.showSnackBar(
                'PDF export coming soon',
              ),
            ),
            AppSpacing.verticalSm,
            SettingsRow(
              icon: Icons.email_outlined,
              label: context.l10n.bookingExportEmail,
              onTap: () => context.showSnackBar(
                'Email export coming soon',
              ),
            ),
            AppSpacing.verticalXl,

            // ── Date range section ──
            SectionLabel(label: context.l10n.bookingExportDateRange),
            AppSpacing.verticalMd,
            Row(
              children: [
                Expanded(
                  child: _DatePickerButton(
                    label: _formatDate(_startDate),
                    onTap: () => _pickDate(isStart: true),
                    isDark: isDark,
                  ),
                ),
                AppSpacing.horizontalMd,
                Expanded(
                  child: _DatePickerButton(
                    label: _formatDate(_endDate),
                    onTap: () => _pickDate(isStart: false),
                    isDark: isDark,
                  ),
                ),
              ],
            ),
            AppSpacing.verticalXl,

            // ── Export button ──
            AppPrimaryButton(
              text: context.l10n.bookingExportButton,
              onPressed: () {
                context.showSnackBar('Export feature coming soon');
                Navigator.of(context).pop();
              },
            ),

            // Bottom safe area padding
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }
}

/// Styled date picker trigger button with calendar icon.
class _DatePickerButton extends StatelessWidget {
  const _DatePickerButton({
    required this.label,
    required this.onTap,
    required this.isDark,
  });

  final String label;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHigh,
          borderRadius: AppRadius.borderRadiusMd,
          boxShadow: isDark ? AppShadows.smDark : AppShadows.smLight,
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: theme.colorScheme.primary,
            ),
            AppSpacing.horizontalSm,
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
