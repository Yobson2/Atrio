import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/payment_method_card.dart';
import 'package:flutter_templates/core/widgets/states/app_empty_state.dart';
import 'package:flutter_templates/features/profile/domain/entities/payment_method.dart';
import 'package:go_router/go_router.dart';

/// Page displaying the user's saved payment methods.
class PaymentMethodsPage extends StatefulWidget {
  /// Creates a [PaymentMethodsPage].
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  // Mock data
  final List<PaymentMethod> _methods = [
    const PaymentMethod(
      id: '1',
      cardBrand: 'visa',
      last4: '4242',
      expiryMonth: '12',
      expiryYear: '27',
      isDefault: true,
    ),
    const PaymentMethod(
      id: '2',
      cardBrand: 'mastercard',
      last4: '8888',
      expiryMonth: '06',
      expiryYear: '26',
    ),
  ];

  void _setDefault(String id) {
    setState(() {
      for (var i = 0; i < _methods.length; i++) {
        final m = _methods[i];
        _methods[i] = PaymentMethod(
          id: m.id,
          cardBrand: m.cardBrand,
          last4: m.last4,
          expiryMonth: m.expiryMonth,
          expiryYear: m.expiryYear,
          isDefault: m.id == id,
        );
      }
    });
  }

  void _delete(String id) {
    setState(() {
      _methods.removeWhere((m) => m.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.paymentMethodsTitle),
        leading: const BackButton(),
      ),
      body: _methods.isEmpty
          ? AppEmptyState(
              icon: Icons.payment_outlined,
              title: context.l10n.paymentMethodsEmpty,
            )
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.xl),
              itemCount: _methods.length,
              separatorBuilder: (_, __) => AppSpacing.verticalMd,
              itemBuilder: (context, index) {
                final method = _methods[index];
                return PaymentMethodCard(
                  cardBrand: method.cardBrand,
                  last4: method.last4,
                  expiryMonth: method.expiryMonth,
                  expiryYear: method.expiryYear,
                  isDefault: method.isDefault,
                  onSetDefault: () => _setDefault(method.id),
                  onDelete: () => _delete(method.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.push('/client-settings/payment-methods/add-payment'),
        backgroundColor: theme.colorScheme.primary,
        child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
      ),
    );
  }
}
