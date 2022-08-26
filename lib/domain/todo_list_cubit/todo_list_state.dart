part of 'todo_list_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoListSuccess extends TodoState {
  final List<TodoTableData> todos;
  final int contDone;

  TodoListSuccess(this.todos, this.contDone);
}

class TodoListLoading extends TodoState {}

class TodoListError extends TodoState {
  final dynamic err;

  TodoListError(this.err);
}
