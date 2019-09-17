class TasksModel {

  List<Task>  tasks = [];

  TasksModel.fromJson(List<Map<String, dynamic>> parsedJson) {
    List<Task> temp = [];
    for (int i = 0; i < parsedJson.length; i++) {
       Task result = Task(parsedJson[i]);
      temp.add(result);
    }
    tasks = temp;
  }
}

class Task {
  
  int id;
  String description;
  bool completed;
  int userId;

  Task(result) {
    id = result['id'];
    description = result['description'];
    // completed = result['completed'] as bool;
    // userId= result['userId'];
  }
 
}
