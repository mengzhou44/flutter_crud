import 'package:flutter/material.dart';
 
import './tasks/tasks-page.dart';

void main() {
  runApp(MaterialApp(title: "CRUD", home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TasksPage();
  }
}
