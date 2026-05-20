import 'package:flutter/material.dart';
import 'package:flutter_templates/core/widgets/layout/app_bottom_nav.dart';
import 'package:flutter_templates/core/widgets/layout/app_scaffold.dart';
import 'package:flutter_templates/core/widgets/layout/glassmorphism_bottom_nav.dart';
import 'package:go_router/go_router.dart';

/// Shell wrapper for the salon owner section with 4-tab glassmorphism bottom nav.
///
/// Tabs: Dashboard | Bookings | Statistics | Settings
class OwnerShell extends StatelessWidget {
  const OwnerShell({required this.navigationShell, super.key});

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
            icon: Icons.dashboard_outlined,
            activeIcon: Icons.dashboard,
            label: 'Dashboard',
          ),
          AppBottomNavItem(
            icon: Icons.calendar_month_outlined,
            activeIcon: Icons.calendar_month,
            label: 'Bookings',
          ),
          AppBottomNavItem(
            icon: Icons.bar_chart_outlined,
            activeIcon: Icons.bar_chart_rounded,
            label: 'Statistics',
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
