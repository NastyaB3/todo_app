import 'dart:io';

import 'package:drift/drift.dart';

// These imports are only needed to open the database
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:todo_app/data/models/todo_table.dart';
import 'package:todo_app/data/repositories/todos_dao.dart';

part 'database.g.dart';

@DriftDatabase(
    // relative import for the drift file. Drift also supports `package:`
    // imports
    tables: [TodoTable], daos: [TodosDao])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
