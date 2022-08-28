import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/data/models/todo_table.dart';
import 'package:todo_app/database/database.dart';

part 'plan_response.freezed.dart';

part 'plan_response.g.dart';

@freezed
class PlanResponse with _$PlanResponse {
  factory PlanResponse({
    required int revision,
    @ElementConverter() required TodoTableData element,
  }) = _PlanResponse;

  factory PlanResponse.fromJson(Map<String, Object?> json) =>
      _$PlanResponseFromJson(json);
}

class ElementConverter
    implements JsonConverter<TodoTableData, Map<String, dynamic>> {
  const ElementConverter();

  @override
  TodoTableData fromJson(Map<String, dynamic> data) {
    return TodoTable.fromJson(data);
  }

  @override
  Map<String, dynamic> toJson(TodoTableData data) {
    return data.toJson();
  }
}
