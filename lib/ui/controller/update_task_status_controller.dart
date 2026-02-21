import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/service/urls.dart';

class UpdateTaskStatusController extends GetxController{
  bool _updateTaskStatusInProgress = false;
  String? _errorMessage;

  bool get updateTaskStatusInProgress => _updateTaskStatusInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> updateTaskStatus(String id,String status) async {
    bool isSuccess = false;
    _updateTaskStatusInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.updateTaskStatusUrl(id, status),
    );

    _updateTaskStatusInProgress = false;
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