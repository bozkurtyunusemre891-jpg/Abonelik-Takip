import 'package:abonelik_takip/core/constants/categories.dart';
import 'package:abonelik_takip/core/formatting/money_format.dart';
import 'package:abonelik_takip/features/subscriptions/domain/models/subscription.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingPaymentCard extends StatelessWidget {
  const UpcomingPaymentCard({super.key, required this.subscription});

  final Subscription subscription;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final next = subscription.nextPaymentDate();
    final dateLabel = DateFormat('d MMMM', 'tr_TR').format(next);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              foregroundColor: theme.colorScheme.onPrimaryContainer,
              child: Icon(subscription.category.icon, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subscription.name,
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    dateLabel,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              formatMoney(subscription.amount, subscription.currency),
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
