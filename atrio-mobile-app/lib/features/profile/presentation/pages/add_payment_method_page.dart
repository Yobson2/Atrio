import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/buttons/app_primary_button.dart';
import 'package:flutter_templates/core/widgets/inputs/app_text_field.dart';
import 'package:go_router/go_router.dart';

/// Form page for adding a new payment method.
class AddPaymentMethodPage extends StatefulWidget {
  /// Creates an [AddPaymentMethodPage].
  const AddPaymentMethodPage({super.key});

  @override
  State<AddPaymentMethodPage> createState() => _AddPaymentMethodPageState();
}

class _AddPaymentMethodPageState extends State<AddPaymentMethodPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // TODO: Call save payment method use case
    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() => _isLoading = false);
    context.showSnackBar(context.l10n.addPaymentSuccess);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.addPaymentTitle),
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // ── Card number ──
                AppTextField(
                  label: context.l10n.addPaymentCardNumber,
                  hint: '1234 5678 9012 3456',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.credit_card_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.validationRequired;
                    }
                    return null;
                  },
                ),
                AppSpacing.verticalLg,

                // ── Expiry + CVV row ──
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: context.l10n.addPaymentExpiry,
                        hint: 'MM/YY',
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.validationRequired;
                          }
                          return null;
                        },
                      ),
                    ),
                    AppSpacing.horizontalMd,
                    Expanded(
                      child: AppTextField(
                        label: context.l10n.addPaymentCvv,
                        hint: '123',
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.validationRequired;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                AppSpacing.verticalLg,

                // ── Name on card ──
                AppTextField(
                  label: context.l10n.addPaymentNameOnCard,
                  hint: 'John Doe',
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.validationRequired;
                    }
                    return null;
                  },
                ),
                AppSpacing.verticalXxl,

                // ── Save button ──
                AppPrimaryButton(
                  text: context.l10n.addPaymentSave,
                  onPressed: _save,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
