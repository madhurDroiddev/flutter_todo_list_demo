
import 'package:task_manager/src/modals/task.dart';
import 'package:task_manager/src/repository/core/database_helper.dart';
import 'package:task_manager/src/repository/dao/TaskDataDao.dart';

import '../core/data_repository.dart';

class TaskDatabaseRepository with DataRepository<TodoTask, int> {
  final TodoTaskDao _dao = TodoTaskDao();

  @override
  Future<int> insert(TodoTask data) async {
    final db = await databaseProvider.db();
    final id = await db.insert(TodoTaskDao.tableName, _dao.toMap(data));
    return id;
  }

  @override
  Future<List<TodoTask>> fetchAllRows(bool isNetworkAvailable) async {
    List<Map<String, dynamic>> list = [];
    if (isNetworkAvailable) {
      /// Data Fetch from Server
      /// TODO: Implement server data fetching
    } else {
      /// Data Fetch from Local DB
      final db = await databaseProvider.db();
      list = await db.query(TodoTaskDao.tableName, orderBy: 'createdDate DESC');
    }
    return _dao.fromList(list);
  }

  @override
  Future<int> delete(int id) async {
    final db = await databaseProvider.db();
    return await db.delete(
      TodoTaskDao.tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(TodoTask task) async {
    final db = await databaseProvider.db();
    return await db.update(
      TodoTaskDao.tableName,
      _dao.toMap(task),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }
}
