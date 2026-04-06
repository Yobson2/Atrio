import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/router/route_names.dart';
import 'package:flutter_templates/core/theme/app_opacity.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/features/auth/domain/entities/user_role.dart';
import 'package:flutter_templates/features/auth/presentation/widgets/auth_header.dart';
import 'package:go_router/go_router.dart';

/// Full-page role selection screen (Client vs Salon Owner).
///
/// Shown after registration to let the user choose their experience.
/// Navigates to the profile setup page with the selected [UserRole].
class ChooseRolePage extends ConsumerStatefulWidget {
  /// Creates a [ChooseRolePage].
  const ChooseRolePage({super.key});

  @override
  ConsumerState<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends ConsumerState<ChooseRolePage> {
  UserRole? _selectedRole;

  void _onComplete() {
    if (_selectedRole == null) return;
    context.push(RouteNames.profileSetup, extra: _selectedRole);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AuthBackground(
        child: Column(
          children: [
            // Glassmorphic top bar
            SafeArea(
              bottom: false,
              child: AuthTopBar(
                showBackButton: true,
                onBack: () => Navigator.of(context).maybePop(),
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.paddingHorizontalXl,
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.xl),

                    // Editorial header
                    Text(
                      context.l10n.chooseRoleTitle,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    AppSpacing.verticalSm,
                    Text(
                      context.l10n.chooseRoleSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppSpacing.xxxl),

                    // Role cards
                    _RoleCard(
                      icon: Icons.person_outlined,
                      title: context.l10n.roleClient,
                      description: context.l10n.roleClientDescription,
                      isSelected: _selectedRole == UserRole.client,
                      onTap: () =>
                          setState(() => _selectedRole = UserRole.client),
                    ),
                    AppSpacing.verticalLg,
                    _RoleCard(
                      icon: Icons.storefront_outlined,
                      title: context.l10n.roleSalonOwner,
                      description: context.l10n.roleSalonOwnerDescription,
                      isSelected: _selectedRole == UserRole.owner,
                      onTap: () =>
                          setState(() => _selectedRole = UserRole.owner),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // Decorative image strip
                    ClipRRect(
                      borderRadius: AppRadius.borderRadiusXl,
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerLow,
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Icon(
                              Icons.content_cut,
                              size: 48,
                              color: theme.colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.1),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      theme.colorScheme.surface,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // CTA button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: _selectedRole != null
                              ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    theme.colorScheme.primary,
                                    theme.colorScheme.primaryContainer,
                                  ],
                                )
                              : null,
                          color: _selectedRole == null
                              ? theme.colorScheme.primary.withValues(alpha: 0.4)
                              : null,
                          borderRadius: AppRadius.borderRadiusMd,
                          boxShadow: _selectedRole != null
                              ? [
                                  BoxShadow(
                                    color: theme.colorScheme.primary
                                        .withValues(alpha: 0.2),
                                    blurRadius: 32,
                                    offset: const Offset(0, 12),
                                  ),
                                ]
                              : null,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _selectedRole != null ? _onComplete : null,
                            borderRadius: AppRadius.borderRadiusMd,
                            child: Center(
                              child: Text(
                                context.l10n.chooseRoleComplete,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    AppSpacing.verticalLg,

                    // Help link
                    TextButton(
                      onPressed: () =>
                          context.push(RouteNames.helpSupport),
                      child: Text(
                        context.l10n.chooseRoleHelp,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // Footer
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppSpacing.xl,
                        bottom: AppSpacing.xl,
                      ),
                      child: Text(
                        'The Editorial Artisan Experience',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.outlineVariant,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
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

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xxl),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: AppRadius.borderRadiusXl,
          border: Border.all(
            color: isSelected
                ? primaryColor
                : theme.colorScheme.outlineVariant
                    .withValues(alpha: AppOpacity.ghostBorder),
            width: 2,
          ),
          boxShadow: isDark ? AppShadows.lgDark : AppShadows.lgLight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: AppSpacing.paddingLg,
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor.withValues(alpha: 0.1)
                    : theme.colorScheme.surfaceContainerLow,
                borderRadius: AppRadius.borderRadiusMd,
              ),
              child: Icon(
                icon,
                size: 36,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Title + checkmark row
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 14,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
              ],
            ),
            AppSpacing.verticalSm,

            // Description
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
