import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/router/route_names.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/theme/locale_provider.dart';
import 'package:flutter_templates/core/theme/theme_provider.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';
import 'package:go_router/go_router.dart';

/// Settings page with tonal section cards, toggle switches,
/// no dividers (spacing only). Editorial Artisan style.
class SettingsPage extends ConsumerWidget {
  /// Creates a [SettingsPage].
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final locale = ref.watch(localeNotifierProvider);
    final l10n = context.l10n;
    final colorScheme = context.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppAppBar(title: l10n.settingsTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xl),

              // Appearance section
              _SectionHeader(title: l10n.settingsAppearance),
              const SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLowest,
                  borderRadius: AppRadius.borderRadiusXl,
                  boxShadow: isDark ? AppShadows.smDark : AppShadows.smLight,
                ),
                child: Column(
                  children: [
                    // Theme mode
                    _SettingsRow(
                      icon: Icons.palette_outlined,
                      label: l10n.settingsTheme,
                      subtitle: _themeLabel(themeMode, l10n),
                      onTap: () => _showThemePicker(context, ref, themeMode),
                    ),
                    // Language
                    _SettingsRow(
                      icon: Icons.language,
                      label: l10n.settingsLanguage,
                      subtitle: _localeLabel(locale, l10n),
                      onTap: () => _showLanguagePicker(context, ref, locale),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // About section
              _SectionHeader(title: l10n.settingsAbout),
              const SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLowest,
                  borderRadius: AppRadius.borderRadiusXl,
                  boxShadow: isDark ? AppShadows.smDark : AppShadows.smLight,
                ),
                child: Column(
                  children: [
                    _SettingsRow(
                      icon: Icons.info_outline,
                      label: l10n.settingsVersion('1.0.0'),
                      showChevron: false,
                    ),
                    _SettingsRow(
                      icon: Icons.description_outlined,
                      label: l10n.settingsTerms,
                      onTap: () => context.push(RouteNames.terms),
                    ),
                    _SettingsRow(
                      icon: Icons.privacy_tip_outlined,
                      label: l10n.settingsPrivacy,
                      onTap: () => context.push(RouteNames.privacy),
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

  String _themeLabel(ThemeMode mode, AppLocalizations l10n) {
    return switch (mode) {
      ThemeMode.light => l10n.settingsThemeLight,
      ThemeMode.dark => l10n.settingsThemeDark,
      ThemeMode.system => l10n.settingsThemeSystem,
    };
  }

  void _showThemePicker(
    BuildContext context,
    WidgetRef ref,
    ThemeMode current,
  ) {
    final l10n = context.l10n;
    final colorScheme = context.colorScheme;

    showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderRadiusXl,
        ),
        title: Text(
          l10n.settingsTheme,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        children: [
          _ThemeOption(
            title: l10n.settingsThemeSystem,
            mode: ThemeMode.system,
            current: current,
            colorScheme: colorScheme,
            onTap: () {
              ref.read(themeModeNotifierProvider.notifier).setThemeMode(
                    ThemeMode.system,
                  );
              Navigator.pop(context);
            },
          ),
          _ThemeOption(
            title: l10n.settingsThemeLight,
            mode: ThemeMode.light,
            current: current,
            colorScheme: colorScheme,
            onTap: () {
              ref.read(themeModeNotifierProvider.notifier).setThemeMode(
                    ThemeMode.light,
                  );
              Navigator.pop(context);
            },
          ),
          _ThemeOption(
            title: l10n.settingsThemeDark,
            mode: ThemeMode.dark,
            current: current,
            colorScheme: colorScheme,
            onTap: () {
              ref.read(themeModeNotifierProvider.notifier).setThemeMode(
                    ThemeMode.dark,
                  );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  String _localeLabel(Locale? locale, AppLocalizations l10n) {
    if (locale == null) return l10n.settingsThemeSystem;
    return switch (locale.languageCode) {
      'fr' => l10n.settingsLanguageFr,
      _ => l10n.settingsLanguageEn,
    };
  }

  void _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    Locale? current,
  ) {
    final l10n = context.l10n;
    final colorScheme = context.colorScheme;

    showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderRadiusXl,
        ),
        title: Text(
          l10n.settingsLanguage,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        children: [
          _LanguageOption(
            title: l10n.settingsLanguageEn,
            code: 'en',
            current: current,
            colorScheme: colorScheme,
            onTap: () {
              ref.read(localeNotifierProvider.notifier).setLocale('en');
              Navigator.pop(context);
            },
          ),
          _LanguageOption(
            title: l10n.settingsLanguageFr,
            code: 'fr',
            current: current,
            colorScheme: colorScheme,
            onTap: () {
              ref.read(localeNotifierProvider.notifier).setLocale('fr');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.title,
    required this.code,
    required this.current,
    required this.colorScheme,
    required this.onTap,
  });

  final String title;
  final String code;
  final Locale? current;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = current?.languageCode == code;

    return SimpleDialogOption(
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.xs,
        ),
        decoration: isSelected
            ? BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: AppRadius.borderRadiusMd,
              )
            : null,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                  color:
                      isSelected ? colorScheme.primary : colorScheme.onSurface,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check,
                color: colorScheme.primary,
                size: 20,
              ),
          ],
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
        title.toUpperCase(),
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

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    this.subtitle,
    this.onTap,
    this.showChevron = true,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.borderRadiusLg,
      child: Padding(
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
              child: Icon(
                icon,
                size: 20,
                color: colorScheme.primary,
              ),
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
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      subtitle!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (showChevron && onTap != null)
              Icon(
                Icons.chevron_right,
                color: colorScheme.outline,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.title,
    required this.mode,
    required this.current,
    required this.colorScheme,
    required this.onTap,
  });

  final String title;
  final ThemeMode mode;
  final ThemeMode current;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = mode == current;

    return SimpleDialogOption(
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.xs,
        ),
        decoration: isSelected
            ? BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: AppRadius.borderRadiusMd,
              )
            : null,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                  color:
                      isSelected ? colorScheme.primary : colorScheme.onSurface,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check,
                color: colorScheme.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
