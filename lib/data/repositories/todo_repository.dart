import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:todo_app/common/api_repository.dart';
import 'package:todo_app/data/models/plans_response.dart';
import 'package:todo_app/data/models/plan_response.dart';
import 'package:todo_app/data/models/todo_table.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/repositories/todos_dao.dart';
import 'package:todo_app/database/database.dart';

class TodoRepository {
  final TodosDao todoDao;
  final _revisionKey = 'revision_key';

  TodoRepository({required this.todoDao});

  //Получает список с сервера
  Future<void> syncPlans() async {
    if (await _isHaveConnection()) {
      final response = await ApiRepository.getInstance().get('/list');
      final plans = PlansResponse.fromJson(response.data);
      _updateRevision(plans.revision);
      final locals = await todoDao.getAll();
      final remote = {for (var element in plans.list) element.id: element};

      for (var element in locals) {
        final searched = remote[element.id];
        if (searched != null && element.changedAt.isAfter(searched.changedAt)) {
          remote[element.id] = element;
        } else if (searched == null) {
          remote[element.id] = element;
        }
      }

      ApiRepository.getInstance().options.headers['X-Last-Known-Revision'] =
          await _getRevision();
      final res = await ApiRepository.getInstance().patch(
        '/list',
        data: {
          'list': remote.values
              .map(
                (e) => TodoTable.toJson(e),
              )
              .toList()
        },
      );
      final revision = PlansResponse.fromJson(res.data).revision;

      _updateRevision(revision);
      await todoDao.removeAll();
      await todoDao.addTodoAll(remote.values);
    }
  }

  Future<void> add(TodoTableData task) async {
    if (await _isHaveConnection()) {
      ApiRepository.getInstance().options.headers['X-Last-Known-Revision'] =
          await _getRevision();
      final response = await ApiRepository.getInstance().post(
        '/list',
        data: {
          'element': TodoTable.toJson(task),
        },
      );

      final item = PlanResponse.fromJson(response.data);
      await _updateRevision(item.revision);
    }
    await todoDao.addTodo(task);
  }

  Future<void> edit(TodoTableData task) async {
    if (await _isHaveConnection()) {
      ApiRepository.getInstance().options.headers['X-Last-Known-Revision'] =
          await _getRevision();
      final response = await ApiRepository.getInstance().put(
        '/list/${task.id}',
        data: {
          'element': TodoTable.toJson(task),
        },
      );

      final item = PlanResponse.fromJson(response.data);
      await _updateRevision(item.revision);
    }
    await todoDao.edit(task);
  }

  Future<int> countToDo() async {
    return await todoDao.countDone();
  }

  Stream<List<TodoTableData>> watch({
    required bool hideCompleted,
  }) {
    return todoDao.watch(hideCompleted: hideCompleted);
  }

  Future<void> remove(String taskId) async {
    if (await _isHaveConnection()) {
      ApiRepository.getInstance().options.headers['X-Last-Known-Revision'] =
          await _getRevision();
      final response = await ApiRepository.getInstance().delete(
        '/list/$taskId',
      );

      final item = PlanResponse.fromJson(response.data);
      await _updateRevision(item.revision);
    }
    await todoDao.remove(taskId);
  }

  Future<int> _getRevision() async {
    try {
      final sp = await SharedPreferences.getInstance();
      return sp.getInt(_revisionKey) ?? -1;
    } catch (_) {
      return -1;
    }
  }

  Future<void> _updateRevision(int revision) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(_revisionKey, revision);
  }

  Future<bool> _isHaveConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
