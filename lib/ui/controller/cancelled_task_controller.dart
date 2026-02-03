import 'package:get/get.dart';
import 'package:task_manager3/data/models/task_model.dart';

import '../../data/service/network_caller.dart';
import '../../data/service/urls.dart';

class CancelledTaskController extends GetxController {
  bool _getCancelledTaskInProgress = false;
  String? _errorMessage;
  List<TaskModel> _cancelledTaskList = [];

  bool get getControlledTaskInProgress => _getCancelledTaskInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get cancelledTaskList => _cancelledTaskList;

  Future<bool> getCancelledTask() async {
    bool isSuccess = false;
    _getCancelledTaskInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getCancelledTasksUrl,
    );
    if (response.isSuccess) {
      _cancelledTaskList.clear();
      for(Map<String,dynamic> jsonData in response.body!['data']){
        _cancelledTaskList.add(TaskModel.fromJson(jsonData));
      }
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage!;
    }
    _getCancelledTaskInProgress = false;
    update();
    return isSuccess;
  }
}
