import 'package:flutter/material.dart';
import 'tasks-model.dart';
import 'tasks-bloc.dart';
import '../utils/constants.dart';

class TasksForm extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Task task;

  TasksForm({Key key, this.task, this.scaffoldKey}) : super(key: key);

  @override
  TasksFormState createState() => new TasksFormState(task: this.task);
}

class TasksFormState extends State<TasksForm> {
  String formTitle;
  String saveButtonText;
  Task task;
  TasksFormState({this.task}) {
   
    if (task.id == null) {
      formTitle = 'Add Task';
      saveButtonText = 'Add';
    } else {
      formTitle = 'Change Task';
      saveButtonText = 'Save';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding)),
      elevation: 0.0,
      child: content(context),
    );
  }

  getUserId() {
    if (task.userId == 0) {
      return "";
    }
    return widget.task.userId.toString();
  }

  saveTask() async {
    try {
      if (task.id == null) {
        await bloc.addTask(task);
      } else {
        await bloc.updateTask(task);
        await bloc.getAllTasks();
      }
    } catch (e) {
      widget.scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Error occured when saving tasks.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.teal[100],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0))));
    }
  }

  content(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Constants.padding,
        bottom: Constants.padding,
        left: Constants.padding,
        right: Constants.padding,
      ),
      decoration: new BoxDecoration(
        color: Colors.teal[100],
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Constants.padding),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Text(
            formTitle,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
              decoration: InputDecoration(hintText: 'Description'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'description is required!';
                }
                return null;
              },
              initialValue: task.description,
              onChanged: (value) {
                this.setState(() {
                  task.description = value;
                });
              }),
          SizedBox(height: 24.0),
          TextFormField(
              decoration: InputDecoration(hintText: 'User Id'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'User Id is required!';
                }
                return null;
              },
              initialValue: getUserId(),
              onChanged: (value) {
                this.setState(() {
                  task.userId = int.parse(value);
                });
              }),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    await saveTask();
                    Navigator.of(context).pop();
                  },
                  child: Text(saveButtonText),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
