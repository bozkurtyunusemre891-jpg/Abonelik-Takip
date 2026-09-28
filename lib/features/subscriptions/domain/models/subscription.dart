class Subscription {
  const Subscription({
    required this.id,
    required this.name,
    required this.amount,
    required this.currency,
    required this.billingDay,
    required this.category,
    this.isActive = true,
  });

  final String id;
  final String name;
  final double amount;
  final String currency;
  final int billingDay;
  final SubscriptionCategory category;
  final bool isActive;

  DateTime nextPaymentDate([DateTime? from]) {
    final now = from ?? DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final thisMonth = _dateInMonth(now.year, now.month);
    if (!thisMonth.isBefore(today)) {
      return thisMonth;
    }
    final nextMonth = now.month == 12 ? 1 : now.month + 1;
    final nextYear = now.month == 12 ? now.year + 1 : now.year;
    return _dateInMonth(nextYear, nextMonth);
  }

  DateTime _dateInMonth(int year, int month) {
    final lastDay = DateTime(year, month + 1, 0).day;
    final day = billingDay.clamp(1, lastDay);
    return DateTime(year, month, day);
  }
}

enum SubscriptionCategory {
  streaming,
  music,
  cloud,
  fitness,
  utilities,
  other,
}
