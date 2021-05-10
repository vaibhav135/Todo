// import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:todo/task_fields.dart';
//import 'package:todo/write_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottomSheet extends StatefulWidget {
  BottomSheet({this.addtask});
  final Function addtask;

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
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

  Map<String, dynamic> someData;
  Future<void> addingTaskData(CollectionReference users) {
    return users
        .add(someData)
        .then((value) => print("data added"))
        .catchError((error) => print("failed to add user $error"));
  }

  DateTime selectedDate = DateTime.now();
  bool hideFloatBtn =
      false; //hides the float button when the bottom sheet appears

  final myController = TextEditingController();
  final myAboutController = TextEditingController();
  final myDateController = TextEditingController();
  final myCategoryController = TextEditingController();
  final myPriorityController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        myDateController.value = TextEditingValue(text: picked.toString());
      });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('tasks');

    // Show error message if initialization failed
    if (_error) {
      return Text("some error");
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return CircularProgressIndicator();
    }

    return hideFloatBtn
        ? Container()
        : FloatingActionButton(
            onPressed: () {
              var bottomSheetController = showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: 370,
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ListView(
                      children: <Widget>[
                        TextField(
                            controller: myController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'your task',
                                labelText: "task")),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: myDateController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'enter the date',
                                labelText: 'task date',
                                prefixIcon: Icon(
                                  Icons.dialpad,
                                  color: Colors.blue[400],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                            textAlign: TextAlign.center,
                            controller: myAboutController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter about yout task',
                                labelText: "about task")),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                            controller: myCategoryController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'choose category',
                                labelText: "task category")),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                            textAlign: TextAlign.center,
                            controller: myPriorityController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'your task priority',
                                labelText: "task priority")),
                        SizedBox(
                          height: 20,
                        ),
                        new RaisedButton(
                          //Task_Field(taskName: myController.text ,taskDate:myDateController.value , aboutTask:myAboutController , priority:myPriorityController.value , taskCategories:myCategoryController)
                          onPressed: () {
                            var task = TaskFields(
                                taskName: myController.text,
                                taskDate: DateTime.parse(myDateController.text),
                                aboutTask: myAboutController.text,
                                priority: int.parse(myPriorityController.text),
                                taskCategories: myCategoryController.text);
                            createData(task, users);
                            widget.addtask(task);
                            Navigator.pop(context);
                            myController.clear();
                            myDateController.clear();
                            myPriorityController.clear();
                            myCategoryController.clear();
                            myAboutController.clear();
                          },
                          textColor: Colors.white,
                          elevation: 20,
                          child: Text("add task"),
                          color: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                        ),
                      ],
                    ),
                  );
                },
              );
              showFoatingActionButton(true);
              bottomSheetController.closed
                  .then((value) => showFoatingActionButton(false));
            },
            //tooltip: 'Increment',
            child: Icon(Icons.add),
          );
  }

  void createData(var task, CollectionReference users) {
    someData = {
      "taskName": task.taskName,
      "taskDate": task.taskDate,
      "aboutTask": task.aboutTask,
      "priority": task.priority,
      "taskCategories": task.taskCategories,
    };
    addingTaskData(users);
  }

  void showFoatingActionButton(bool value) {
    setState(() {
      hideFloatBtn = value;
    });
  }
}
