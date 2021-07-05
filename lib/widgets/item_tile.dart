import 'package:flutter/material.dart';
import 'package:remainder_main/database/repo.dart';
import 'package:remainder_main/models/task_model.dart';

class ItemTile extends StatelessWidget {
  Task taskitem;
  int index;
  Function updatescreen;
  ItemTile(
      {required this.taskitem,
      required this.index,
      required this.updatescreen});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: Colors.blueAccent,
      child: ListTile(
        onLongPress: () {
          Repository().deleteitme(taskitem.id as String);
          updatescreen();
        },
        leading: CircleAvatar(
          child: Text((index + 1).toString()),
        ),
        title: Text(taskitem.title as String),
        subtitle: Text("${taskitem.duedate}"),
      ),
    );
    ;
  }
}
