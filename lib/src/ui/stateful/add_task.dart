import 'dart:async';

import 'package:task_manager/src/modals/priority.dart';
import 'package:task_manager/src/modals/task.dart';
import 'package:task_manager/src/utils/app_utils.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  final int length;

  const AddTask({super.key, required this.length});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _descriptionController;

  DateTime? _selectedDateTime;
  List<PriorityLevel> _priorityLevelList = [];
  PriorityLevel? _selectedPriority;

  final StreamController<List<PriorityLevel>> _streamController =
      StreamController<List<PriorityLevel>>.broadcast();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _dateController = TextEditingController();
    _descriptionController = TextEditingController();
    _priorityLevelList = CommonUtils.createPriorityList();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveTask,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Title",
                  hintText: "Enter task title",
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: _selectDate,
                child: IgnorePointer(
                  child: TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Due Date",
                      hintText: "Choose Date",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description",
                  hintText: "Enter task description",
                  alignLabelWithHint: true,
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 20),
              Text(
                "Select Priority",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              StreamBuilder<List<PriorityLevel>>(
                stream: _streamController.stream,
                initialData: _priorityLevelList,
                builder: (context, snapshot) {
                  return Row(
                    children: _priorityLevelList.map((priority) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () => _selectPriority(priority),
                            child: Card(
                              elevation: priority.isSelected ? 4 : 1,
                              color: priority.isSelected
                                  ? priority.color
                                  : Colors.white,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 8,
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      _getPriorityIcon(priority.priority),
                                      color: priority.isSelected
                                          ? Colors.white
                                          : priority.color,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      priority.title,
                                      style: TextStyle(
                                        color: priority.isSelected
                                            ? Colors.white
                                            : Colors.black87,
                                        fontWeight: priority.isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getPriorityIcon(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Icons.priority_high;
      case Priority.medium:
        return Icons.remove;
      case Priority.low:
        return Icons.keyboard_arrow_down;
    }
  }

  Future<void> _selectDate() async {
    final DateTime? selectedDate = await CommonUtils.setCalendar(context);
    if (selectedDate != null) {
      setState(() {
        _selectedDateTime = selectedDate;
        _dateController.text = CommonUtils.getDate(selectedDate.toIso8601String());
      });
    }
  }

  void _selectPriority(PriorityLevel priority) {
    setState(() {
      for (final element in _priorityLevelList) {
        element.isSelected = false;
      }
      priority.isSelected = true;
      _selectedPriority = priority;
    });
    _streamController.add(_priorityLevelList);
  }

  void _saveTask() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
      return;
    }

    if (_selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a due date')),
      );
      return;
    }

    if (_selectedPriority == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a priority level')),
      );
      return;
    }

    final task = TodoTask(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      taskDate: _selectedDateTime!.toIso8601String(),
      createdDate: DateTime.now().toIso8601String(),
      level: _selectedPriority!.index,
      isCompleted: 0,
    );

    Navigator.of(context).pop(task);
  }
}
