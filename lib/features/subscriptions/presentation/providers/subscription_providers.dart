import 'package:abonelik_takip/features/subscriptions/data/repositories/subscription_repository_impl.dart';
import 'package:abonelik_takip/features/subscriptions/domain/models/subscription.dart';
import 'package:abonelik_takip/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  return SubscriptionRepositoryImpl();
});

class SubscriptionsNotifier extends Notifier<List<Subscription>> {
  @override
  List<Subscription> build() {
    return ref.read(subscriptionRepositoryProvider).getAll();
  }

  void add(Subscription subscription) {
    ref.read(subscriptionRepositoryProvider).add(subscription);
    state = ref.read(subscriptionRepositoryProvider).getAll();
  }
}

final subscriptionsProvider =
    NotifierProvider<SubscriptionsNotifier, List<Subscription>>(
  SubscriptionsNotifier.new,
);

final activeSubscriptionsProvider = Provider<List<Subscription>>((ref) {
  return ref
      .watch(subscriptionsProvider)
      .where((subscription) => subscription.isActive)
      .toList();
});

final monthlyTotalsProvider = Provider<Map<String, double>>((ref) {
  final totals = <String, double>{};
  for (final subscription in ref.watch(activeSubscriptionsProvider)) {
    totals.update(
      subscription.currency,
      (value) => value + subscription.amount,
      ifAbsent: () => subscription.amount,
    );
  }
  return totals;
});

final upcomingPaymentsProvider = Provider<List<Subscription>>((ref) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final until = today.add(const Duration(days: 14));
  final upcoming = ref.watch(activeSubscriptionsProvider).where((subscription) {
    final next = subscription.nextPaymentDate(now);
    return !next.isAfter(until);
  }).toList()
    ..sort(
      (a, b) => a.nextPaymentDate(now).compareTo(b.nextPaymentDate(now)),
    );
  return upcoming;
});
