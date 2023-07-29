import 'package:flutter/foundation.dart';
import 'package:todoey/helpers/db_helper.dart';
import 'package:todoey/models/task.dart';

class TasksProvider extends ChangeNotifier {
  Future<List<Task>> get tasks async {
    return DBHelper.instance.tasks;
  }

  Future<int> get tasksCount async => DBHelper.instance.tasksCount;

  Future<void> addTask(Task task) async {
    DBHelper.instance.insert(task);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    task.toggleDone();
    await DBHelper.instance.updateTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    await DBHelper.instance.deleteTask(task);
    notifyListeners();
  }
}
