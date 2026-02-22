import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/service/urls.dart';

class DeleteTaskController extends GetxController{
  bool _deleteTaskInProgress = false;
  String? _errorMessage;

  bool get deleteTaskInProgress => _deleteTaskInProgress;
  String? get errorMessage => _errorMessage;
  Future<bool> deleteTask(String id) async {
    bool isSuccess = false;
    _deleteTaskInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteTaskUrl(id),
    );
    _deleteTaskInProgress = false;
    update();

    if (response.isSuccess) {
     _errorMessage = null;
     isSuccess = true;
    } else {
     _errorMessage = response.errorMessage!;
     isSuccess = false;
    }
    return isSuccess;
  }

}