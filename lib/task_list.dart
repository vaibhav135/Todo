import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/task_fields.dart';

class Task_List extends StatefulWidget {
  var tasks;
  Task_List({this.tasks});
  dynamic someMethod() {
    print("printing from task_list $tasks");
  }

  @override
  _Task_ListState createState() => _Task_ListState(this.tasks);
}

class _Task_ListState extends State<Task_List> {
  List<Task_Fields> task_fields = <Task_Fields>[];
  var _v;
  _Task_ListState(this._v);
  void addList() {
    setState(() {
      task_fields.add(_v);
      print("printing from task_listState $_v");
    });
  }

  @override
  Widget build(BuildContext context) {
    addList();
    // TODO: implement build
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: task_fields.length,
        itemBuilder: (context, index) {
          var item = task_fields[index];
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
