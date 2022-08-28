import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_main.dart' as test_main;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Future<void> addDelay(int ms) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
  }

  testWidgets('Add todo Test', (WidgetTester tester) async {
    test_main.main();
    await tester.pumpAndSettle();
    await addDelay(5000);
    await tester.ensureVisible(find.byType(FloatingActionButton));
    await tester.tap(find.byType(FloatingActionButton));
    await addDelay(2000);
    tester.printToConsole('Detail Screen is open');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Testing');
    expect(find.text('Testing'), findsOneWidget);
    await tester.ensureVisible(find.byType(TextButton));
    await tester.tap(find.byType(TextButton));
    await addDelay(2000);
    tester.printToConsole('New Todo was added');
    await tester.pumpAndSettle();

  });
}
