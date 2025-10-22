import 'package:flutter/material.dart';

enum TaskType { tNew, completed, cancelled, progress }

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.taskType});

  final TaskType taskType;

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
            Text('Title', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Description', style: TextStyle(color: Colors.black54)),
            Text('Date: 12/12/12'),
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
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTaskChipColor() {
    if (taskType == TaskType.tNew) {
      return Colors.blue;
    } else if (taskType == TaskType.completed) {
      return Colors.green;
    } else if (taskType == TaskType.progress) {
      return Colors.purple;
    } else {
      return Colors.red;
    }
  }

  String _getTaskTypeName() {
    if (taskType == TaskType.tNew) {
      return 'New';
    } else if (taskType == TaskType.completed) {
      return 'Completed';
    } else if (taskType == TaskType.cancelled) {
      return 'Cancelled';
    } else {
      return 'Progress';
    }
  }
}
