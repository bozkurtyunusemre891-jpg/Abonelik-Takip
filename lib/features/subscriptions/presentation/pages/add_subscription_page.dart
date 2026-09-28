import 'package:abonelik_takip/core/constants/categories.dart';
import 'package:abonelik_takip/core/constants/currencies.dart';
import 'package:abonelik_takip/features/subscriptions/domain/models/subscription.dart';
import 'package:abonelik_takip/features/subscriptions/presentation/providers/subscription_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class AddSubscriptionPage extends ConsumerStatefulWidget {
  const AddSubscriptionPage({super.key});

  @override
  ConsumerState<AddSubscriptionPage> createState() =>
      _AddSubscriptionPageState();
}

class _AddSubscriptionPageState extends ConsumerState<AddSubscriptionPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  String _currency = kSupportedCurrencies.first;
  int _billingDay = 1;
  SubscriptionCategory _category = SubscriptionCategory.streaming;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final amount = double.parse(
      _amountController.text.replaceAll(',', '.').trim(),
    );
    ref.read(subscriptionsProvider.notifier).add(
          Subscription(
            id: const Uuid().v4(),
            name: _nameController.text.trim(),
            amount: amount,
            currency: _currency,
            billingDay: _billingDay,
            category: _category,
          ),
        );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yeni abonelik')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'İsim',
                hintText: 'Netflix, Spotify…',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'İsim gerekli';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Tutar',
                hintText: '149.99',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Tutar gerekli';
                }
                final parsed = double.tryParse(
                  value.replaceAll(',', '.').trim(),
                );
                if (parsed == null || parsed <= 0) {
                  return 'Geçerli bir tutar gir';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownMenu<String>(
              initialSelection: _currency,
              label: const Text('Para birimi'),
              expandedInsets: EdgeInsets.zero,
              dropdownMenuEntries: [
                for (final currency in kSupportedCurrencies)
                  DropdownMenuEntry(value: currency, label: currency),
              ],
              onSelected: (value) {
                if (value != null) {
                  setState(() => _currency = value);
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownMenu<int>(
              initialSelection: _billingDay,
              label: const Text('Ödeme günü'),
              expandedInsets: EdgeInsets.zero,
              dropdownMenuEntries: [
                for (var day = 1; day <= 31; day++)
                  DropdownMenuEntry(value: day, label: '$day'),
              ],
              onSelected: (value) {
                if (value != null) {
                  setState(() => _billingDay = value);
                }
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Kategori',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final category in SubscriptionCategory.values)
                  FilterChip(
                    avatar: Icon(category.icon, size: 18),
                    label: Text(category.label),
                    selected: _category == category,
                    onSelected: (_) => setState(() => _category = category),
                  ),
              ],
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _submit,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Kaydet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
