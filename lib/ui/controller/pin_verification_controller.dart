import 'package:get/get.dart';
import '../../data/service/network_caller.dart';
import '../../data/service/urls.dart';

class PinVerificationController extends GetxController{
  bool _verifyOtpInProgress = false;
  String? _errorMessage;

  bool get verifyOtpInProgress => _verifyOtpInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(String otp,String email) async {

    bool isSuccess = false;
    _verifyOtpInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverVerifyOtp(email, otp),
    );
    _verifyOtpInProgress = false;
    update();

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;

    } else {
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }
    return isSuccess;
  }


}