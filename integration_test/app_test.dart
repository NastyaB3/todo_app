import 'package:flutter/material.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/common/api_repository.dart';
import 'mock_data.dart';
import 'test_main.dart' as test_main;

void main() {
  final dioAdapter = DioAdapter(dio: ApiRepository.getInstance());

  dioAdapter.onGet(
    '/list',
    (server) => server.reply(
      200,
      list,
    ),
  );

  dioAdapter.onDelete(
    '/list/2',
    (server) => server.reply(
      200,
      list,
    ),
    data: {},
  );

  dioAdapter.onPatch(
    '/list',
        (server) => server.reply(
      200,
      list,
    ),
    data: {},
  );


  dioAdapter.onPost(
    '/list',
        (server) => server.reply(
      200,
      element,
    ),
    data: {},
  );

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Add todo Test', (WidgetTester tester) async {
    test_main.main();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byType(FloatingActionButton));
    await tester.tap(find.byType(FloatingActionButton));
    tester.printToConsole('Detail Screen is open');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Testing');
    expect(find.text('Testing'), findsOneWidget);
    await tester.ensureVisible(find.byType(TextButton));
    await tester.tap(find.byType(TextButton));
    tester.printToConsole('New Todo was added');
    await tester.pumpAndSettle();
  });
}
