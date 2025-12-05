import 'package:flutter/material.dart';
import 'package:task_manager3/data/models/task_model.dart';
import 'package:task_manager3/data/service/network_caller.dart';
import 'package:task_manager3/data/service/urls.dart';
import 'package:task_manager3/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager3/ui/widgets/show_snack_bar_message.dart';

enum TaskType { tNew, completed, cancelled, progress }

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskType,
    required this.taskModel,
    required this.onStatusUpdate,
    required this.onDeleteTask,
  });

  final TaskType taskType;
  final TaskModel taskModel;
  final VoidCallback onStatusUpdate;
  final VoidCallback onDeleteTask;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInProgress = false;
  bool _deleteTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              widget.taskModel.description,
              style: TextStyle(color: Colors.black54),
            ),
            Text("Date: ${widget.taskModel.createdDate}"),
            const SizedBox(height: 13),
            Row(
              children: [
                Chip(
                  label: Text(
                    _getTaskTypeName(),
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  backgroundColor: _getTaskChipColor(),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                Spacer(),
                Visibility(
                  visible: _updateTaskStatusInProgress == false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: IconButton(
                    onPressed: _showTaskStatusDialog,
                    icon: Icon(Icons.edit),
                  ),
                ),
                Visibility(
                  visible: _deleteTaskInProgress == false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: IconButton(
                    onPressed: () {
                      _showDeleteTaskDialog();
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTaskChipColor() {
    if (widget.taskType == TaskType.tNew) {
      return Colors.blue;
    } else if (widget.taskType == TaskType.completed) {
      return Colors.green;
    } else if (widget.taskType == TaskType.progress) {
      return Colors.purple;
    } else {
      return Colors.red;
    }
  }

  String _getTaskTypeName() {
    if (widget.taskType == TaskType.tNew) {
      return 'New';
    } else if (widget.taskType == TaskType.completed) {
      return 'Completed';
    } else if (widget.taskType == TaskType.cancelled) {
      return 'Cancelled';
    } else {
      return 'Progress';
    }
  }

  void _showTaskStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('New'),
                trailing: _getTaskStatusTrailing(TaskType.tNew),
                onTap: () {
                  if (widget.taskType == TaskType.tNew) {
                    return;
                  } else {
                    _updateTaskStatus('New');
                  }
                },
              ),
              ListTile(
                title: Text('Completed'),
                trailing: _getTaskStatusTrailing(TaskType.completed),
                onTap: () {
                  if (widget.taskType == TaskType.completed) {
                    return;
                  } else {
                    _updateTaskStatus('Completed');
                  }
                },
              ),
              ListTile(
                title: Text('Cancelled'),
                trailing: _getTaskStatusTrailing(TaskType.cancelled),
                onTap: () {
                  if (widget.taskType == TaskType.cancelled) {
                    return;
                  } else {
                    _updateTaskStatus('Cancelled');
                  }
                },
              ),
              ListTile(
                title: Text('Progress'),
                trailing: _getTaskStatusTrailing(TaskType.progress),
                onTap: () {
                  if (widget.taskType == TaskType.progress) {
                    return;
                  } else {
                    _updateTaskStatus('Progress');
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget? _getTaskStatusTrailing(TaskType taskType) {
    return widget.taskType == taskType ? Icon(Icons.check) : null;
  }

  Future<void> _updateTaskStatus(String status) async {
    Navigator.pop(context);
    _updateTaskStatusInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.updateTaskStatusUrl(widget.taskModel.id, status),
    );

    _updateTaskStatusInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      widget.onStatusUpdate();
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage);
      }
    }
  }

  void _showDeleteTaskDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Delete Task?'),
          content: Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Cancel'),
            ),
            TextButton(onPressed: () {
              Navigator.pop(ctx);
              _deleteTask();
            }, child: Text('Delete')),
          ],
        );
      },
    );
  }

  Future<void> _deleteTask() async {
    _deleteTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteTaskUrl(widget.taskModel.id),
    );
    _deleteTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      widget.onDeleteTask();
      if (mounted) {
        showSnackBarMessage(context, 'Task deleted');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage);
      }
    }
  }
}
