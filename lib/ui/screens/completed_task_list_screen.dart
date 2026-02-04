import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager3/ui/controller/completed_task_controller.dart';
import 'package:task_manager3/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager3/ui/widgets/show_snack_bar_message.dart';

import '../widgets/task_card.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() =>
      _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCompletedTask();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompletedTaskController>(
      builder: (controller) {
        return Visibility(
          visible: controller.getCompletedTaskInProgress == false,
          replacement: CenteredCircularProgressIndicator(),
          child: ListView.builder(
            itemCount: controller.completedTasklist.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskType: TaskType.completed,
                taskModel: controller.completedTasklist[index],
                onStatusUpdate: () {
                  controller.completedTasklist;
                },
                onDeleteTask: () {
                  controller.completedTasklist;
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _getCompletedTask() async {
    bool isSuccess = await Get.find<CompletedTaskController>()
        .getCompletedTask();
    if (!isSuccess && mounted) {
      showSnackBarMessage(
        context,
        Get.find<CompletedTaskController>().errorMessage,
      );
    }
  }
}
