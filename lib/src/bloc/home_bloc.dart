import 'dart:async';

import 'package:firebasechat/src/bloc/base_bloc.dart';
import 'package:firebasechat/src/modals/task.dart';

class HomeBloc extends Bloc {
  List<TodoTask> taskList;

  HomeBloc(this.taskList);

  // 1
  final _todoTaskController = StreamController<List<TodoTask>>.broadcast();

  // 2
  Stream<List<TodoTask>> get taskStream => _todoTaskController.stream;

  // 3
  StreamSink<List<TodoTask>> get taskSink => _todoTaskController.sink;

  // 4
  StreamSubscription<List<TodoTask>> get taskSubscription =>
      taskStream.listen((event) {});

  @override
  void dispose() {
    _todoTaskController?.close();
  }
}
