import 'package:injectable/injectable.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/data/repositories/todos_dao.dart';
import 'package:todo_app/database/database.dart';

@module
abstract class TodoModule {
  @singleton
  AppDb provideAppDb() {
    return AppDb();
  }

  @singleton
  TodosDao provideToDoDao(AppDb db) {
    return TodosDao(db);
  }

  @singleton
  TodoRepository provideRepository(TodosDao toDoDao) {
    return TodoRepository(todoDao: toDoDao);
  }
}
