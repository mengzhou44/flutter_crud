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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            tasks(bloc),

          ],
        ));
  }

  Widget tasks(TasksBloc bloc) {
    return Flexible(
      child: StreamBuilder(
        stream: bloc.allTasks,
        builder: (context, AsyncSnapshot<TasksModel> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data.tasks.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 0,
                  childAspectRatio: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  Task task = snapshot.data.tasks[index];
                  return Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      
                      child: Center(
                          child: Text(
                              "${task.id},  ${task.userId}, ${task.completed},${task.description}" ,
                              style: TextStyle(fontSize: 18)
                              ) ,
                      ) ,
                      color: Colors.teal[100]);
                });
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
