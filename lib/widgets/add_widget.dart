import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../database/repo.dart';
import '../models/task_model.dart';

class AddItem extends StatefulWidget {
  Function getlist;
  @override
  _AddItemState createState() => _AddItemState();
  AddItem({required this.getlist});
}

class _AddItemState extends State<AddItem> {
  //TODO:get this function
  TextEditingController titlecontroller = TextEditingController();
  DateTime? duedate;
  MaterialButton selectduedate(BuildContext context) {
    return MaterialButton(
      child: Text(
        "select time",
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.redAccent,
      onPressed: () {
        datetimepicker(context);
      },
    );
  }

  void datetimepicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            child: CupertinoDatePicker(
                minimumDate: DateTime.now(),
                minimumYear: DateTime.now().year,
                maximumDate: DateTime(
                  DateTime.now().year + 2,
                ),
                onDateTimeChanged: (DateTime selecteddate) {
                  setState(() {
                    duedate = selecteddate;
                  });
                  print(duedate);
                }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titlecontroller,
                    decoration: InputDecoration(hintText: 'enter the task'),
                    onChanged: (value) {
                      titlecontroller.text = value;
                      titlecontroller.selection = TextSelection.fromPosition(
                          TextPosition(offset: titlecontroller.text.length));
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  duedate == null
                      ? Text('Select the due date')

                      : Text("Selected date is ${DateFormat("dd-MMMM-yy").format(duedate!)} ${DateFormat.jm().format(duedate!)}"),


                  selectduedate(context),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            child: Text('submit'),
                            onPressed: () {
                              var taskobj = Task(
                                  duedate: duedate!,
                                  title: titlecontroller.text);
                              Repository().insertitem(taskobj);
                              Navigator.pop(context);
                              widget.getlist();
                            }),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
