import 'package:todoey/constants/keys.dart';

class Task {
  int? id;
  String title;
  bool isDone;

  Task({
    this.id,
    required this.title,
    this.isDone = false,
  });

  Task.fromMap(Map<String, dynamic> map)
      : id = map[Keys.columnId],
        title = map[Keys.columnTitle],
        isDone = map[Keys.columnDone] == 1;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Keys.columnTitle: title,
      Keys.columnDone: isDone ? 1 : 0,
    };

    if (id != null) {
      map[Keys.columnId] = id;
    }

    return map;
  }

  void toggleDone() {
    isDone = !isDone;
  }
}
