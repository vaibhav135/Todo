import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/task_fields.dart';

class TaskList extends StatefulWidget {
  final tasks;
  TaskList({this.tasks});
  dynamic someMethod() {
    print("printing from TaskList $tasks");
  }

  @override
  _TaskListState createState() => _TaskListState(this.tasks);
}

class _TaskListState extends State<TaskList> {
  List<TaskFields> taskFields = <TaskFields>[];
  var _v;
  
  _TaskListState(this._v);
  void addList() {
    setState(() {
      taskFields.add(_v);
      print("printing from TaskListState $_v");
    });
  }

  @override
  Widget build(BuildContext context) {
    addList();
    // TODO: implement build
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: taskFields.length,
        itemBuilder: (context, index) {
          var item = taskFields[index];
          return Stack(
            children: [
              Card(
                child: Column(
                  children: [
                    Text(item.taskName),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
