import 'dart:async';

import 'package:task_manager/src/bloc/base_bloc.dart';
import 'package:task_manager/src/modals/task.dart';
import 'package:task_manager/src/repository/repo/TaskDatabaseRepository.dart';

class HomeBloc extends Bloc {
  final StreamController<List<TodoTask>> _todoTaskController =
      StreamController<List<TodoTask>>.broadcast();
  final TaskDatabaseRepository _repository = TaskDatabaseRepository();

  Stream<List<TodoTask>> get taskStream => _todoTaskController.stream;
  StreamSink<List<TodoTask>> get taskSink => _todoTaskController.sink;

  StreamSubscription<List<TodoTask>> get taskSubscription =>
      taskStream.listen((event) {});

  Future<void> saveTask(TodoTask task) async {
    try {
      await _repository.insert(task);
      await fetchAllTasks();
    } catch (e) {
      // Handle error appropriately
      print('Error saving task: $e');
    }
  }

  Future<void> fetchAllTasks() async {
    try {
      final tasks = await _repository.fetchAllRows(await isNetworkAvailable);
      taskSink.add(tasks);
    } catch (e) {
      // Handle error appropriately
      print('Error fetching tasks: $e');
      taskSink.add([]);
    }
  }

  Future<void> delete(TodoTask task) async {
    try {
      if (task.id != null) {
        await _repository.delete(task.id!);
        await fetchAllTasks();
      }
    } catch (e) {
      // Handle error appropriately
      print('Error deleting task: $e');
    }
  }

  Future<void> updateTask(TodoTask task) async {
    try {
      await _repository.update(task);
      await fetchAllTasks();
    } catch (e) {
      // Handle error appropriately
      print('Error updating task: $e');
    }
  }

  @override
  void dispose() {
    _todoTaskController.close();
  }
}
