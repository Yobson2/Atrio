import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:go_router/go_router.dart';

/// Owner page: salon settings (visual identity, gallery, contact, hours).
class SalonSettingsPage extends StatelessWidget {
  const SalonSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text('BarberBook'),
        actions: [
          TextButton(onPressed: () => context.showSnackBar('Salon settings coming soon'), child: Text('Salon Settings', style: theme.textTheme.labelMedium?.copyWith(color: AppColors.primaryLight))),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visual identity
            _SectionHeader(icon: Icons.palette_rounded, title: context.l10n.ownerSettingsVisualIdentity),
            AppSpacing.verticalMd,
            _SettingItem(label: context.l10n.ownerSettingsSalonName, value: 'The Artisan Basin'),
            AppSpacing.verticalSm,
            _SettingItem(label: context.l10n.ownerSettingsBrandStatement, value: 'A premium grooming studio dedicated to delivering artisan-level cuts and shaves...'),
            AppSpacing.verticalSm,
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(color: AppColors.surfaceContainerHighLight, borderRadius: BorderRadius.circular(12)),
              child: Icon(Icons.store_rounded, color: AppColors.onSurfaceVariantLight),
            ),
            AppSpacing.verticalXxl,

            // Studio gallery
            _SectionHeader(icon: Icons.photo_library_rounded, title: context.l10n.ownerSettingsStudioGallery),
            AppSpacing.verticalMd,
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, __) => AppSpacing.horizontalSm,
                itemBuilder: (_, i) => Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(color: AppColors.surfaceContainerHighLight, borderRadius: BorderRadius.circular(8)),
                  child: i == 3
                    ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.add_rounded, color: AppColors.primaryLight),
                        Text(context.l10n.ownerSettingsAddPhotos, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.primaryLight)),
                      ])
                    : Icon(Icons.image_rounded, color: AppColors.onSurfaceVariantLight),
                ),
              ),
            ),
            AppSpacing.verticalXxl,

            // Contact details
            _SectionHeader(icon: Icons.contact_phone_rounded, title: context.l10n.ownerSettingsContactDetails),
            AppSpacing.verticalMd,
            _SettingItem(label: 'Phone', value: '+1 (555) 234 8901'),
            AppSpacing.verticalSm,
            _SettingItem(label: 'Email', value: 'hello@artisanbasin.co'),
            AppSpacing.verticalSm,
            _SettingItem(label: 'Address', value: '142 Alderman Lane, Studio 3'),
            AppSpacing.verticalXxl,

            // Opening hours
            _SectionHeader(icon: Icons.schedule_rounded, title: context.l10n.ownerSettingsOpeningHours),
            AppSpacing.verticalMd,
            ...['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'].map(
              (day) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    SizedBox(width: 100, child: Text(day, style: theme.textTheme.bodyMedium)),
                    const Spacer(),
                    Text(
                      day == 'Sunday' ? 'Closed' : day == 'Saturday' ? '10:00 - 18:00' : '09:00 - 21:00',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: day == 'Sunday' ? AppColors.errorLight : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primaryLight),
        AppSpacing.horizontalSm,
        Text(title, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLowest, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.labelSmall?.copyWith(color: AppColors.onSurfaceVariantLight, letterSpacing: 0.5)),
          AppSpacing.verticalXs,
          Text(value, style: theme.textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
