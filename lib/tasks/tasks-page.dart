import 'package:flutter/material.dart';
import 'tasks-bloc.dart';
import 'tasks-model.dart';
import '../widgets/button.dart';
import 'tasks-form.dart';

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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        TasksForm(task: new Task()),
                  );
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                             Expanded(
                               flex: 3,
                               child: Text(
                                  "${task.userId}, ${task.completed},${task.description}",
                                  
                                  style: TextStyle(fontSize: 18)),
                             ),
                             Expanded(
                               flex: 1,
                               child: FlatButton(
                                      child: Text('Change'), onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  TasksForm(task: task),
                                            );
                                      }),
                             )
                          ],
                        ),
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
