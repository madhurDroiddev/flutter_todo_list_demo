import 'dart:async';

import 'package:firebasechat/src/modals/priority.dart';
import 'package:firebasechat/src/modals/task.dart';
import 'package:firebasechat/src/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class AddTask extends StatefulWidget {
  final int length;

  const AddTask({Key key, this.length}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState(this.length);
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController;
  TextEditingController dateController;
  TextEditingController descriptionController;

  DateTime dateTime;

  final int length;

  List<PriorityLevel> priorityLevelList;

  StreamController<List<PriorityLevel>> _streamController;

  _AddTaskState(this.length);

  PriorityLevel selectedPriority;

  @override
  void initState() {
    super.initState();

    _streamController = StreamController.broadcast();

    titleController = TextEditingController();
    dateController = TextEditingController();
    descriptionController = TextEditingController();

    priorityLevelList = CommonUtils.createPriorityList();
  }

  @override
  void dispose() {
    super.dispose();

    titleController?.dispose();
    dateController?.dispose();
    descriptionController?.dispose();

    _streamController?.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () => saveTask())
        ],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Title",
                    labelStyle:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: InkWell(
                  onTap: () async {
                    dateTime = await CommonUtils.setCalender(context);
                    dateController.text =
                        CommonUtils.getDate(dateTime.toIso8601String());
                  },
                  child: TextField(
                    readOnly: true,
                    enabled: false,
                    controller: dateController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.calendar_today),
                        hintText: "Choose Date",
                        hintStyle: TextStyle(fontSize: 13)),
                  ),
                ),
              ),
              Container(
                height: 200,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: InputDecoration.collapsed(
                      hintText: "Description",
                      hintStyle: TextStyle(fontSize: 13)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Select Priority"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: StreamBuilder<List<PriorityLevel>>(
                          stream: _streamController.stream,
                          initialData: priorityLevelList,
                          builder: (context, snapshot) {
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: priorityLevelList
                                  .map((e) => Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            e.isSelect = true;
                                            priorityLevelList
                                                .forEach((element) {
                                              if (e.priority !=
                                                  element.priority) {
                                                element.isSelect = false;
                                              }
                                            });
                                            selectedPriority = e;
                                            _streamController.sink
                                                .add(priorityLevelList);
                                          },
                                          child: Card(
                                            color: e.isSelect
                                                ? Colors.blueAccent
                                                : Colors.white,
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                  top: 5,
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 5),
                                              child: Text(
                                                e.title,
                                                style: TextStyle(
                                                    color: e.isSelect
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  saveTask() {
    TodoTask task = TodoTask(
        title: titleController.text,
        description: descriptionController.text,
        taskDate: dateTime.toIso8601String(),
        createdDate: DateTime.now().toIso8601String(),
        level: selectedPriority.index,
        isCompleted: 0);

    Navigator.of(context).pop(task);
  }
}
