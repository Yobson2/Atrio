import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// A grid widget showing uploaded photos with an add button.
///
/// Displays photos in a horizontal row with rounded corners.
/// Each photo has a small delete button in the corner.
/// The last slot (if not full) shows a dashed border add-photo placeholder.
class PhotoUploadGrid extends StatelessWidget {
  /// Creates a [PhotoUploadGrid].
  const PhotoUploadGrid({
    required this.photos,
    required this.onAddPhoto,
    required this.onRemovePhoto,
    super.key,
    this.maxPhotos = 4,
  });

  /// List of photo URLs or file paths.
  final List<String> photos;

  /// Called when the add-photo button is tapped.
  final VoidCallback onAddPhoto;

  /// Called with the index of the photo to remove.
  final ValueChanged<int> onRemovePhoto;

  /// Maximum number of photos allowed.
  final int maxPhotos;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showAddButton = photos.length < maxPhotos;

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length + (showAddButton ? 1 : 0),
        separatorBuilder: (_, __) => AppSpacing.horizontalSm,
        itemBuilder: (context, index) {
          if (index < photos.length) {
            return _PhotoTile(
              photoPath: photos[index],
              onRemove: () => onRemovePhoto(index),
            );
          }
          return _AddPhotoTile(
            onTap: onAddPhoto,
            color: theme.colorScheme.outline,
          );
        },
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.photoPath,
    required this.onRemove,
  });

  final String photoPath;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: AppRadius.borderRadiusMd,
            child: Container(
              width: 80,
              height: 80,
              color: theme.colorScheme.surfaceContainerHigh,
              child: Icon(
                Icons.image_rounded,
                color: theme.colorScheme.onSurfaceVariant,
                size: 32,
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: theme.colorScheme.error,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: 14,
                  color: theme.colorScheme.onError,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddPhotoTile extends StatelessWidget {
  const _AddPhotoTile({
    required this.onTap,
    required this.color,
  });

  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: color,
          borderRadius: AppRadius.md,
        ),
        child: SizedBox(
          width: 80,
          height: 80,
          child: Icon(
            Icons.add_a_photo_outlined,
            color: color,
            size: 28,
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.borderRadius,
  });

  final Color color;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    const dashWidth = 6.0;
    const dashSpace = 4.0;

    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(
            distance,
            end > metric.length ? metric.length : end,
          ),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      borderRadius != oldDelegate.borderRadius;
}
