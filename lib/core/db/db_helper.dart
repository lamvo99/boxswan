import 'package:box_swan/model/expense_model.dart';
import 'package:box_swan/model/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableNameTask = "taskTable";
  static final String _tableNameExpense = "expenseTable";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'boxswan.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (Database db,int version) async {
          print('Creating a new one database');
          await db.execute('CREATE TABLE $_tableNameTask (id INTEGER PRIMARY KEY AUTOINCREMENT,title STRING, note TEXT, date STRING, startTime STRING, endTime STRING, remind INTEGER, repeat STRING,color INTEGER ,isCompleted INTEGER)');
          await db.execute('CREATE TABLE $_tableNameExpense (id INTEGER PRIMARY KEY AUTOINCREMENT,nameTrans STRING, amount INTEGER, date STRING,incomOrSpending INTEGER)');
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<int> insertTask(TaskModel? task) async {
    print("insert task function called");
    return await _db?.insert(_tableNameTask, task!.toJson()) ?? 1;
  }

  static Future<int> insertExpense(ExpenseModel? expense) async {
    print("insert expense function called");
    return await _db?.insert(_tableNameExpense, expense!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> queryTask() async {
    print('query task function called');
    return await _db!.query(_tableNameTask);
  }

  static Future<List<Map<String, dynamic>>> queryExpense() async {
    print('query expense function called');
    return await _db!.query(_tableNameExpense);
  }

  static deleteTask({required TaskModel task}) async{
    await _db!.delete(_tableNameTask, where: 'id=?', whereArgs: [task.id]);
  }

  static updateTask(int? id) async {
    return await _db!.rawUpdate('''
    UPDATE taskTable
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  }

}