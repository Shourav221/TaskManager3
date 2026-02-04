import 'package:get/get.dart';
import 'package:task_manager3/data/service/network_caller.dart';
import 'package:task_manager3/data/service/urls.dart';

class ForgotPasswordController extends GetxController {
  bool _forgotPasswordInProgress = false;
  String? _errorMessage;

  bool get forgotPasswordInProgress => _forgotPasswordInProgress;
  String? get errorMessage => _errorMessage;
  Future<bool> forgotPassword(String email) async {
    bool isSuccess = false;
    _forgotPasswordInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverVerifyEmail(email),
    );
    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }

    _forgotPasswordInProgress = false;
    update();
    return isSuccess;
  }
}
