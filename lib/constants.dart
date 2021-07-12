import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const String tablename = 'list';
const String colid = 'id';
const String colduedate = 'duedate';
const String coltitle = 'title';
const String colschedule = 'isScheduled';
const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        "channel id", 'REMAINDER_APP', "TO REMAIND YOU TO COMPLETE THE TASK",
        importance: Importance.max, priority: Priority.max);

const NotificationDetails platformSpecifis =
    NotificationDetails(android: androidNotificationDetails);
