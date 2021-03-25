
import 'package:firebasechat/src/modals/task.dart';
import 'package:firebasechat/src/repository/core/database_helper.dart';
import 'package:firebasechat/src/repository/dao/TaskDataDao.dart';

import '../core/data_repository.dart';

class TaskDatabaseRepository implements DataRepository<TodoTask, int> {
  final dao = TodoTaskDao();

  @override
  DatabaseProvider databaseProvider = DatabaseProvider();

  @override
  Future<int> insert(TodoTask data) async {
    final db = await databaseProvider.db();
    int id = await db.insert(dao.tableName, dao.toMap(data));
    return id;
  }

  @override
  Future<List<TodoTask>> fetchAllRows(bool isNetworkAvailable) async {
    List<Map<String, dynamic>> list = [];
    if (isNetworkAvailable) {
      /// Data Fetch from Server

    } else {
      /// Data Fetch from Local DB
      final db = await databaseProvider.db();
      list = await db.query(dao.tableName);
    }
    return dao.fromList(list);
  }

  @override
  Future<int> delete(int id) async {
    final db = await databaseProvider.db();
    return await db.delete(dao.tableName, where: "id IS $id");
  }
}
