import 'package:abonelik_takip/features/subscriptions/domain/models/subscription.dart';

abstract class SubscriptionRepository {
  List<Subscription> getAll();

  void add(Subscription subscription);
}
