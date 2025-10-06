import 'package:task_manager/src/modals/priority.dart';

class TodoTask {
  final int? id;
  final String title;
  final String description;
  final String taskDate;
  final String createdDate;
  final int isCompleted;
  final int level;

  const TodoTask({
    this.id,
    required this.title,
    required this.description,
    required this.taskDate,
    required this.createdDate,
    required this.isCompleted,
    required this.level,
  });

  @override
  String toString() {
    return 'TodoTask {'
        ' id: $id,'
        ' title: $title,'
        ' description: $description,'
        ' taskDate: $taskDate,'
        ' createdDate: $createdDate,'
        ' isCompleted: $isCompleted,'
        ' level: $level,'
        '}';
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'taskDate': taskDate,
      'createdDate': createdDate,
      'isCompleted': isCompleted,
      'level': level,
    };
  }

  factory TodoTask.fromMap(Map<String, dynamic> map) {
    return TodoTask(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      taskDate: map['taskDate'] as String,
      createdDate: map['createdDate'] as String,
      isCompleted: map['isCompleted'] as int,
      level: map['level'] as int,
    );
  }

  TodoTask copyWith({
    int? id,
    String? title,
    String? description,
    String? taskDate,
    String? createdDate,
    int? isCompleted,
    int? level,
  }) {
    return TodoTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      taskDate: taskDate ?? this.taskDate,
      createdDate: createdDate ?? this.createdDate,
      isCompleted: isCompleted ?? this.isCompleted,
      level: level ?? this.level,
    );
  }
}
