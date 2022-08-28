import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/data/models/todo_table.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/domain/details_cubit/detail_cubit.dart';

import 'details_test.mocks.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

@GenerateMocks([MockTodoRepository])
void main() {
  DetailCubit? detailCubit;
  MockTodoRepository? todoRepository;

  setUp(() {
    todoRepository = MockTodoRepository();
    detailCubit = DetailCubit(todoRepository!);
  });

  tearDown(() {
    detailCubit?.close();
  });

  group('detailCubit', () {
    test('add task to todo [success]', () {
      final expectResponse = [
        DetailInitial(),
        DetailLoading(),
        DetailSuccess(),
      ];

      final task = TodoTableData(
        id: '123',
        title: 'sdf',
        importance: Importance.low,
        changedAt: DateTime.now(),
        createdAt: DateTime.now(),
        lastUpdatedBy: '',
        done: false,
      );

      expectLater(detailCubit, emitsInOrder(expectResponse));

      detailCubit?.add(
        task: task,
      );
    });
  });
}
