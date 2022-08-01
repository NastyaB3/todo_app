// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class TodoTableData extends DataClass implements Insertable<TodoTableData> {
  final String? id;
  final String localId;
  final String title;
  final String importance;
  final DateTime? deadline;
  final bool done;
  final String? color;
  final DateTime createdAt;
  final DateTime changedAt;
  final String lastUpdatedBy;
  TodoTableData(
      {this.id,
      required this.localId,
      required this.title,
      required this.importance,
      this.deadline,
      required this.done,
      this.color,
      required this.createdAt,
      required this.changedAt,
      required this.lastUpdatedBy});
  factory TodoTableData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TodoTableData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id']),
      localId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}local_id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      importance: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}importance'])!,
      deadline: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deadline']),
      done: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}done'])!,
      color: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      changedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}changed_at'])!,
      lastUpdatedBy: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated_by'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String?>(id);
    }
    map['local_id'] = Variable<String>(localId);
    map['title'] = Variable<String>(title);
    map['importance'] = Variable<String>(importance);
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime?>(deadline);
    }
    map['done'] = Variable<bool>(done);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String?>(color);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['changed_at'] = Variable<DateTime>(changedAt);
    map['last_updated_by'] = Variable<String>(lastUpdatedBy);
    return map;
  }

  TodoTableCompanion toCompanion(bool nullToAbsent) {
    return TodoTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      localId: Value(localId),
      title: Value(title),
      importance: Value(importance),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      done: Value(done),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      createdAt: Value(createdAt),
      changedAt: Value(changedAt),
      lastUpdatedBy: Value(lastUpdatedBy),
    );
  }

  factory TodoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoTableData(
      id: serializer.fromJson<String?>(json['id']),
      localId: serializer.fromJson<String>(json['localId']),
      title: serializer.fromJson<String>(json['title']),
      importance: serializer.fromJson<String>(json['importance']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      done: serializer.fromJson<bool>(json['done']),
      color: serializer.fromJson<String?>(json['color']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
      lastUpdatedBy: serializer.fromJson<String>(json['lastUpdatedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String?>(id),
      'localId': serializer.toJson<String>(localId),
      'title': serializer.toJson<String>(title),
      'importance': serializer.toJson<String>(importance),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'done': serializer.toJson<bool>(done),
      'color': serializer.toJson<String?>(color),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'changedAt': serializer.toJson<DateTime>(changedAt),
      'lastUpdatedBy': serializer.toJson<String>(lastUpdatedBy),
    };
  }

  TodoTableData copyWith(
          {String? id,
          String? localId,
          String? title,
          String? importance,
          DateTime? deadline,
          bool? done,
          String? color,
          DateTime? createdAt,
          DateTime? changedAt,
          String? lastUpdatedBy}) =>
      TodoTableData(
        id: id ?? this.id,
        localId: localId ?? this.localId,
        title: title ?? this.title,
        importance: importance ?? this.importance,
        deadline: deadline ?? this.deadline,
        done: done ?? this.done,
        color: color ?? this.color,
        createdAt: createdAt ?? this.createdAt,
        changedAt: changedAt ?? this.changedAt,
        lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
      );
  @override
  String toString() {
    return (StringBuffer('TodoTableData(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('title: $title, ')
          ..write('importance: $importance, ')
          ..write('deadline: $deadline, ')
          ..write('done: $done, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt, ')
          ..write('changedAt: $changedAt, ')
          ..write('lastUpdatedBy: $lastUpdatedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, localId, title, importance, deadline,
      done, color, createdAt, changedAt, lastUpdatedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoTableData &&
          other.id == this.id &&
          other.localId == this.localId &&
          other.title == this.title &&
          other.importance == this.importance &&
          other.deadline == this.deadline &&
          other.done == this.done &&
          other.color == this.color &&
          other.createdAt == this.createdAt &&
          other.changedAt == this.changedAt &&
          other.lastUpdatedBy == this.lastUpdatedBy);
}

class TodoTableCompanion extends UpdateCompanion<TodoTableData> {
  final Value<String?> id;
  final Value<String> localId;
  final Value<String> title;
  final Value<String> importance;
  final Value<DateTime?> deadline;
  final Value<bool> done;
  final Value<String?> color;
  final Value<DateTime> createdAt;
  final Value<DateTime> changedAt;
  final Value<String> lastUpdatedBy;
  const TodoTableCompanion({
    this.id = const Value.absent(),
    this.localId = const Value.absent(),
    this.title = const Value.absent(),
    this.importance = const Value.absent(),
    this.deadline = const Value.absent(),
    this.done = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.lastUpdatedBy = const Value.absent(),
  });
  TodoTableCompanion.insert({
    this.id = const Value.absent(),
    required String localId,
    required String title,
    this.importance = const Value.absent(),
    this.deadline = const Value.absent(),
    required bool done,
    this.color = const Value.absent(),
    required DateTime createdAt,
    required DateTime changedAt,
    required String lastUpdatedBy,
  })  : localId = Value(localId),
        title = Value(title),
        done = Value(done),
        createdAt = Value(createdAt),
        changedAt = Value(changedAt),
        lastUpdatedBy = Value(lastUpdatedBy);
  static Insertable<TodoTableData> custom({
    Expression<String?>? id,
    Expression<String>? localId,
    Expression<String>? title,
    Expression<String>? importance,
    Expression<DateTime?>? deadline,
    Expression<bool>? done,
    Expression<String?>? color,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? changedAt,
    Expression<String>? lastUpdatedBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localId != null) 'local_id': localId,
      if (title != null) 'title': title,
      if (importance != null) 'importance': importance,
      if (deadline != null) 'deadline': deadline,
      if (done != null) 'done': done,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
      if (changedAt != null) 'changed_at': changedAt,
      if (lastUpdatedBy != null) 'last_updated_by': lastUpdatedBy,
    });
  }

  TodoTableCompanion copyWith(
      {Value<String?>? id,
      Value<String>? localId,
      Value<String>? title,
      Value<String>? importance,
      Value<DateTime?>? deadline,
      Value<bool>? done,
      Value<String?>? color,
      Value<DateTime>? createdAt,
      Value<DateTime>? changedAt,
      Value<String>? lastUpdatedBy}) {
    return TodoTableCompanion(
      id: id ?? this.id,
      localId: localId ?? this.localId,
      title: title ?? this.title,
      importance: importance ?? this.importance,
      deadline: deadline ?? this.deadline,
      done: done ?? this.done,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String?>(id.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (importance.present) {
      map['importance'] = Variable<String>(importance.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime?>(deadline.value);
    }
    if (done.present) {
      map['done'] = Variable<bool>(done.value);
    }
    if (color.present) {
      map['color'] = Variable<String?>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    if (lastUpdatedBy.present) {
      map['last_updated_by'] = Variable<String>(lastUpdatedBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoTableCompanion(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('title: $title, ')
          ..write('importance: $importance, ')
          ..write('deadline: $deadline, ')
          ..write('done: $done, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt, ')
          ..write('changedAt: $changedAt, ')
          ..write('lastUpdatedBy: $lastUpdatedBy')
          ..write(')'))
        .toString();
  }
}

class $TodoTableTable extends TodoTable
    with TableInfo<$TodoTableTable, TodoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  @override
  late final GeneratedColumn<String?> localId = GeneratedColumn<String?>(
      'local_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _importanceMeta = const VerificationMeta('importance');
  @override
  late final GeneratedColumn<String?> importance = GeneratedColumn<String?>(
      'importance', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('Нет'));
  final VerificationMeta _deadlineMeta = const VerificationMeta('deadline');
  @override
  late final GeneratedColumn<DateTime?> deadline = GeneratedColumn<DateTime?>(
      'deadline', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _doneMeta = const VerificationMeta('done');
  @override
  late final GeneratedColumn<bool?> done = GeneratedColumn<bool?>(
      'done', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (done IN (0, 1))');
  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String?> color = GeneratedColumn<String?>(
      'color', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _changedAtMeta = const VerificationMeta('changedAt');
  @override
  late final GeneratedColumn<DateTime?> changedAt = GeneratedColumn<DateTime?>(
      'changed_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _lastUpdatedByMeta =
      const VerificationMeta('lastUpdatedBy');
  @override
  late final GeneratedColumn<String?> lastUpdatedBy = GeneratedColumn<String?>(
      'last_updated_by', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        localId,
        title,
        importance,
        deadline,
        done,
        color,
        createdAt,
        changedAt,
        lastUpdatedBy
      ];
  @override
  String get aliasedName => _alias ?? 'todo_table';
  @override
  String get actualTableName => 'todo_table';
  @override
  VerificationContext validateIntegrity(Insertable<TodoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('importance')) {
      context.handle(
          _importanceMeta,
          importance.isAcceptableOrUnknown(
              data['importance']!, _importanceMeta));
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    }
    if (data.containsKey('done')) {
      context.handle(
          _doneMeta, done.isAcceptableOrUnknown(data['done']!, _doneMeta));
    } else if (isInserting) {
      context.missing(_doneMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(_changedAtMeta,
          changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta));
    } else if (isInserting) {
      context.missing(_changedAtMeta);
    }
    if (data.containsKey('last_updated_by')) {
      context.handle(
          _lastUpdatedByMeta,
          lastUpdatedBy.isAcceptableOrUnknown(
              data['last_updated_by']!, _lastUpdatedByMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, localId};
  @override
  TodoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TodoTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodoTableTable createAlias(String alias) {
    return $TodoTableTable(attachedDatabase, alias);
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TodoTableTable todoTable = $TodoTableTable(this);
  late final TodosDao todosDao = TodosDao(this as AppDb);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoTable];
}
