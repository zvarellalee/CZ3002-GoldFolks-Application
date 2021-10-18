import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:goldfolks/model/MedicineType.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:goldfolks/view/Reminder/ReminderScreen.dart';

class NotificationController {
  // Create notification(s) based on selected reminder timings.
  static bool listening = false;

  static void tryListen() {
    if (!listening) {
      AwesomeNotifications().actionStream.listen((receivedNotification) {
        // do check for current date.
        NotificationController.checkDateToCancel(receivedNotification.payload);
        }
      );
      listening = true;
    }
  }
  static Future<void> createDailyNotifications(Reminder reminder) async {
    // iterate through the frequencies, creating notification for each.
    for (int i = 0; i < reminder.frequency; i++) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: reminder.notificationIds[i],
          channelKey: 'scheduled_channel',
          title: 'Time to take your ${reminder.medicineName} ${(reminder
              .medicineType != MedicineType.Other) ? reminder.medicineType
              .string : "medicine"}!',
          body: reminder.description,
          notificationLayout: NotificationLayout.Default,
          payload: {"endDate":reminder.endDate.toIso8601String(),
            "id0":reminder.notificationIds[0].toString(),
            "id1":reminder.notificationIds[1].toString(),
            "id2":reminder.notificationIds[2].toString(),
            "id3":reminder.notificationIds[3].toString(),
            "frequency":reminder.frequency.toString(),
            "lastTiming":Reminder.timeOfDayToString(reminder.frequencyTiming[reminder.frequency-1]),
          },
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'MARK_DONE',
            label: 'Done',
          ),
        ],
        schedule: NotificationCalendar(
          hour: reminder.frequencyTiming[i].hour,
          minute: reminder.frequencyTiming[i].minute,
          second: 0,
          millisecond: 0,
          repeats: true,
        ),
      );
    }
  }

  // On login, schedule all notifications
  static Future<void> scheduleAllNotifications(List<Reminder> reminderList) async {
    for (Reminder reminder in reminderList) {
      await createDailyNotifications(reminder);
    }
  }

  // When we delete reminders, delete all notifications as well
  static Future<void> cancelScheduledNotifications(Reminder reminder) async {
    for (int i = 0; i < reminder.frequency; i++)
      await AwesomeNotifications().cancel(reminder.notificationIds[i]);
  }
  // When we edit a medication reminder, cancel all previous reminders and set new ones.
  static Future<void> changeDailyNotifications(Reminder reminder, int numPreviousReminders) async {
    for (int i = 0; i < numPreviousReminders; i++)
      await AwesomeNotifications().cancel(reminder.notificationIds[i]);
    await createDailyNotifications(reminder);
  }
  // On logout, cancel all notifications.
  static Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
  // check the end date of the current notification
  static Future<void> checkDateToCancel(Map<String, String> payload) async {
    DateTime endDate = DateTime.parse(payload["endDate"]);
    if (endDate.compareTo(DateTime.now()) <= 0) {
      //print("now");
      TimeOfDay t = Reminder.stringToTimeOfDay(payload["lastTiming"]);
      DateTime lastTiming = DateTime(endDate.year, endDate.month, endDate.day, t.hour, t.minute);
      if (lastTiming.compareTo(DateTime.now()) <= 0) {
        int frequency = int.parse(payload["frequency"]);
        for (int i = 0; i < frequency; i++) {
          await AwesomeNotifications().cancel(
              int.parse(payload["id" + i.toString()]));
        }
      }
    } else {
    }
  }
}