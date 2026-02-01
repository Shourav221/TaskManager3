import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/service/urls.dart';
class AddNewTaskController extends GetxController{
  bool _addNewTaskInProgress = false;
  String? _errorMessage;

  bool get addNewTaskInProgress => _addNewTaskInProgress;
  String? get errorMessage => _errorMessage;
  Future<bool> addNewTask(String title,String description) async {
    bool isSuccess = false;
    _addNewTaskInProgress = true;
    update();

    Map<String, String> requestedBody = {
      "title": title,
      "description": description,
      "status": "New",
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createTaskUrl,
      body: requestedBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _addNewTaskInProgress = false;
    update();
    return isSuccess;
  }
}