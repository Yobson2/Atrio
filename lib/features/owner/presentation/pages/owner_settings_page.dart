import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/router/route_names.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/theme/theme_provider.dart';
import 'package:flutter_templates/core/widgets/data_display/app_avatar.dart';
import 'package:flutter_templates/core/widgets/data_display/section_label.dart';
import 'package:flutter_templates/core/widgets/data_display/settings_row.dart';
import 'package:flutter_templates/core/widgets/layout/settings_card_group.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';
import 'package:go_router/go_router.dart';

/// Owner settings hub page replacing the PlaceholderPage.
///
/// Provides navigation to salon management (salon settings, barbers,
/// services, queue), account settings, and logout.
class OwnerSettingsPage extends ConsumerWidget {
  const OwnerSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final themeMode = ref.watch(themeModeNotifierProvider);
    final l10n = context.l10n;
    final theme = Theme.of(context);

    final user = switch (authState) {
      AuthAuthenticated(:final user) => user,
      _ => null,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Atrio',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // ── Avatar ──
              AppAvatar(
                imageUrl: user?.avatarUrl,
                name: user?.name ?? 'User',
                radius: 48,
              ),
              AppSpacing.verticalLg,

              // ── Name & Email ──
              Text(
                user?.name ?? 'User',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              AppSpacing.verticalXs,
              Text(
                user?.email ?? '',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              AppSpacing.verticalSm,

              // ── Role Badge ──
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  l10n.ownerSettingsSalonOwner,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.tertiary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              AppSpacing.verticalXxl,

              // ── Salon Management ──
              SectionLabel(label: l10n.ownerSettingsSalonManagement),
              AppSpacing.verticalMd,
              SettingsCardGroup(
                children: [
                  SettingsRow(
                    icon: Icons.store_rounded,
                    label: l10n.ownerSettingsSalonSettings,
                    onTap: () =>
                        context.goNamed(RouteNames.salonSettingsName),
                  ),
                  SettingsRow(
                    icon: Icons.people_outline_rounded,
                    label: l10n.ownerSettingsManageBarbers,
                    onTap: () =>
                        context.goNamed(RouteNames.manageBarbersName),
                  ),
                  SettingsRow(
                    icon: Icons.content_cut_rounded,
                    label: l10n.ownerSettingsManageServices,
                    onTap: () =>
                        context.goNamed(RouteNames.manageServicesName),
                  ),
                  SettingsRow(
                    icon: Icons.queue_rounded,
                    label: l10n.ownerSettingsQueueManagement,
                    onTap: () =>
                        context.goNamed(RouteNames.queueManagementName),
                  ),
                ],
              ),
              AppSpacing.verticalXl,

              // ── Account ──
              SectionLabel(label: l10n.profileAccountSettings),
              AppSpacing.verticalMd,
              SettingsCardGroup(
                children: [
                  SettingsRow(
                    icon: Icons.person_outline_rounded,
                    label: l10n.profileEditProfile,
                    onTap: () => context.showSnackBar('Edit profile coming soon'),
                  ),
                  SettingsRow(
                    icon: Icons.lock_outline_rounded,
                    label: l10n.profileChangePassword,
                    onTap: () => context.showSnackBar('Change password coming soon'),
                  ),
                  SettingsRow(
                    icon: Icons.dark_mode_outlined,
                    label: l10n.profileDarkMode,
                    trailing: Switch(
                      value: themeMode == ThemeMode.dark,
                      onChanged: (_) {
                        ref
                            .read(themeModeNotifierProvider.notifier)
                            .toggle();
                      },
                      activeColor: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalXl,

              // ── Safety & Privacy ──
              SectionLabel(label: l10n.profileSafetyPrivacy),
              AppSpacing.verticalMd,
              SettingsCardGroup(
                children: [
                  SettingsRow(
                    icon: Icons.logout_rounded,
                    label: l10n.profileLogout,
                    isDestructive: true,
                    onTap: () {
                      ref.read(authNotifierProvider.notifier).logout();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
