import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart'; // Import LocalStorage

import 'package:expense_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create a LocalStorage instance for testing
    final localStorage = LocalStorage('expense_app_test');

    // Ensure the LocalStorage is ready
    await localStorage.ready;

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(localStorage: localStorage)); // Pass localStorage

    // Verify that our counter starts at 0.
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