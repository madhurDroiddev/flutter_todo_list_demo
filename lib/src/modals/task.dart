import 'package:firebasechat/src/modals/priority.dart';

class TodoTask {
  int id;
  String title;
  String description;
  String taskDate;
  String createdDate;
  bool isCompleted;
  PriorityLevel level;

//<editor-fold desc="Data Methods" defaultstate="collapsed">


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
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is TodoTask &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              title == other.title &&
              description == other.description &&
              taskDate == other.taskDate &&
              createdDate == other.createdDate &&
              isCompleted == other.isCompleted &&
              level == other.level
          );


  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      taskDate.hashCode ^
      createdDate.hashCode ^
      isCompleted.hashCode ^
      level.hashCode;


  @override
  String toString() {
    return 'TodoTask{' +
        ' id: $id,' +
        ' title: $title,' +
        ' description: $description,' +
        ' taskDate: $taskDate,' +
        ' createdDate: $createdDate,' +
        ' isCompleted: $isCompleted,' +
        ' level: $level,' +
        '}';
  }


  TodoTask copyWith({
    int id,
    String title,
    String description,
    String taskDate,
    String createdDate,
    bool isCompleted,
    PriorityLevel level,
  }) {
    return new TodoTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      taskDate: taskDate ?? this.taskDate,
      createdDate: createdDate ?? this.createdDate,
      isCompleted: isCompleted ?? this.isCompleted,
      level: level ?? this.level,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
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
      isCompleted: map['isCompleted'] as bool,
      level: map['level'] as PriorityLevel,
    );
  }


//</editor-fold>
}
