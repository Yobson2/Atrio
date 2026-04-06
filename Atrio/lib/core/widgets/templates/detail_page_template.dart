import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Page template for detail screens with hero image.
///
/// Provides a scrollable layout with a hero image at the top,
/// overlapping content card, and an optional sticky bottom CTA.
class DetailPageTemplate extends StatelessWidget {
  /// Creates a [DetailPageTemplate].
  const DetailPageTemplate({
    required this.body,
    super.key,
    this.heroImage,
    this.heroHeight = 280,
    this.appBar,
    this.bottomBar,
    this.overlapOffset = 24,
    this.backgroundColor,
  });

  /// The main content below the hero image.
  final Widget body;

  /// Hero image widget at the top.
  final Widget? heroImage;

  /// Height of the hero image area.
  final double heroHeight;

  /// Optional app bar (displayed over the hero).
  final PreferredSizeWidget? appBar;

  /// Optional sticky bottom action bar.
  final Widget? bottomBar;

  /// How much the body overlaps the hero image.
  final double overlapOffset;

  /// Background color. Defaults to scaffold background.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bg,
      extendBodyBehindAppBar: heroImage != null,
      appBar: appBar,
      body: CustomScrollView(
        slivers: [
          if (heroImage != null)
            SliverToBoxAdapter(
              child: SizedBox(
                height: heroHeight,
                width: double.infinity,
                child: heroImage,
              ),
            ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset:
                  heroImage != null ? Offset(0, -overlapOffset) : Offset.zero,
              child: Container(
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: heroImage != null
                      ? const BorderRadius.vertical(
                          top: Radius.circular(AppRadius.xl),
                        )
                      : null,
                ),
                padding: AppSpacing.paddingLg,
                child: body,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomBar != null
          ? SafeArea(
              child: Padding(
                padding: AppSpacing.paddingLg,
                child: bottomBar,
              ),
            )
          : null,
    );
  }
}
