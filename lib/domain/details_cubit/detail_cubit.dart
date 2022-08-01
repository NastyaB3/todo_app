import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/todo_repository.dart';
import '../../database/database.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final TodoRepository _repository;

  DetailCubit(this._repository) : super(DetailInitial());

  Future<void> addTodo({
    required TodoTableData task,
  }) async {
    emit(DetailLoading());
    try {
      await _repository.addTodo(task);
      emit(DetailSuccess());
    } catch (e) {
      emit(
        DetailError(
          e.toString(),
        ),
      );
    }
  }
}
