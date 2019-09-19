import 'package:flutter/material.dart';
import 'tasks-bloc.dart';
import 'tasks-model.dart';
import '../widgets/button.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.getAllTasks();
    return Scaffold(
        appBar: AppBar(
          title: Text("Restful Client"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            showTasks(bloc),
            Container(
              padding: EdgeInsets.only(bottom: 40),
              child: Button(
                buttonText: 'Add',
                onPressed: () async {
                  await bloc.addTask(new Task(
                      completed: false,
                      description: 'go to church',
                      userId: 1));
                  await bloc.getAllTasks();
                },
              ),
            )
          ],
        ));
  }

  Widget showTasks(TasksBloc bloc) {
    return Flexible(
      child: StreamBuilder(
        stream: bloc.allTasks,
        builder: (context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 0,
                  childAspectRatio: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  Task task = snapshot.data[index];
                  return Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                            "${task.id},  ${task.userId}, ${task.completed},${task.description}",
                            style: TextStyle(fontSize: 18)),
                      ),
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
