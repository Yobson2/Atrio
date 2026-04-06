import 'package:flutter/material.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer.dart';

/// Skeleton placeholder shaped like a circular avatar.
class AppSkeletonAvatar extends StatelessWidget {
  /// Creates an [AppSkeletonAvatar].
  const AppSkeletonAvatar({
    super.key,
    this.radius = 24,
  });

  /// Radius of the avatar circle.
  final double radius;

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      width: radius * 2,
      height: radius * 2,
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
