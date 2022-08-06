import 'package:todo_app/data/models/todo_table.dart';
import 'package:todo_app/database/database.dart';

class PlanResponse {
  final int revision;
  final TodoTableData element;

  PlanResponse({
    required this.revision,
    required this.element,
  });

  factory PlanResponse.fromJson(Map<String, dynamic> json) {
    return PlanResponse(
      revision: json['revision'],
      element: TodoTable.fromJson(json['element']),
    );
  }
}
