import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width / 2 + 30,
        child: Column(
          children: [
            ClipRRect(
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(30),
              //     bottomRight: Radius.circular(30)),
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.blueAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      //TODO:add the pic here
                      radius: 50,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Profile button',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text("List of items"),
              ),
            ),
          ],
        ));
  }
}
