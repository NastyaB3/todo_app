import 'package:todo_app/common/api_repository.dart';
import 'package:todo_app/data/models/plans_model.dart';

import '../../database/database.dart';
import 'todos_dao.dart';

class TodoRepository {
  final TodosDao toDoDao;

  TodoRepository({required this.toDoDao});

  Future<PlansModel> getListPlans() async {
    final response = await ApiRepository.getInstance().get('/list ');
    return PlansModel();
  }

  Future<int> addTodo(TodoTableData task) {
    return toDoDao.addTodo(task);
  }

  Stream<List<TodoTableData>> watch() {
    return toDoDao.watch();
  }

  Future<int> remove(TodoTableData task) {
    return toDoDao.remove(task);
  }

  Future<void> edit(TodoTableData task) {
    return toDoDao.edit(task);
  }
}
