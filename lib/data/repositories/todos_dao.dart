import 'package:drift/drift.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/data/models/todo_table.dart';

part 'todos_dao.g.dart';

@DriftAccessor(tables: [TodoTable])
class TodosDao extends DatabaseAccessor<AppDb> with _$TodosDaoMixin {
  TodosDao(AppDb db) : super(db);

  Future<void> addTodoAll(Iterable<TodoTableData> tasks) async {
    await batch(
      (batch) => batch.insertAll(
        todoTable,
        tasks,
        mode: InsertMode.insertOrReplace,
      ),
    );
  }

  Future<int> addTodo(TodoTableData task) {
    return into(todoTable).insert(
      task,
      mode: InsertMode.insertOrReplace,
    );
  }

  Stream<List<TodoTableData>> watch({
    required bool hideCompleted,
  }) {
    if (hideCompleted) {
      return (select(todoTable)..where((tbl) => tbl.done.equals(false)))
          .watch();
    } else {
      return select(todoTable).watch();
    }
  }

  Future<List<TodoTableData>> getAll() {
    return select(todoTable).get();
  }

  Future<int> remove(String task) {
    return (delete(todoTable)..where((tbl) => tbl.id.equals(task))).go();
  }

  Future<int> removeAll() {
    return delete(todoTable).go();
  }

  Future<void> edit(TodoTableData task) async {
    await update(todoTable).replace(task);
  }

  Future<int> countDone() async {
    final count = todoTable.title.count();

    final query = db.selectOnly(todoTable)
      ..addColumns([count])
      ..where(todoTable.done.equals(true));

    final result = await query.getSingle();

    return result.rawData.data.values.first;
  }
}
