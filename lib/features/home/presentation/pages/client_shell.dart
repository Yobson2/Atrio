import 'package:flutter/material.dart';
import 'package:flutter_templates/core/widgets/layout/app_bottom_nav.dart';
import 'package:flutter_templates/core/widgets/layout/app_scaffold.dart';
import 'package:flutter_templates/core/widgets/layout/glassmorphism_bottom_nav.dart';
import 'package:go_router/go_router.dart';

/// Shell wrapper for the client section with 4-tab glassmorphism bottom nav.
///
/// Tabs: Discover | Bookings | Queue | Settings
class ClientShell extends StatelessWidget {
  const ClientShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: navigationShell,
      bottomNavigationBar: GlassmorphismBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: const [
          AppBottomNavItem(
            icon: Icons.explore_outlined,
            activeIcon: Icons.explore,
            label: 'Discover',
          ),
          AppBottomNavItem(
            icon: Icons.calendar_month_outlined,
            activeIcon: Icons.calendar_month,
            label: 'Bookings',
          ),
          AppBottomNavItem(
            icon: Icons.people_outline_rounded,
            activeIcon: Icons.people_rounded,
            label: 'Queue',
          ),
          AppBottomNavItem(
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings,
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
