import 'package:task_manager/src/modals/task.dart';
import 'package:task_manager/src/utils/app_utils.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final TodoTask task;
  final VoidCallback onDelete;
  final VoidCallback? onToggleComplete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onDelete,
    this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.isCompleted == 1;
    final priorityColor = CommonUtils.getPriorityColor(task.level);
    final priorityText = CommonUtils.getPriorityText(task.level);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      child: InkWell(
        onTap: onToggleComplete,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: priorityColor.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: isCompleted 
                            ? TextDecoration.lineThrough 
                            : null,
                        color: isCompleted 
                            ? Colors.grey[600] 
                            : null,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (onToggleComplete != null)
                    Checkbox(
                      value: isCompleted,
                      onChanged: (_) => onToggleComplete?.call(),
                      activeColor: priorityColor,
                    ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: onDelete,
                    color: Colors.red[400],
                    tooltip: 'Delete task',
                  ),
                ],
              ),
              if (task.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  task.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isCompleted ? Colors.grey[500] : Colors.grey[700],
                    decoration: isCompleted 
                        ? TextDecoration.lineThrough 
                        : null,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getPriorityIcon(task.level),
                          size: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          priorityText,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Due: ${CommonUtils.getDate(task.taskDate)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getDueDateColor(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (task.createdDate.isNotEmpty)
                        Text(
                          'Created: ${CommonUtils.getDate(task.createdDate)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getPriorityIcon(int level) {
    switch (level) {
      case 0: // High
        return Icons.priority_high;
      case 1: // Medium
        return Icons.remove;
      case 2: // Low
        return Icons.keyboard_arrow_down;
      default:
        return Icons.help_outline;
    }
  }

  Color _getDueDateColor() {
    try {
      final dueDate = DateTime.parse(task.taskDate);
      final now = DateTime.now();
      final difference = dueDate.difference(now).inDays;

      if (difference < 0) {
        return Colors.red; // Overdue
      } else if (difference <= 1) {
        return Colors.orange; // Due soon
      } else {
        return Colors.grey[600]!; // Normal
      }
    } catch (e) {
      return Colors.grey[600]!;
    }
  }
}
