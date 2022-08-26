import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/database/database.dart';

part 'todo_list_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _todoRepository;
  StreamSubscription? _todoSub;

  TodoCubit(this._todoRepository) : super(TodoInitial());

  Future<void> fetch({
    required bool hideCompleted,
    required bool refresh,
  }) async {
    emit(TodoListLoading());
    await _todoSub?.cancel();
    if (refresh) {
      try {
        await _todoRepository.syncPlans();
      } catch (e) {
        emit(TodoListError(e));
        return;
      }
    }
    _todoSub = _todoRepository.watch(hideCompleted: hideCompleted).listen(
      (event) async {
        emit(
          TodoListSuccess(
            event,
            await _todoRepository.countToDo(),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    _todoSub?.cancel();
    super.close();
  }
}
