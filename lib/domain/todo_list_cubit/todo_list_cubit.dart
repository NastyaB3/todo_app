import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/database/database.dart';

import '../../data/repositories/todo_repository.dart';


part 'todo_list_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _todoRepository;
  StreamSubscription? _todoSub;

  TodoCubit(this._todoRepository) : super(TodoInitial());

  Future<void> fetch() async {
    _todoSub = _todoRepository.watch().listen(
      (event) {
        emit(
          TodoListSuccess(
            event,
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
