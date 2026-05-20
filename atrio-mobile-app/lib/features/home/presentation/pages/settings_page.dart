import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/theme/theme_provider.dart';
import 'package:flutter_templates/core/widgets/data_display/app_list_tile.dart';
import 'package:flutter_templates/core/widgets/layout/app_app_bar.dart';

/// Settings page with theme and language options.
class SettingsPage extends ConsumerWidget {
  /// Creates a [SettingsPage].
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppAppBar(title: l10n.settingsTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingLg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appearance section
              Text(
                l10n.settingsAppearance,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
              AppSpacing.verticalMd,
              // Theme mode
              AppListTile(
                leading: const Icon(Icons.palette_outlined),
                title: l10n.settingsTheme,
                subtitle: _themeLabel(themeMode, l10n),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showThemePicker(context, ref, themeMode),
              ),
              AppSpacing.verticalSm,
              // Language
              AppListTile(
                leading: const Icon(Icons.language),
                title: l10n.settingsLanguage,
                subtitle: l10n.settingsLanguageEn,
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showLanguagePicker(context),
              ),
              AppSpacing.verticalXl,
              // About section
              Text(
                l10n.settingsAbout,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
              AppSpacing.verticalMd,
              AppListTile(
                leading: const Icon(Icons.info_outline),
                title: l10n.settingsVersion('1.0.0'),
              ),
              AppSpacing.verticalSm,
              AppListTile(
                leading: const Icon(Icons.description_outlined),
                title: l10n.settingsTerms,
                trailing: const Icon(Icons.chevron_right),
              ),
              AppSpacing.verticalSm,
              AppListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: l10n.settingsPrivacy,
                trailing: const Icon(Icons.chevron_right),
              ),
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
    showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.settingsTheme),
        children: [
          _ThemeOption(
            title: l10n.settingsThemeSystem,
            mode: ThemeMode.system,
            current: current,
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

  void _showLanguagePicker(BuildContext context) {
    final l10n = context.l10n;
    showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.settingsLanguage),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.settingsLanguageEn),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.settingsLanguageFr),
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.title,
    required this.mode,
    required this.current,
    required this.onTap,
  });

  final String title;
  final ThemeMode mode;
  final ThemeMode current;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onTap,
      child: Row(
        children: [
          Expanded(child: Text(title)),
          if (mode == current)
            Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
            ),
        ],
      ),
    );
  }
}
