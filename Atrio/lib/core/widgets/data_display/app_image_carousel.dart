import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_durations.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer.dart';

/// Image carousel with PageView and dot indicator.
///
/// Displays a swipeable set of network images with a page indicator.
class AppImageCarousel extends StatefulWidget {
  /// Creates an [AppImageCarousel].
  const AppImageCarousel({
    required this.imageUrls,
    super.key,
    this.height = 250,
    this.borderRadius,
    this.onTap,
    this.fit = BoxFit.cover,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 5),
  });

  /// List of image URLs to display.
  final List<String> imageUrls;

  /// Height of the carousel.
  final double height;

  /// Border radius for the carousel container.
  final BorderRadius? borderRadius;

  /// Callback when an image is tapped. Receives the index.
  final ValueChanged<int>? onTap;

  /// How images are fitted.
  final BoxFit fit;

  /// Whether to auto-advance pages.
  final bool autoPlay;

  /// Interval between auto-advance.
  final Duration autoPlayInterval;

  @override
  State<AppImageCarousel> createState() => _AppImageCarouselState();
}

class _AppImageCarouselState extends State<AppImageCarousel> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = widget.borderRadius ?? AppRadius.borderRadiusMd;

    if (widget.imageUrls.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: const Center(child: Icon(Icons.image_outlined, size: 48)),
      );
    }

    return Semantics(
      label: 'Image gallery, ${widget.imageUrls.length} images',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: radius,
            child: SizedBox(
              height: widget.height,
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.imageUrls.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: widget.onTap != null
                        ? () => widget.onTap!(index)
                        : null,
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrls[index],
                      fit: widget.fit,
                      width: double.infinity,
                      placeholder: (context, url) => AppShimmer(
                        height: widget.height,
                      ),
                      errorWidget: (context, url, error) => ColoredBox(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: 48,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (widget.imageUrls.length > 1) ...[
            AppSpacing.verticalSm,
            _DotIndicator(
              count: widget.imageUrls.length,
              current: _currentPage,
              activeColor: theme.colorScheme.primary,
              inactiveColor: theme.colorScheme.outlineVariant,
            ),
          ],
        ],
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({
    required this.count,
    required this.current,
    required this.activeColor,
    required this.inactiveColor,
  });

  final int count;
  final int current;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == current;
        return AnimatedContainer(
          duration: AppDurations.fast,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: AppRadius.borderRadiusFull,
          ),
        );
      }),
    );
  }
}
