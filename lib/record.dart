import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String taskName, aboutTask, taskCategory, currentDateTime;
  final int priority;
  final DateTime date;

  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['taskName'] != null),
        assert(map['aboutTask'] != null),
        assert(map['taskCategories'] != null),
        assert(map['priority'] != null),
        assert(map['taskDate'] != null),
        assert(map['currentDateTime'] != null),
        taskName = map['taskName'],
        taskCategory = map['taskCategories'],
        aboutTask = map['aboutTask'],
        priority = map['priority'],
        date = (map['taskDate']).toDate(),
        currentDateTime = map['currentDateTime'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$taskName:$taskCategory:$aboutTask:$date>";
}
