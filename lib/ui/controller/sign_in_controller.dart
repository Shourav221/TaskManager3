import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../data/models/user_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/service/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController{
  bool _inProgress =false;
  String? _errorMessage;
  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  Future<bool> signIn(String email,String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, String> requestBody = {
      "email": email,
      "password": password,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.logInUrl,
      body: requestBody,
      isFromLogin: true,
    );

    _inProgress = true;
    update();

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(response.body!['data']);
      String token = response.body!['token'];

      await AuthController.saveUserData(userModel, token);
      isSuccess = true;
      _errorMessage = null;
      }
     else {
       _errorMessage = response.errorMessage!;
      }
     _inProgress = false;
     update();
     return isSuccess;
    }
  }