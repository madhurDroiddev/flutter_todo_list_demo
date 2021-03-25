import 'package:firebasechat/src/modals/priority.dart';

class TodoTask {
  int id;
  String title;
  String description;
  String taskDate;
  String createdDate;
  int isCompleted;
  int level;

  TodoTask({
    this.id,
    this.title,
    this.description,
    this.taskDate,
    this.createdDate,
    this.isCompleted,
    this.level,
  });

  @override
  String toString() {
    return 'TodoTask {' +
        ' id: $id,' +
        ' title: $title,' +
        ' description: $description,' +
        ' taskDate: $taskDate,' +
        ' createdDate: $createdDate,' +
        ' isCompleted: $isCompleted,' +
        ' level: $level,' +
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': this.id,
      'title': this.title,
      'description': this.description,
      'taskDate': this.taskDate,
      'createdDate': this.createdDate,
      'isCompleted': this.isCompleted,
      'level': this.level,
    };
  }

  factory TodoTask.fromMap(Map<String, dynamic> map) {
    return new TodoTask(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      taskDate: map['taskDate'] as String,
      createdDate: map['createdDate'] as String,
      isCompleted: map['isCompleted'] as int,
      level: map['level'] as int,
    );
  }
}
