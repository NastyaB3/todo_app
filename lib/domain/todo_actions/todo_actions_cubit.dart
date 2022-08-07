import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/database/database.dart';


part 'todo_actions_state.dart';

class TodoActionsCubit extends Cubit<TodoActionsState> {
  final TodoRepository _repository;

  TodoActionsCubit(this._repository) : super(TodoActionsInitial());

  Future<void> toggleDone(
    TodoTableData task,
  ) async {
    final edited = task.copyWith(
      done: !task.done,
    );
    _repository.edit(edited);
  }

  Future<void> delete(
    TodoTableData task,
  ) async {
    _repository.remove(task.id);
  }
}
