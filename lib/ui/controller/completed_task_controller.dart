import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task_manager3/data/models/task_model.dart';

import '../../data/service/network_caller.dart';
import '../../data/service/urls.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTaskInProgress = false;
  String? _errorMessage;

  List<TaskModel> _completedTaskList = [];

  bool get getCompletedTaskInProgress => _getCompletedTaskInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get completedTasklist => _completedTaskList;

  Future<bool> getCompletedTask() async {
    bool isSuccess = false;
    _getCompletedTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getCompletedTasksUrl,
    );

    if (response.isSuccess) {
      _completedTaskList.clear();

      for (Map<String, dynamic> jsonData in response.body!['data']) {
        _completedTaskList.add(TaskModel.fromJson(jsonData));
        _errorMessage = null;
        isSuccess = true;
      }
    } else {
      _errorMessage = response.errorMessage!;
      isSuccess = false;
    }

    _getCompletedTaskInProgress = false;
    update();
    return isSuccess;
  }
}
