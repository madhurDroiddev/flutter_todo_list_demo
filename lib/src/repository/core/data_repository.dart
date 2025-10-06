

import 'database_helper.dart';

mixin DataRepository<T, K> {
  /// Data Provider
  DatabaseProvider get databaseProvider => DatabaseProvider();

  /// CRUD Operations
  Future<int> insert(T data);

  Future<int> delete(K id);

  Future<List<T>> fetchAllRows(bool isNetworkAvailable);
}
