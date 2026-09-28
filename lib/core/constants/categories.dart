import 'package:abonelik_takip/features/subscriptions/domain/models/subscription.dart';
import 'package:flutter/material.dart';

extension SubscriptionCategoryUi on SubscriptionCategory {
  String get label => switch (this) {
        SubscriptionCategory.streaming => 'Yayın',
        SubscriptionCategory.music => 'Müzik',
        SubscriptionCategory.cloud => 'Bulut',
        SubscriptionCategory.fitness => 'Spor',
        SubscriptionCategory.utilities => 'Faturalar',
        SubscriptionCategory.other => 'Diğer',
      };

  IconData get icon => switch (this) {
        SubscriptionCategory.streaming => Icons.live_tv_outlined,
        SubscriptionCategory.music => Icons.music_note_outlined,
        SubscriptionCategory.cloud => Icons.cloud_outlined,
        SubscriptionCategory.fitness => Icons.fitness_center_outlined,
        SubscriptionCategory.utilities => Icons.receipt_long_outlined,
        SubscriptionCategory.other => Icons.category_outlined,
      };
}
