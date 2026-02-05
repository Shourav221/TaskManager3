import 'package:get/get.dart';
import '../../data/models/task_status_count_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/service/urls.dart';

class TaskStatusCountController extends GetxController {
  bool _getTaskStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  String? _errorMessage;

  bool get getTaskStatusCountInProgress => _getTaskStatusCountInProgress;
  List<TaskStatusCountModel> get taskStatusCountList => _taskStatusCountList;
  String? get errorMessage => _errorMessage;

  Future<bool> getTaskStatusCount() async {
    bool isSuccess = false;
    _getTaskStatusCountInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getTaskStatusCountUrl,
    );

    if (response.isSuccess) {
      _taskStatusCountList.clear();
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        _taskStatusCountList.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }

    _getTaskStatusCountInProgress = false;
    update();
    return isSuccess;
  }
}
