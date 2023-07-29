import 'package:sqflite/sqflite.dart';
import 'package:todoey/constants/keys.dart';
import 'package:todoey/models/task.dart';

class DBHelper {
  const DBHelper._();

  static const DBHelper instance = DBHelper._();

  static late Database _db;

  Future<void> init() async {
    var dbPath = await getDatabasesPath();
    dbPath += '/tasks.db';

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
                  create table ${Keys.tableTodo} (
                    ${Keys.columnId} integer primary key autoincrement,
                    ${Keys.columnTitle} text not null,
                    ${Keys.columnDone} integer not null
                    )
                  ''');
      },
    );
  }

  Future<List<Task>> get tasks async {
    List<Map<String, dynamic>> records = await _db.query(Keys.tableTodo);
    return records.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> get tasksCount async =>
      _db.query(Keys.tableTodo).then((value) => value.length);

  Future<void> insert(Task newTask) async {
    newTask.id = await _db.insert(
      Keys.tableTodo,
      newTask.toMap(),
    );
  }

  Future<void> updateTask(Task task) async {
    await _db.update(
      Keys.tableTodo,
      task.toMap(),
      where: '${Keys.columnId} = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(Task task) async {
    await _db.delete(
      Keys.tableTodo,
      where: '${Keys.columnId} = ?',
      whereArgs: [task.id],
    );
  }
}
