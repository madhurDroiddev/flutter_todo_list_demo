
import 'package:task_manager/src/repository/dao/TaskDataDao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  factory DatabaseProvider() => _instance;
  
  bool _isInitialized = false;
  Database? _db;

  DatabaseProvider._internal();

  Future<Database> db() async {
    if (!_isInitialized) await _init();
    return _db!;
  }

  Future<void> _init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'task_manager.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(TodoTaskDao().createTableQuery);
      },
    );
    _isInitialized = true;
  }

  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
      _isInitialized = false;
    }
  }
}