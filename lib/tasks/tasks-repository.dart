import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './tasks-model.dart';

import '../utils/constants.dart';

class TasksRepository {
  Future<List<Task>> getAllTasks() async {

      var response = await http.get("${Constants.baseUrl}/all-tasks");
      var items = json.decode(response.body);

      List<Task> result = new List<Task>();
      for (var i = 0; i < items.length; i++) {
        print(items[i]);
        result.add(Task.fromJson(items[i]));
      }
      return result;
   
  }

  Future<void> addTask(Task task) async {
      
    String json =
        '{ "userId": ${task.userId}, "description": "${task.description}", "completed": ${task.completed}}';
    Map<String, String> headers = {"Content-type": "application/json"};

    await http.post("${Constants.baseUrl}/tasks", headers: headers, body: json);
  }

  Future<void> updateTask(Task task) async {
    String json =
        '{ "id": ${task.id}, "userId": ${task.userId}, "description": "${task.description}", "completed": ${task.completed}}';
    Map<String, String> headers = {"Content-type": "application/json"};

    await http.put("${Constants.baseUrl}/tasks", headers: headers, body: json);
  }

  Future<void> deleteTask(int id) async {
 
    Map<String, String> headers = {"Content-type": "application/json"};
    await http.delete("${Constants.baseUrl}/tasks/$id", headers: headers);
  }
}
