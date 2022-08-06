import 'package:todo_app/data/models/todo_table.dart';
import 'package:todo_app/database/database.dart';

class PlansResponse {
  final int revision;
  final List<TodoTableData> list;

  PlansResponse({
    required this.revision,
    required this.list,
  });

  factory PlansResponse.fromJson(Map<String, dynamic> json) {
    return PlansResponse(
      revision: json['revision'],
      list: json['list'] != null
          ? (json['list'] as Iterable)
              .map((e) => TodoTable.fromJson(e))
              .toList()
          : [],
    );
  }
}
