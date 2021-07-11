import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../constants.dart';
import '../notification_Services/timezone.dart';
import 'package:timezone/timezone.dart' as tz;

class Notification_service {
  static final Notification_service _flutterLocalNotificationsPlugin =
      Notification_service._init();

  factory Notification_service() {
    return _flutterLocalNotificationsPlugin;
  }

  Notification_service._init();

  Future<void> init() async {
    final AndroidInitializationSettings initandroid =
        AndroidInitializationSettings('freeone');
    // final IOSInitializationSettings initIOS = IOSInitializationSettings();
    final InitializationSettings initalizesettings = InitializationSettings(
      android: initandroid,
    );

    await FlutterLocalNotificationsPlugin().initialize(initalizesettings);
  }

  void schedulenotification(
    int id,
    String title,
    String body,
    DateTime duedate,
  ) async {
    final timeZone = TimeZone();
    String timezonename = await timeZone.getTimeZoneName();
    final location = await timeZone.getLocation(timezonename);
    final scheduledate = tz.TZDateTime.from(duedate, location);

    FlutterLocalNotificationsPlugin().zonedSchedule(
        id, title, body, scheduledate, platformSpecifis,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
    print('scheduled');
  }

  void cancelnotification(int id) async {
    await FlutterLocalNotificationsPlugin().cancel(id);
  }

  Future<List<PendingNotificationRequest>> getpendingNotifications() async {
    return await FlutterLocalNotificationsPlugin()
        .pendingNotificationRequests();
  }

  void cancelall() async {
    await FlutterLocalNotificationsPlugin().cancelAll();
  }

  // void Repeat(int id,
  //     String title,
  //     String body,
  //     //TODO:and new property if we require to repeat daily
  //     ) async {
  //   await FlutterLocalNotificationsPlugin().showDailyAtTime(
  //       id, title, body, Time(), platformSpecifis)
  // }

}
