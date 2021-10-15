import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:goldfolks/view/Reminder/ReminderScreen.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationController {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // var initSetting;
  // var initSettingAndroid;
  // BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
  //     BehaviorSubject<ReceiveNotification>();
  //
  // LocalNotificationController.init() {
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   initializePlatform();
  // }
  //
  // initializePlatform() {
  //   initSettingAndroid = AndroidInitializationSettings('notification_bell');
  //   initSetting = InitializationSettings(android: initSettingAndroid);
  // }
  //
  // setOnNotificationReceive(Function onNotificationReceive) {
  //   didReceiveLocalNotificationSubject.listen((notification) {
  //     onNotificationReceive(notification);
  //   });
  // }
  //
  // setOnNotificationClick(Function onNotificationClick) async {
  //   await flutterLocalNotificationsPlugin.initialize(initSetting,
  //       onSelectNotification: (String payload) async {
  //     onNotificationClick(payload);
  //   });
  // }

  BuildContext _context;

  Future<FlutterLocalNotificationsPlugin> initNotifies(
      BuildContext context) async {
    this._context = context;
    //-----------------------------| Initialize local notifications |--------------------------------------
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('notification_bell');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    return flutterLocalNotificationsPlugin;
    //======================================================================================================
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: _context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  Future reminderNotification(int id, String name, String description, int time,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id.toInt(),
        name,
        description,
        tz.TZDateTime.now(tz.local).add(Duration(milliseconds: time)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'GoldFolks Notification', 'GoldFolks Notification',
              channelDescription: 'GoldFolks Notification Channel'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> deleteReminderNotification(int id,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(id);
    } catch (e) {
      print("Notification doesn't exist");
    }
  }

  Future<void> editReminderNotification(Reminder reminderInfo,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    deleteReminderNotification(
        reminderInfo.reminderId, flutterLocalNotificationsPlugin);
    //showDailyAtTimeNotification(reminderInfo, flutterLocalNotificationsPlugin);
  }
}

class ReceiveNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceiveNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}
