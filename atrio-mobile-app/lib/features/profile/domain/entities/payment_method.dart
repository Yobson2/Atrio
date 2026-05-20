import 'package:flutter/foundation.dart';

/// A saved payment method entity.
@immutable
class PaymentMethod {
  /// Creates a [PaymentMethod].
  const PaymentMethod({
    required this.id,
    required this.cardBrand,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    this.isDefault = false,
  });

  /// Unique identifier.
  final String id;

  /// Card brand (e.g. "visa", "mastercard").
  final String cardBrand;

  /// Last 4 digits of the card number.
  final String last4;

  /// Expiry month (e.g. "12").
  final String expiryMonth;

  /// Expiry year (e.g. "25").
  final String expiryYear;

  /// Whether this is the default payment method.
  final bool isDefault;
}
