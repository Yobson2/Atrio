import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/widgets/layout/app_bottom_nav.dart';
import 'package:flutter_templates/core/widgets/layout/app_scaffold.dart';
import 'package:flutter_templates/features/auth/domain/entities/user_role.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';
import 'package:go_router/go_router.dart';

/// Shell wrapper with role-aware bottom navigation.
///
/// Clients see: Discover / Bookings / Profile / Settings
/// Owners see: Dashboard / Queue / Profile / Settings
///
/// Uses glassmorphic [AppBottomNav] with extendBody: true
/// so content scrolls behind the translucent nav bar.
class HomeShell extends ConsumerWidget {
  /// Creates a [HomeShell].
  const HomeShell({required this.navigationShell, super.key});

  /// GoRouter navigation shell for managing nested routes.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isOwner =
        authState is AuthAuthenticated && authState.user.role == UserRole.owner;
    final l10n = context.l10n;

    return AppScaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: AppBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: isOwner ? _ownerItems(l10n) : _clientItems(l10n),
      ),
    );
  }

  List<AppBottomNavItem> _clientItems(dynamic l10n) {
    return [
      const AppBottomNavItem(
        icon: Icons.search_outlined,
        activeIcon: Icons.search,
        label: 'Discover',
      ),
      const AppBottomNavItem(
        icon: Icons.calendar_today_outlined,
        activeIcon: Icons.calendar_today,
        label: 'Bookings',
      ),
      AppBottomNavItem(
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: l10n.profileTitle as String,
      ),
      AppBottomNavItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings,
        label: l10n.settingsTitle as String,
      ),
    ];
  }

  List<AppBottomNavItem> _ownerItems(dynamic l10n) {
    return [
      const AppBottomNavItem(
        icon: Icons.dashboard_outlined,
        activeIcon: Icons.dashboard,
        label: 'Dashboard',
      ),
      const AppBottomNavItem(
        icon: Icons.queue_outlined,
        activeIcon: Icons.queue,
        label: 'Queue',
      ),
      AppBottomNavItem(
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: l10n.profileTitle as String,
      ),
      AppBottomNavItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings,
        label: l10n.settingsTitle as String,
      ),
    ];
  }
}
