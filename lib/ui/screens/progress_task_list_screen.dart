import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager3/ui/controller/progress_task_controller.dart';
import 'package:task_manager3/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager3/ui/widgets/show_snack_bar_message.dart';

import '../widgets/task_card.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProgressTask();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressTaskController>(
      builder: (controller) {
        return Visibility(
          visible: controller.getProgressTaskInProgress == false,
          replacement: CenteredCircularProgressIndicator(),
          child: ListView.builder(
            itemCount: controller.progressList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskType: TaskType.progress,
                taskModel: controller.progressList[index],
                onStatusUpdate: () {
                  controller.progressList;
                },
                onDeleteTask: () {
                  controller.progressList;
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _getProgressTask() async {
    bool isSuccess = await Get.find<ProgressTaskController>().getProgressTask();

    if (!isSuccess && mounted) {
      showSnackBarMessage(
        context,
        Get.find<ProgressTaskController>().getProgressTask(),
      );
    }
  }
}
