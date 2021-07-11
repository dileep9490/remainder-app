import 'package:flutter/material.dart';
import 'package:remainder_main/database/repo.dart';
import 'package:remainder_main/models/task_model.dart';
import 'package:remainder_main/notification_Services/notification_service.dart';

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
  void schedulenotification(int index, String title, DateTime duedate) {
    Notification_service().schedulenotification(index, title, "body", duedate);
    print('Scheduled from itemtile');
  }

  void cancelnotifi(int id) {
    Notification_service().cancelnotification(id);
    print('canceled');
  }

  @override
  Widget build(BuildContext context) {
    Task taskobjref = widget.taskitem;

    void showSnackbar(String value) {
      final snackbar = SnackBar(
        content: Text('$value ${taskobjref.title}'),
        duration: Duration(seconds: 1),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: Colors.blueAccent,
      child: ListTile(
        onLongPress: () {
          Repository().deleteitme(taskobjref.id as int);
          // showSnackbar('deleted');
          widget.updatescreen();
        },
        leading: CircleAvatar(
          child: Text((widget.index + 1).toString()),
        ),
        title: Text(taskobjref.title as String),
        subtitle: Text(
          "DUEDATE : ${taskobjref.duedate.day}-${taskobjref.duedate.month}-${taskobjref.duedate.year} ${taskobjref.duedate.hour}:${taskobjref.duedate.minute}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Switch(
          value: taskobjref.isScheduled,
          onChanged: (value) => setState(()  {
            print(value);
            taskobjref.isScheduled = value;
            if (taskobjref.isScheduled) {
              if (taskobjref.duedate.hour >= DateTime.now().hour) {
                schedulenotification(
                  taskobjref.id!,
                  taskobjref.title,
                  taskobjref.duedate,
                );
                 Repository().updatetask(taskobjref);
                showSnackbar('Scheduled');
              } else {
                taskobjref.isScheduled = !value;
                 Repository().updatetask(taskobjref);
                showSnackbar('Can\'t schedule ');
              }
            } else if (!taskobjref.isScheduled) {
              cancelnotifi(taskobjref.id!);
               Repository().updatetask(taskobjref);
              showSnackbar('Cancelled');
            }
          }),
        ),
      ),
    );
    ;
  }
}
