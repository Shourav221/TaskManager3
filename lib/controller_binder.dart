import 'package:get/get.dart';
import 'package:task_manager3/ui/controller/add_new_task_controller.dart';
import 'package:task_manager3/ui/controller/cancelled_task_controller.dart';
import 'package:task_manager3/ui/controller/completed_task_controller.dart';
import 'package:task_manager3/ui/controller/forgot_password_controller.dart';
import 'package:task_manager3/ui/controller/new_task_controller.dart';
import 'package:task_manager3/ui/controller/progress_task_controller.dart';
import 'package:task_manager3/ui/controller/sign_in_controller.dart';
import 'package:task_manager3/ui/controller/sign_up_controller.dart';
import 'package:task_manager3/ui/controller/task_status_count_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(AddNewTaskController());
    Get.put(CancelledTaskController());
    Get.put(CompletedTaskController());
    Get.put(ForgotPasswordController());
    Get.put(NewTaskController());
    Get.put(TaskStatusCountController());
    Get.put(ProgressTaskController());
  }
}
