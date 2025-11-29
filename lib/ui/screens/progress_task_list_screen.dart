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
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _getProgressList = [];

  @override
  void initState() {
    _getProgressTask();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _getProgressTaskInProgress == false,
      replacement: CenteredCircularProgressIndicator(),
      child: ListView.builder(
        itemCount: _getProgressList.length,
        itemBuilder: (context, index) {
          return TaskCard(
            taskType: TaskType.progress,
            taskModel: _getProgressList[index],
          );
        },
      ),
    );
  }

  Future<void> _getProgressTask() async {
    _getProgressTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getProgressTasksUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _getProgressList = list;
    }

    _getProgressTaskInProgress = false;
    setState(() {});
  }
}
