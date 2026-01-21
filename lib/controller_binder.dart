import 'package:get/get.dart';
import 'package:task_manager3/ui/controller/sign_in_controller.dart';
import 'package:task_manager3/ui/controller/sign_up_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
  }

}