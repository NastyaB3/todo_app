import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/todo_repository.dart';
import '../../database/database.dart';

part 'todo_actions_state.dart';

class TodoActionsCubit extends Cubit<TodoActionsState> {
  final TodoRepository _repository;

  TodoActionsCubit(this._repository) : super(TodoActionsInitial());

  Future<void> toggleDone(
    TodoTableData task,
  ) async {
    _repository.edit(task.copyWith(done: !task.done));
  }

  Future<void> delete(
    TodoTableData task,
  ) async {
    _repository.remove(task);
  }
}
