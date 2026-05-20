import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_shadows.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/pill_chip.dart';

/// Card displaying a saved payment method with brand icon, masked number,
/// expiry, and default/action controls.
class PaymentMethodCard extends StatelessWidget {
  /// Creates a [PaymentMethodCard].
  const PaymentMethodCard({
    required this.cardBrand,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    super.key,
    this.isDefault = false,
    this.onSetDefault,
    this.onDelete,
  });

  /// Card brand identifier (e.g. "visa", "mastercard").
  final String cardBrand;

  /// Last 4 digits of the card number.
  final String last4;

  /// Expiry month.
  final String expiryMonth;

  /// Expiry year.
  final String expiryYear;

  /// Whether this card is the default payment method.
  final bool isDefault;

  /// Called when the user selects "Set as default".
  final VoidCallback? onSetDefault;

  /// Called when the user selects "Delete".
  final VoidCallback? onDelete;

  Color _brandColor() {
    switch (cardBrand.toLowerCase()) {
      case 'visa':
        return const Color(0xFF1A1F71);
      case 'mastercard':
        return const Color(0xFFEB001B);
      default:
        return const Color(0xFF757575);
    }
  }

  String _brandLabel() {
    switch (cardBrand.toLowerCase()) {
      case 'visa':
        return 'Visa';
      case 'mastercard':
        return 'Mastercard';
      default:
        return cardBrand;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: AppRadius.borderRadiusLg,
        boxShadow: isDark ? AppShadows.smDark : AppShadows.smLight,
      ),
      child: Row(
        children: [
          // ── Brand icon ──
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _brandColor().withValues(alpha: 0.1),
              borderRadius: AppRadius.borderRadiusMd,
            ),
            child: Icon(
              Icons.credit_card_rounded,
              color: _brandColor(),
              size: 24,
            ),
          ),
          AppSpacing.horizontalMd,

          // ── Card info ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_brandLabel()} \u2022\u2022\u2022\u2022 $last4',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Expires $expiryMonth/$expiryYear',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // ── Trailing: default chip or popup menu ──
          if (isDefault)
            PillChip(
              label: context.l10n.paymentMethodsDefault,
              isSelected: true,
            )
          else
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              onSelected: (value) {
                if (value == 'default') {
                  onSetDefault?.call();
                } else if (value == 'delete') {
                  onDelete?.call();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'default',
                  child: Text(context.l10n.paymentMethodsSetDefault),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    context.l10n.paymentMethodsDelete,
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
