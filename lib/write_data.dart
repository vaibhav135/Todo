import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//ignore: must_be_immutable
class WritingTaskData extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final Map<String, dynamic> someData;
  WritingTaskData(Map<String, dynamic> someData) : this.someData = someData;
  //Map<String, dynamic> taskData = {};
  //List<TaskFields> taskFields = <TaskFields>[];
  Future<void> addingTaskData(CollectionReference users) {
    return users
        .add(someData)
        .then((value) => print("data added"))
        .catchError((error) => print("failed to add user $error"));
  }

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('tasks');
    print(
        "intialized ..................................................  fuck");
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text("some error occured"),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          addingTaskData(users);
          return null;
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
