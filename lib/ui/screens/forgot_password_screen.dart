import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager3/data/service/network_caller.dart';
import 'package:task_manager3/data/service/urls.dart';
import 'package:task_manager3/ui/controller/auth_controller.dart';
import 'package:task_manager3/ui/screens/pin_verification_screen.dart';
import 'package:task_manager3/ui/screens/sign_in_screen.dart';
import 'package:task_manager3/ui/widgets/screen_background.dart';
import 'package:task_manager3/ui/widgets/show_snack_bar_message.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static String name = 'forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();

  bool _forgotPasswordInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  'Your Email Address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digit verification pin will send to your email address',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (String? value) {
                    String email = value ?? '';
                    if (EmailValidator.validate(email) == false) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onTapForgotPassword,
                  child: Icon(Icons.arrow_circle_right_outlined),
                ),
                const SizedBox(height: 16),
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


  void _onTapForgotPassword() {
    if (_formKey.currentState!.validate()) {
      _forgotPassword();
    }
  }

  void _onTapSignIn() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }


  Future<void> _forgotPassword() async {
    _forgotPasswordInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverVerifyEmail(_emailTEController.text),
    );

    _forgotPasswordInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, PinVerificationScreen.name);
        showSnackBarMessage(context, 'A 6 digit OTP code sent to your email');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage);
      }
    }
  }


  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
