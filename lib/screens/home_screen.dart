import 'package:flutter/material.dart';
import 'package:remainder_main/database/repo.dart';
import 'package:remainder_main/widgets/add_widget.dart';
import 'package:remainder_main/widgets/item_tile.dart';

import '../models/task_model.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Task>>? _tasklist;
  @override
  initState() {
    super.initState();
    _updateTaskList();
  }

  void _updateTaskList() {
    setState(() {
      _tasklist = Repository().getTaskList();
    });
    print('getting list');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REMAINDER APP"),
      ),
      body: FutureBuilder(
          future: _tasklist,
          builder: (context, AsyncSnapshot<List<Task>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, count) {
                    return ItemTile(
                      updatescreen: _updateTaskList,
                      index: count,
                      taskitem: snapshot.data![count],
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddItem(
                  getlist: _updateTaskList,
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
