import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationController {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  var initSettingAndroid;
  var initSettingIos;
  var initSetting;
  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();

  LocalNotificationController.init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializePlatform();
  }

  initializePlatform() {
    initSettingAndroid = AndroidInitializationSettings('notification_bell');
    initSettingIos = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {});
    initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIos);
  }

  setOnNotificationReceive(Function onNotificationReceive) {
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
    });
  }

  Future<void> showDailyAtTimeNotification(Reminder reminderInfo) async {
    String name = reminderInfo.medicineName;
    String description = reminderInfo.description;
    TimeOfDay time = reminderInfo.frequencyTiming[0];
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        name,
        description,
        _nextInstanceOfTime(
            DateTime(now.year, now.month, now.day, time.hour, time.minute)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'GoldFolks Notification', 'GoldFolks Notification',
              channelDescription: 'GoldFolks Notification Channel'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  tz.TZDateTime _nextInstanceOfTime(DateTime dateTime) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, dateTime.year,
        dateTime.month, dateTime.day, dateTime.hour, dateTime.hour);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}

LocalNotificationController localNotificationManager =
    LocalNotificationController.init();

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
