
import 'package:task_manager/src/repository/core/dao.dart';
import '../../modals/task.dart';

class TodoTaskDao extends Dao<TodoTask> {
  static const String tableName = 'TodoTask';
  static const String columnId = 'id';
  static const String title = 'title';
  static const String description = 'description';
  static const String taskDate = 'taskDate';
  static const String createdDate = 'createdDate';
  static const String isCompleted = 'isCompleted';
  static const String level = 'level';

  @override
  String get createTableQuery =>
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
      " $title TEXT NOT NULL,"
      " $description TEXT NOT NULL,"
      " $taskDate TEXT NOT NULL,"
      " $createdDate TEXT NOT NULL,"
      " $isCompleted INTEGER NOT NULL,"
      " $level INTEGER NOT NULL"
      ")";

  String createTable(Map<String, dynamic> query, String primaryKey,
      {bool isAutoIncrement = false}) {
    Map<String, String> map = <String, String>{};

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
    String queryString = "CREATE TABLE $tableName(";

    List<String> columns = [];

    map.forEach((key, value) {
      columns.add(" $key $value${primaryKey == key ? " PRIMARY KEY${isAutoIncrement ? " AUTOINCREMENT" : ""}" : ""}");
    });

    queryString = "$queryString${columns.join(",")} )";

    return queryString;
  }

  @override
  List<TodoTask> fromList(List<Map<String, dynamic>> query) {
    List<TodoTask> data = <TodoTask>[];
    for (Map<String, dynamic> map in query) {
      data.add(fromMap(map));
    }
    return data;
  }

  @override
  TodoTask fromMap(Map<String, dynamic> query) {
    return TodoTask.fromMap(query);
  }

  @override
  Map<String, dynamic> toMap(TodoTask object) {
    return object.toMap();
  }
}
