import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager3/ui/screens/sign_in_screen.dart';
import 'package:task_manager3/ui/utils/assets_path.dart';
import 'package:task_manager3/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(
      context,
      SignInScreen.name
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(child: SvgPicture.asset(AssetsPath.logoSvg)),
      ),
    );
  }
}
