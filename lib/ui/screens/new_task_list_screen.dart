import 'package:flutter/material.dart';
import 'package:task_manager3/ui/screens/add_new_task_screen.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_summary_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
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
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TaskCountSummaryCard(title: 'Cancelled', count: 13);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 4);
                },
                itemCount: 4,
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TaskCard(taskType: TaskType.tNew,);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),


    );
  }
  void _onTapAddNewTaskButton(){
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }
}
