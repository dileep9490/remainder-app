// import 'dart:core';
//
// import 'package:flutter/cupertino.dart';
// import 'package:remainder_main/constants.dart';
// import 'package:remainder_main/database/repo.dart';
// import 'package:remainder_main/models/task_model.dart';
//
// class TaskService extends ChangeNotifier {
//   Repository obj = Repository();
//   // List<Task>? reqlist;
//
//   Future addItem(Task task) {
//     return obj.insertitem('$tablename', task.toMap());
//   }
//
//   Future deleteItem(String id) {
//     return obj.deleteitme('$tablename', id);
//   }
//
//   Future<List<Task>> getall() async {
//     final List<Task> tasklist = [];
//     final List<Map<String, dynamic>> maplist =
//         await obj.readalldata('$tablename');
//     maplist.forEach((element) {
//       tasklist.add(Task.fromMap(element));
//     });
//     return tasklist;
//   }
// }
