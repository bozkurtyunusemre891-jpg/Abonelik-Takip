import 'package:abonelik_takip/features/subscriptions/domain/models/subscription.dart';
import 'package:abonelik_takip/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:uuid/uuid.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl({List<Subscription>? seed})
      : _items = List<Subscription>.from(seed ?? _defaultSeed());

  final List<Subscription> _items;

  static const _uuid = Uuid();

  static List<Subscription> _defaultSeed() {
    final today = DateTime.now().day;
    int upcomingDay(int offset) {
      final candidate = today + offset;
      if (candidate <= 28) {
        return candidate;
      }
      return ((today - 3).clamp(1, 28));
    }

    return [
      Subscription(
        id: _uuid.v4(),
        name: 'Netflix',
        amount: 149.99,
        currency: 'TRY',
        billingDay: upcomingDay(3),
        category: SubscriptionCategory.streaming,
      ),
      Subscription(
        id: _uuid.v4(),
        name: 'Spotify',
        amount: 59.99,
        currency: 'TRY',
        billingDay: upcomingDay(8),
        category: SubscriptionCategory.music,
      ),
      Subscription(
        id: _uuid.v4(),
        name: 'iCloud+',
        amount: 0.99,
        currency: 'USD',
        billingDay: 1,
        category: SubscriptionCategory.cloud,
      ),
    ];
  }

  @override
  List<Subscription> getAll() => List.unmodifiable(_items);

  @override
  void add(Subscription subscription) {
    _items.add(subscription);
  }
}
