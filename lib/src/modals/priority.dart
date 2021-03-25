import 'package:flutter/material.dart';

enum Priority { High, Medium, Low }

class PriorityLevel {
  int index;
  String title;
  Priority priority;
  bool isSelect;
  Color color;

  PriorityLevel(this.index,
      {this.title, this.priority, this.isSelect: false, this.color});
}
