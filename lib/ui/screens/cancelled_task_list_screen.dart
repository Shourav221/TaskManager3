import 'package:flutter/material.dart';
import 'package:task_manager3/data/models/task_model.dart';
import 'package:task_manager3/data/service/network_caller.dart';
import 'package:task_manager3/data/service/urls.dart';
import 'package:task_manager3/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager3/ui/widgets/show_snack_bar_message.dart';
import 'package:task_manager3/ui/widgets/task_card.dart';

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() =>
      _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {
  bool _getCancelledTaskInProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCancelledTask();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _getCancelledTaskInProgress == false,
      replacement: CenteredCircularProgressIndicator(),
      child: ListView.builder(
        itemCount: _cancelledTaskList.length,
        itemBuilder: (context, index) {
          return TaskCard(
            taskType: TaskType.cancelled,
            taskModel: _cancelledTaskList[index],
            onStatusUpdate: () {
              _cancelledTaskList;
            },
          );
        },
      ),
    );
  }

  Future<void> _getCancelledTask() async {
    _getCancelledTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getCancelledTasksUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTaskList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }

    _getCancelledTaskInProgress = false;
    setState(() {});
  }
}
