import 'dart:async';

import 'package:firebasechat/src/bloc/home_bloc.dart';
import 'package:firebasechat/src/modals/task.dart';
import 'package:firebasechat/src/ui/cards/task_card.dart';
import 'package:firebasechat/src/utils/app_utils.dart';
import 'package:firebasechat/src/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc bloc;

  List<TodoTask> listTask;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = HomeBloc(List());
    listTask = List();

    bloc.taskSubscription.onData((data) {
      print("Listen Any changes here");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task", style: TextStyle(color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var task = await Navigator.of(context).pushNamed(Routes.addTask,
              arguments: {'length': listTask.length});

          if (task != null) {
            listTask.add(task);
            bloc.taskSink.add(listTask);
          }
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        alignment: Alignment.center,
        child: StreamBuilder<List<TodoTask>>(
            stream: bloc.taskStream,
            initialData: List(),
            builder: (context, snapshot) {
              listTask = snapshot.data;
              if (snapshot.data.length != 0) {
                return ListView.builder(
                  itemBuilder: (buildContext, index) {
                    return TaskCard(
                      task: listTask[index],
                      onDelete: () {
                        listTask.removeAt(index);
                        bloc.taskSink.add(listTask);
                      },
                    );
                  },
                  itemCount: listTask.length,
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.list,
                        color: Colors.black,
                      ),
                      Text("No task is added yet!")
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
