import 'dart:async';

import 'package:firebasechat/src/bloc/base_bloc.dart';
import 'package:firebasechat/src/modals/task.dart';
import 'package:firebasechat/src/repository/repo/TaskDatabaseRepository.dart';

class HomeBloc extends Bloc {
  // 1
  final _todoTaskController = StreamController<List<TodoTask>>.broadcast();

  // 2
  Stream<List<TodoTask>> get taskStream => _todoTaskController.stream;

  // 3
  StreamSink<List<TodoTask>> get taskSink => _todoTaskController.sink;

  // 4
  StreamSubscription<List<TodoTask>> get taskSubscription =>
      taskStream.listen((event) {});

  saveTask(TodoTask task) {
    TaskDatabaseRepository repository = TaskDatabaseRepository();
    repository.insert(task).then((value) {
      fetchAllTasks();
    });
  }

  fetchAllTasks() async {
    TaskDatabaseRepository repository = TaskDatabaseRepository();
    repository.fetchAllRows(await isNetworkAvailable).then((value) {
      taskSink.add(value);
    });
  }

  delete(TodoTask task){
    TaskDatabaseRepository repository = TaskDatabaseRepository();
    repository.delete(task.id).then((value) {
      fetchAllTasks();
    });
  }

  @override
  void dispose() {
    _todoTaskController?.close();
  }
}
