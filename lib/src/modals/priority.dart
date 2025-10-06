import 'package:flutter/material.dart';

enum Priority { high, medium, low }

class PriorityLevel {
  final int index;
  final String title;
  final Priority priority;
  bool isSelected;
  final Color color;

  PriorityLevel(
    this.index, {
    required this.title,
    required this.priority,
    this.isSelected = false,
    required this.color,
  });

  PriorityLevel copyWith({
    int? index,
    String? title,
    Priority? priority,
    bool? isSelected,
    Color? color,
  }) {
    return PriorityLevel(
      index ?? this.index,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      isSelected: isSelected ?? this.isSelected,
      color: color ?? this.color,
    );
  }
}
