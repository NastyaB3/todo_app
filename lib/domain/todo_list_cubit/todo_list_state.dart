part of 'todo_list_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoListSuccess extends TodoState {
  final List<TodoTableData> todos;

  TodoListSuccess(this.todos);
}

class TodoListLoading extends TodoState {}

class TodoListError extends TodoState {}
