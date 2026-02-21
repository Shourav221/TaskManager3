import 'package:get/get.dart';
import 'package:task_manager3/data/models/task_model.dart';

import '../../data/service/network_caller.dart';
import '../../data/service/urls.dart';

class ProgressTaskController extends GetxController {
  bool _getProgressTaskInProgress = false;
  String? _errorMessage;
  List<TaskModel> _progressList = [];

  bool get getProgressTaskInProgress => _getProgressTaskInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get progressList => _progressList;

  Future<bool> getProgressTask() async {
    bool isSuccess = false;
    _getProgressTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getProgressTasksUrl,
    );

    if (response.isSuccess) {
      _progressList.clear();
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }

    _getProgressTaskInProgress = false;
    update();
    return isSuccess;
  }
}
