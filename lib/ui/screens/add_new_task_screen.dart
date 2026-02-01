import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager3/ui/controller/add_new_task_controller.dart';
import 'package:task_manager3/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_manager3/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager3/ui/widgets/screen_background.dart';
import 'package:task_manager3/ui/widgets/show_snack_bar_message.dart';
import 'package:task_manager3/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});
  static String name = 'add-new-task';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _titleTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'title'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty == true) {
                      return "Enter your title.";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionTEController,
                  maxLines: 6,
                  decoration: InputDecoration(hintText: 'Description'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty == true) {
                      return "Enter any description";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 12),
                GetBuilder<AddNewTaskController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.addNewTaskInProgress == false,
                      replacement: CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapAddNewTask,
                        child: Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddNewTask() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    bool isSuccess = await Get.find<AddNewTaskController>().addNewTask(
      _titleTEController.text.trim(),
      _descriptionTEController.text.trim(),
    );

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, "New task added successfully");
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          Get.find<AddNewTaskController>().errorMessage,
        );
      }
    }
    Get.offAllNamed(MainNavBarHolderScreen.name);
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
