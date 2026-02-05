import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager3/ui/controller/new_task_controller.dart';
import 'package:task_manager3/ui/controller/task_status_count_controller.dart';
import 'package:task_manager3/ui/screens/add_new_task_screen.dart';
import 'package:task_manager3/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager3/ui/widgets/show_snack_bar_message.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_summary_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getNewTaskList();
      _getTaskStatusCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 15),
            SizedBox(
              height: 100,
              child: GetBuilder<TaskStatusCountController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.getTaskStatusCountInProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return TaskCountSummaryCard(
                          title: controller.taskStatusCountList[index].id,
                          count: controller.taskStatusCountList[index].count,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 4);
                      },
                      itemCount: controller.taskStatusCountList.length,
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: GetBuilder<NewTaskController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.getNewTaskInProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ListView.builder(
                      itemCount: controller.newTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskType: TaskType.tNew,
                          taskModel: controller.newTaskList[index],
                          onStatusUpdate: () {
                            controller.newTaskList;
                            Get.find<TaskStatusCountController>()
                                .taskStatusCountList;
                          },
                          onDeleteTask: () {
                            controller.newTaskList;
                            Get.find<TaskStatusCountController>()
                                .taskStatusCountList;
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getTaskStatusCount() async {
    bool isSuccess = await Get.find<TaskStatusCountController>()
        .getTaskStatusCount();

    if (!isSuccess && mounted) {
      showSnackBarMessage(
        context,
        Get.find<TaskStatusCountController>().errorMessage,
      );
    }
  }

  Future<void> _getNewTaskList() async {
    bool isSuccess = await Get.find<NewTaskController>().getNewTaskList();

    if (!isSuccess && mounted) {
      showSnackBarMessage(context, Get.find<NewTaskController>().errorMessage);
    }
  }

  void _onTapAddNewTaskButton() {
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }
}
