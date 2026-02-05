import 'package:get/get.dart';
import 'package:task_manager3/data/models/task_model.dart';

import '../../data/service/network_caller.dart';
import '../../data/service/urls.dart';

class NewTaskController extends GetxController{
  bool _getNewTasksInProgress = false;
  List<TaskModel> _newTaskList = [];
  String? _errorMessage;

  bool get getNewTaskInProgress => _getNewTasksInProgress;
  List<TaskModel> get newTaskList => _newTaskList;
  String? get errorMessage => _errorMessage;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTasksInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getNewTasksUrl,
    );

    if (response.isSuccess) {
      _newTaskList.clear();
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        _newTaskList.add(TaskModel.fromJson(jsonData));
      }
      _errorMessage = null;
      isSuccess = true;

    } else {
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }

    _getNewTasksInProgress = false;
    update();
    return isSuccess;
  }
}