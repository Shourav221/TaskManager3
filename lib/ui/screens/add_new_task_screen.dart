import 'package:flutter/material.dart';
import 'package:task_manager3/data/service/network_caller.dart';
import 'package:task_manager3/data/service/urls.dart';
import 'package:task_manager3/ui/widgets/screen_background.dart';
import 'package:task_manager3/ui/widgets/show_snack_bar_message.dart';
import 'package:task_manager3/ui/widgets/tm_app_bar.dart';

import '../../app.dart';
import '../widgets/centered_circular_progress_indicator.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});
  static String name = 'add-new-task';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewTaskInProgress = false;
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
                  textInputAction: TextInputAction.next,
                  controller: _subjectTEController,
                  decoration: InputDecoration(hintText: 'Subject'),
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
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Visibility(
                  visible: _addNewTaskInProgress == false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapAddNewTask,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
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
    // Navigator.pushReplacementNamed(context, MainNavBarHolderScreen.name);

    // Navigator.pop(context);
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});

    Map<String, String> requestBody = {
      "title": _subjectTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New",
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createTaskUrl,
      body: requestBody,
    );
    _addNewTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _subjectTEController.clear();
      _descriptionTEController.clear();
      showSnackBarMessage(
        TaskManagerApp.navigator.currentContext!,
        "New task added",
      );
    } else {
      showSnackBarMessage(
        TaskManagerApp.navigator.currentContext!,
        response.errorMessage,
      );
    }
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
