import 'package:todo_app/data/models/todo_table.dart';
import 'package:todo_app/database/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'plans_response.freezed.dart';

part 'plans_response.g.dart';

@freezed
class PlansResponse with _$PlansResponse {
  factory PlansResponse({
    required int revision,
    @TodoTableDataConverter() required List<TodoTableData> list,
  }) = _PlansResponse;

  factory PlansResponse.fromJson(Map<String, Object?> json) =>
      _$PlansResponseFromJson(json);
}

class TodoTableDataConverter
    implements JsonConverter<List<TodoTableData>, List<dynamic>> {
  const TodoTableDataConverter();

  @override
  List<TodoTableData> fromJson(List<dynamic> json) {
    return json.map((e) => TodoTable.fromJson(e)).toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<TodoTableData> data) {
    return data.map((e) => e.toJson()).toList();
  }
}
