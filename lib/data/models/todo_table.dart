import 'package:drift/drift.dart';
import 'package:todo_app/database/database.dart';

enum Importance {
  low('low'),
  basic('basic'),
  important('important');

  final String value;

  const Importance(this.value);
}

class TodoTable extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get importance => text().map(const ImportanceConverter())();

  DateTimeColumn get deadline => dateTime().nullable()();

  BoolColumn get done => boolean()();

  TextColumn get color => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get changedAt => dateTime()();

  TextColumn get lastUpdatedBy => text()();

  @override
  Set<Column> get primaryKey => {id};

  static TodoTableData fromJson(Map<String, dynamic> json) {
    return TodoTableData(
      id: json['id'],
      title: json['text'],
      importance: Importance.values
          .firstWhere((element) => element.value == json['importance']),
      deadline: json['deadline'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['deadline']).toLocal()
          : null,
      done: json['done'],
      color: json['color'],
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(json['created_at']).toLocal(),
      changedAt:
          DateTime.fromMillisecondsSinceEpoch(json['changed_at']).toLocal(),
      lastUpdatedBy: json['last_updated_by'],
    );
  }

  static Map<String, dynamic> toJson(TodoTableData data) {
    return <String, dynamic>{
      'id': data.id,
      'text': data.title,
      'importance': data.importance.value,
      'deadline': data.deadline?.millisecondsSinceEpoch,
      'done': data.done,
      'color': data.color,
      'created_at': data.createdAt.millisecondsSinceEpoch,
      'changed_at': data.changedAt.millisecondsSinceEpoch,
      'last_updated_by': data.lastUpdatedBy,
    };
  }
}

class ImportanceConverter extends TypeConverter<Importance, String>
    with JsonTypeConverter<Importance, String> {
  const ImportanceConverter();

  @override
  Importance? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Importance.values.firstWhere((element) => element.value == fromDb);
  }

  @override
  String? mapToSql(Importance? value) {
    if (value == null) {
      return null;
    }

    return value.value;
  }
}
