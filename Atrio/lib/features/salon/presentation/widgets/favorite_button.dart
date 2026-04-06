import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/features/salon/presentation/providers/favorites_providers.dart';

/// Animated heart toggle button for favoriting a salon.
class FavoriteButton extends ConsumerWidget {
  /// Creates a [FavoriteButton].
  const FavoriteButton({
    required this.salonId,
    super.key,
    this.size = 24,
    this.color,
  });

  /// The salon ID to favorite/unfavorite.
  final String salonId;

  /// Icon size.
  final double size;

  /// Optional override color for the unfilled state.
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesNotifierProvider);
    final isFav = favorites.contains(salonId);

    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(isFav),
          size: size,
          color: isFav ? Colors.red : (color ?? Theme.of(context).iconTheme.color),
        ),
      ),
      onPressed: () async {
        final added =
            await ref.read(favoritesNotifierProvider.notifier).toggle(salonId);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                added ? 'Added to favorites' : 'Removed from favorites',
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
    );
  }
}
