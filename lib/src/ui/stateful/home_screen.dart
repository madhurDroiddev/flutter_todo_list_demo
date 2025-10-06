import 'dart:async';

import 'package:task_manager/src/bloc/home_bloc.dart';
import 'package:task_manager/src/modals/task.dart';
import 'package:task_manager/src/ui/cards/task_card.dart';
import 'package:task_manager/src/utils/routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _bloc;
  List<TodoTask> _taskList = [];

  @override
  void initState() {
    super.initState();
    _bloc = HomeBloc();
    _bloc.fetchAllTasks();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<TodoTask>>(
        stream: _bloc.taskStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading tasks',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _bloc.fetchAllTasks(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            _taskList = snapshot.data!;
            if (_taskList.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _taskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    task: _taskList[index],
                    onDelete: () => _bloc.delete(_taskList[index]),
                    onToggleComplete: () => _toggleTaskComplete(_taskList[index]),
                  );
                },
              );
            } else {
              return _buildEmptyState();
            }
          }

          return _buildEmptyState();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks yet!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first task',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToAddTask() async {
    final task = await Navigator.of(context).pushNamed(
      Routes.addTask,
      arguments: {'length': _taskList.length},
    );

    if (task != null && task is TodoTask) {
      await _bloc.saveTask(task);
    }
  }

  Future<void> _toggleTaskComplete(TodoTask task) async {
    final updatedTask = task.copyWith(
      isCompleted: task.isCompleted == 1 ? 0 : 1,
    );
    await _bloc.updateTask(updatedTask);
  }
}
