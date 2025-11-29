import 'package:flutter/material.dart';
import 'package:task_manager3/ui/controller/auth_controller.dart';
import 'package:task_manager3/ui/screens/sign_in_screen.dart';
import 'package:task_manager3/ui/screens/update_profile_screen.dart';

import '../../app.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({super.key});

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TMAppBarState extends State<TMAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: [
          CircleAvatar(),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: _onTapProfileBar,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shourav Mahato',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    'shourav@gmail.com',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(onPressed: _onTapLogOutButton, icon: Icon(Icons.logout)),
        ],
      ),
    );
  }

  void _onTapProfileBar() {
    if (ModalRoute.of(context)!.settings.name != UpdateProfileScreen.name) {
      Navigator.pushNamed(context, UpdateProfileScreen.name);
    }
  }

  void _onTapLogOutButton() async{
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
      TaskManagerApp.navigator.currentContext!,
      SignInScreen.name,
      (predicate) => false,
    );
  }
}
