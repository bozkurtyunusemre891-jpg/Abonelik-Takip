import 'package:abonelik_takip/core/constants/categories.dart';
import 'package:abonelik_takip/core/formatting/money_format.dart';
import 'package:abonelik_takip/features/subscriptions/domain/models/subscription.dart';
import 'package:flutter/material.dart';

class SubscriptionListTile extends StatelessWidget {
  const SubscriptionListTile({super.key, required this.subscription});

  final Subscription subscription;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.secondaryContainer,
          foregroundColor: theme.colorScheme.onSecondaryContainer,
          child: Icon(subscription.category.icon, size: 20),
        ),
        title: Text(subscription.name),
        subtitle: Text(
          '${subscription.category.label} · Her ayın ${subscription.billingDay}. günü',
        ),
        trailing: Text(
          formatMoney(subscription.amount, subscription.currency),
          style: theme.textTheme.titleSmall,
        ),
      ),
    );
  }
}
