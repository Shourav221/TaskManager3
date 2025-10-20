import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager3/ui/screens/set_password_screen.dart';
import 'package:task_manager3/ui/screens/sign_in_screen.dart';
import 'package:task_manager3/ui/widgets/screen_background.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  static String name = 'pin-verification';

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  'PIN Verification',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  'A 6 digit verification pin will send to your email address',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                TextFormField(controller: _pinTEController),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: _onTapVerify, child: Text('Verify')),
                const SizedBox(height: 12),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Have account? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTapSignIn,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapVerify() {
    Navigator.pushReplacementNamed(
      context,
      SetPasswordScreen.name,
    );
  }

  void _onTapSignIn() {
    Navigator.pushReplacementNamed(
      context,
      SignInScreen.name,
    );
  }

  @override
  void dispose() {
    _pinTEController.dispose();
    super.dispose();
  }
}
