import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remainder_main/notification_info/notification_service.dart';
import '../database/repo.dart';
import '../models/task_model.dart';

class ItemTile extends StatefulWidget {
  Task taskitem;
  int index;
  Function updatescreen;

  ItemTile(
      {required this.taskitem,
      required this.index,
      required this.updatescreen});

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    Task taskobjref = widget.taskitem;

    void showSnackbar(String value) {
      final snackbar = SnackBar(
        content: Text('$value ${taskobjref.title}'),
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context)..removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: Colors.blueAccent,
      child: ListTile(
        onLongPress: () {
          Repository().deleteitme(taskobjref.id!);
          Notification_service().cancelnotification(taskobjref.id!);
          widget.updatescreen();
        },
        leading: CircleAvatar(
          child: Text((widget.index + 1).toString()),
        ),
        title: Text(taskobjref.title),
        subtitle: Text("DueDate:${DateFormat("dd-MMMM-yy").format(taskobjref.duedate)} ${DateFormat.jm().format(taskobjref.duedate)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
        trailing: Switch(
          value: taskobjref.isScheduled,
          onChanged: (value) {
            setState(() {
              taskobjref.isScheduled = value;
            });
            if (taskobjref.isScheduled) {
              if (taskobjref.duedate.hour >= DateTime.now().hour &&
                  (taskobjref.duedate.hour == DateTime.now().hour &&
                      taskobjref.duedate.minute > DateTime.now().minute)) {
                Notification_service().schedulenotification(taskobjref);
                showSnackbar('scheduled');
                print('scheduled');
              } else {
                setState(() {
                  taskobjref.isScheduled = !value;
                });
                showSnackbar('can\'t scheduled');
                print('not scheduled');
              }
            } else if (!taskobjref.isScheduled) {
              Notification_service().cancelnotification(taskobjref.id!);
              showSnackbar('cancelled');
              print('cancelled');
            }
            Repository().updatetask(taskobjref);
          },
        ),
      ),
    );

  }
}