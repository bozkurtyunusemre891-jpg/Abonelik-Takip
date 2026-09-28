import 'package:abonelik_takip/features/subscriptions/presentation/providers/subscription_providers.dart';
import 'package:abonelik_takip/features/subscriptions/presentation/widgets/monthly_summary_card.dart';
import 'package:abonelik_takip/features/subscriptions/presentation/widgets/subscription_list_tile.dart';
import 'package:abonelik_takip/features/subscriptions/presentation/widgets/upcoming_payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(activeSubscriptionsProvider);
    final totals = ref.watch(monthlyTotalsProvider);
    final upcoming = ref.watch(upcomingPaymentsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Abonelikler')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add'),
        icon: const Icon(Icons.add),
        label: const Text('Ekle'),
      ),
      body: items.isEmpty
          ? _EmptyState(onAdd: () => context.push('/add'))
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
              children: [
                MonthlySummaryCard(totals: totals),
                const SizedBox(height: 24),
                Text(
                  'Yaklaşan ödemeler',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                if (upcoming.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Önümüzdeki 14 günde ödeme yok.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                else
                  ...upcoming.map(
                    (subscription) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: UpcomingPaymentCard(subscription: subscription),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  'Aktif abonelikler',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ...items.map(
                  (subscription) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SubscriptionListTile(subscription: subscription),
                  ),
                ),
              ],
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.subscriptions_outlined,
              size: 56,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Henüz abonelik yok',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Aylık giderlerini görmek için ilk aboneliğini ekle.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('İlk aboneliği ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
