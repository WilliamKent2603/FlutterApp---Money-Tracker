import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mmas_money_tracker/main.dart';
import 'package:mmas_money_tracker/providers/transaction_provider.dart'; // Pastikan jalur ini benar

void main() {
  testWidgets('MMASMoneyTrackerApp has a title and increments counter',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ],
        child:
            const MMASMoneyTrackerApp(), // Ganti MyApp dengan MMASMoneyTrackerApp
      ),
    );

    // Verify that our app has a title.
    expect(find.text('MMAS Money Tracker'), findsOneWidget);

    // Verify that the counter starts at 0 (as an example, assuming the counter exists).
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
