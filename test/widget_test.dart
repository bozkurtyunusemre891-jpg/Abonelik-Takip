import 'package:abonelik_takip/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  testWidgets('Ana ekran başlığı görünür', (WidgetTester tester) async {
    await initializeDateFormatting('tr_TR');
    await tester.pumpWidget(
      const ProviderScope(child: AbonelikTakipApp()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Abonelikler'), findsOneWidget);
    expect(find.text('Aylık toplam gider'), findsOneWidget);
    expect(find.text('Ekle'), findsOneWidget);
  });
}
