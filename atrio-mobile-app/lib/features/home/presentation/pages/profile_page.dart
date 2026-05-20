import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_colors.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/theme/theme_provider.dart';
import 'package:flutter_templates/core/widgets/data_display/app_avatar.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';

/// Profile page matching the BarberBook design with avatar, member badge,
/// stats, account settings, and safety options.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

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
          'BarberBook',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Avatar
              AppAvatar(
                imageUrl: user?.avatarUrl,
                name: user?.name ?? 'User',
                radius: 48,
              ),
              AppSpacing.verticalLg,

              // Name
              Text(
                user?.name ?? 'User',
                style: theme.textTheme.headlineSmall,
              ),
              AppSpacing.verticalXs,

              // Email
              Text(
                user?.email ?? '',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceVariantLight,
                ),
              ),
              AppSpacing.verticalSm,

              // Platinum member badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  l10n.profilePlatinumMember,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
              AppSpacing.verticalXl,

              // Stats row
              Row(
                children: [
                  _StatBox(value: '48', label: l10n.profileTotalVisits),
                  AppSpacing.horizontalMd,
                  _StatBox(value: '5', label: l10n.profileUpcoming),
                ],
              ),
              AppSpacing.verticalXxl,

              // Account settings section
              _SectionLabel(label: l10n.profileAccountSettings),
              AppSpacing.verticalMd,
              _SettingRow(
                icon: Icons.person_outline_rounded,
                label: l10n.profileEditProfile,
                onTap: () => context.showSnackBar('Edit profile coming soon'),
              ),
              _SettingRow(
                icon: Icons.lock_outline_rounded,
                label: l10n.profileChangePassword,
                onTap: () => context.showSnackBar('Change password coming soon'),
              ),
              _SettingRow(
                icon: Icons.dark_mode_outlined,
                label: l10n.profileDarkMode,
                trailing: Switch(
                  value: themeMode == ThemeMode.dark,
                  onChanged: (_) {
                    ref.read(themeModeNotifierProvider.notifier).toggle();
                  },
                  activeColor: AppColors.primaryLight,
                ),
              ),
              AppSpacing.verticalXl,

              // Safety & privacy section
              _SectionLabel(label: l10n.profileSafetyPrivacy),
              AppSpacing.verticalMd,
              _SettingRow(
                icon: Icons.logout_rounded,
                label: l10n.profileLogout,
                iconColor: AppColors.errorLight,
                textColor: AppColors.errorLight,
                onTap: () {
                  ref.read(authNotifierProvider.notifier).logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primaryLight.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryLight,
              ),
            ),
            AppSpacing.verticalXs,
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.onSurfaceVariantLight,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.onSurfaceVariantLight,
              letterSpacing: 0.8,
            ),
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    required this.label,
    this.onTap,
    this.trailing,
    this.iconColor,
    this.textColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: iconColor ?? AppColors.onSurfaceVariantLight,
            ),
            AppSpacing.horizontalMd,
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textColor,
                ),
              ),
            ),
            trailing ??
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.onSurfaceVariantLight,
                ),
          ],
        ),
      ),
    );
  }
}
