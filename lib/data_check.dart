import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:todo/record.dart';
import 'package:todo/task_page.dart';

enum TaskState { selected, notSelected }

class DataCheck extends StatefulWidget {
  const DataCheck({Key key}) : super(key: key);
  //final BuildContext contxt;
  @override
  _DataCheckState createState() => _DataCheckState();
}

class _DataCheckState extends State<DataCheck> {
  TaskState tstate = TaskState.notSelected;
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    if (_error) return Text("There is some error");

    if (!_initialized) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    //print(record.reference.id);
    return Padding(
      key: ValueKey(record.taskName),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.taskName),
          leading: Radio<TaskState>(
            value: TaskState.selected,
            groupValue: tstate,
            onChanged: (TaskState value) {
              setState(() {
                tstate = value;
                // TODO: if the state is selected then the task will be moved to completed
                if (tstate == TaskState.selected) print(tstate);
              });
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskPage(record)),
            );
          },
        ),
      ),
    );
  }
}
