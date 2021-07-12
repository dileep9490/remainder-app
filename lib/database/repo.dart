import 'package:path_provider/path_provider.dart';
import 'package:remainder_main/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import '../constants.dart';

class Repository {
  Future<Database> initDatabase() async {
    var dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'list.db';
    Database db = await openDatabase(path, version: 1, onCreate: _createDB);
    return db;
  }

  _createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tablename($colid TEXT NOT NULL , $coltitle TEXT NOT NULL, $colduedate TEXT NOT NULL)");
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

  Future<int> deleteitme(String id) async {
    Database db = await database;
    int result =
        await db.delete(tablename, where: '$colid =?', whereArgs: [id]);
    return result;
  }

  Future<List<Map<String, dynamic>>> readalldata() async {
    Database db = await database;
    var listofobj = await db.query(tablename);
    return listofobj;
  }

  Future<List<Task>> getTaskList() async {
    List<Map<String, dynamic>> taskmaplist = await readalldata();
    List<Task> tasklist = [];
    taskmaplist.forEach((element) {
      tasklist.add(Task.fromMap(element));
    });
    return tasklist;
  }
}
