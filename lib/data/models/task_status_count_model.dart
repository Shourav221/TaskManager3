class TaskStatusCountModel{
  late String id;
  late int sum;

  TaskStatusCountModel.fromJson(Map<String,dynamic> jsonData){
    id = jsonData['_id'];
    sum = jsonData['sum'];
  }
}
