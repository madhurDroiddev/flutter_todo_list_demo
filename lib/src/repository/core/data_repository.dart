

import 'database_helper.dart';

mixin DataRepository<T, K> {
  /// Data Provider
  DatabaseProvider databaseProvider;


  /// CRUD Operations
  Future<int> insert(T data);

  Future<int> delete(K id);

  Future<List<T>> fetchAllRows(bool isNetworkAvailable);
}
