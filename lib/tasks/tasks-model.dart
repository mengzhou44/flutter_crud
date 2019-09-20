class Task {
  int id;
  String description;
  bool completed;
  int userId;

  Task({this.userId,  this.completed, this.description});

  Task.newTask() {
      id=0;
      description ='';
      completed = true;
      userId =0;
  }

  Task.fromJson(result) {
    
    id = result['id'];
    description = result['description'];
    completed = result['completed'];
    userId = result['userId'];
  }
}
