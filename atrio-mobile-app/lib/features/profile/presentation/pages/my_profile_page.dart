import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/router/route_names.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/theme/theme_provider.dart';
import 'package:flutter_templates/core/widgets/data_display/app_avatar.dart';
import 'package:flutter_templates/core/widgets/data_display/section_label.dart';
import 'package:flutter_templates/core/widgets/data_display/settings_row.dart';
import 'package:flutter_templates/core/widgets/layout/settings_card_group.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';
import 'package:go_router/go_router.dart';

/// Client profile & settings page replacing the PlaceholderPage.
///
/// Matches the `ressources/my_profile` design with hero avatar,
/// stats bento row, grouped settings, and logout.
class MyProfilePage extends ConsumerWidget {
  const MyProfilePage({super.key});

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
              // ── Hero Avatar ──
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: AppShadows.mdLight,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.surface,
                      ),
                      child: AppAvatar(
                        imageUrl: user?.avatarUrl,
                        name: user?.name ?? 'User',
                        radius: 64,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => context.showSnackBar(
                        'Photo upload coming soon',
                      ),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                          boxShadow: AppShadows.smLight,
                        ),
                        child: Icon(
                          Icons.edit_rounded,
                          size: 18,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
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

              // ── Member Badge ──
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  l10n.profilePlatinumMember,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              AppSpacing.verticalXl,

              // ── Stats Bento Row ──
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      value: '48',
                      label: l10n.profileTotalVisits,
                      valueColor: theme.colorScheme.primary,
                    ),
                  ),
                  AppSpacing.horizontalMd,
                  Expanded(
                    child: _StatCard(
                      value: '5',
                      label: l10n.profileUpcoming,
                      valueColor: theme.colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalXxl,

              // ── Account Settings ──
              SectionLabel(label: l10n.profileAccountSettings),
              AppSpacing.verticalMd,
              SettingsCardGroup(
                children: [
                  SettingsRow(
                    icon: Icons.person_outline_rounded,
                    label: l10n.profileEditProfile,
                    onTap: () => context.goNamed(RouteNames.editProfileName),
                  ),
                  SettingsRow(
                    icon: Icons.lock_outline_rounded,
                    label: l10n.profileChangePassword,
                    onTap: () => context.goNamed(RouteNames.changePasswordName),
                  ),
                  SettingsRow(
                    icon: Icons.notifications_outlined,
                    label: l10n.profileNotifications,
                    onTap: () => context.goNamed(RouteNames.notificationsName),
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

              // ── More ──
              SectionLabel(label: l10n.profileSafetyPrivacy),
              AppSpacing.verticalMd,
              SettingsCardGroup(
                children: [
                  SettingsRow(
                    icon: Icons.favorite_outline_rounded,
                    label: l10n.profileFavorites,
                    onTap: () => context.goNamed(RouteNames.favoritesName),
                  ),
                  SettingsRow(
                    icon: Icons.payment_outlined,
                    label: l10n.profilePaymentMethods,
                    onTap: () => context.goNamed(RouteNames.paymentMethodsName),
                  ),
                  SettingsRow(
                    icon: Icons.star_outline_rounded,
                    label: l10n.profileLoyalty,
                    onTap: () => context.goNamed(RouteNames.loyaltyName),
                  ),
                  SettingsRow(
                    icon: Icons.chat_outlined,
                    label: l10n.profileMessages,
                    onTap: () => context.goNamed(RouteNames.conversationsName),
                  ),
                  SettingsRow(
                    icon: Icons.help_outline_rounded,
                    label: l10n.profileHelpSupport,
                    onTap: () => context.goNamed(RouteNames.helpSupportName),
                  ),
                ],
              ),
              AppSpacing.verticalXl,

              // ── Logout ──
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

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.smLight,
      ),
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: valueColor,
            ),
          ),
          AppSpacing.verticalXs,
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
