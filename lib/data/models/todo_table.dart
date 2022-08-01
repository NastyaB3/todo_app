import 'package:drift/drift.dart';

class TodoTable extends Table {
  TextColumn get id => text().nullable()();

  TextColumn get localId => text()();

  TextColumn get title => text()();

  TextColumn get importance => text().withDefault(const Constant('Нет'))();

  DateTimeColumn get deadline => dateTime().nullable()();

  BoolColumn get done => boolean()();

  TextColumn get color => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get changedAt => dateTime()();

  TextColumn get lastUpdatedBy => text()();

  @override
  Set<Column> get primaryKey => {id, localId};
}
