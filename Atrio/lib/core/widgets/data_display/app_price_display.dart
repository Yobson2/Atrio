import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';

/// Formatted price display with optional original price and "From" prefix.
///
/// Handles currency formatting, strikethrough for discounts,
/// and "from" prefix for variable pricing.
class AppPriceDisplay extends StatelessWidget {
  /// Creates an [AppPriceDisplay].
  const AppPriceDisplay({
    required this.price,
    super.key,
    this.originalPrice,
    this.currency = r'$',
    this.showFrom = false,
    this.style,
    this.originalPriceStyle,
  });

  /// Current price value.
  final double price;

  /// Original price before discount. Shows strikethrough when set.
  final double? originalPrice;

  /// Currency symbol.
  final String currency;

  /// Whether to show "From" prefix.
  final bool showFrom;

  /// Text style for the current price.
  final TextStyle? style;

  /// Text style for the original (crossed-out) price.
  final TextStyle? originalPriceStyle;

  String _formatPrice(double value) => '$currency${value.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priceStyle = style ??
        theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.primary,
        );
    final crossedStyle = originalPriceStyle ??
        theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          decoration: TextDecoration.lineThrough,
        );

    return Semantics(
      label: _buildSemanticLabel(),
      child: ExcludeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            if (showFrom)
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.xs),
                child: Text(
                  'From',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            Text(_formatPrice(price), style: priceStyle),
            if (originalPrice != null && originalPrice! > price) ...[
              AppSpacing.horizontalXs,
              Text(_formatPrice(originalPrice!), style: crossedStyle),
            ],
          ],
        ),
      ),
    );
  }

  String _buildSemanticLabel() {
    final buffer = StringBuffer();
    if (showFrom) buffer.write('From ');
    buffer.write(_formatPrice(price));
    if (originalPrice != null && originalPrice! > price) {
      buffer.write(', was ${_formatPrice(originalPrice!)}');
    }
    return buffer.toString();
  }
}
