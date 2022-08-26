import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/database/database.dart';


part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final TodoRepository _repository;

  DetailCubit(this._repository) : super(DetailInitial());

  Future<void> add({
    required TodoTableData task,
  }) async {
    emit(DetailLoading());
    try {
      await _repository.add(task);
      emit(DetailSuccess());
    } catch (e) {
      emit(
        DetailError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> edit({
    required TodoTableData task,
  }) async {
    emit(DetailLoading());
    try {
      await _repository.edit(task);
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
