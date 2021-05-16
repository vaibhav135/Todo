import 'package:flutter/material.dart';
import 'package:todo/deleteTask.dart';

class TaskPage extends StatefulWidget {
  final taskData;
  const TaskPage(this.taskData);

  @override
  _TaskPageState createState() => _TaskPageState();
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    dynamic taskData = widget.taskData;
    print(taskData.currentDateTime);
    return Scaffold(
        appBar: AppBar(
          title: new Text(taskData.taskName),
          actions: <Widget>[
            DeleteTask(taskData.reference.id),
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 50),
            new ListTile(
              leading: const Icon(Icons.create),
              title: const Text('Created on'),
              subtitle: Text(taskData.currentDateTime),
            ),
            new ListTile(
              leading: const Icon(Icons.label),
              title: const Text('description'),
              subtitle: Text(taskData.aboutTask),
            ),
            new ListTile(
              leading: const Icon(Icons.label),
              title: const Text('category'),
              subtitle: Text(taskData.taskCategory),
            ),
            new ListTile(
              leading: const Icon(Icons.add_alert_rounded),
              title: const Text('priority'),
              subtitle: Text('${taskData.priority}'),
            ),
            new ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('Deadline'),
              subtitle: Text('${taskData.date}'),
            )
          ],
        ));
  }
}
