import 'package:flutter/material.dart';
import 'tasks-bloc.dart';
import 'tasks-model.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.getTasks();
    return Scaffold(
      appBar: AppBar(
        title: Text("GraphlQL Client"),
      ),
      body: StreamBuilder(
        stream: bloc.allTasks,
        builder: (context, AsyncSnapshot<TasksModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<TasksModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.tasks.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (BuildContext context, int index) {
           return  Text(snapshot.data.tasks[index].description);
        });
  }
}
