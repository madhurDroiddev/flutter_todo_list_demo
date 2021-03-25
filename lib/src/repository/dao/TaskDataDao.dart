

import 'package:firebasechat/src/repository/core/dao.dart';

import '../../modals/task.dart';

class TodoTaskDao extends Dao<TodoTask> {
  final tableName = 'TodoTask';
  final columnId = 'id';
  final title = 'title';
  final description = 'description';
  final taskDate = 'taskDate';
  final createdDate = 'createdDate';
  final isCompleted = 'isCompleted';
  final level = 'level';

  @override
  String get createTableQuery =>
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
      " $title TEXT,"
      " $description TEXT,"
      " $taskDate TEXT,"
      " $createdDate TEXT,"
      " $isCompleted INTEGER,"
      " $level INTEGER"
      ")";

  String createTable(Map<String, dynamic> query, String primaryKey,
      {bool isAutoIncrement: false}) {
    Map<String, String> map = Map();

    /// Create map which contain keys name and it's data type

    query.forEach((key, value) {
      if (value is int) {
        map[key] = "INTEGER";
      } else if (value is String) {
        map[key] = "TEXT";
      } else {
        map[key] = "TEXT";
      }
    });

    /// Creating Query using keys and it's data types

    String _query = "CREATE TABLE $tableName(";

    List<String> columns = [];

    map.forEach((key, value) {
      columns.add(" " +
          key +
          " " +
          value +
          (primaryKey == key
              ? " PRIMARY KEY " + (isAutoIncrement ? "AUTOINCREMENT" : "")
              : ""));
    });

    _query = _query + columns.join(",") + ")";

    return _query;
  }

  @override
  List<TodoTask> fromList(List<Map<String, dynamic>> query) {
    List<TodoTask> data = <TodoTask>[];
    for (Map map in query) {
      data.add(fromMap(map));
    }
    return data;
  }

  @override
  TodoTask fromMap(Map<String, dynamic> query) {
    TodoTask data = TodoTask.fromMap(query);
    return data;
  }

  @override
  Map<String, dynamic> toMap(TodoTask object) {
    return object.toMap();
  }
}
