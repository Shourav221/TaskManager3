import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager3/ui/controller/cancelled_task_controller.dart';
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCancelledTask();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancelledTaskController>(
      builder: (controller) {
        return Visibility(
          visible: controller.getControlledTaskInProgress == false,
          replacement: CenteredCircularProgressIndicator(),
          child: ListView.builder(
            itemCount: controller.cancelledTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskType: TaskType.cancelled,
                taskModel: controller.cancelledTaskList[index],
                onStatusUpdate: () {
                  controller.cancelledTaskList;
                },
                onDeleteTask: () {
                  controller.cancelledTaskList;
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _getCancelledTask() async {
    bool isSuccess = await Get.find<CancelledTaskController>()
        .getCancelledTask();
    if (!isSuccess && mounted) {
      showSnackBarMessage(
        context,
        Get.find<CancelledTaskController>().errorMessage,
      );
    }
  }
}
