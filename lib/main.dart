import 'package:flutter/material.dart';
import 'package:todo/bottom_sheet.dart' as sheet;
import 'package:todo/task_fields.dart';
import 'package:todo/data_check.dart';
//import 'package:todo/write_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  // var tasks;
  // dynamic get gettingTask => tasks;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  // bool hide_float_btn =
  //     false; //hides the float button when the bottom sheet appears
  TabController _controller;
  int _tab = 0;

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
  }

  List<TaskFields> taskFields = <TaskFields>[];
  //_Task_ListState(this._v);
  final VoidCallback addingSomething;

  _MyHomePageState({this.addingSomething});

  void addList(var someValue) {
    setState(() {
      taskFields.add(someValue);
      print("printing from task_listState $someValue");
    });
  }

  void removeList(var someItem) {
    setState(() {
      taskFields.remove(someItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new TabBarView(
        controller: _controller,
        children: <Widget>[
          DataCheck(),
          ListView.builder(
              key: new PageStorageKey('building'),
              scrollDirection: Axis.vertical,
              itemCount: taskFields.length,
              itemBuilder: (context, index) {
                var item = taskFields[index];
                return _displayingCards(item);
              }),
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        onTap: (int value) {
          _controller.animateTo(value);
          setState(() {
            _tab = value;
          });
        },
        currentIndex: _tab,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: new Icon(Icons.arrow_downward),
            label: 'fetching',
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.arrow_upward),
            label: 'creating',
          ),
        ],
      ),
      //body: DataCheck(),
      //body: Container(
      //child: new Column(
      //children: <Widget>[
      //ListView.builder(
      //scrollDirection: Axis.vertical,
      //itemCount: taskFields.length,
      //itemBuilder: (context, index) {
      //var item = taskFields[index];
      //return _displayingCards(item);
      //}),
      //Container(
      //child: DataCheck(),
      //width: 48.0,
      //height: 48.0,
      //),
      //],
      //),
      //),
      floatingActionButton:
          _tab == 1 ? sheet.BottomSheet(addtask: addList) : null,
    );
  }

  Widget _displayingCards(var item) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: 650,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.taskName, style: TextStyle(fontSize: 16)),
                ),
                Text(item.taskCategories, style: TextStyle(fontSize: 15)),
                IconButton(
                  icon: Icon(Icons.delete_rounded),
                  onPressed: () => removeList(item),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 3.0,
            margin: EdgeInsets.all(5),
          ),
        )
      ],
    );
  }
}

// Widget _buildList(Task_Fields tf) {
//     return new Padding(
//       padding: const EdgeInsets.all(16.0),
//       child:new ListTile(
//         title: new Text(tf.taskName , style: new TextStyle(fontSize:16.0),)

//       )
//     );
//   }

// void showFoatingActionButton(bool value) {
//   setState(() {
//     hide_float_btn = value;
//   });
// }

//ScrollController _controller;
//@override
//void initState() {
//_controller = ScrollController();
//_controller.addListener(_scrollListener); //the listener for up and down.
//super.initState();
//}

//_scrollListener() {
//if (_controller.offset >= _controller.position.maxScrollExtent &&
//!_controller.position.outOfRange) {
//setState(() {
////you can do anything here
//});
//}
//if (_controller.offset <= _controller.position.minScrollExtent &&
//!_controller.position.outOfRange) {
//setState(() {
////you can do anything here
//});
//}
//}
