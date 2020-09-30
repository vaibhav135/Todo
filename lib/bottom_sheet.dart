// import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:todo/task_fields.dart';
import 'package:todo/task_list.dart';

class Bottom_Sheet extends StatefulWidget {
  @override
  _Bottom_SheetState createState() => _Bottom_SheetState();
}

class _Bottom_SheetState extends State<Bottom_Sheet> {
  DateTime selectedDate = DateTime.now();
  bool hide_float_btn =
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
    return hide_float_btn
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Task_List(
                                      tasks: Task_Fields(
                                          taskName: myController.text,
                                          taskDate: DateTime.parse(
                                              myDateController.text),
                                          aboutTask: myAboutController.text,
                                          priority: int.parse(
                                              myPriorityController.text),
                                          taskCategories:
                                              myCategoryController.text),
                                    ),
                                  ),
                                );
                              });
                            },
                            child: AbsorbPointer(
                              child: new RaisedButton(
                                //Task_Field(taskName: myController.text ,taskDate:myDateController.value , aboutTask:myAboutController , priority:myPriorityController.value , taskCategories:myCategoryController)
                                onPressed: null,
                                textColor: Colors.white,
                                elevation: 20,
                                child: Text("add task"),
                                color: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });

              showFoatingActionButton(true);
              bottomSheetController.closed
                  .then((value) => showFoatingActionButton(false));
            },
            //tooltip: 'Increment',
            child: Icon(Icons.add),
          );
  }

  void showFoatingActionButton(bool value) {
    setState(() {
      hide_float_btn = value;
    });
  }
}
