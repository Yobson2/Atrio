import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Page template for dashboard screens.
///
/// Provides a layout with stat cards at the top and tabbed or
/// sectioned content below.
class DashboardTemplate extends StatelessWidget {
  /// Creates a [DashboardTemplate].
  const DashboardTemplate({
    required this.body,
    super.key,
    this.appBar,
    this.statsRow,
    this.tabs,
    this.tabViews,
    this.floatingActionButton,
    this.padding,
  });

  /// The main content below the stats.
  final Widget body;

  /// Optional app bar.
  final PreferredSizeWidget? appBar;

  /// Optional row of stat cards at the top.
  final Widget? statsRow;

  /// Optional tab bar items.
  final List<Tab>? tabs;

  /// Content for each tab. Must match [tabs] length.
  final List<Widget>? tabViews;

  /// Optional FAB.
  final Widget? floatingActionButton;

  /// Content padding.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final hasTabs = tabs != null && tabViews != null && tabs!.isNotEmpty;

    if (hasTabs) {
      return DefaultTabController(
        length: tabs!.length,
        child: _buildScaffold(context, hasTabs: true),
      );
    }

    return _buildScaffold(context, hasTabs: false);
  }

  Widget _buildScaffold(BuildContext context, {required bool hasTabs}) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: Column(
        children: [
          if (statsRow != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: statsRow,
            ),
          if (hasTabs) ...[
            TabBar(
              tabs: tabs!,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
              indicatorColor: theme.colorScheme.primary,
            ),
            Expanded(
              child: TabBarView(
                children: tabViews!,
              ),
            ),
          ] else
            Expanded(
              child: SingleChildScrollView(
                padding: padding ?? AppSpacing.paddingLg,
                child: body,
              ),
            ),
        ],
      ),
    );
  }
}
