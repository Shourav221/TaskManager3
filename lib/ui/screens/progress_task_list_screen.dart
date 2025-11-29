import 'package:flutter/material.dart';
import 'package:task_manager3/data/models/task_model.dart';
import 'package:task_manager3/data/service/network_caller.dart';
import 'package:task_manager3/data/service/urls.dart';
import 'package:task_manager3/ui/widgets/centered_circular_progress_indicator.dart';

import '../widgets/task_card.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        // return TaskCard(
        //   taskType: TaskType.progress,
        //   taskModel: _getProgressList[index],
        // );
      },
    );
  }

}
