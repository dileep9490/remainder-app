import 'package:path_provider/path_provider.dart';
import 'package:remainder_main/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import '../constants.dart';

class Repository {
  Future<Database> initDatabase() async {
    var dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'task.db';
    Database db = await openDatabase(path, version: 1, onCreate: _createDB);
    return db;
  }

  _createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tablename($colid INTEGER PRIMARY KEY AUTOINCREMENT , $coltitle TEXT NOT NULL, $colduedate TEXT NOT NULL,$colschedule INTEGER NOT NULL)");
  }

  Future<Database>? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = initDatabase();
      return _database!;
    }
    return _database!;
  }

  Future<int> insertitem(Task task) async {
    Database db = await database;
    int result = await db.insert(tablename, task.toMap());
    return result;
  }

  Future<int> deleteitme(int id) async {
    Database db = await database;
    int result =
        await db.delete(tablename, where: '$colid =?', whereArgs: [id]);
    return result;
  }

  Future<List<Map<String, dynamic>>> readalldata() async {
    Database db = await database;
    var listofobj = await db.query(tablename);
    // print(await db.query(tablename));
    return listofobj;
  }

  Future<List<Task>> getTaskList() async {
    List<Map<String, dynamic>> taskmaplist = await readalldata();
    print('getting list ${taskmaplist}');
    List<Task> tasklist = [];
    taskmaplist.forEach((element) {
      tasklist.add(Task.fromMap(element));
    });
    return tasklist;
  }

  Future updatetask(Task task) async {
    Database db = await database;
    Map<String, dynamic> value = {colschedule: task.isScheduled};
    await db
        .update(tablename, value, where: '$colid = ?', whereArgs: [task.id]);
    print('updated');
  }
}
