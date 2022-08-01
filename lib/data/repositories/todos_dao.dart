import 'package:drift/drift.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/data/models/todo_table.dart';

part 'todos_dao.g.dart';

@DriftAccessor(tables: [TodoTable])
class TodosDao extends DatabaseAccessor<AppDb> with _$TodosDaoMixin {
  TodosDao(AppDb db) : super(db);

  Future<int> addTodo(TodoTableData task) {
    return into(todoTable).insert(task);
  }

  Stream<List<TodoTableData>> watch() {
    return select(todoTable).watch();
  }

  Future<int> remove(TodoTableData task) {
    return delete(todoTable).delete(task);
  }

  Future<void> edit(TodoTableData task){

    return update(todoTable).replace(task);
  }
}