import 'package:flutter/material.dart';
import 'package:task_manager3/ui/screens/cancelled_task_list_screen.dart';
import 'package:task_manager3/ui/screens/completed_task_list_screen.dart';
import 'package:task_manager3/ui/screens/new_task_list_screen.dart';
import 'package:task_manager3/ui/screens/progress_task_list_screen.dart';
import 'package:task_manager3/ui/widgets/tm_app_bar.dart';

class MainNavBarHolderScreen extends StatefulWidget {
  const MainNavBarHolderScreen({super.key});

  static String name = 'nav-bar-holder';

  @override
  State<MainNavBarHolderScreen> createState() => _MainNavBarHolderScreenState();
}

class _MainNavBarHolderScreenState extends State<MainNavBarHolderScreen> {
  List<Widget> _screens = [
    NewTaskListScreen(),
    CompletedTaskListScreen(),
    CancelledTaskListScreen(),
    ProgressTaskListScreen(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.green,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label_outlined),
            label: 'New Task',
          ),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.close), label: 'Cancelled'),
          NavigationDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}
