import 'package:firebasechat/src/modals/task.dart';
import 'package:firebasechat/src/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final TodoTask task;
  final int index;
  final Function onDelete;

  const TaskCard({Key key, this.task, this.index, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  task.title,
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                    icon: Icon(Icons.delete), onPressed: () => onDelete())
              ],
            ),
            Text(
              task.description ?? "Description",
              style: TextStyle(fontSize: 12),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Card(
                    color: CommonUtils.createPriorityList()[task.level].color,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        CommonUtils.createPriorityList()[task.level].title,
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ),
                  Text(
                    CommonUtils.getDate(task.taskDate),
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
