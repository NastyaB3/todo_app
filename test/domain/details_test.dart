import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/data/models/todo_table.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/domain/details_cubit/detail_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_app/domain/todo_actions/todo_actions_cubit.dart';

import 'details_test.mocks.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

@GenerateMocks([MockTodoRepository])
void main() {
  DetailCubit? detailCubit;
  TodoActionsCubit? todoActionsCubit;
  MockTodoRepository? todoRepository;

  const taskId = '123';

  final task = TodoTableData(
    id: taskId,
    title: 'sdf',
    importance: Importance.low,
    changedAt: DateTime.now(),
    createdAt: DateTime.now(),
    lastUpdatedBy: '',
    done: false,
  );

  setUp(() {
    todoRepository = MockMockTodoRepository();
    detailCubit = DetailCubit(todoRepository!);
    todoActionsCubit = TodoActionsCubit(todoRepository!);

    when(todoRepository!.watch(hideCompleted: true))
        .thenAnswer((_) => const Stream.empty());
    when(todoRepository!.watch(hideCompleted: false))
        .thenAnswer((_) => const Stream.empty());

    when(todoRepository!.add(task)).thenAnswer((_) => Future.value());
    when(todoRepository!.edit(task)).thenAnswer((_) => Future.value());
    when(todoRepository!.remove(taskId)).thenAnswer((_) => Future.value());
  });

  tearDown(() {
    detailCubit?.close();
  });

  group('detail screen', () {
    blocTest<DetailCubit, DetailState>(
      'add task to todo [success]',
      build: () => detailCubit!,
      act: (cubit) => cubit.add(task: task),
      expect: () => [DetailLoading(), DetailSuccess()],
    );
    blocTest<DetailCubit, DetailState>(
      'edit task [success]',
      build: () => detailCubit!,
      act: (cubit) => cubit.edit(task: task),
      expect: () => [DetailLoading(), DetailSuccess()],
    );
    blocTest<TodoActionsCubit, TodoActionsState>(
      'delete task [success]',
      build: () => todoActionsCubit!,
      act: (cubit) => todoActionsCubit?.delete(task),
      expect: () => [],
    );
  });
}
