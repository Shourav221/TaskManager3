import 'package:flutter/material.dart';
import 'package:task_manager3/ui/widgets/screen_background.dart';
import 'package:task_manager3/ui/widgets/tm_app_bar.dart';

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
                  controller: _subjectTEController,
                  decoration: InputDecoration(hintText: 'Subject'),
                  validator: (String? value){
                    if(value?.trim().isEmpty == true){
                      return "Enter your title.";
                    }
                    else null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionTEController,
                  maxLines: 6,
                  decoration: InputDecoration(hintText: 'Description'),
                  validator: (String? value){
                    if(value?.trim().isEmpty == true){
                      return "Enter any description";
                    }
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _onTapAddNewTask,
                  child: Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddNewTask() {
    if(_formKey.currentState!.validate()){

    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
