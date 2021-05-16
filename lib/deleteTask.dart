import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteTask extends StatelessWidget {
  final String reference;
  const DeleteTask(this.reference);
  Widget build(BuildContext context) {
    print(reference);
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    Future<void> deleteTask() {
      return tasks
          .doc(reference)
          .delete()
          .then((value) => print("task Deleted"))
          .catchError((error) => print("Failed to delete task: $error"));
    }

    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        deleteTask();
        Navigator.pop(context);
      },
    );
  }
}
