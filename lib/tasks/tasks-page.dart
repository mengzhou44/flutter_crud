import 'package:flutter/material.dart';
import 'tasks-bloc.dart';
import 'tasks-model.dart';
import '../widgets/button.dart';
import '../widgets/confirm.dart';
import 'tasks-form.dart';

class TasksPage extends StatelessWidget {

  final GlobalKey  _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    bloc.getAllTasks();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Tasks to do"),
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
                        TasksForm(task: Task.newTask(), scaffoldKey: _scaffoldKey),
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
                  childAspectRatio: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  Task task = snapshot.data[index];
                  return Dismissible(
                    background: stackBehindDismiss(),
                    key: ObjectKey(task),
                    child: Container(
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
                                      child: Text('Change'),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              TasksForm(task: task),
                                        );
                                      }))
                            ],
                          ),
                        ),
                        color: Colors.teal[100]),
                    onDismissed: (direction) async {
                      await bloc.deleteTask(task.id);
                      await bloc.getAllTasks();
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Task ${task.id}  is deleted.")));
                    },
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Confirm(
                                confirmText:
                                    "Are you sure you want to delete this task?");
                          });
                    },
                  );
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

Widget stackBehindDismiss() {
  return Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 20.0),
    color: Colors.teal[100],
    child: Icon(
      Icons.delete,
      color: Colors.red,
    ),
  );
}
