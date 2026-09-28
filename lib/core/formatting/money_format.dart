import 'package:intl/intl.dart';

String formatMoney(double amount, String currency) {
  final locale = switch (currency) {
    'TRY' => 'tr_TR',
    'EUR' => 'de_DE',
    _ => 'en_US',
  };
  return NumberFormat.simpleCurrency(locale: locale, name: currency)
      .format(amount);
}

String formatMonthlyTotals(Map<String, double> totals) {
  if (totals.isEmpty) {
    return formatMoney(0, 'TRY');
  }
  const order = ['TRY', 'USD', 'EUR'];
  final keys = [
    ...order.where(totals.containsKey),
    ...totals.keys.where((key) => !order.contains(key)),
  ];
  return keys.map((key) => formatMoney(totals[key]!, key)).join(' · ');
}
