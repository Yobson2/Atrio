import 'package:flutter/material.dart';
import 'package:flutter_templates/core/widgets/layout/responsive_builder.dart';

/// Adaptive grid layout that adjusts columns and gutters
/// based on the current breakpoint.
class AppGrid extends StatelessWidget {
  /// Creates an [AppGrid].
  const AppGrid({
    required this.children,
    super.key,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.spacing,
    this.runSpacing,
    this.childAspectRatio = 1.0,
    this.shrinkWrap = true,
    this.physics = const NeverScrollableScrollPhysics(),
    this.padding,
  });

  /// Grid children.
  final List<Widget> children;

  /// Columns on mobile. Defaults to [Breakpoints.mobileColumns].
  final int? mobileColumns;

  /// Columns on tablet. Defaults to [Breakpoints.tabletColumns].
  final int? tabletColumns;

  /// Columns on desktop. Defaults to [Breakpoints.desktopColumns].
  final int? desktopColumns;

  /// Space between items horizontally. Auto-resolves per breakpoint if null.
  final double? spacing;

  /// Space between items vertically. Defaults to [spacing].
  final double? runSpacing;

  /// Aspect ratio of each grid cell.
  final double childAspectRatio;

  /// Whether the grid should shrink-wrap its content.
  final bool shrinkWrap;

  /// Scroll physics.
  final ScrollPhysics? physics;

  /// Padding around the grid.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveBuilder.responsiveValue<int>(
      context,
      mobile: mobileColumns ?? 2,
      tablet: tabletColumns ?? 3,
      desktop: desktopColumns ?? 4,
    );

    final gutter = spacing ??
        ResponsiveBuilder.responsiveValue<double>(
          context,
          mobile: Breakpoints.gutterMobile,
          tablet: Breakpoints.gutterTablet,
          desktop: Breakpoints.gutterDesktop,
        );

    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: runSpacing ?? gutter,
        crossAxisSpacing: gutter,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
