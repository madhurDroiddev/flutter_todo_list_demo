import 'package:flutter/material.dart';

enum Priority { High, Medium, Low }

class PriorityLevel {
  String title;
  Priority priority;
  bool isSelect;
  Color color;

  PriorityLevel({this.title, this.priority, this.isSelect: false, this.color});
}
